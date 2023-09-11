Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6690B79B682
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354120AbjIKVwc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbjIKOoh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3BC12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BBDC433C7;
        Mon, 11 Sep 2023 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443473;
        bh=/TR8tW2uQLAPbcrQrOX8BeSB7XAhyPkRSh60Bq2y0mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcKcR/BpedArwDmXdsLBQYLHa0WsoHJZXWG/lTzjcciHNivQjY55H/cXkbVjaH4m+
         PG6kLPSY68APlD4+U++3vZWfxGb5SwvBHjPpJxGkG6brZSo9UgB3LWWped2EDd2ZaB
         g6J5vFp8WfX7qFt8/6Pduepmf/8wjGcwNyOySzjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Yang Wang <kevinyang.wang@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 362/737] drm/amd/pm: fix variable dereferenced issue in amdgpu_device_attr_create()
Date:   Mon, 11 Sep 2023 15:43:41 +0200
Message-ID: <20230911134700.644769632@linuxfoundation.org>
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

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 25e6373a5b8efc623443f2699d2b929bf3067d76 ]

- fix variable ('attr') dereferenced issue.
- using condition check instead of BUG_ON().

Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f4f40459f22b9..a5b2a7d943f71 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2195,15 +2195,19 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 				     uint32_t mask, struct list_head *attr_list)
 {
 	int ret = 0;
-	struct device_attribute *dev_attr = &attr->dev_attr;
-	const char *name = dev_attr->attr.name;
 	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
 	struct amdgpu_device_attr_entry *attr_entry;
+	struct device_attribute *dev_attr;
+	const char *name;
 
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
 
-	BUG_ON(!attr);
+	if (!attr)
+		return -EINVAL;
+
+	dev_attr = &attr->dev_attr;
+	name = dev_attr->attr.name;
 
 	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
 
-- 
2.40.1



