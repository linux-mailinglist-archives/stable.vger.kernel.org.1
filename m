Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46472C257
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjFLLEU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjFLLEC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834783F6
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1040461297
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273AFC433D2;
        Mon, 12 Jun 2023 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567127;
        bh=IN9O4ELQUBVA4DysH3zQo0U+CMMMW8V1go+V+/lcfds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaA8wXdU5bYDoYVhz6zqDPSme1XHgJG1MoEVWTz+Lv/UQFBnZmOIfshnKdwJ4DVtl
         JMPspBGRlCjjjqoqOhOi0xMBke9L/93+H2aH1rxgMnXOZJYUIBTDOzVR0B+bn7JIV3
         VfBqHY4v2v3abi/7VzNnc4AWbNiOMePPdvTfsDdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 143/160] soundwire: stream: Add missing clear of alloc_slave_rt
Date:   Mon, 12 Jun 2023 12:27:55 +0200
Message-ID: <20230612101721.620299173@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 58d95889f3c2064c6139ee94bb0e4d86e1ad4eab ]

The current path that skips allocating the slave runtime does not clear
the alloc_slave_rt flag, this is clearly incorrect. Add the missing
clear, so the runtime won't be erroneously cleaned up.

Fixes: f3016b891c8c ("soundwire: stream: sdw_stream_add_ functions can be called multiple times")
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230602101140.2040141-1-ckeepax@opensource.cirrus.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 8c6da1739e3d1..3c909853aaf89 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -2019,8 +2019,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt)
+	if (s_rt) {
+		alloc_slave_rt = false;
 		goto skip_alloc_slave_rt;
+	}
 
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
-- 
2.39.2



