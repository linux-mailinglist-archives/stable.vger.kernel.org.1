Return-Path: <stable+bounces-227545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAHUCUNRvWlr8gIAu9opvQ
	(envelope-from <stable+bounces-227545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:53:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE702DB614
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47F6302B3A7
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143C3BA245;
	Fri, 20 Mar 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUclMnzJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87E40DFAE
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014781; cv=none; b=eRUpuxuVaTt433x2+fh4Ql39TDuzpSknJiY0bHayzWSL99Uhj2fqp6QpmcOFteWPejxqvRUTbt38p1um/yMYv6c8PCth3BXG+OfbZfkxK177k2ap2ThWFM7zupArWjJYN9lVosBHV3D122JiVOVbOAgUU5bu9yvTrn8e3xygyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014781; c=relaxed/simple;
	bh=A/9P8iAEKFRJ7M4R/HCFL9HDLtwSxbSj6Gs+e1vapy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA9+Ep9SZQj+LG5wjQYd0NXWEyaWQW6rudOSUPwXQhK3i8g2jTMLxyiDSJzAU42ThHq/sYovxQeYf1waPd7RUSKOVdBv7FyCMwVVkgNa6hcNwOJwTI+Gey/g6ZIOZ6qm0xSqQSZ0jp9j+VUOGTCHqvGJYQrFa3gmo2UhqzkacF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUclMnzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC311C4CEF7;
	Fri, 20 Mar 2026 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014781;
	bh=A/9P8iAEKFRJ7M4R/HCFL9HDLtwSxbSj6Gs+e1vapy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUclMnzJ9ic2J5x81zbFW2VIDxMh8DP7q4jtHqMa0xkd4NOippj2GaDN5QGJ+PzFN
	 w0MTYPL+0cchjA/2M9Ag8QXY+s8aBDducW+NzXNGOiyMF5SzTCI6cvRI2dwh2iTDLF
	 V2NqeyMRFYwbO0KjniEU2mJkiilV7x+93hp8i4cHmNo6NdC/oAGPInXt4IeJ9FK1LH
	 48izWJOMkhnTDmBGAQYPDmZsU2mKuAVFMr0x3S/S1hFe/3okPE+hDt12L87hOU6V5M
	 d9rNUZRV6U/osBD652s1UfcJ96AbGNVXy8LhGVWusL4kV7rJ92ytQYqyDJS0mE/Dde
	 +HJwVibk6M+rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] LoongArch: Check return values for set_memory_{rw,rox}
Date: Fri, 20 Mar 2026 09:52:59 -0400
Message-ID: <20260320135259.4165408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032002-strode-okay-e7ab@gregkh>
References: <2026032002-strode-okay-e7ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227545-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AE702DB614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 431ce839dad66d0d56fb604785452c6a57409f35 ]

set_memory_rw() and set_memory_rox() may fail, so we should check the
return values and return immediately in larch_insn_text_copy().

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
[ kept `stop_machine()` instead of `stop_machine_cpuslocked()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/inst.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index bf037f0c6b26c..3f7f0f8b32dec 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -258,6 +258,7 @@ static int text_copy_cb(void *data)
 int larch_insn_text_copy(void *dst, void *src, size_t len)
 {
 	int ret = 0;
+	int err = 0;
 	size_t start, end;
 	struct insn_copy copy = {
 		.dst = dst,
@@ -269,9 +270,19 @@ int larch_insn_text_copy(void *dst, void *src, size_t len)
 	start = round_down((size_t)dst, PAGE_SIZE);
 	end   = round_up((size_t)dst + len, PAGE_SIZE);
 
-	set_memory_rw(start, (end - start) / PAGE_SIZE);
+	err = set_memory_rw(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rw() failed\n", __func__);
+		return err;
+	}
+
 	ret = stop_machine(text_copy_cb, &copy, cpu_online_mask);
-	set_memory_rox(start, (end - start) / PAGE_SIZE);
+
+	err = set_memory_rox(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rox() failed\n", __func__);
+		return err;
+	}
 
 	return ret;
 }
-- 
2.51.0


