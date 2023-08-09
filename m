Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA77759DA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjHILDf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjHILDb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699F2110
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678D6630D7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E40C433CC;
        Wed,  9 Aug 2023 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579009;
        bh=dp+8IKv4mgmy3Z/UBKxdAA2/zaz9V9IQSESzQaPR1qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2Yq0HrJPSKS8B96rcRLlFsDYvngKZ2ylsPwPLWXLouadHQfoX+TTYJSEw3tSVIBT
         EIuSMijrMAYNeuFJHXctN38x692uObFaDGdFqYN5neNmU8t51T0NF+R/kr9fnGLTPR
         VOyTA0AtCEesoDRPuZwgMLsvBx4Jzt8n13V3xXd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Leo Li <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org,
        Kumar Gala <galak@kernel.crashing.org>,
        Nicolas Schier <nicolas@jasle.eu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/204] soc/fsl/qe: fix usb.c build errors
Date:   Wed,  9 Aug 2023 12:39:39 +0200
Message-ID: <20230809103643.950006860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 7b1a78babd0d2cd27aa07255dee0c2d7ac0f31e3 ]

Fix build errors in soc/fsl/qe/usb.c when QUICC_ENGINE is not set.
This happens when PPC_EP88XC is set, which selects CPM1 & CPM.
When CPM is set, USB_FSL_QE can be set without QUICC_ENGINE
being set. When USB_FSL_QE is set, QE_USB deafults to y, which
causes build errors when QUICC_ENGINE is not set. Making
QE_USB depend on QUICC_ENGINE prevents QE_USB from defaulting to y.

Fixes these build errors:

drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
usb.c:(.text+0x1e): undefined reference to `qe_immr'
powerpc-linux-ld: usb.c:(.text+0x2a): undefined reference to `qe_immr'
powerpc-linux-ld: usb.c:(.text+0xbc): undefined reference to `qe_setbrg'
powerpc-linux-ld: usb.c:(.text+0xca): undefined reference to `cmxgcr_lock'
powerpc-linux-ld: usb.c:(.text+0xce): undefined reference to `cmxgcr_lock'

Fixes: 5e41486c408e ("powerpc/QE: add support for QE USB clocks routing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202301101500.pillNv6R-lkp@intel.com/
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Leo Li <leoyang.li@nxp.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Nicolas Schier <nicolas@jasle.eu>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index 73a2e08b47ef9..e2ccddd348b5b 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -37,6 +37,7 @@ config QE_TDM
 
 config QE_USB
 	bool
+	depends on QUICC_ENGINE
 	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
-- 
2.39.2



