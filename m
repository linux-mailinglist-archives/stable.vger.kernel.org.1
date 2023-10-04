Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD007B883F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbjJDSOP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbjJDSOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE5A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27B9C433C8;
        Wed,  4 Oct 2023 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443250;
        bh=J2VKG8KDKIseZxHnxgPyzT+tv70JUlv1T8xtTi6Q4A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tE+PRgUT8u7q0gUDI+y0CZHzLLM2dEOi7uZigq1tQvhLD+aPGld2bkjYsn3DUHcPm
         6CEdpBGsP9gTovF+dNptGJlIiXYoaffSNR2DDOU46agMZdx1PtShaejKl/pxExwCoH
         Jr1LyJ1Ls1rDZD5FzLqe+Gus9qIYmQHZYVMAmReU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiaoke Wang <xkernel.wang@foxmail.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 089/259] i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()
Date:   Wed,  4 Oct 2023 19:54:22 +0200
Message-ID: <20231004175221.437049588@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaoke Wang <xkernel.wang@foxmail.com>

[ Upstream commit 7c0195fa9a9e263df204963f88a22b21688ffb66 ]

devm_kstrdup() returns pointer to allocated string on success,
NULL on failure. So it is better to check the return value of it.

Fixes: e35478eac030 ("i2c: mux: demux-pinctrl: run properly with multiple instances")
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index f7a7405d4350a..8e8688e8de0fb 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -243,6 +243,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
-- 
2.40.1



