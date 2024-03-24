Return-Path: <stable+bounces-31018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE0888DCE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DFC1F277C4
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C63106ED;
	Mon, 25 Mar 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brBLmfR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB0296166;
	Sun, 24 Mar 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324313; cv=none; b=pTd9vkBYvBLL8PdQ1A0YUYlfBW43fqRYCOcn5oUi0GYQgJipCRdCS5+3n8y3b0H3c+fTLsgt2Dy0X3yqbdBDU3itCy/Om/H1zdDAZslIsZ9UfCa1rHFzc8MDgXGiXfqAU6Z0bKmvTPKMsH5bHa2j6FXTz1wIKYxB/hbUuhJ5xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324313; c=relaxed/simple;
	bh=me2HpTQgosWZGh8i0coUrQySsAR7m8rC0zF8tIHzlWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLn0x+t7jvd3NbvB/1wmKggvm69BwxCPxEQxwHbJEpNPpTejm5uxHnJ7/WFI8jSBu1ue6eCrukqQy7V0jPMO1xIdExjxtHSAKmMT00JaSczlBV5fguZMm/BkEsRIneqq5PvspYmvgttKLEv0nKxOIZF9bTj5vMGy1K4qOM6ekyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brBLmfR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6409DC433A6;
	Sun, 24 Mar 2024 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324312;
	bh=me2HpTQgosWZGh8i0coUrQySsAR7m8rC0zF8tIHzlWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brBLmfR2K87teGQ7ZOe0lWcMSwRFziK995A0bJGC3ewdr3Cr87OtNl353USOiJLXF
	 /F+y9ijEg1Tea5SPMzFRzFPsnHT2Evc2/n1WiirOF4/qTcY7f9NdLrgpih06lm8S22
	 A97JGgLDv2W1SSoCjq/xIl1JmeyMrBA+IlecCPFoJhAKcuQlstEvpLnFwbj5bQvl21
	 qcnOPguV2YmGvhuYwmjp9ZcnAYifGgcC/XK82wO/X1Qx/E1WKWKu37DOr1mXlGu0qr
	 yg1SK7M8qzauj6HZTVpqVTOsDBQ8yE4YaSzL9qDZoW3upc8VBYUBLnqPcg8PRaSA52
	 qd6PYmZf72Bag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/148] media: media/dvb: Use kmemdup rather than duplicating its implementation
Date: Sun, 24 Mar 2024 19:49:07 -0400
Message-ID: <20240324235012.1356413-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fuqian Huang <huangfq.daxian@gmail.com>

[ Upstream commit f6af820ef1be58c2e4b81aa479b9f109eb6344ce ]

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Stable-dep-of: 8c64f4cdf4e6 ("media: edia: dvbdev: fix a use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c             | 3 +--
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 1f80c4fa31c9b..5d68ad0ac5d26 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -485,7 +485,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		return -ENOMEM;
 	}
 
-	dvbdevfops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
 
 	if (!dvbdevfops){
 		kfree (dvbdev);
@@ -502,7 +502,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->fops = dvbdevfops;
 	init_waitqueue_head (&dvbdev->wait_queue);
 
-	memcpy(dvbdevfops, template->fops, sizeof(struct file_operations));
 	dvbdevfops->owner = adap->module;
 
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 9670bc98b45a9..33cf6dccb547f 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -12287,7 +12287,8 @@ struct dvb_frontend *drx39xxj_attach(struct i2c_adapter *i2c)
 	if (state == NULL)
 		goto error;
 
-	demod = kmalloc(sizeof(struct drx_demod_instance), GFP_KERNEL);
+	demod = kmemdup(&drxj_default_demod_g,
+			sizeof(struct drx_demod_instance), GFP_KERNEL);
 	if (demod == NULL)
 		goto error;
 
@@ -12311,8 +12312,6 @@ struct dvb_frontend *drx39xxj_attach(struct i2c_adapter *i2c)
 	state->demod = demod;
 
 	/* setup the demod data */
-	memcpy(demod, &drxj_default_demod_g, sizeof(struct drx_demod_instance));
-
 	demod->my_i2c_dev_addr = demod_addr;
 	demod->my_common_attr = demod_comm_attr;
 	demod->my_i2c_dev_addr->user_data = state;
-- 
2.43.0


