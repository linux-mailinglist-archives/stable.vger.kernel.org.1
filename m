Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A375537E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjGPUTk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjGPUTk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB8890
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E47760DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3277C433C8;
        Sun, 16 Jul 2023 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538778;
        bh=8M/JMwttDdJna+e2sGSEmjJKf9t9p0CDBzIIaqsNmXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL/PSY+0y6f18OkCF+WDSVBe4MlyMUZTW+TT1YBLNaidU/06PXF2369gJmjaHUrl9
         8TG1/xvqWcOe5buL3fd27FfBQsWJAYPtBLEEJ/SzABUksgHeSrYw+0gql8k4gvZNDd
         +lHlFe618YiRQqre+YR3yni/IENK3iOtEG3gU4Ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 573/800] media: i2c: imx296: fix error checking in imx296_read_temperature()
Date:   Sun, 16 Jul 2023 21:47:06 +0200
Message-ID: <20230716195002.395194927@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit 1b3565dbc6aa124f34674e3dcf6966f663817e05 ]

The "& IMX296_TMDOUT_MASK" means that "tmdout" can't be negative so the
error checking will not work.

Fixes: cb33db2b6ccf ("media: i2c: IMX296 camera sensor driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx296.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx296.c b/drivers/media/i2c/imx296.c
index 4f22c0515ef8d..c3d6d52fc7727 100644
--- a/drivers/media/i2c/imx296.c
+++ b/drivers/media/i2c/imx296.c
@@ -922,10 +922,12 @@ static int imx296_read_temperature(struct imx296 *sensor, int *temp)
 	if (ret < 0)
 		return ret;
 
-	tmdout = imx296_read(sensor, IMX296_TMDOUT) & IMX296_TMDOUT_MASK;
+	tmdout = imx296_read(sensor, IMX296_TMDOUT);
 	if (tmdout < 0)
 		return tmdout;
 
+	tmdout &= IMX296_TMDOUT_MASK;
+
 	/* T(°C) = 246.312 - 0.304 * TMDOUT */;
 	*temp = 246312 - 304 * tmdout;
 
-- 
2.39.2



