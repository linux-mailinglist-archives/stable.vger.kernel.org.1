Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0465B72C180
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbjFLKyx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjFLKyZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F011D9F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A842B612A1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA48C433D2;
        Mon, 12 Jun 2023 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566430;
        bh=rf3iRqsSZdB9FykzCji545FxjenMgby/fmVKik3hZ9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRB2L68JoW+gPrTOBlVI5YVOi2rJxlIpwAAJK+sBBqQNxuVlhIvOv36g1n3KaEPPL
         22nw2+liXPhwozVHeso6QYMh4YEQVFUGxdkXQJHcfXM8TzKAdU5OWbXA0+unqlTgab
         Re1FTbensot1Y2PetM2tZcZRunHVotwv8SH5Ll/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/132] platform/surface: aggregator_tabletsw: Add support for book mode in KIP subsystem
Date:   Mon, 12 Jun 2023 12:25:39 +0200
Message-ID: <20230612101710.547746528@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Maximilian Luz <luzmaximilian@gmail.com>

[ Upstream commit 9bed667033e66083d363a11e9414ad401ecc242c ]

Devices with a type-cover have an additional "book" mode, deactivating
type-cover input and turning off its backlight. This is currently
unsupported, leading to the warning

  surface_aggregator_tablet_mode_switch 01:0e:01:00:01: unknown KIP cover state: 6

Therefore, add support for this state and map it to enable tablet-mode.

Fixes: 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch driver")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Link: https://lore.kernel.org/r/20230525213218.2797480-2-luzmaximilian@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/surface/surface_aggregator_tabletsw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 27d95a6a78513..af8b547cffdc6 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -201,6 +201,7 @@ enum ssam_kip_cover_state {
 	SSAM_KIP_COVER_STATE_LAPTOP        = 0x03,
 	SSAM_KIP_COVER_STATE_FOLDED_CANVAS = 0x04,
 	SSAM_KIP_COVER_STATE_FOLDED_BACK   = 0x05,
+	SSAM_KIP_COVER_STATE_BOOK          = 0x06,
 };
 
 static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 state)
@@ -221,6 +222,9 @@ static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 stat
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
 		return "folded-back";
 
+	case SSAM_KIP_COVER_STATE_BOOK:
+		return "book";
+
 	default:
 		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %u\n", state);
 		return "<unknown>";
@@ -233,6 +237,7 @@ static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 s
 	case SSAM_KIP_COVER_STATE_DISCONNECTED:
 	case SSAM_KIP_COVER_STATE_FOLDED_CANVAS:
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
+	case SSAM_KIP_COVER_STATE_BOOK:
 		return true;
 
 	case SSAM_KIP_COVER_STATE_CLOSED:
-- 
2.39.2



