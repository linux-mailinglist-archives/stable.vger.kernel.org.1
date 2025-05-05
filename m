Return-Path: <stable+bounces-141466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B3AAB3A7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FA91B63F75
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FA33B328;
	Tue,  6 May 2025 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH38lmVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040F288C08;
	Mon,  5 May 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486382; cv=none; b=BhpZTGSHLwC8U4L6EX9xrmYCv1+FB8aXMiZlQvGqECt3ICuFzKmgZV74Hq/4BfqSvC6tjTwp3L8LhErANP3movReF1nGmOQwJS4KnQK9vtnUhDRRWe5ZSCMRZ9QE+MF9Dzwo9Y02+8UKjrIEpDHN2nX+cUOrfuH9akCi3/cpuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486382; c=relaxed/simple;
	bh=8E7nac/QCc3SLVtRbHD9vhpFGLL1kZeil0JHEGfxZME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyF35iwxeTkwXuzaLzlkHlIyb7cT+nLIrdV8zi5xX9dJF7KdDYp9t3Bp3uClasUkyI4FZ8wvI49vRKhwc+JoAJjkKeMciudccbjh/bJMtHi/slH7Crb0LLzO32baDYXnzRvgQiYWGDa1mhECainXG92BSWBl0nTR4wP6x2ngAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH38lmVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D9C4CEEF;
	Mon,  5 May 2025 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486381;
	bh=8E7nac/QCc3SLVtRbHD9vhpFGLL1kZeil0JHEGfxZME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PH38lmVgTOK0jEnp+9nVq/RcpTsiBVJCfsuMQl9wz0y3BNrKTdSv/YFBkfH59xMKs
	 sxGcoD3HPG3N0B4rfyoOyFC0WYiNngBcxJEmPYr2g7+1bWppEKzQKNGmsvHcWVNMud
	 3KEyozuvcY//8QbzYcGh4AMLg0h7zPVSTdJDO7chErCEYpmzqXxFummy5gvh30J2n1
	 dq3kC4kI+P34Nsa4h/FmfxwqfFVQE5XDOpZPcqrzsmXaKyBOVDKdtcCaaGSNDPU2iS
	 3AFjryyfD++bBT5XZWm7wfOBVBvXuQrRe1nLsfP8TDevuMTHdy5VS2XpiOa2jgJYyQ
	 uFSqQWSQM3eEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 293/294] drm/panel-edp: Add Starry 116KHD024006
Date: Mon,  5 May 2025 18:56:33 -0400
Message-Id: <20250505225634.2688578-293-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 749b5b279e5636cdcef51e15d67b77162cca6caa ]

We have a few reports of sc7180-trogdor-pompom devices that have a
panel in them that IDs as STA 0x0004 and has the following raw EDID:

  00 ff ff ff ff ff ff 00  4e 81 04 00 00 00 00 00
  10 20 01 04 a5 1a 0e 78  0a dc dd 96 5b 5b 91 28
  1f 52 54 00 00 00 01 01  01 01 01 01 01 01 01 01
  01 01 01 01 01 01 8e 1c  56 a0 50 00 1e 30 28 20
  55 00 00 90 10 00 00 18  00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fe
  00 31 31 36 4b 48 44 30  32 34 30 30 36 0a 00 e6

We've been unable to locate a datasheet for this panel and our partner
has not been responsive, but all Starry eDP datasheets that we can
find agree on the same timing (delay_100_500_e200) so it should be
safe to use that here instead of the super conservative timings. We'll
still go a little extra conservative and allow `hpd_absent` of 200
instead of 100 because that won't add any real-world delay in most
cases.

We'll associate the string from the EDID ("116KHD024006") with this
panel. Given that the ID is the suspicious value of 0x0004 it seems
likely that Starry doesn't always update their IDs but the string will
still work to differentiate if we ever need to in the future.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250109142853.1.Ibcc3009933fd19507cc9c713ad0c99c7a9e4fe17@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 94fe2f3836a9a..53b3b24d7d7c0 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1923,6 +1923,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &sharp_lq140m1jw46.delay, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 
+	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0004, &delay_200_500_e200, "116KHD024006"),
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
 
 	{ /* sentinal */ }
-- 
2.39.5


