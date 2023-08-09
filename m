Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183D9775DE1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjHILmS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjHILmM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9A1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF8063473
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1632C433CB;
        Wed,  9 Aug 2023 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581331;
        bh=qj4JVP/Sr8qjVGEhUQQ/zqaS5duXdJP3OPj+7OdIvSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQBuk5oUTwnUQoIYD2bcVPfz9M6aQYO8O8UPMo5N7hxS492Q/nEVSniuG66nwS31e
         bbAKCvgEHqc+Ccw7Bp/hSLylBQ53moQqxw1xyu88bcl3m8Ae60dTr/SM5YfqySnGdl
         udQdgrzDgawHEb0tDq8cgdDQenrXbT56v8Z/OLi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Chao Song <chao.song@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 188/201] soundwire: bus: add better dev_dbg to track complete() calls
Date:   Wed,  9 Aug 2023 12:43:10 +0200
Message-ID: <20230809103650.106720412@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit f1b690261247c9895f7a4b05d14a4026739134eb ]

Add a dev_dbg() log for both enumeration and initialization completion
to better track suspend-resume issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20210126085402.4264-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: c40d6b3249b1 ("soundwire: fix enumeration completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3317a02bcc170..9c7c8fa7f53e4 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -797,7 +797,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 
 	if (status == SDW_SLAVE_UNATTACHED) {
 		dev_dbg(&slave->dev,
-			"%s: initializing completion for Slave %d\n",
+			"%s: initializing enumeration and init completion for Slave %d\n",
 			__func__, slave->dev_num);
 
 		init_completion(&slave->enumeration_complete);
@@ -806,7 +806,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
 		dev_dbg(&slave->dev,
-			"%s: signaling completion for Slave %d\n",
+			"%s: signaling enumeration completion for Slave %d\n",
 			__func__, slave->dev_num);
 
 		complete(&slave->enumeration_complete);
@@ -1734,8 +1734,13 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
-		if (attached_initializing)
+		if (attached_initializing) {
+			dev_dbg(&slave->dev,
+				"%s: signaling initialization completion for Slave %d\n",
+				__func__, slave->dev_num);
+
 			complete(&slave->initialization_complete);
+		}
 	}
 
 	return ret;
-- 
2.40.1



