Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C454F7A7AFB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjITLsG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbjITLsG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:48:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9793B0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:48:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15065C433C8;
        Wed, 20 Sep 2023 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210480;
        bh=TcXZ6ltSBC3PUSffvinI0SVuHYHyirBBGxkyxME+fGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtebxirZHifVAbqd5DJAtUydweZYJgqYRiQfU1IsctbfR31qoz6CyqSmD4QiL449/
         c/i5/QsD4pnK2hjnPsxRgPCAvFJJYLjihSsB6ikpmJbSooOHdVuk0s5XNrNQAMaqk/
         PaXzLQL1on+lpCNYrSErTW+YtGPbFbUAIL1Tp8IM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 065/211] drm/edid: Add quirk for OSVR HDK 2.0
Date:   Wed, 20 Sep 2023 13:28:29 +0200
Message-ID: <20230920112847.790092654@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Campbell <rcampbell@nvidia.com>

[ Upstream commit 98d4cb705bc00afd4a9a71cc1e84f7111682639a ]

The OSVR virtual reality headset HDK 2.0 uses a different EDID
vendor and device identifier than the HDK 1.1 - 1.4 headsets.
Add the HDK 2.0 vendor and device identifier to the quirks table so
that window managers do not try to display the desktop screen on the
headset display.

Closes: https://gitlab.freedesktop.org/drm/misc/-/issues/30
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230621061903.3422648-1-rcampbell@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 1f470968ed14b..9271e47d66572 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -230,6 +230,7 @@ static const struct edid_quirk {
 
 	/* OSVR HDK and HDK2 VR Headsets */
 	EDID_QUIRK('S', 'V', 'R', 0x1019, EDID_QUIRK_NON_DESKTOP),
+	EDID_QUIRK('A', 'U', 'O', 0x1111, EDID_QUIRK_NON_DESKTOP),
 };
 
 /*
-- 
2.40.1



