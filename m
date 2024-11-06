Return-Path: <stable+bounces-91703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD259BF491
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C651F236C9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340422076DF;
	Wed,  6 Nov 2024 17:48:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792362036E2;
	Wed,  6 Nov 2024 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915321; cv=none; b=gWk+n/itM65Dz2X6EcvKLl7WaN5UnUcKTQH6UoDqkz0/5s2Y85CLOiwQHmyCP5SS65DRMsMU8We1MbdA7F0GvigeJKXGisnOcFUqjPlaOf9MLAam5/4xNbaCZ2yQ44+jNPPLWNmpU2/B8ESfGeU4Pgmd8Mt/lW5VuVmVEsB6x7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915321; c=relaxed/simple;
	bh=MPiumqJT7AxuuDKLT0ImfUnDD8n1jnUk04Z9Z1kO6Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcPu3HN8sdrFBLdDnJyFNUV4zmYl9wr8EaItiCv6lkFjJrCi0gMy9QohSg1D/L0So3PQcKj+JNvkaOYYLwtLuKCoRK1D7ZqVd6OJxmMVRLyNj/43yv6+0d1y5gP1wtERaFSG19X5Isp81gIECdd8BqclL3QyKoITIkg8cHcPZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id F39E225021;
	Wed,  6 Nov 2024 20:48:31 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 20:48:04 +0300 (MSK)
Received: from MBP-Anastasia.DL (unknown [10.198.46.47])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XkCNM02rDz1h0CX;
	Wed,  6 Nov 2024 20:48:02 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	lvc-project@linuxtesting.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Christopher Covington <cov@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1 1/1] arm64: esr: Define ESR_ELx_EC_* constants as UL
Date: Wed,  6 Nov 2024 20:47:56 +0300
Message-ID: <20241106174757.38951-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106174757.38951-1-abelova@astralinux.ru>
References: <20241106174757.38951-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2024/11/06 14:56:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 188998 [Nov 06 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/06 15:41:00 #26827080
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2024/11/06 14:56:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Anastasia Belova <abelova@astralinux.ru>

commit b6db3eb6c373b97d9e433530d748590421bbeea7 upstream.

Add explicit casting to prevent expantion of 32th bit of
u32 into highest half of u64 in several places.

For example, in inject_abt64:
ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT = 0x24 << 26.
This operation's result is int with 1 in 32th bit.
While casting this value into u64 (esr is u64) 1
fills 32 highest bits.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: <stable@vger.kernel.org>
Fixes: aa8eff9bfbd5 ("arm64: KVM: fault injection into a guest")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/stable/20240910085016.32120-1-abelova%40astralinux.ru
Link: https://lore.kernel.org/r/20240910085016.32120-1-abelova@astralinux.ru
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/esr.h | 86 ++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 15b34fbfca66..4582cfc5d940 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -10,63 +10,63 @@
 #include <asm/memory.h>
 #include <asm/sysreg.h>
 
-#define ESR_ELx_EC_UNKNOWN	(0x00)
-#define ESR_ELx_EC_WFx		(0x01)
+#define ESR_ELx_EC_UNKNOWN	UL(0x00)
+#define ESR_ELx_EC_WFx		UL(0x01)
 /* Unallocated EC: 0x02 */
-#define ESR_ELx_EC_CP15_32	(0x03)
-#define ESR_ELx_EC_CP15_64	(0x04)
-#define ESR_ELx_EC_CP14_MR	(0x05)
-#define ESR_ELx_EC_CP14_LS	(0x06)
-#define ESR_ELx_EC_FP_ASIMD	(0x07)
-#define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
-#define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
+#define ESR_ELx_EC_CP15_32	UL(0x03)
+#define ESR_ELx_EC_CP15_64	UL(0x04)
+#define ESR_ELx_EC_CP14_MR	UL(0x05)
+#define ESR_ELx_EC_CP14_LS	UL(0x06)
+#define ESR_ELx_EC_FP_ASIMD	UL(0x07)
+#define ESR_ELx_EC_CP10_ID	UL(0x08)	/* EL2 only */
+#define ESR_ELx_EC_PAC		UL(0x09)	/* EL2 and above */
 /* Unallocated EC: 0x0A - 0x0B */
-#define ESR_ELx_EC_CP14_64	(0x0C)
-#define ESR_ELx_EC_BTI		(0x0D)
-#define ESR_ELx_EC_ILL		(0x0E)
+#define ESR_ELx_EC_CP14_64	UL(0x0C)
+#define ESR_ELx_EC_BTI		UL(0x0D)
+#define ESR_ELx_EC_ILL		UL(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
-#define ESR_ELx_EC_SVC32	(0x11)
-#define ESR_ELx_EC_HVC32	(0x12)	/* EL2 only */
-#define ESR_ELx_EC_SMC32	(0x13)	/* EL2 and above */
+#define ESR_ELx_EC_SVC32	UL(0x11)
+#define ESR_ELx_EC_HVC32	UL(0x12)	/* EL2 only */
+#define ESR_ELx_EC_SMC32	UL(0x13)	/* EL2 and above */
 /* Unallocated EC: 0x14 */
-#define ESR_ELx_EC_SVC64	(0x15)
-#define ESR_ELx_EC_HVC64	(0x16)	/* EL2 and above */
-#define ESR_ELx_EC_SMC64	(0x17)	/* EL2 and above */
-#define ESR_ELx_EC_SYS64	(0x18)
-#define ESR_ELx_EC_SVE		(0x19)
-#define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
+#define ESR_ELx_EC_SVC64	UL(0x15)
+#define ESR_ELx_EC_HVC64	UL(0x16)	/* EL2 and above */
+#define ESR_ELx_EC_SMC64	UL(0x17)	/* EL2 and above */
+#define ESR_ELx_EC_SYS64	UL(0x18)
+#define ESR_ELx_EC_SVE		UL(0x19)
+#define ESR_ELx_EC_ERET		UL(0x1a)	/* EL2 only */
 /* Unallocated EC: 0x1B */
-#define ESR_ELx_EC_FPAC		(0x1C)	/* EL1 and above */
-#define ESR_ELx_EC_SME		(0x1D)
+#define ESR_ELx_EC_FPAC		UL(0x1C)	/* EL1 and above */
+#define ESR_ELx_EC_SME		UL(0x1D)
 /* Unallocated EC: 0x1E */
-#define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
-#define ESR_ELx_EC_IABT_LOW	(0x20)
-#define ESR_ELx_EC_IABT_CUR	(0x21)
-#define ESR_ELx_EC_PC_ALIGN	(0x22)
+#define ESR_ELx_EC_IMP_DEF	UL(0x1f)	/* EL3 only */
+#define ESR_ELx_EC_IABT_LOW	UL(0x20)
+#define ESR_ELx_EC_IABT_CUR	UL(0x21)
+#define ESR_ELx_EC_PC_ALIGN	UL(0x22)
 /* Unallocated EC: 0x23 */
-#define ESR_ELx_EC_DABT_LOW	(0x24)
-#define ESR_ELx_EC_DABT_CUR	(0x25)
-#define ESR_ELx_EC_SP_ALIGN	(0x26)
+#define ESR_ELx_EC_DABT_LOW	UL(0x24)
+#define ESR_ELx_EC_DABT_CUR	UL(0x25)
+#define ESR_ELx_EC_SP_ALIGN	UL(0x26)
 /* Unallocated EC: 0x27 */
-#define ESR_ELx_EC_FP_EXC32	(0x28)
+#define ESR_ELx_EC_FP_EXC32	UL(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
-#define ESR_ELx_EC_FP_EXC64	(0x2C)
+#define ESR_ELx_EC_FP_EXC64	UL(0x2C)
 /* Unallocated EC: 0x2D - 0x2E */
-#define ESR_ELx_EC_SERROR	(0x2F)
-#define ESR_ELx_EC_BREAKPT_LOW	(0x30)
-#define ESR_ELx_EC_BREAKPT_CUR	(0x31)
-#define ESR_ELx_EC_SOFTSTP_LOW	(0x32)
-#define ESR_ELx_EC_SOFTSTP_CUR	(0x33)
-#define ESR_ELx_EC_WATCHPT_LOW	(0x34)
-#define ESR_ELx_EC_WATCHPT_CUR	(0x35)
+#define ESR_ELx_EC_SERROR	UL(0x2F)
+#define ESR_ELx_EC_BREAKPT_LOW	UL(0x30)
+#define ESR_ELx_EC_BREAKPT_CUR	UL(0x31)
+#define ESR_ELx_EC_SOFTSTP_LOW	UL(0x32)
+#define ESR_ELx_EC_SOFTSTP_CUR	UL(0x33)
+#define ESR_ELx_EC_WATCHPT_LOW	UL(0x34)
+#define ESR_ELx_EC_WATCHPT_CUR	UL(0x35)
 /* Unallocated EC: 0x36 - 0x37 */
-#define ESR_ELx_EC_BKPT32	(0x38)
+#define ESR_ELx_EC_BKPT32	UL(0x38)
 /* Unallocated EC: 0x39 */
-#define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
+#define ESR_ELx_EC_VECTOR32	UL(0x3A)	/* EL2 only */
 /* Unallocated EC: 0x3B */
-#define ESR_ELx_EC_BRK64	(0x3C)
+#define ESR_ELx_EC_BRK64	UL(0x3C)
 /* Unallocated EC: 0x3D - 0x3F */
-#define ESR_ELx_EC_MAX		(0x3F)
+#define ESR_ELx_EC_MAX		UL(0x3F)
 
 #define ESR_ELx_EC_SHIFT	(26)
 #define ESR_ELx_EC_WIDTH	(6)
-- 
2.47.0


