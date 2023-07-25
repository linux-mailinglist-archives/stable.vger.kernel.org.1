Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F9761165
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjGYKur (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjGYKu2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3A1FFA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52FB961648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6906BC433C8;
        Tue, 25 Jul 2023 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282210;
        bh=d5u29PkFHU5M4AVwKAW5UzJ/SzyrOt0Mh00oKMvMpjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHLy3i9dqRyMMkjWz/xoMLIY+7+BCqH5cdmi8OvaBMhcFv1yKtNSWeiT5wPD2E5wY
         wZv5NdOZoacC6wKWuM9HqjW+a82Mb9rdzk4npNv7nowx8GFPyTvl7Wgq/awAp8lPWe
         N29EaWuQNorSfQVkp6v6c+3EpSw35UNwCYojW2Jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 6.4 048/227] drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP
Date:   Tue, 25 Jul 2023 12:43:35 +0200
Message-ID: <20230725104516.790119455@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

commit ea293f823a8805735d9e00124df81a8f448ed1ae upstream.

Fixes OOPS on boards with ANX9805 DP encoders.

Cc: stable@vger.kernel.org # 6.4+
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230719044051.6975-3-skeggsb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1873,6 +1873,8 @@ nv50_pior_destroy(struct drm_encoder *en
 	nvif_outp_dtor(&nv_encoder->outp);
 
 	drm_encoder_cleanup(encoder);
+
+	mutex_destroy(&nv_encoder->dp.hpd_irq_lock);
 	kfree(encoder);
 }
 
@@ -1917,6 +1919,8 @@ nv50_pior_create(struct drm_connector *c
 	nv_encoder->i2c = ddc;
 	nv_encoder->aux = aux;
 
+	mutex_init(&nv_encoder->dp.hpd_irq_lock);
+
 	encoder = to_drm_encoder(nv_encoder);
 	encoder->possible_crtcs = dcbe->heads;
 	encoder->possible_clones = 0;


