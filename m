Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD1787693
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbjHXRRb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbjHXRRV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35419A3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11A163C3A
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36EAC433C8;
        Thu, 24 Aug 2023 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897438;
        bh=88ClI+6dkGTOrNKciLvZ+v2sks8R+1GGj1R7RriKmIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kc7x5puh0wWAiAAWMaFsgmDbDk3RE9Vf0X0pzJdFj6AHf4xgMLbaPkUi7CSa1FIQw
         MoyM/YyGOSQ8jgi3yFbs7it3dW5dfQr7jZz3QmaAfRJzN3Q9s8z2LM1zkJazKtU39H
         c8gDFu7IifFgQD+MOzWn58+RTq9kEHjnGPpUH0uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/135] powerpc/kasan: Disable KCOV in KASAN code
Date:   Thu, 24 Aug 2023 19:08:31 +0200
Message-ID: <20230824170618.837188836@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gray <bgray@linux.ibm.com>

[ Upstream commit ccb381e1af1ace292153c88eb1fffa5683d16a20 ]

As per the generic KASAN code in mm/kasan, disable KCOV with
KCOV_INSTRUMENT := n in the makefile.

This fixes a ppc64 boot hang when KCOV and KASAN are enabled.
kasan_early_init() gets called before a PACA is initialised, but the
KCOV hook expects a valid PACA.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230710044143.146840-1-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/kasan/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b2..8636b17c6a20f 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KASAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
-- 
2.40.1



