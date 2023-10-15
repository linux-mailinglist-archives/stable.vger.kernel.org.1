Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9B7C9B5F
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 22:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJOUW2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOUW1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 16:22:27 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185ECAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 13:22:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F64840E01AA;
        Sun, 15 Oct 2023 20:22:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uGoJYQ5cYcXv; Sun, 15 Oct 2023 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697401336; bh=FwGRrYlCqTtjjDFMtf2Syfxetw6fMP6rokeUAo3DNrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgCvAEuJHb83SpXIdAC/Qyxymctmy3vccgakdQYvRTslhKsEkaog2CF4jxoZDjNxT
         QxsV1c70DRzQCIzJf0zErt+u1dLBJOpsdHFnqChWEiKAjhqflne438GztyPi7b8jSE
         AKMLhjmxg1fzSs3avGXC/udOfl9+GaIjwu6z8f8iKWw8FlFMElzNrmHT/hGfn9J/cj
         qBcHHxMME4tlaggSwxsZ4KYJHJbGniWjdlyIGd5JXxJxBjPTHi7R2/Yvwgiln6J0tV
         IwN5I50/pVVyFu/or9KIvUkEyWbmpAqGGBz6WADf40qK7Dh6h0nj3bXSAhRZbeQIGX
         YdPjfCxSGu6xwwDabvxG113bv7P5UYpe1g1xNt8CryXxzrGRetcEXVApNeVcYoKa4K
         C0leBzU8gvRt5sn1dckz1K45S9gDJPUN70nUvoatb5QbL3EkJWQs+UQ7EepcPG1gY4
         WQYBQL+0UyKCU6JPJY6QChMtzmPJGT0B5Chy4RfPw7xaSqVZCAurE1z/nwuVAoqbcl
         qHinH9EC/rbiYEOWQfEMb+ZEBUDcsKJXan1bEQDWxlOypklWTw1lfkW3TN2MWtmuqH
         oiRbsTrJePLXxo/YhVXi6gtKsAV+PSrv9JOWmChgLOLx4JPyGeH0wuLEKO3RB3CFlA
         GYYUUYNYIU4c/fwMtyFwAi3g=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B54AA40E014B;
        Sun, 15 Oct 2023 20:22:12 +0000 (UTC)
Date:   Sun, 15 Oct 2023 22:22:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     gregkh@linuxfoundation.org
Cc:     rene@exactcode.de, stable@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/cpu: Fix AMD erratum #1485 on
 Zen4-based CPUs" failed to apply to 5.4-stable tree
Message-ID: <20231015202207.GCZSxJ75lVvnJKNj/M@fat_crate.local>
References: <2023101526-mumbling-theft-3113@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023101526-mumbling-theft-3113@gregkh>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
 arch/x86/kernel/cpu/amd.c        | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
index 7137256f2c31..7167a162d7be 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -502,6 +502,10 @@
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
index fcffee447ba1..eb3cd4ad45ae 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -75,6 +75,10 @@ static const int amd_zenbleed[] =3D
 			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
=20
+static const int amd_erratum_1485[] =3D
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erra=
tum)
 {
 	int osvw_id =3D *erratum++;
@@ -1117,6 +1121,10 @@ static void init_amd(struct cpuinfo_x86 *c)
 	check_null_seg_clears_base(c);
=20
 	zenbleed_check(c);
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
=20
 #ifdef CONFIG_X86_32
--=20
2.42.0.rc0.25.ga82fb66fed25


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
