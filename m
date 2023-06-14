Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647D72BFF3
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjFLKsU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFLKrz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242523C26
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDAC8623E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006CCC433EF;
        Mon, 12 Jun 2023 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565962;
        bh=KQSwfsewYJxBPelnOyXM0ylwKW2KNSABwC09aLtOANo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbPCbXmJ6zrgYQy00gnukGrsVab6ORYgx4575qZJJZuAS9VZn3YIEG6B6B1bXkHbO
         mf4ASVHwcbQeh/HG9sy+auE0Vd0WWhAQRiy1g2FcGpj6iZrKDtt3rSAKk5nXzo0KQN
         OedlZdIodEcD5+eY+qEMAoxl/Ydp7d34Zbp6w07A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 5.10 12/68] staging: vchiq_core: drop vchiq_status from vchiq_initialise
Date:   Mon, 12 Jun 2023 12:26:04 +0200
Message-ID: <20230612101658.976499523@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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

From: Stefan Wahren <stefan.wahren@i2se.com>

commit abf2836a381a30763e24acd58da56fa615c6581a upstream.

Replace the custom set of return values with proper Linux error codes for
vchiq_initialise().

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Link: https://lore.kernel.org/r/1619347863-16080-11-git-send-email-stefan.wahren@i2se.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |   20 +++++-----
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -147,12 +147,11 @@ vchiq_blocking_bulk_transfer(unsigned in
 	unsigned int size, enum vchiq_bulk_dir dir);
 
 #define VCHIQ_INIT_RETRIES 10
-enum vchiq_status vchiq_initialise(struct vchiq_instance **instance_out)
+int vchiq_initialise(struct vchiq_instance **instance_out)
 {
-	enum vchiq_status status = VCHIQ_ERROR;
 	struct vchiq_state *state;
 	struct vchiq_instance *instance = NULL;
-	int i;
+	int i, ret;
 
 	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
 
@@ -169,6 +168,7 @@ enum vchiq_status vchiq_initialise(struc
 	if (i == VCHIQ_INIT_RETRIES) {
 		vchiq_log_error(vchiq_core_log_level,
 			"%s: videocore not initialized\n", __func__);
+		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
 		vchiq_log_warning(vchiq_core_log_level,
@@ -180,6 +180,7 @@ enum vchiq_status vchiq_initialise(struc
 	if (!instance) {
 		vchiq_log_error(vchiq_core_log_level,
 			"%s: error allocating vchiq instance\n", __func__);
+		ret = -ENOMEM;
 		goto failed;
 	}
 
@@ -190,13 +191,13 @@ enum vchiq_status vchiq_initialise(struc
 
 	*instance_out = instance;
 
-	status = VCHIQ_SUCCESS;
+	ret = 0;
 
 failed:
 	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
+		"%s(%p): returning %d", __func__, instance, ret);
 
-	return status;
+	return ret;
 }
 EXPORT_SYMBOL(vchiq_initialise);
 
@@ -2223,6 +2224,7 @@ vchiq_keepalive_thread_func(void *v)
 	enum vchiq_status status;
 	struct vchiq_instance *instance;
 	unsigned int ka_handle;
+	int ret;
 
 	struct vchiq_service_params_kernel params = {
 		.fourcc      = VCHIQ_MAKE_FOURCC('K', 'E', 'E', 'P'),
@@ -2231,10 +2233,10 @@ vchiq_keepalive_thread_func(void *v)
 		.version_min = KEEPALIVE_VER_MIN
 	};
 
-	status = vchiq_initialise(&instance);
-	if (status != VCHIQ_SUCCESS) {
+	ret = vchiq_initialise(&instance);
+	if (ret) {
 		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_initialise failed %d", __func__, status);
+			"%s vchiq_initialise failed %d", __func__, ret);
 		goto exit;
 	}
 


