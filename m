Return-Path: <stable+bounces-89024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615449B2DD4
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252CA2818AE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B081E1036;
	Mon, 28 Oct 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V64SN0XX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446211E0E19;
	Mon, 28 Oct 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112759; cv=none; b=kI5CjZSsNHnnzFrwbWw5alfROx7kgsUrIHfTicDSyh7/7XZWgu+09p+qd43WmWS8WRuXVBY8yI0CnEwZX8T85bdiHjygakfvMXNmigJKkG696PJPkt8FtTU3f4MoVOH/WlrK0rZb/BkPBSATpaniGWSVCCRVERrIoqU98/Cw8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112759; c=relaxed/simple;
	bh=YF4sBgifMpR8XfTvx/8Bx1jrpkdQ/cVLCCdJZe391Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbZ+8hGjmXqiOnaaCZYohzWYWCPHcKCUvVJy5xyJLzredL6PfZKi8T9mtyhFfTp576T0sW9uAFLBI+2HqMhJ1vgj6cFxrGuJwSXd5m/1q744GankLhap/YyHz1vVxu6El8Ai2gQZTbHSVRBCF6bwRFdvvQ7d4qg8JXYBaPMY1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V64SN0XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF9BC4CEE3;
	Mon, 28 Oct 2024 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112759;
	bh=YF4sBgifMpR8XfTvx/8Bx1jrpkdQ/cVLCCdJZe391Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V64SN0XX529bCV9e6En/yDma9wKR5ZTQPmlcM8WKAJuBWMwWViYsTdB8j19BnlOsb
	 1FXCSHINr+ax8rY0hO51jvqFAKjJWXRZ0LAPg1kiCoClunM8Jsx2FFiSHltawNhR2k
	 KPxYUKXGTIj85fNGeOf0qHa7N+gMb1ezZHHgVtAIfQ6JqK63ZnLy4BLaNMw0/DpZBe
	 XyP7E/ZwfSTVLJFeQ37CWvlqCKicDkFK64lOb58pkqeFMQCABUWK/SIdMPVGeKIkXY
	 hQTy0052O0zllmSURxoh726rMT9uhpiXUiL460XwovDtOzTlTik6cGjgbIBTzFkt8F
	 bPpHhkrjTA1Bg==
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
Subject: [PATCH AUTOSEL 6.6 10/15] ASoC: rt722-sdca: increase clk_stop_timeout to fix clock stop issue
Date: Mon, 28 Oct 2024 06:52:06 -0400
Message-ID: <20241028105218.3559888-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 32578a212642e..91314327d9eee 100644
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


