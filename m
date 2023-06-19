Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3863E7352DC
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjFSKi7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFSKiw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD6E9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E063860B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C6CC433C8;
        Mon, 19 Jun 2023 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171130;
        bh=p65th1/VH7uyQAFReinMAJRxYsIds31Xi9sAAbdGQ5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xc1DtrFgjx2tue+2x2/Hvlo7ul41RaPsajRFGNseD2PIwlHZapDlaaV1lDkn1nnKs
         zX+S1slClY6jvT73RtTmDXmlMxbaKxxbQPUe2Kb1M17ldjOEk3VK0oP0OXPaTaw1Fh
         kw/7e7nJnq0+cDPfS/wKt1hoAxz6cMuedD8DLdUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Natalia Petrova <n.petrova@fintech.ru>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 159/187] drm/nouveau: add nv_encoder pointer check for NULL
Date:   Mon, 19 Jun 2023 12:29:37 +0200
Message-ID: <20230619102205.264405015@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Natalia Petrova <n.petrova@fintech.ru>

[ Upstream commit 55b94bb8c42464bad3d2217f6874aa1a85664eac ]

Pointer nv_encoder could be dereferenced at nouveau_connector.c
in case it's equal to NULL by jumping to goto label.
This patch adds a NULL-check to avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3195c5f9784a ("drm/nouveau: set encoder for lvds")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[Fixed patch title]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230512103320.82234-1-n.petrova@fintech.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 5dbf025e68737..f75c6f09dd2af 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -730,7 +730,8 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 #endif
 
 	nouveau_connector_set_edid(nv_connector, edid);
-	nouveau_connector_set_encoder(connector, nv_encoder);
+	if (nv_encoder)
+		nouveau_connector_set_encoder(connector, nv_encoder);
 	return status;
 }
 
-- 
2.39.2



