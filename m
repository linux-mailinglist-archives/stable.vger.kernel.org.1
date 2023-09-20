Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231A57A7F86
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjITM1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjITM1k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:27:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93315C9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:27:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D157AC433C7;
        Wed, 20 Sep 2023 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212853;
        bh=Q7/hj1/GoC1TRiqEHC+Tjb1E+ZN/IcBIMwcduhDxkXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGzZliaNTJrrsuzmHuiJO97heOmpdBP1BJOz9Ebmtu5OTaRBWwAbqdxu2WmhcVkiW
         a6XATnSSzNVi0BLKQMzxnaFNeSj+RVmKs0fBkwPh+bc2MUdvSJfVrafrcsjcdLz4iq
         58nCxYLJT6NogWvca0yiWfAR+u8VkXk9oKaJVLGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 044/367] powerpc/32s: Fix assembler warning about r0
Date:   Wed, 20 Sep 2023 13:27:01 +0200
Message-ID: <20230920112859.636560941@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit b51ba4fe2e134b631f9c8f45423707aab71449b5 upstream.

The assembler says:
  arch/powerpc/kernel/head_32.S:1095: Warning: invalid register expression

It's objecting to the use of r0 as the RA argument. That's because
when RA = 0 the literal value 0 is used, rather than the content of
r0, making the use of r0 in the source potentially confusing.

Fix it to use a literal 0, the generated code is identical.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/2b69ac8e1cddff6f808fc7415907179eab4aae9e.1596693679.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/head_32.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -922,7 +922,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_T
 	 */
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
-	stw	r5, 0xf0(r0)	/* This much match your Abatron config */
+	stw	r5, 0xf0(0)	/* This much match your Abatron config */
 	lis	r6, swapper_pg_dir@h
 	ori	r6, r6, swapper_pg_dir@l
 	tophys(r5, r5)


