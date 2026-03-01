Return-Path: <stable+bounces-222187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLTMFb+eo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F51CCD5F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD469303F088
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475630AD15;
	Sun,  1 Mar 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw81YRVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F22FE07D;
	Sun,  1 Mar 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330116; cv=none; b=a2ejrXcooTSx5hJ1xKBeDsGZxhELSWQ+QrrAbRjmwhHsV4f9ko/MiiUU+9vMP5j8gD9QGDcNuMHowAjDHvQ/SpbgM5I2167XVPcvpaipv6L4ZxZOPb7NR1b5yGW3Axi/ktWOEHE/fvSrhd3H1XcsgVqD5hT167/wrBsjesqkB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330116; c=relaxed/simple;
	bh=bhfHUyEcFd2BY07SAHZSvIUgr1GdW/hebPkTiFlnHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q24VCCJ02LuxUAZ7xNuhOFk8tPrJkZBCm26ULd6W7glhTYz8JasDo+iGlqK2POsZWJaZwze7wH6aMZ9tv9n1v8ftgHRJGJVZWRrB3Uym/lDdATi7YjFUEaivZeqiXPUE7d0LqcbrxmEFLQZ/8eF6uFtEpv0H/3/CAm82JOh9aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw81YRVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559FBC19421;
	Sun,  1 Mar 2026 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330115;
	bh=bhfHUyEcFd2BY07SAHZSvIUgr1GdW/hebPkTiFlnHvA=;
	h=From:To:Cc:Subject:Date:From;
	b=Gw81YRVxC9ymZ0K0UMYXJTgXbUBq1CzkL/2ngV36vxcasb+cEymnvzVvq5xRhm+7h
	 cDFatiQ8AZ1aVZjRuy+k5wDQ0zGQlZzx0wNhRqb35Yp8WWBEoqwNE0yc7hlaLHqv7i
	 7zae8yf4GIU5nx/zR7fHwvBKrNK9aHrvqV0jmkUq0+HfUwHG+LMu7WVbiPvPA1EtZy
	 H5zfneCulB09cFt8U6aWmZdpVilaE9dtWxh4Np/+UsmGdyh6msGIffagVN4kSAbn9B
	 4IzPlc0dNgPbvyENvhjp4T6ViM1JuDqhyeePL92+xHEU9uKeNYr/BIt1A8ks7y7Emr
	 WpKLPWYUezAiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-rt-devel@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:13 -0500
Message-ID: <20260301015514.1722401-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222187-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D1F51CCD5F
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 70b0faae3590c628a98a627a10e5d211310169d4 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:13 +0800
Subject: [PATCH] LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT

After commit 88fd2b70120d ("LoongArch: Fix sleeping in atomic context for
PREEMPT_RT"), it should guard percpu handler under !CONFIG_PREEMPT_RT to
avoid redundant operations.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/unwind_prologue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index 729e775bd40dd..ee1c29686ab05 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -65,7 +65,7 @@ static inline bool scan_handlers(unsigned long entry_offset)
 
 static inline bool fix_exception(unsigned long pc)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-- 
2.51.0





