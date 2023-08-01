Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8F76AFD7
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjHAJuf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjHAJuQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191A2D44
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354996150D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD7AC433C7;
        Tue,  1 Aug 2023 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883388;
        bh=bSNXkM12ehFkEEqG8TfHzaOkakg+YHN8Tnnj4JSgxZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzGWScYsXeCVY5Y/KOA2A0OBambchgf1e+NhJE0J+epc+7cJIG2MDyX2ZiX7NaEaK
         5Ny3Qb819bokBe6kpVKd6Bz/2GOLNsFRYh+QPL0v9ci/TK+6Qx8IJIG9P2pBnW7KQu
         V03eNNDhoYik5YzewHFGI3y+b9NC30H8sn7kFXic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.4 190/239] x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled
Date:   Tue,  1 Aug 2023 11:20:54 +0200
Message-ID: <20230801091932.547505137@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

commit fd470a8beed88440b160d690344fbae05a0b9b1b upstream.

Unlike Intel's Enhanced IBRS feature, AMD's Automatic IBRS does not
provide protection to processes running at CPL3/user mode, see section
"Extended Feature Enable Register (EFER)" in the APM v2 at
https://bugzilla.kernel.org/attachment.cgi?id=304652

Explicitly enable STIBP to protect against cross-thread CPL3
branch target injections on systems with Automatic IBRS enabled.

Also update the relevant documentation.

Fixes: e7862eda309e ("x86/cpu: Support AMD Automatic IBRS")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230720194727.67022-1-kim.phillips@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst |   11 +++++++----
 arch/x86/kernel/cpu/bugs.c                    |   15 +++++++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -484,11 +484,14 @@ Spectre variant 2
 
    Systems which support enhanced IBRS (eIBRS) enable IBRS protection once at
    boot, by setting the IBRS bit, and they're automatically protected against
-   Spectre v2 variant attacks, including cross-thread branch target injections
-   on SMT systems (STIBP). In other words, eIBRS enables STIBP too.
+   Spectre v2 variant attacks.
 
-   Legacy IBRS systems clear the IBRS bit on exit to userspace and
-   therefore explicitly enable STIBP for that
+   On Intel's enhanced IBRS systems, this includes cross-thread branch target
+   injections on SMT systems (STIBP). In other words, Intel eIBRS enables
+   STIBP, too.
+
+   AMD Automatic IBRS does not protect userspace, and Legacy IBRS systems clear
+   the IBRS bit on exit to userspace, therefore both explicitly enable STIBP.
 
    The retpoline mitigation is turned on by default on vulnerable
    CPUs. It can be forced on or off by the administrator
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1199,19 +1199,21 @@ spectre_v2_user_select_mitigation(void)
 	}
 
 	/*
-	 * If no STIBP, enhanced IBRS is enabled, or SMT impossible, STIBP
+	 * If no STIBP, Intel enhanced IBRS is enabled, or SMT impossible, STIBP
 	 * is not required.
 	 *
-	 * Enhanced IBRS also protects against cross-thread branch target
+	 * Intel's Enhanced IBRS also protects against cross-thread branch target
 	 * injection in user-mode as the IBRS bit remains always set which
 	 * implicitly enables cross-thread protections.  However, in legacy IBRS
 	 * mode, the IBRS bit is set only on kernel entry and cleared on return
-	 * to userspace. This disables the implicit cross-thread protection,
-	 * so allow for STIBP to be selected in that case.
+	 * to userspace.  AMD Automatic IBRS also does not protect userspace.
+	 * These modes therefore disable the implicit cross-thread protection,
+	 * so allow for STIBP to be selected in those cases.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !smt_possible ||
-	    spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
 		return;
 
 	/*
@@ -2343,7 +2345,8 @@ static ssize_t mmio_stale_data_show_stat
 
 static char *stibp_state(void)
 {
-	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	    !boot_cpu_has(X86_FEATURE_AUTOIBRS))
 		return "";
 
 	switch (spectre_v2_user_stibp) {


