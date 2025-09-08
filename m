Return-Path: <stable+bounces-178978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C86B49C55
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 23:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C221BC1E3D
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 21:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A102E03F1;
	Mon,  8 Sep 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br8+7gFO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFB19644B
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368121; cv=none; b=PrKTBw9t7aDTm2Hlx3A3FAsgcUi63In/Szmr3JJcsJa1YHZ3TlxCWuvBte/nVY2GMmI4L6pxUC4LOZhgQ5Z52XwgjJtfVUyKJSVcfNQJiJ8wqjjGu2BjWGgMxORPFETVbQzy+tTTV6ttRDBlGRj4dUdSlXe62aXm8Ir2cbNVJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368121; c=relaxed/simple;
	bh=UOgk3/E3D4E02nKIKWi0dRPv7K+5xw7Ik3KpazdOikg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajFvmmPDjJcQq5nVcl8g7L8Z8a6st6OLp0QYR4jnxKIPLDaP9lN1LlMveDOdOoqEra2K3b+75VfyHqbVUZoaVUcY3n/yW8BcjdwV9WjfHT1vx5kZ57C1jqHlCY3kRr5LHkCjOpRSGa4sFVLNhLkzqdbB79Qy7hAZG0KNxJR6IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br8+7gFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED82C4CEF1;
	Mon,  8 Sep 2025 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368121;
	bh=UOgk3/E3D4E02nKIKWi0dRPv7K+5xw7Ik3KpazdOikg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=br8+7gFOjPsPyhYnma4s5V1694Np367+q4kcjGtjShmRYzYlZD6lAEpi7/8DPGxJa
	 fkRJlTw88xyyomWpmja1JuhsSIdZge2AL73Tz0w9PUXDVwi4BBWJl0tw7jk8qNkcQw
	 6khOogQAy7g7CHOi6zzqsHyerk+ij/ovmIBcyuD8BusWYr1e2LnXiZKIQkb85oQRGl
	 6vXTKTT6P6xle5bYYTPWtU9RCBMWb9v13jUsdsC72X3iUb6pJd+RzfWm0Uy7Vk5co4
	 jSw7DV6hW7KEGxmQmGaCvjhzWsCnV4NI4MreSb+Ol6tFeJuMBedJJWVLfrhZI1MTtj
	 4GT2qvbNeffvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization
Date: Mon,  8 Sep 2025 17:48:39 -0400
Message-ID: <20250908214839.2435036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041738-unfounded-kitten-3d41@gregkh>
References: <2025041738-unfounded-kitten-3d41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 4936cd5817af35d23e4d283f48fa59a18ef481e4 ]

On Mediatek devices with a system companion processor (SCP) the mtk_scp
structure has to be removed explicitly to avoid a resource leak.
Free the structure in case the allocation of the firmware structure fails
during the firmware initialization.

Fixes: 53dbe0850444 ("media: mtk-vcodec: potential null pointer deference in SCP")
Cc: stable@vger.kernel.org
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ Adapted file path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
index 27f08b1d34d19..e13f09d883543 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
@@ -65,8 +65,10 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	if (!fw)
+	if (!fw) {
+		scp_put(scp);
 		return ERR_PTR(-ENOMEM);
+	}
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
-- 
2.51.0


