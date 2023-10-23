Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB847D30A3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJWLAr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjJWLAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD11910CA
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:00:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F59C433C9;
        Mon, 23 Oct 2023 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058842;
        bh=eYevToiCctEHETlrWy6o5ccH8OIeRhDLbHe+jYMyDWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dfXZUlLUzraoWKcI56fUMBM9QMsZf5eAUag92fZtQ3GEDjTpvt+dxhdVZOI+w3tt
         jSTR2E5MvhViSYtYUJhe+pqbnSgqadMcuvB8kpEWCwyln9y7g5tgFJub02Vz4baaSK
         OxPXIyaPH1zLr3e/ldU59HdnyIdrqNfgiGIprW1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 44/66] i2c: mux: Avoid potential false error message in i2c_mux_add_adapter
Date:   Mon, 23 Oct 2023 12:56:34 +0200
Message-ID: <20231023104812.477914269@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit b13e59e74ff71a1004e0508107e91e9a84fd7388 ]

I2C_CLASS_DEPRECATED is a flag and not an actual class.
There's nothing speaking against both, parent and child, having
I2C_CLASS_DEPRECATED set. Therefore exclude it from the check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 7ba31f6bf1488..ad5fd357b2bce 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -334,7 +334,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/* Sanity check on class */
-	if (i2c_mux_parent_classes(parent) & class)
+	if (i2c_mux_parent_classes(parent) & class & ~I2C_CLASS_DEPRECATED)
 		dev_err(&parent->dev,
 			"Segment %d behind mux can't share classes with ancestors\n",
 			chan_id);
-- 
2.40.1



