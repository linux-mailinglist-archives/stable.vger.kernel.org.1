Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AC7ECF9D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjKOTtg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjKOTtg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA50B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45BBC433C8;
        Wed, 15 Nov 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077772;
        bh=+12ROAgj1vBAsdcDsXWnHvUzadasaQT1nPg+ODuY8/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xFiij5OYsxX1Stv9L9vvYJLOY9riloidmvlemjOx5eEW4Hw0z9WecPs1SVqXObJhj
         7foW+uQWtPHHvjCiSAxkv4VI0iGh56Y+N/XCdGQmaF8NWAit2AYrETbE4rDBa9Lp8o
         YELAvNGSmTf82FmgS4Tgv09MmBjmWUoBBZk3fwMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 510/603] media: ov13b10: Fix some error checking in probe
Date:   Wed, 15 Nov 2023 14:17:35 -0500
Message-ID: <20231115191647.420645190@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d66b45e1b082462c3e14528b83e18ee92362e456 ]

The "ret = " assignment was missing, so ov13b10_power_on() is not
checked for errors.  Add the assignment.

Fixes: 6e28afd15228 ("media: ov13b10: add PM control support based on power resources")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov13b10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
index dbc642c5995b6..8ebdb32dd3dbc 100644
--- a/drivers/media/i2c/ov13b10.c
+++ b/drivers/media/i2c/ov13b10.c
@@ -1501,7 +1501,7 @@ static int ov13b10_probe(struct i2c_client *client)
 
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
-		ov13b10_power_on(&client->dev);
+		ret = ov13b10_power_on(&client->dev);
 		if (ret) {
 			dev_err(&client->dev, "failed to power on\n");
 			return ret;
-- 
2.42.0



