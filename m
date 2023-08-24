Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489C787389
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjHXPEO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbjHXPDr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ADF19B2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 592BE6719F
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD3FC433C8;
        Thu, 24 Aug 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889424;
        bh=R3R6eW9fknteVr3APEBLVlX+BXtBiNnOYSi6HBZkLnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJ2tyt4vzFOHqj3UKX5t+iaIF6sNVwtfJkOyFNdScTVR/VVfu+xg6b8/4VYwTy36y
         1GOzgYsCPTDHWBi+TcN/0YMbJXuZS2QilZkAvcPiqjQKXfEmh12x66ADHLi/fqDEpq
         KLA8MS9VvFvV2slBm+wvQqdR1x8QCK7pDViUC1Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.10 132/135] x86/srso: Disable the mitigation on unaffected configurations
Date:   Thu, 24 Aug 2023 16:51:15 +0200
Message-ID: <20230824145032.763783515@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Borislav Petkov (AMD) <bp@alien8.de>

commit e9fbc47b818b964ddff5df5b2d5c0f5f32f4a147 upstream.

Skip the srso cmd line parsing which is not needed on Zen1/2 with SMT
disabled and with the proper microcode applied (latter should be the
case anyway) as those are not affected.

Fixes: 5a15d8348881 ("x86/srso: Tie SBPB bit setting to microcode patch detection")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230813104517.3346-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2329,8 +2329,10 @@ static void __init srso_select_mitigatio
 		 * IBPB microcode has been applied.
 		 */
 		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
+		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+			return;
+		}
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
@@ -2616,6 +2618,9 @@ static ssize_t gds_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
+	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
+		return sysfs_emit(buf, "Not affected\n");
+
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
 			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));


