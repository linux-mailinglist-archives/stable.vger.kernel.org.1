Return-Path: <stable+bounces-89003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382F9B2D9A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2772A281826
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69611D416B;
	Mon, 28 Oct 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4274WKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AC1D7E4E;
	Mon, 28 Oct 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112706; cv=none; b=n/g7NTzWkpmkIxlL6857vAOqHGVr8WLG24aa1J33AU3JJF63WeMiZkKvEgkaDWGVNwacG3X8u4x4wX1Vuhhc2e7fSJcE+cXvGE7Kn92TpAD6QvpJqQj2hLwTrJB7yYzx1u4HVwHTLwzmpj3hz3ILaCkK1q+3dgNURFlBmBRN6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112706; c=relaxed/simple;
	bh=Q946M9xGZhGP++idZLebE0GJjIFz8BtZZxEHxcj4EDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv98syTRD3pzAhcaeUorpUzSbJHzOtK/6huUMShGvZXQcYlURZnbY6KIU176GVzH+3ydrrBJAFTvscbPZh+jU1EGF/Vli1CQmjTgUjdZZEBJBPfu9/3hinPyc4kNXSc3YCFbVkgb8NEKk/ly8E4fMEVU22DbfUEC+saCYQejbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4274WKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3A5C4CEE4;
	Mon, 28 Oct 2024 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112706;
	bh=Q946M9xGZhGP++idZLebE0GJjIFz8BtZZxEHxcj4EDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4274WKTMeD/r22drJFUsoJI/sXp2SEt3F5UZZ3Bqi0EkKLhzwtGKAKPpyNNeS5Sc
	 rnCNabi1MQTci2ynDF/MSreYfSEQLsDv3MXEEmVDbScvQCo7n3LrAS0P4tWwLrIz9M
	 FDfygIyszQB0ftqQtklKkEHRssS7K0ruQhAMGaXiSKfjqXQQ961h/FvAqI8Y1lqAiM
	 Sj3AWMx8DvkP+Xi/IdZkd67CWeyqjwfKPIL5MAs6M1qjokHN2mMeiZiTW74vtkeCfv
	 UQ5jomlXX/yEUTIF/uJn9sbJTi++6pn8O2pHNILIDZr8lKSpsGtzXI5RA/jGNGeaJz
	 InagzF2dCaAqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 21/32] ASoC: rt722-sdca: increase clk_stop_timeout to fix clock stop issue
Date: Mon, 28 Oct 2024 06:50:03 -0400
Message-ID: <20241028105050.3559169-21-sashal@kernel.org>
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

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 038fa6ddf5d22694f61ff7a7a53c8887c6b08c45 ]

clk_stop_timeout should be increased to 900ms to fix clock stop issue.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://patch.msgid.link/cd26275d9fc54374a18dc016755cb72d@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 87354bb1564e8..d5c985ff5ac55 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -253,7 +253,7 @@ static int rt722_sdca_read_prop(struct sdw_slave *slave)
 	}
 
 	/* set the timeout values */
-	prop->clk_stop_timeout = 200;
+	prop->clk_stop_timeout = 900;
 
 	/* wake-up event */
 	prop->wake_capable = 1;
-- 
2.43.0


