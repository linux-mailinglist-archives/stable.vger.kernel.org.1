Return-Path: <stable+bounces-110552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64660A1C9F2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF8A169A75
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A41F9F62;
	Sun, 26 Jan 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d65Xl5BC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDB1AAE1E;
	Sun, 26 Jan 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903337; cv=none; b=VJILdJo5IZO2TZEPArwE1UN083VKxJb7tG8tTyt4zz6x6HGhcGPTpUFAR8eo3YLanAXw2RRd6ywt8M3hM7T5q98LWcBgCv4S7aMYXseiTY7rJZaBrTNsaix6qSR4Y7iNr3QE7HHcFmrcrfpDFkg8rL9bL71hzYVCcCZ2som27ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903337; c=relaxed/simple;
	bh=fyiEmA/jTVf27Oj64YW7GKYpRdBIwjXLXoZQuJA4XOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUjvFouUi4uln0r/RoR+uy02bw6ORmSq0xKqIeci+D6fcDO1mTc/TGFbrFtsuMMKjZFP9jFC5KR6vNI29YEVuwfHnbLOfm4SvIb6qunsPfGJLMDxYKIZU9efyWjeZQYZCqMwXEKWw30dIe2IpLnIzEKkrS0gNabzGLWWjyscM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d65Xl5BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC02C4CED3;
	Sun, 26 Jan 2025 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903337;
	bh=fyiEmA/jTVf27Oj64YW7GKYpRdBIwjXLXoZQuJA4XOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d65Xl5BClaoN0OfHrCvp0yR+SaHMxXr5BzwgKLnilD2eXZNWOgaj5/xsfEnSquWIj
	 uVFiLXochCNC/NgUKreUJPm4wIHXJgg71iX2aBRjATKaP6dJgtjsOJzAf57udt0xs5
	 Pfe8OB5xqpw8wWR2+ResKVZCGs1qpkawLhuxUGOkHOxiC3b104al2zVu443sRkWMy4
	 x8LEqgBXKEL3EvcE2+ezEG0Kyi+8li3ogyPaqcPVBZLehiFx9EaxxKJhrAOrutT/rd
	 YTxcLSSadsEVLS/WAnS+IOcyg7miArrt5JCblNM93XmB66a1hR+Xf6NrxMbIAx/rPQ
	 7oQijtw8TiKdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	krzk@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/31] drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:32 -0500
Message-Id: <20250126145448.930220-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 5e8436d334ed7f6785416447c50b42077c6503e0 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-5-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 1e26cd4f83479..52059cfff4f0b 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1643,7 +1643,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	struct drm_connector *connector = &hdata->connector;
 
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


