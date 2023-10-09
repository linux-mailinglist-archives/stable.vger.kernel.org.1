Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107497BE171
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377240AbjJINuU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377373AbjJINuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:50:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D591
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:50:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA4C433CC;
        Mon,  9 Oct 2023 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859417;
        bh=AhYEI+R0raPDWiVKlsqzIuF43RU22UHLEqmugNzbnh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BxVesnBLJskPeyJTDKxY6xvoMwgY6lXm0ld6p0Z8/dGKSJzkOBl8B4GWec4xDUwb/
         MarvN7I8UDjqFennd8XttR/cqJUP8T2yDkoygDoyYLZsSWoxRunZhIYAH0iA5/akT7
         bFuUdkQa6hj4dmrBs7YvnP4IRE8VFLpoULDbKmkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Werner Sembach <wse@tuxedocomputers.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/91] Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN
Date:   Mon,  9 Oct 2023 15:05:47 +0200
Message-ID: <20231009130112.064554831@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Werner Sembach <wse@tuxedocomputers.com>

[ Upstream commit eb09074bdb05ffd6bfe77f8b4a41b76ef78c997b ]

The touchpad of this device is both connected via PS/2 and i2c. This causes
strange behavior when both driver fight for control. The easy fix is to
prevent the PS/2 driver from accessing the mouse port as the full feature
set of the touchpad is only supported in the i2c interface anyway.

The strange behavior in this case is, that when an external screen is
connected and the notebook is closed, the pointer on the external screen is
moving to the lower right corner. When the notebook is opened again, this
movement stops, but the touchpad clicks are unresponsive afterwards until
reboot.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230607173331.851192-1-wse@tuxedocomputers.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index da2bf8259330e..0cf9a37873261 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1188,6 +1188,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	/* See comment on TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU above */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PD5x_7xPNP_PNR_PNN_PNT"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
-- 
2.40.1



