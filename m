Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73727BDF24
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376479AbjJIN0r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjJIN0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:26:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8E9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:26:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34E1C433C8;
        Mon,  9 Oct 2023 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858004;
        bh=HbtMn3yX1qOtPtIxlWyo1uGtnOlaS3UAWYZkrp/qS/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMcTHmPyS/dtmY7BptveC/2tKXjWhuxfDKo8kMN9FBsnndAtm3HF2qJb0EpSGdPFi
         Zx4OZs66j7FQnXl4psZoUEY5tq+26IKzWko3XDMCKrBFk9C5VGf72dfQD2WxQrekz0
         6lg2HQ6lJL7r5px6/LFTTPCdVX0Snf6VF/YhqNFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexandra Diupina <adiupina@astralinux.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 35/75] drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()
Date:   Mon,  9 Oct 2023 15:01:57 +0200
Message-ID: <20231009130112.463319075@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandra Diupina <adiupina@astralinux.ru>

[ Upstream commit a59addacf899b1b21a7b7449a1c52c98704c2472 ]

Process the result of hdlc_open() and call uhdlc_close()
in case of an error. It is necessary to pass the error
code up the control flow, similar to a possible
error in request_irq().
Also add a hdlc_close() call to the uhdlc_close()
because the comment to hdlc_close() says it must be called
by the hardware driver when the HDLC device is being closed

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 8305df1a3008a..44348e2dd95ea 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,6 +34,8 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_S)
 
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -705,6 +707,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
+	int rc = 0;
 
 	if (priv->hdlc_busy != 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -728,10 +731,13 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-		hdlc_open(dev);
+
+		rc = hdlc_open(dev);
+		if (rc)
+			uhdlc_close(dev);
 	}
 
-	return 0;
+	return rc;
 }
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
@@ -821,6 +827,8 @@ static int uhdlc_close(struct net_device *dev)
 	netdev_reset_queue(dev);
 	priv->hdlc_busy = 0;
 
+	hdlc_close(dev);
+
 	return 0;
 }
 
-- 
2.40.1



