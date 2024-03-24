Return-Path: <stable+bounces-30817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0492888C90
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898C428C424
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A71C130D;
	Mon, 25 Mar 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhxQwSEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078E17C6C2;
	Sun, 24 Mar 2024 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323798; cv=none; b=a45M3NAeUITZsRWZaG8p/RvQ7yAEFBoS9GXr+zeOQNmV4f5JhkvERe+jw4gISEYmvmUr4XMPKuDPQxbgCIlnr26ej9TEKiGAQwjRk3WfwvY45AmJ8EAD08UPCjVCgabvgzyearTjBTBx1JHJ7w6QCMy2l393l+yfDPRbRkddUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323798; c=relaxed/simple;
	bh=ieKy/hv6bciQ6MqgyuqOGf6/YtMkhtBG+HDbPucQycQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5iwcbF6+HQCLQ0qkL+GFGWysrGNd2c87Ch5DySG51m37LNwK8EBOueSMZS8eBJo946t6WoOHhZGFxihVhisYPPC1YgpiZgEbd+GgqiSE0pBfvh3cSJwNDt2Iigg4cM1Axco2UqXpZ5tL5uX6eE5PzuHj9WPcpdDSpuEoJOhmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhxQwSEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139CBC433F1;
	Sun, 24 Mar 2024 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323797;
	bh=ieKy/hv6bciQ6MqgyuqOGf6/YtMkhtBG+HDbPucQycQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhxQwSEYrDeYpujnPH+nghySXbicHHjj8Yo41GgUYXnfhgBQTtI/sZmx/wQCDjJ75
	 zeV4BYFNTm25XuVaRjbPFjpnAi3CRp3Go+qPjFXw+UO+fpqXG006mBdkF9NieTMZmK
	 BWc/OJcPMToCZga9eC7ZLO8rygKSqJ0j/zsEoXlABrdfg404YhKQgJiYxfRcezHmta
	 8QpfiLIvt0FuJBKuIehmcSydtpa/Z1rkz+ABAf5hn/weZxpi6hI9x/FQoqfMKxPstz
	 kMSmj9oqJPrlTg253+VpQ32YSOZeMZyWF2TZ7aPA141ht+/ZUoRTN7XIacCBU2AGlc
	 ddsO6wlx0n3Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 175/238] media: ttpci: fix two memleaks in budget_av_attach
Date: Sun, 24 Mar 2024 19:39:23 -0400
Message-ID: <20240324234027.1354210-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit d0b07f712bf61e1a3cf23c87c663791c42e50837 ]

When saa7146_register_device and saa7146_vv_init fails, budget_av_attach
should free the resources it allocates, like the error-handling of
ttpci_budget_init does. Besides, there are two fixme comment refers to
such deallocations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ttpci/budget-av.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 3cb83005cf09b..519f85e0a397d 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1462,7 +1462,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1471,9 +1472,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
 		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
-			/* fixme: proper cleanup here */
-			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
+			ERR("cannot register capture v4l2 device\n");
 			return err;
 		}
 
-- 
2.43.0


