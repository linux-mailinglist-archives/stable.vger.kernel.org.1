Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83EA79B52F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbjIKV6V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjIKORY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBB0DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:17:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D242C433C8;
        Mon, 11 Sep 2023 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441840;
        bh=adMwtBaZcgF7HwAgQ9jZ+gIeDcpAgHQCgzBQTQNE+/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th/VwoKEyuBVvtQ0Gxci7PB15qkmGn41XM/fNhgVIYqFWH3ek3w5EwWoQ0I/4lf7B
         RjyUuZB6afBRUZT8v9V44L27et75NBJGCB4t462t4ybELemumyrlTp8Zsx/K/cTboG
         7m8KWNCRZR1FNzYBjSGyij8xNwcKI0YD99OGkQSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 528/739] arm64: defconfig: Drop CONFIG_VIDEO_IMX_MEDIA
Date:   Mon, 11 Sep 2023 15:45:27 +0200
Message-ID: <20230911134705.857155465@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 0ca2fbab99b12bb81fceaafe5495c00d76789a37 ]

CONFIG_VIDEO_IMX_MEDIA isn't needed on arm64 platforms since commit
9f257f502c2e ("media: imx: Unstage the imx7-media-csi driver") which
moved the last arm64 driver depending on that Kconfig symbol out of
staging. Drop it from the arm64 defconfig.

Fixes: 9f257f502c2e ("media: imx: Unstage the imx7-media-csi driver")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 28714382ce3f5..d8bae57af16d5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1129,7 +1129,6 @@ CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
-CONFIG_VIDEO_IMX_MEDIA=m
 CONFIG_VIDEO_MAX96712=m
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
-- 
2.40.1



