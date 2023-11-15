Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4C7ECD68
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjKOTg1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjKOTgW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FFCD4D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF61C433BB;
        Wed, 15 Nov 2023 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076977;
        bh=XeKyegiWDsh/wyPg1psx59hYgy/R0wJMwDxlbVqpgxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahUsrRutrynBd7hCS/ljavKqiCYbeKLitj3nGdFjZ89GawOaWiD6HQrVOgbYwiwAR
         Ln9v6JbMWFogZ9qfIwwhDncNqK+eDxXKFWrAOgMUbn4i1xWQ7euFG0jYvZVkRXxzXE
         KHbBKPh7sJWuCrQfrZ55FhSnMw2Iczk542zIQ8Mg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 481/550] media: vidtv: psi: Add check for kstrdup
Date:   Wed, 15 Nov 2023 14:17:45 -0500
Message-ID: <20231115191634.208941594@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 76a2c5df6ca8bd8ada45e953b8c72b746f42918d ]

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: 7a7899f6f58e ("media: vidtv: psi: Implement an Event Information Table (EIT)")
Fixes: c2f78f0cb294 ("media: vidtv: psi: add a Network Information Table (NIT)")
Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 45 +++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index ce0b7a6e92dc3..2a51c898c11eb 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -301,16 +301,29 @@ struct vidtv_psi_desc_service *vidtv_psi_service_desc_init(struct vidtv_psi_desc
 
 	desc->service_name_len = service_name_len;
 
-	if (service_name && service_name_len)
+	if (service_name && service_name_len) {
 		desc->service_name = kstrdup(service_name, GFP_KERNEL);
+		if (!desc->service_name)
+			goto free_desc;
+	}
 
 	desc->provider_name_len = provider_name_len;
 
-	if (provider_name && provider_name_len)
+	if (provider_name && provider_name_len) {
 		desc->provider_name = kstrdup(provider_name, GFP_KERNEL);
+		if (!desc->provider_name)
+			goto free_desc_service_name;
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
+
+free_desc_service_name:
+	if (service_name && service_name_len)
+		kfree(desc->service_name);
+free_desc:
+	kfree(desc);
+	return NULL;
 }
 
 struct vidtv_psi_desc_registration
@@ -355,8 +368,13 @@ struct vidtv_psi_desc_network_name
 
 	desc->length = network_name_len;
 
-	if (network_name && network_name_len)
+	if (network_name && network_name_len) {
 		desc->network_name = kstrdup(network_name, GFP_KERNEL);
+		if (!desc->network_name) {
+			kfree(desc);
+			return NULL;
+		}
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
@@ -442,15 +460,32 @@ struct vidtv_psi_desc_short_event
 		iso_language_code = "eng";
 
 	desc->iso_language_code = kstrdup(iso_language_code, GFP_KERNEL);
+	if (!desc->iso_language_code)
+		goto free_desc;
 
-	if (event_name && event_name_len)
+	if (event_name && event_name_len) {
 		desc->event_name = kstrdup(event_name, GFP_KERNEL);
+		if (!desc->event_name)
+			goto free_desc_language_code;
+	}
 
-	if (text && text_len)
+	if (text && text_len) {
 		desc->text = kstrdup(text, GFP_KERNEL);
+		if (!desc->text)
+			goto free_desc_event_name;
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
+
+free_desc_event_name:
+	if (event_name && event_name_len)
+		kfree(desc->event_name);
+free_desc_language_code:
+	kfree(desc->iso_language_code);
+free_desc:
+	kfree(desc);
+	return NULL;
 }
 
 struct vidtv_psi_desc *vidtv_psi_desc_clone(struct vidtv_psi_desc *desc)
-- 
2.42.0



