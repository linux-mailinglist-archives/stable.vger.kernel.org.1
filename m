Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1175CDD4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjGUQPI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjGUQOq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D13C32
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A43FF61D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C405C433C7;
        Fri, 21 Jul 2023 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956056;
        bh=oytDSgUuT7xYCf3cXJP0kRhgXITYLduCI35TG+iGW8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p42NZ8d1XsX1QBd5J1uI+j2MEzPJN03H9e2CN/hqkTbV6+NgRgxg+dTcf3+yfLRLx
         IadGZEjJCI/024RUTUNV+Um2JS6WbeWaOYhcHxGlAro/SKU2M7VmonfVWyiKUkS1D0
         YzvGYL1Cn5PiZNdIVY0CdLgUwJyORiQHLmNiJqRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karol Herbst <kherbst@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 100/292] drm/nouveau/acr: Abort loading ACR if no firmware was found
Date:   Fri, 21 Jul 2023 18:03:29 +0200
Message-ID: <20230721160533.091378955@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karol Herbst <kherbst@redhat.com>

[ Upstream commit 938a06c8b7913455073506c33ae3bff029c3c4ef ]

This fixes a NULL pointer access inside nvkm_acr_oneinit in case necessary
firmware files couldn't be loaded.

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/212
Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230522201838.1496622-1-kherbst@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
index 795f3a649b122..9b8ca4e898f90 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
@@ -224,7 +224,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
 	u64 falcons;
 	int ret, i;
 
-	if (list_empty(&acr->hsfw)) {
+	if (list_empty(&acr->hsfw) || !acr->func || !acr->func->wpr_layout) {
 		nvkm_debug(subdev, "No HSFW(s)\n");
 		nvkm_acr_cleanup(acr);
 		return 0;
-- 
2.39.2



