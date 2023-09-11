Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC179AF2A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjIKVN3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjIKOxU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A7B118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D8DC433D9;
        Mon, 11 Sep 2023 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443996;
        bh=0uQ5coB8JkwXZZP2mGozqlDZECEjDxJihQ+wpYX+nNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoaARjYnzikXnDs9Kxpy/ixV9MkEkT0AJyvqhyQ2rDW35//N/64SLJkA85bkXbGvK
         +JlvHUKPuDycSNXXYgIniJaymzSucwpbSy5ZRBDZSv+5BuCuNLMh+kD/U5frIQzFt6
         rYPjceiA5XqCH2ap+DIqN3BmnSqyODyU9ljZotq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 573/737] media: i2c: rdacm21: Fix uninitialized value
Date:   Mon, 11 Sep 2023 15:47:12 +0200
Message-ID: <20230911134706.544411130@linuxfoundation.org>
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

From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

[ Upstream commit 33c7ae8f49e3413c81e879e1fdfcea4c5516e37b ]

Fix the following smatch warning:

drivers/media/i2c/rdacm21.c:373 ov10640_check_id() error: uninitialized
symbol 'val'.

Initialize 'val' to 0 in the ov10640_check_id() function.

Fixes: 2b821698dc73 ("media: i2c: rdacm21: Power up OV10640 before OV490")
Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/rdacm21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index 9ccc56c30d3b0..d269c541ebe4c 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -351,7 +351,7 @@ static void ov10640_power_up(struct rdacm21_device *dev)
 static int ov10640_check_id(struct rdacm21_device *dev)
 {
 	unsigned int i;
-	u8 val;
+	u8 val = 0;
 
 	/* Read OV10640 ID to test communications. */
 	for (i = 0; i < OV10640_PID_TIMEOUT; ++i) {
-- 
2.40.1



