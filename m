Return-Path: <stable+bounces-77907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1632988427
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C611F2281C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CBB18C003;
	Fri, 27 Sep 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0b4kiXWA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD718C004;
	Fri, 27 Sep 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439886; cv=none; b=WKO5u+5qtsZDUV/v53/uRG4XZ16HRI1ILvw7c2rJkAEUzeQCid7ZkJan2Tp0IZUYZm3CTlM0V1Z4jU/HjdhvTIQGgX76fkxH7wHBoS0cg6ViT/XjGsdkckxM23A1mjD4zGpajwaxVLA9dmPYqmS7909CUQjk+SVC2X4Ag185Tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439886; c=relaxed/simple;
	bh=gJvuhv0w5L7EMXJ7UMwbOG87OfCwKF7hYYRG/JkUKLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1CMbPHEHo2anoMNTZSYFaZF+hoEdwdqNcOVgbqhn6MBugrxQw6Dc6I95+sGZRhMpcmOOv86vjlFG9kzc6Tz8g08IxBNZS4UidzFITo2b+7DjrbfXev47NVm0gQoeDAfyZ8mqI5q+Rozwp/+ZI18En3Etq8jM5PWPYpVZQdb8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0b4kiXWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A92C4CECD;
	Fri, 27 Sep 2024 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727439886;
	bh=gJvuhv0w5L7EMXJ7UMwbOG87OfCwKF7hYYRG/JkUKLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0b4kiXWA6wHI3ydVVVwHIhoGmGJgxGmZ1ExVHtTdh+SFC0hvbTv5RKavs6h76+BLV
	 7o6zywstqREK8S90vNO5UrncdT8tjJCaMHzA11XAOxuModXx547+E4bY/nivEUtVwJ
	 UVGInO3gTZ66T1KCB2pyPrLv/znATU9nTNwc7lOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/54] ASoC: allow module autoloading for table db1200_pids
Date: Fri, 27 Sep 2024 14:22:55 +0200
Message-ID: <20240927121719.855819116@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 0e9fdab1e8df490354562187cdbb8dec643eae2c ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-2-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/au1x/db1200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 400eaf9f8b140..f185711180cb4 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0




