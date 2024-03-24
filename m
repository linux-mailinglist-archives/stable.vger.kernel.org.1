Return-Path: <stable+bounces-30949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB3889328
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A381F2F609
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C43041B2;
	Mon, 25 Mar 2024 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/AogOVR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B25182762;
	Sun, 24 Mar 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324176; cv=none; b=NpyCjg4AdAosplh2aa7ZQ2TM6d5w/q+daIBlveIDvk7q+DvDsMS+vvrERW6MUmUn0RPBpjNkvnWP4dPuBR9PkKTNHe6L6UZQj0/bpwEAmW+/ZqpoAQVZNNUSvbuejbR0xDFfoT42Pdzch5Uj/Bd7DtspW3Idx1wGfiDi6uKXJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324176; c=relaxed/simple;
	bh=FTe4ZX7VYZ8SrJmSCLv4eDtXVTPqOYrMW0q9tjbwYoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNyuyR5UasOpZr4EBvwve5/61s+1Gm3tIICixI22zeuJfzc9lcwqj5zNPcsxneLTK/2/itXE1Vt9m3NFQCvRLuS4NzihQr/aw9hnX6+4YTdmZwCBppAh3FaCUWOXj48XpmhrOc6mgbeHBLLHCxEmj2UavTZixAXhCCxSEdjzmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/AogOVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2812C433F1;
	Sun, 24 Mar 2024 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324175;
	bh=FTe4ZX7VYZ8SrJmSCLv4eDtXVTPqOYrMW0q9tjbwYoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/AogOVRSJPd1BDd1UsjVJVpMIezI/vO7dgw4jB3vJ71VjGYrL59OyDMFufu3uWaH
	 T8a+J0YkW9OVxEDae/UIK9QGbN4Zbi3a3YSfYJuPeNxQnMMhK7ogfo0QE3HA4lwA+P
	 Ks1nO5eyWAF/MoSpRAFU2Xo14SncTkh6xAGhESb3QpIy6C4sc0dn4PUQv53sDF+9fn
	 am420JZ7klX+3/6Pcn/BhKAEAMezntcKqEYVPXiQ1xh/a1tt8GGfRLAsDZs7rMIi8D
	 O3eUR3o/mZBG+ARisZXrEKChN90d/fvJpkR6/Q5eifotzTqwZEnwcUcKx8tMs9+Yjk
	 P7l/RKLPlseAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 167/183] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 19:46:20 -0400
Message-ID: <20240324234638.1355609-168-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 34164202a5827f60a203ca9acaf2d9f7d432aac8 ]

The get_channel_from_mode() function is supposed to return the channel
which matches the mode.  But it has a bug where if it doesn't find a
matching channel then it returns the last channel.  It should return
NULL instead.

Also remove an unnecessary NULL check on "channel".

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/379c0cb4-39e0-4293-8a18-c7b1298e5420@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d2672b65c3f49..e59bb27236b9f 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -100,15 +100,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
 static struct gb_channel *get_channel_from_mode(struct gb_light *light,
 						u32 mode)
 {
-	struct gb_channel *channel = NULL;
+	struct gb_channel *channel;
 	int i;
 
 	for (i = 0; i < light->channels_count; i++) {
 		channel = &light->channels[i];
-		if (channel && channel->mode == mode)
-			break;
+		if (channel->mode == mode)
+			return channel;
 	}
-	return channel;
+	return NULL;
 }
 
 static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
-- 
2.43.0


