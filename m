Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5075CE04
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGUQQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGUQQ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5743599
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D8D861D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30412C433C7;
        Fri, 21 Jul 2023 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956132;
        bh=UOC4YaUSp80zDPImaHYO9dyBUubaKOKNwNkGhjaZnds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ktCm3Hjam9NblzJ3hQH7OxhFZyTW4vlMEWjjYOb0ddvkyHW9D2eaIOH1zvM5J3va
         xEWjuuYT0x1o5K2rmzqGMN/DDe/wAgRwzp+ISlrsDyhSuhcqO49T9aX0svLYYzwGg3
         J6uItrbUBCk+l8me7DzEnrKNVYyxWLl75l2a5qPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 098/292] drm/nouveau/disp/g94: enable HDMI
Date:   Fri, 21 Jul 2023 18:03:27 +0200
Message-ID: <20230721160533.008045537@linuxfoundation.org>
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

[ Upstream commit c177872cb056e0b499af4717d8d1977017fd53df ]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Fixes: f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + infoframe methods")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230630160645.3984596-1-kherbst@redhat.com
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
index a4853c4e5ee3a..67ef889a0c5f4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
@@ -295,6 +295,7 @@ g94_sor = {
 	.clock = nv50_sor_clock,
 	.war_2 = g94_sor_war_2,
 	.war_3 = g94_sor_war_3,
+	.hdmi = &g84_sor_hdmi,
 	.dp = &g94_sor_dp,
 };
 
-- 
2.39.2



