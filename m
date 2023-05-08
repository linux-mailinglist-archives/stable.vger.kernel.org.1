Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86E6FABB9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjEHLQt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjEHLQs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A337611
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DDA362C09
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7F9C433EF;
        Mon,  8 May 2023 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544603;
        bh=TDiau+zfBxFbKvVSuhNND9OxJa3qdwFgDMrE057EEFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ap12QYBGHd/4QSzQ5dVoYls21d2jaifR/IeBIN59G9x7CviEbMthBs11sSxyYbsdX
         Du4iHIqxoiT2cHDFYOSaEJ9Z1o/75qNLOeiZNOHsaKbULzTxnKrFtfCy1n8NqKMCpS
         lUkZAW6KLhKKGfseMd25JVPBMUcq6u0NfnjKl11o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiefeng Li <jiefeng_li@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 446/694] wifi: mt76: mt7921: fix missing unwind goto in `mt7921u_probe`
Date:   Mon,  8 May 2023 11:44:41 +0200
Message-Id: <20230508094448.012281431@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiefeng Li <jiefeng_li@hust.edu.cn>

[ Upstream commit 5c47cdebbaeb7724df6f9f46917c93e53f791547 ]

`mt7921u_dma_init` can only return zero or negative number according to its
definition. When it returns non-zero number, there exists an error and this
function should handle this error rather than return directly.

Fixes: 0d2afe09fad5 ("mt76: mt7921: add mt7921u driver")
Signed-off-by: Jiefeng Li <jiefeng_li@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8fef09ed29c91..70c9bbdbf60e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -272,7 +272,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 
 	ret = mt7921u_dma_init(dev, false);
 	if (ret)
-		return ret;
+		goto error;
 
 	hw = mt76_hw(dev);
 	/* check hw sg support in order to enable AMSDU */
-- 
2.39.2



