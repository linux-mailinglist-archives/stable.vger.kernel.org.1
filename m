Return-Path: <stable+bounces-117355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA997A3B592
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBEED7A4CE1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735E1DED64;
	Wed, 19 Feb 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0pG7e+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F91DED5C;
	Wed, 19 Feb 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955020; cv=none; b=tFA8vly8u1y/4+37hpDXelFEZmD+X4DWCnoRdKp2Jp45XkaBFwTAqtLQMl4PAgynfSmhQXLRqmEz1Zk+PiMU3Jh+K1hGj5MWiKsduMM5SVahV394HWKkuUID/TJSzcQOl1wc+qmpPEtOgHw1vtLkR7b3fOEo5XdGSL3lp/nm6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955020; c=relaxed/simple;
	bh=ascVHkDYiSYmUkCgI6XT/HdDFesby7jJF9B1kqv4qw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUricFrZSgP1AT4Cfz5wUUW1RLR92xdsJ0Mj5j5LeUuEGVapvt9NvViYDWxHP9TFTFZI/H4WRoD1yyRjl1DsC1kE7yp5ZZ5D6+FoOIS076bW4AKbAiPqMIwwK+xtO6hAxh69jDXQ6c85A7Lqis95dkFwC1pJ0O+GmFoPop4bwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O0pG7e+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F39AC4CED1;
	Wed, 19 Feb 2025 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955019;
	bh=ascVHkDYiSYmUkCgI6XT/HdDFesby7jJF9B1kqv4qw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0pG7e+bJ+E/u1RpR7SHq1fpZu3w9z91cflAJcEPx58SzWSSwVhpSuFVxEM7GWx53
	 RfU2sghJgh9zBOceAG3znBSlbyv8yu0rHVydWoXMIbmJsKMgGP7kXpmfmNz6+aNDOO
	 7dsL+jU4kKTDowzM/j6wwQy80mHFL+agCe7yWOkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 108/230] ring-buffer: Update pages_touched to reflect persistent buffer content
Date: Wed, 19 Feb 2025 09:27:05 +0100
Message-ID: <20250219082605.916374849@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

commit 97937834ae876f29565415ab15f1284666dc6be3 upstream.

The pages_touched field represents the number of subbuffers in the ring
buffer that have content that can be read. This is used in accounting of
"dirty_pages" and "buffer_percent" to allow the user to wait for the
buffer to be filled to a certain amount before it reads the buffer in
blocking mode.

The persistent buffer never updated this value so it was set to zero, and
this accounting would take it as it had no content. This would cause user
space to wait for content even though there's enough content in the ring
buffer that satisfies the buffer_percent.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250214123512.0631436e@gandalf.local.home
Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1850,6 +1850,11 @@ static void rb_meta_validate_events(stru
 				cpu_buffer->cpu);
 			goto invalid;
 		}
+
+		/* If the buffer has content, update pages_touched */
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
 		local_set(&cpu_buffer->head_page->entries, ret);



