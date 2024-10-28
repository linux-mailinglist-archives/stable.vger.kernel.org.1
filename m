Return-Path: <stable+bounces-88985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EB9B2D59
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C9C1F22991
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999B1D7E4A;
	Mon, 28 Oct 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/r9qWF0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69631D7E3D;
	Mon, 28 Oct 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112665; cv=none; b=VrSYDFqvHaJyLqHmqmg5zGzDatowQjPnZVy46Pbxymnvn+5ynNEQDHWK2kzDXtKYUdLpSckwYo/mZU/BqZoDgoB8zTLj/cgY70MFzVBKIWdRKnnJht0zhn+2LA+57aB7NqQgzwLc9g3RyodUenLdtSyktQDc0p2tZFr8daVzenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112665; c=relaxed/simple;
	bh=bAJ1+rWDEugpJK5v1NJSm8waCHQowkpAsEvANUBEun4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl0ZjRMOab8xPmOmBl7e0+Ybloil0Z2V7smBDUD/rsFsB3rsBDOq7LbN0mcxn3KQ0+oMvNMar3s/wfFUQE7P8zJmAiDJwvq/NFAT2XUWIu7aqPEN5V0Wm51/I1L0/6E+7vRdf4zLCCaCeFI43d3J4ZJFpydsGxCFcSd1Y7RzST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/r9qWF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5212C4CEE3;
	Mon, 28 Oct 2024 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112664;
	bh=bAJ1+rWDEugpJK5v1NJSm8waCHQowkpAsEvANUBEun4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/r9qWF0OQeQs1n9HYgUDPe9t6gQJ1eaiFpghJac5ac9IKyX2/ZY8PlOU7YqYE1p+
	 3y2Gzi7HTIS4y2xKiP61t1ERb2v9BL7qrX0ZD7aEc8NA33NAtEUgGE5nTiQUzgAxeX
	 M57YOBn1+8GRnlMdDxuD3Cmnb/DaeSwLOPTw/YoP3l+TQVfqrDDPsKQ6cMxKunp3WP
	 LpSuCxioeaXu24mV79cabjQmK15q/SJtBCgV6t5Wqan6Bkm7YYmtR8Ip1nOlbasABt
	 nkrEIx+Gsp+T7rPQh+af9DLuiod9vVMLSrxfEi6BVkAPxBQ0jfTXqqBIr/kMOw4NEA
	 N94kiDEXQ6mPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	andriy.shevchenko@linux.intel.com,
	heiko@sntech.de,
	ckeepax@opensource.cirrus.com,
	nathan@kernel.org,
	u.kleine-koenig@baylibre.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 03/32] ASoC: codecs: Fix error handling in aw_dev_get_dsp_status function
Date: Mon, 28 Oct 2024 06:49:45 -0400
Message-ID: <20241028105050.3559169-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit 251ce34a446ef0e1d6acd65cf5947abd5d10b8b6 ]

Added proper error handling for register value check that
return -EPERM when register value does not meet expected condition

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Link: https://patch.msgid.link/20241009073938.7472-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/aw88399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 8dc2b8aa6832d..bba59885242d0 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -656,7 +656,7 @@ static int aw_dev_get_dsp_status(struct aw_device *aw_dev)
 	if (ret)
 		return ret;
 	if (!(reg_val & (~AW88399_WDT_CNT_MASK)))
-		ret = -EPERM;
+		return -EPERM;
 
 	return 0;
 }
-- 
2.43.0


