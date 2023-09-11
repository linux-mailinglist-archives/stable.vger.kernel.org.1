Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49B79BA13
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjIKVFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbjIKOww (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:52:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F4D118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:52:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE88C433C7;
        Mon, 11 Sep 2023 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443967;
        bh=tUSe/qh74gctDMxhr8HVgn7NrO75fTiX1YnC7uvmAi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6i1Qgb8fWchLUqUi5GH2EYp6DiHUGElH9osX4fT0bAAYIOZkG4/LF2uLodrTqB+m
         1tl161a0eNAYWX7d0T+qfL19i4ChzTabC7s+gSOe+FLGdN8y8PdwX4IrLNmE+FZWAe
         9Mi6dg5yOGuayZhwhxfyELrn/oGRfpD1UptmHzVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 564/737] media: Documentation: Fix [GS]_ROUTING documentation
Date:   Mon, 11 Sep 2023 15:47:03 +0200
Message-ID: <20230911134706.304799794@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 997a6b01cd97b74684728d5af6511c333f25957d ]

Add mention that successful VIDIOC_SUBDEV_G_ROUTING call will update
'num_routes' and remove mention about non-existing streams, which is
incorrect.

Fixes: ea73eda50813 ("media: Documentation: Add GS_ROUTING documentation")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../userspace-api/media/v4l/vidioc-subdev-g-routing.rst    | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
index 2d6e3bbdd0404..72677a280cd64 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
@@ -58,6 +58,9 @@ the subdevice exposes, drivers return the ENOSPC error code and adjust the
 value of the ``num_routes`` field. Application should then reserve enough memory
 for all the route entries and call ``VIDIOC_SUBDEV_G_ROUTING`` again.
 
+On a successful ``VIDIOC_SUBDEV_G_ROUTING`` call the driver updates the
+``num_routes`` field to reflect the actual number of routes returned.
+
 .. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.7cm}|
 
 .. c:type:: v4l2_subdev_routing
@@ -138,9 +141,7 @@ ENOSPC
 
 EINVAL
    The sink or source pad identifiers reference a non-existing pad, or reference
-   pads of different types (ie. the sink_pad identifiers refers to a source pad)
-   or the sink or source stream identifiers reference a non-existing stream on
-   the sink or source pad.
+   pads of different types (ie. the sink_pad identifiers refers to a source pad).
 
 E2BIG
    The application provided ``num_routes`` for ``VIDIOC_SUBDEV_S_ROUTING`` is
-- 
2.40.1



