Return-Path: <stable+bounces-110596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B386AA1CA4F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ED81681F2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACC9201116;
	Sun, 26 Jan 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW+NNTnh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17351201103;
	Sun, 26 Jan 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903438; cv=none; b=kUD2yDjddTnBQUgrgIJc3VVU/0jGNix8bB2RRkYLhYeMBOs3se196W0AKBnUQ+AYHM+8NuD8228uSk/JSgBrX6AxPQY0VmJZEbmEN14wT/cq4yWv5OQvZSaCgF444Fn//Ybr1p2jwVacEn4VttTXp9GPQNUYW0Gyln5CvqNPX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903438; c=relaxed/simple;
	bh=Hp9DZrCKjPM+6PwiDNFCOHJ/yx2WVOqIMsJwOuCGVSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emad55gqWtZijEB2NVADJAdDO7I8cCsRD4ZrDfD7Q1/zLA8DC1AoOyJjHednWdz19NfjScAwWfeBcjgzF1ItHERaG7vvvUq6pxpsKyKzTOiJjkmtClqAcCjIL3oomb2SnKMM9PMj5jPxzCkOBRiClKyLxXrI9UM+9r24JncZ0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW+NNTnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5309DC4CEE3;
	Sun, 26 Jan 2025 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903435;
	bh=Hp9DZrCKjPM+6PwiDNFCOHJ/yx2WVOqIMsJwOuCGVSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tW+NNTnhK6BSyiI0U7norDFeyrCX2fr8I41WdGfbuzYG2A4BKH7OBLxT1STrhKrJ7
	 FWUZlSg4tBjvhCj/ZarK74MUxJQHGcG/CnlnutF7QwHGTFVKZxSfm09yL344uFVo2m
	 7d9EYt+sqUjeGYXFe2h+smDm4ofvkaixFY2NmKerll26bLZw9buCLNNpzgGpsAEJPv
	 IBKTjX7mVLPj4VMqHyjMdWFpO5a0IZx4x+lqbG0EPvAEtN5sv9HSvdbJ6VI0lxZJj1
	 GZSk8zjzW6dB6pDUkrNuVaQSSYLzuz8iYT7k8ZGBN1ZozDoE38svWPGiYjwuE/nJ4e
	 7TheRAXI09xjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	alain.volmat@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 2/3] drm/sti: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:57:10 -0500
Message-Id: <20250126145711.946014-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145711.946014-1-sashal@kernel.org>
References: <20250126145711.946014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit e99c0b517bcd53cf61f998a3c4291333401cb391 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-9-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 36bea1551ef84..8b2f44d73630b 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1219,7 +1219,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


