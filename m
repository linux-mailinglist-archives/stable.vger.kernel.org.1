Return-Path: <stable+bounces-12352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23F835DBA
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 10:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2E1288304
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50F39ACD;
	Mon, 22 Jan 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKdz0JE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5439AC5;
	Mon, 22 Jan 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914735; cv=none; b=YZGN7Wvc7nK7KhEjvC9t6dbTY0rm6uCk8p6K/+HFkpA/uz+Oi2iE56f1wcWi+aJRM/BEYYSLf8jH7zK99UHWx2baRvJv1tbZjEEv6jKtipu+1OZSf86MLpxqojOLKdo4MBaMVE7gP8i/5CtPJG0TRYiqzdZiSLqlbLpHHHlKnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914735; c=relaxed/simple;
	bh=2fBoKCcegy/XwfiYfFjhAIztTEvocYf7E0NC0/GEvbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mInPPCJmMHRUcBUL+pLoeWsDwg4AT7lDpUCSMRSuHC91kLS1pT2Tk9v56yMnRjXUbcjIKGUfjPqLrF3idEcomRV5BcC/QWtiBnGltkvTwAAhImlUMJN5Z9c7LnNgz+HJVODB1BEfH1eQ7LZeE2nW5BXXW9JLwmjvRj0Lo0oZNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKdz0JE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C62DC433F1;
	Mon, 22 Jan 2024 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705914735;
	bh=2fBoKCcegy/XwfiYfFjhAIztTEvocYf7E0NC0/GEvbw=;
	h=From:To:Cc:Subject:Date:From;
	b=vKdz0JE13pPip5mI1Oa+yl435logMUU4vyMM1h6xeHAdY0fXHfcFPNCEWL+vI69mf
	 VDrk4h2N5ffm4ccvIrZ4M1hxKTDix67WGWHmw3t2dX89i34lRQf97cqAv21tbv7aLc
	 G7VpwXIOhkDbi8Kj4qArT8Yt4IsYXBqKvYB1KmN/0asJdL5tnl+oTZo2WEoF4HIpwg
	 30JuiA5gsXaoxULLWVRPpSgw/rBrhHOnixQlLZ4Gn0/FP5UluJUCYaHoaaVd1/YVd2
	 kP0iys9hHkEP+zPV3UMLEEF5Tj/r3euVnFS4paIH4llSahDiT3c5EMUqccsPY+o9G5
	 20VTZoMvMkWog==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rRqLx-0000000079Q-1j8u;
	Mon, 22 Jan 2024 10:12:26 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wcd938x: fix headphones volume controls
Date: Mon, 22 Jan 2024 10:11:30 +0100
Message-ID: <20240122091130.27463-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lowest headphones volume setting does not mute so the leave the TLV
mute flag unset.

This is specifically needed to let the sound server use the lowest gain
setting.

Fixes: c03226ba15fe ("ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR")
Cc: stable@vger.kernel.org      # 6.5
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index faf8d3f9b3c5..98055dd39b78 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -210,7 +210,7 @@ struct wcd938x_priv {
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
-static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);
+static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(analog_gain, 0, 3000);
 
 struct wcd938x_mbhc_zdet_param {
-- 
2.43.0


