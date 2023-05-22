Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3270C76A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEVT3d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEVT3Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230A18C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F96B628EB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674D7C433D2;
        Mon, 22 May 2023 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783751;
        bh=xKx/R8XJkJRLG03QGYpP8wHeGAmznaHWqdrhoCtth8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raK+K40N/Y5OZmwK8Kgt85/E3lNXsxamUwMAkAcCCJAv5csmKqKpbg6a3Lf9qUzrH
         xfz8pU+RLb3MbY/ox3u+Uzng+/wku3/fR8N13XvACDaSdnV5m3JaCIyFqeH37b7aUd
         fvR6Wm47RoDEgl1t70ZUPPyJp+9NSWCnWz+GPIro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/292] soundwire: bus: Fix unbalanced pm_runtime_put() causing usage count underflow
Date:   Mon, 22 May 2023 20:08:20 +0100
Message-Id: <20230522190409.537773547@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit e9537962519e88969f5f69cd0571eb4f6984403c ]

This reverts commit
443a98e649b4 ("soundwire: bus: use pm_runtime_resume_and_get()")

Change calls to pm_runtime_resume_and_get() back to pm_runtime_get_sync().
This fixes a usage count underrun caused by doing a pm_runtime_put() even
though pm_runtime_resume_and_get() returned an error.

The three affected functions ignore -EACCES error from trying to get
pm_runtime, and carry on, including a put at the end of the function.
But pm_runtime_resume_and_get() does not increment the usage count if it
returns an error. So in the -EACCES case you must not call
pm_runtime_put().

The documentation for pm_runtime_get_sync() says:
 "Consider using pm_runtime_resume_and_get() ...  as this is likely to
 result in cleaner code."

In this case I don't think it results in cleaner code because the
pm_runtime_put() at the end of the function would have to be conditional on
the return value from pm_runtime_resume_and_get() at the top of the
function.

pm_runtime_get_sync() doesn't have this problem because it always
increments the count, so always needs a put. The code can just flow through
and do the pm_runtime_put() unconditionally.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230406134640.8582-1-rf@opensource.cirrus.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 76515c33e639e..4fd221d0cc818 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -571,9 +571,11 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
+	}
 
 	ret = sdw_nread_no_pm(slave, addr, count, val);
 
@@ -595,9 +597,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
+	}
 
 	ret = sdw_nwrite_no_pm(slave, addr, count, val);
 
@@ -1565,9 +1569,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err(&slave->dev, "Failed to resume device: %d\n", ret);
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
 	}
 
-- 
2.39.2



