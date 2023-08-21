Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D2783271
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjHUT6u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHUT6s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C904812C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6802F646DE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E90C433CC;
        Mon, 21 Aug 2023 19:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647925;
        bh=ziT8LjD+H6/mXuzlnivpUnSdMdH6GPHZrgYd7YEQQ40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2dinN01orruxTDe+O9kyaWQ5/Jm/uRiOzKW6S00I/M/RzGLZTUXuLly1UD6bzWU0
         gIUwRROZvQQyHlUi7yhPrZJeCPoLjscwIqv3K9CQHZ1Pl+WB+VdPLPGqtDVrvv7yaZ
         h43YDg6HnNq0LOoXQOx7wjpae0IF41qjemgw+iQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 187/194] x86/srso: Correct the mitigation status when SMT is disabled
Date:   Mon, 21 Aug 2023 21:42:46 +0200
Message-ID: <20230821194130.911317510@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

commit 6405b72e8d17bd1875a56ae52d23ec3cd51b9d66 upstream.

Specify how is SRSO mitigated when SMT is disabled. Also, correct the
SMT check for that.

Fixes: e9fbc47b818b ("x86/srso: Disable the mitigation on unaffected configurations")
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20230814200813.p5czl47zssuej7nv@treble
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2398,8 +2398,7 @@ static void __init srso_select_mitigatio
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
+		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
@@ -2689,7 +2688,7 @@ static ssize_t gds_show_state(char *buf)
 static ssize_t srso_show_state(char *buf)
 {
 	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
-		return sysfs_emit(buf, "Not affected\n");
+		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],


