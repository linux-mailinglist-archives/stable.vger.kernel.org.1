Return-Path: <stable+bounces-7611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712B817356
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD31B24172
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEE37881;
	Mon, 18 Dec 2023 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRgPNMiv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045231D122;
	Mon, 18 Dec 2023 14:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785EFC433C8;
	Mon, 18 Dec 2023 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908931;
	bh=GSS1JOHsv0+xLN9WBOS85ACbj4cv9uXuPN6PPx/Z5PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRgPNMivJIF/TTlMcmpkG8rQkaAb6otJxfXZ1iD5upWGW7MGShruB4baDSlh3qfs+
	 HnvTrMH+/lPTAPdQnlKD9bMvOTjdBk96cH3eaNreLXbbh8RPaJAuACJZyd9u6s0Lnp
	 cj/qP8PW91wyQICUpSHVz/He65v1rknMfcvh7Blg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 62/83] perf: Fix perf_event_validate_size() lockdep splat
Date: Mon, 18 Dec 2023 14:52:23 +0100
Message-ID: <20231218135052.459655072@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 7e2c1e4b34f07d9aa8937fab88359d4a0fce468e upstream.

When lockdep is enabled, the for_each_sibling_event(sibling, event)
macro checks that event->ctx->mutex is held. When creating a new group
leader event, we call perf_event_validate_size() on a partially
initialized event where event->ctx is NULL, and so when
for_each_sibling_event() attempts to check event->ctx->mutex, we get a
splat, as reported by Lucas De Marchi:

  WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080

This only happens for a new event which is its own group_leader, and in
this case there cannot be any sibling events. Thus it's safe to skip the
check for siblings, which avoids having to make invasive and ugly
changes to for_each_sibling_event().

Avoid the splat by bailing out early when the new event is its own
group_leader.

Fixes: 382c27f4ed28f803 ("perf: Fix perf_event_validate_size()")
Closes: https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
Closes: https://lore.kernel.org/lkml/ZXpm6gQ%2Fd59jGsuW@xpf.sh.intel.com/
Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231215112450.3972309-1-mark.rutland@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2032,6 +2032,16 @@ static bool perf_event_validate_size(str
 				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	/*
+	 * When creating a new group leader, group_leader->ctx is initialized
+	 * after the size has been validated, but we cannot safely use
+	 * for_each_sibling_event() until group_leader->ctx is set. A new group
+	 * leader cannot have any siblings yet, so we can safely skip checking
+	 * the non-existent siblings.
+	 */
+	if (event == group_leader)
+		return true;
+
 	for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)



