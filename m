Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C6719D69
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjFANWt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjFANWr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467A97
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9B760A0B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B142C433EF;
        Thu,  1 Jun 2023 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625765;
        bh=aiYXE7OjtZw5d+fA+53xrBfr0NXXx+y/x4JybuWeWkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMI2nz5myAKj4U11JD0+JZx2qVxdJ41PAKXhh0e2NxtMcKTy5y59kmsTZNTadCv2f
         aiJ3QnwexdjXsgM0uPO7E56EvXo30Bia8Sflxd7sl8+swZbEz3O9Ka9uPd36ftcVJo
         Eg6ikQdV1zY1Tl3sCi371CpNXO+gwSxT5OB2V4Us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Bersenev <bay@hackerdom.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 09/16] cdc_ncm: Fix the build warning
Date:   Thu,  1 Jun 2023 14:21:04 +0100
Message-Id: <20230601131932.389174924@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
References: <20230601131931.947241286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Bersenev <bay@hackerdom.ru>

[ Upstream commit 5d0ab06b63fc9c727a7bb72c81321c0114be540b ]

The ndp32->wLength is two bytes long, so replace cpu_to_le32 with cpu_to_le16.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5fb4f74c26efd..4824385fe2c79 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1177,7 +1177,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 		ndp32 = ctx->delayed_ndp32;
 
 	ndp32->dwSignature = sign;
-	ndp32->wLength = cpu_to_le32(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
+	ndp32->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
 	return ndp32;
 }
 
-- 
2.39.2



