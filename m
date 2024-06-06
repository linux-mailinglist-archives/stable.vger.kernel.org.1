Return-Path: <stable+bounces-49145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606F8FEC0B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B971C234C7
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C41AC436;
	Thu,  6 Jun 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cANeMBcd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8781AC431;
	Thu,  6 Jun 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683324; cv=none; b=TgTi+Xbjhxj6TIgqJpigi3b6sJW/srGJQ0dpmIsS8nHLXr0aPtn3MA3tqeWOI/BC6suMU9x1iBn/Wj0vwFfvJWneWCPoS6vZ5DShNO1d7ZUyG0n8gyceKGOl6ZLMbgt2+g2iMby2JpAOJOvbbNVB88rPSncf/0t0iCZ4VQ2pqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683324; c=relaxed/simple;
	bh=tzAL0HsFg5aZEr1FmL5GAXhI4Qdi7t4PAjFyxesUTX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDmVzbP/n4HIVzY9K7fucGMEa7z4yetYwWz7rGwH0LnPYhGl+C6lJItc+//Vnxgo4KI49gc8L/DUO6qeFT3kPcxMuk1jfXGwkkSgKI1OE1gcLzGxavtVNsnNvq8ia5fPfpf7o8aGcoJbyDpsO/z9y/eorgD3kVetBJZ3gIt0yeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cANeMBcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE192C2BD10;
	Thu,  6 Jun 2024 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683323;
	bh=tzAL0HsFg5aZEr1FmL5GAXhI4Qdi7t4PAjFyxesUTX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cANeMBcdJzWxSJqhNVfhbGbq/q/O4QUbjtDq6olEqmLr5FpbmRbMKNx6S503DYlr0
	 fjymTxp/EtO6PUDjSo3if2huYKtevtnpAfFIYMYNkBDurRZQ/7jKEeAhbCHJqtuuYX
	 i+fIKzJjjAGJFyz16X3lWIyuwwRHIjuoCj4KNK3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Hewitt <christianshewitt@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 203/473] drm/meson: vclk: fix calculation of 59.94 fractional rates
Date: Thu,  6 Jun 2024 16:02:12 +0200
Message-ID: <20240606131706.646322374@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit bfbc68e4d8695497f858a45a142665e22a512ea3 ]

Playing 4K media with 59.94 fractional rate (typically VP9) causes the screen to lose
sync with the following error reported in the system log:

[   89.610280] Fatal Error, invalid HDMI vclk freq 593406

Modetest shows the following:

3840x2160 59.94 3840 4016 4104 4400 2160 2168 2178 2250 593407 flags: xxxx, xxxx,
drm calculated value -------------------------------------^

Change the fractional rate calculation to stop DIV_ROUND_CLOSEST rounding down which
results in vclk freq failing to match correctly.

Fixes: e5fab2ec9ca4 ("drm/meson: vclk: add support for YUV420 setup")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240109230704.4120561-1-christianshewitt@gmail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240109230704.4120561-1-christianshewitt@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a82119eb58ed..2a942dc6a6dc2 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/10)*10);
+				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
-- 
2.43.0




