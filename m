Return-Path: <stable+bounces-232810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEhRE+xIzWn4bQYAu9opvQ
	(envelope-from <stable+bounces-232810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BE37DF1F
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C73F3046D84
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B64047D959;
	Wed,  1 Apr 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slRv9Zs+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0F4779A1
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060177; cv=none; b=pRh+K4ROpaLkSI9zoIlvR1+B90mF2Z4tFJRMGfo4ORLrTD0ISC5HLD8ps5K0TAsGT7y4ocHlmuH0tk/JnxuyhJxq/hXoNIbyWS2TzsLK74l1ZWUsRXaNyallwJjXhz8hXD1YIzjHYwNI0KZrMRCQPsrPwJu1iPu+9sZLn/loxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060177; c=relaxed/simple;
	bh=HuePag26Xv2G3CKFasNuj/cJzYLSKzvmHYOnHoPjbVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+2FNZaxXGxGvgJOlwaRsH03mVKiLPCAZkaTrNORcVkJ3JiR1MRa16GMc6CarQvx7A25qufCmDra2dc7uRXekLG/ngM8Ncr65a5fFCL5pvJRIs9F1QwG6XkJEqx3fsNWMzCPFs90kQxSp4EDNkYgVx5DK3fl0wiTnpKMCtXvwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slRv9Zs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617A5C4CEF7;
	Wed,  1 Apr 2026 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775060176;
	bh=HuePag26Xv2G3CKFasNuj/cJzYLSKzvmHYOnHoPjbVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slRv9Zs+1i3le4iqvyVncZAsceISA7zL8KRPiWbmn9h9mkaNCTbXBxY2h3X6FP6kD
	 BuMPM9297x7MrOUh6SzjYdoi2jaJQuay3dgJ3cn42hCjAUSfR0GSMGH7tN225K/pX3
	 Gk/SDnC0DhkbPIMkeA9j9O+efAIaTCMtN/5TvmZmbmGNNkV9yprt5Aq3POH7jQny5N
	 E8gb7nV/pcifSmLNC58J/ecAM8C1+rNlMdK2LrXaXCJXU6Edy6pJy37Tpxs5yv0Pxa
	 e0LnLeADwLWe0Hpi6t5TyN9WLm3SEGR3Y6XhrkhFkAchE2qzucScHSX5Ah1B5yLj+p
	 dpj2rKTW4cK2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] LoongArch: vDSO: Use vdso/datapage.h to access vDSO data
Date: Wed,  1 Apr 2026 12:16:13 -0400
Message-ID: <20260401161614.113725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033044-kilometer-hefty-7423@gregkh>
References: <2026033044-kilometer-hefty-7423@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-232810-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B04BE37DF1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit dc32cb4ba6f408e05857fbbf0b2965deec1d5c92 ]

vdso/datapage.h provides symbols and functions to ease the access to
shared vDSO data from both the kernel and the vDSO.
Make use of it to simplify the current code and also prepare for further
changes unifying the vDSO data storage between architectures.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-8-b64f0842d512@linutronix.de
Stable-dep-of: e4878c37f667 ("LoongArch: vDSO: Emit GNU_EH_FRAME correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/vdso/getrandom.h    |  3 +--
 arch/loongarch/include/asm/vdso/gettimeofday.h |  4 ++--
 arch/loongarch/include/asm/vdso/vdso.h         | 18 +-----------------
 arch/loongarch/kernel/asm-offsets.c            |  9 +++++++++
 arch/loongarch/vdso/vdso.lds.S                 |  8 +++++++-
 arch/loongarch/vdso/vgetcpu.c                  |  2 +-
 6 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/include/asm/vdso/getrandom.h
index 7e9edc1cb610d..39f706f14baca 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -30,8 +30,7 @@ static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, uns
 
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
 {
-	return (const struct vdso_rng_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGES_START *
-	       PAGE_SIZE + offsetof(struct loongarch_vdso_data, rng_data));
+	return &_loongarch_data.rng_data;
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 2d1a9c27af292..edb428204375c 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -91,14 +91,14 @@ static inline bool loongarch_vdso_hres_capable(void)
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return (const struct vdso_data *)get_vdso_data();
+	return _vdso_data;
 }
 
 #ifdef CONFIG_TIME_NS
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
-	return (const struct vdso_data *)(get_vdso_data() + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE);
+	return _timens_data;
 }
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index e31ac7474513c..1c183a9b2115a 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -48,23 +48,7 @@ enum vvar_pages {
 
 #define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
 
-static inline unsigned long get_vdso_base(void)
-{
-	unsigned long addr;
-
-	__asm__(
-	" la.pcrel %0, _start\n"
-	: "=r" (addr)
-	:
-	:);
-
-	return addr;
-}
-
-static inline unsigned long get_vdso_data(void)
-{
-	return get_vdso_base() - VVAR_SIZE;
-}
+extern struct loongarch_vdso_data _loongarch_data __attribute__((visibility("hidden")));
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 73954aa226646..e476c143181a7 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -16,6 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/ftrace.h>
+#include <vdso/datapage.h>
 
 static void __used output_ptreg_defines(void)
 {
@@ -311,3 +312,11 @@ static void __used output_kvm_defines(void)
 	OFFSET(KVM_GPGD, kvm, arch.pgd);
 	BLANK();
 }
+
+static void __used output_vdso_defines(void)
+{
+	COMMENT("LoongArch vDSO offsets.");
+
+	DEFINE(__VVAR_PAGES, VVAR_NR_PAGES);
+	BLANK();
+}
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 6b441bde4026e..160cfaef2de45 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -3,6 +3,8 @@
  * Author: Huacai Chen <chenhuacai@loongson.cn>
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <asm/page.h>
+#include <generated/asm-offsets.h>
 
 OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
 
@@ -10,7 +12,11 @@ OUTPUT_ARCH(loongarch)
 
 SECTIONS
 {
-	PROVIDE(_start = .);
+	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
+#ifdef CONFIG_TIME_NS
+	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
+#endif
+	PROVIDE(_loongarch_data = _vdso_data + 2 * PAGE_SIZE);
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 9e445be39763a..0db51258b2a7c 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -21,7 +21,7 @@ static __always_inline int read_cpu_id(void)
 
 static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 {
-	return (struct vdso_pcpu_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGES_START * PAGE_SIZE);
+	return _loongarch_data.pdata;
 }
 
 extern
-- 
2.53.0


