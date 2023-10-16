Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85D57CA110
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJPHzw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJPHzw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 03:55:52 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F2DE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:55:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AFF740E01AA;
        Mon, 16 Oct 2023 07:55:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v7XoXMhNayxI; Mon, 16 Oct 2023 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697442946; bh=fz6hqbd0QgB2y+oYQqWyczsjsdibvqvcbH4mVBPq9Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLsuZDZA3k+xx+HEcy+KHESchlPmHrkQvGfxMFa5++NPo/Onj4068u7nGPDSXnkqj
         3mAWkdkI6iKLCCCZUBy2jCsXfNCdZ8gJ7LD5iFYy/kSaDO1xt6yjsCJT5tSaIUPuUO
         T3Ff8QO//lmADvOX+gsFg1zqG9NPLFaSzR7RUiaHvoeVPjllphdSDi2G9+OkiWIoGw
         nyhTnCaTkH8S2i0yKaGqE+nka6krsEfAezof8KOIpOr+FBGd9t7xfdDD++obhfXZfr
         Xps8NA3657aHKC+43v8MJIVHIN6IqlCPlX+7L6P/nq2XoEtT5gsrsnGzYf1PS/e0fF
         Y2vsob05pB0I96Xnz/8oR7HugZ/rMsPadnwzKaQq8BxX6MltgPZU6sepYdGroAAWBZ
         fVl//RKzpe4BlyX+AKdPey/ysBU+EOY6PLS//5hnRWhJ5+5q5fOgbVRCWWTzR8R6uJ
         NDubQ4r7maO8OxQuLFIbIEdnkPfSKV5BFAZICeevaHY+sH27J6wCAY5fm4oTlQWq6+
         KWrhqChcgbc82v4h+yD8cdK8BLxsMTm5aJcV9KOCJwY1NiasUt7Vo8mXp7L2PRX96F
         veCMDGS3qw88nWI2vOXV6UtI0lkHmp9FmxhcROxrL/y7y1XemF4Qupn1snjkYZL8kI
         wHmkTKQHHinmQy++BRZHcsxk=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E84CE40E014B;
        Mon, 16 Oct 2023 07:55:41 +0000 (UTC)
Date:   Mon, 16 Oct 2023 09:55:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     gregkh@linuxfoundation.org
Cc:     rene@exactcode.de, stable@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/cpu: Fix AMD erratum #1485 on
 Zen4-based CPUs" failed to apply to 4.14-stable tree
Message-ID: <20231016075537.GBZSzseVhKAg9674XP@fat_crate.local>
References: <2023101528-jawed-shelving-071a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023101528-jawed-shelving-071a@gregkh>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sat, 7 Oct 2023 12:57:02 +0200
Subject: [PATCH] x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Upstream commit f454b18e07f518bcd0c05af17a2239138bff52de.

Fix erratum #1485 on Zen4 parts where running with STIBP disabled can
cause an #UD exception. The performance impact of the fix is negligible.

Reported-by: Ren=C3=A9 Rebe <rene@exactcode.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Ren=C3=A9 Rebe <rene@exactcode.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/D99589F4-BC5D-430B-87B2-72C20370CF57@exac=
tcode.com
---
 arch/x86/include/asm/msr-index.h | 4 ++++
 arch/x86/kernel/cpu/amd.c        | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
index 3a1e43588685..a10cd3fef963 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -442,6 +442,10 @@
=20
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
=20
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
=20
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index e0c9ede0196a..96305270c435 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -24,6 +24,7 @@
=20
 static const int amd_erratum_383[];
 static const int amd_erratum_400[];
+static const int amd_erratum_1485[];
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erra=
tum);
=20
 /*
@@ -974,6 +975,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	    cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
=20
 #ifdef CONFIG_X86_32
@@ -1102,6 +1107,10 @@ static const int amd_erratum_383[] =3D
 	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
=20
=20
+static const int amd_erratum_1485[] =3D
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erra=
tum)
 {
 	int osvw_id =3D *erratum++;
--=20
2.42.0.rc0.25.ga82fb66fed25


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
