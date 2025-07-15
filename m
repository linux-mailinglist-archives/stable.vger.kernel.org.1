Return-Path: <stable+bounces-162017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E24B05B33
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E547B590B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6FD26D4F2;
	Tue, 15 Jul 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0HEW2WBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B957261B;
	Tue, 15 Jul 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585452; cv=none; b=qxrWKsnjKvKprF9TxhUhrRl3caDPBAFNlSx2bvIQuvOo6coriD2bHFcsfx4GLhFIPxD5Me2EaI1CFmIJQJFOfKzd1XVm3CBY83slFUJcOTghKRCumGFN3xeTlJakuTNXZVSdnK4Z9kWYQuA7tM3ZcnSpuMTDwga+cAFKimJlOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585452; c=relaxed/simple;
	bh=8P0xmzLdcF/KfcqiEOX8782qvWp1ndqL4Tr2O2BuTwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrikEvTWZkDN3bVJ1SvfYzqlQBFbgxPja21LKBF8uP3VF7yt4EoUs6VGHgPfPgeRxhDcBZAe4BWobgPD8umZnwJb953sVsd8Lh7BJEnDNPTUqHtpvkfmMNCUPgT1LtSyNl1XZOpedPJ3f1a2G8uLImeoqZ+wa/dh8KecpgrTpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0HEW2WBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2C7C4CEE3;
	Tue, 15 Jul 2025 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585452;
	bh=8P0xmzLdcF/KfcqiEOX8782qvWp1ndqL4Tr2O2BuTwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0HEW2WBMTx3n00z75r5+66cjet5BCE5zAaTb918UFKOj82+3uqzWpILpuwEU2ywpH
	 f6cMWG+910aUQrLmacqwL7hMKAq4S3+spy8YXQU334uWkXXBGzQevHzSbvmR7QVSe8
	 3M1jT+OM+0utoHHquYMRuF+yDiwrS08ScCpfymR8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 018/163] perf: Revert to requiring CAP_SYS_ADMIN for uprobes
Date: Tue, 15 Jul 2025 15:11:26 +0200
Message-ID: <20250715130809.501210339@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit ba677dbe77af5ffe6204e0f3f547f3ba059c6302 ]

Jann reports that uprobes can be used destructively when used in the
middle of an instruction. The kernel only verifies there is a valid
instruction at the requested offset, but due to variable instruction
length cannot determine if this is an instruction as seen by the
intended execution stream.

Additionally, Mark Rutland notes that on architectures that mix data
in the text segment (like arm64), a similar things can be done if the
data word is 'mistaken' for an instruction.

As such, require CAP_SYS_ADMIN for uprobes.

Fixes: c9e0924e5c2b ("perf/core: open access to probes for CAP_PERFMON privileged process")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55c19a0d3a814..dd745485b0f46 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10737,7 +10737,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
 
-	if (!perfmon_capable())
+	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	/*
-- 
2.39.5




