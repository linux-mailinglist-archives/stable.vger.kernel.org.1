Return-Path: <stable+bounces-110524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C040CA1CC81
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765C4161F8C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0931F37DD;
	Sun, 26 Jan 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGwoEWKM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C21F37AC;
	Sun, 26 Jan 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903259; cv=none; b=iLD/5msJ7b0jnr7K372iV+CWA/xaj5QKtFOmCf9AisBK/qS4hJNmoQAhuB/2oVry/mRoCh+LfFrdZrYL11q5JIriPBp9SsR/qeA1XaQGi2SrN1BCQXZIsYMh9q2SR1uE2ScbJ8moK2g1/b4MJgCN+gz5r8LdHMNADuzc8CPZT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903259; c=relaxed/simple;
	bh=fJyTBS2ExqGpvNbdJ1n6lStfVfvPf17Xj4nym5EELzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPa1G0pxMPsln47S/afTGIH8szN0TS68UrXgPXMkuunhbMI/v+Yq1zbOC3cZXKUHIeALlhspktJTY/bTyOWDQLi6VZKPbDVuOz+HIM+MdqqRQM25s/uWTGGVe7clid714i869yk03fF/2Fy72f2aPAiMH4sAjR5jDke8g+/jkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGwoEWKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC85C4CED3;
	Sun, 26 Jan 2025 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903259;
	bh=fJyTBS2ExqGpvNbdJ1n6lStfVfvPf17Xj4nym5EELzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGwoEWKM/0G22AHOzr9tGLUtqc+7kJBzRmrdLtjgE/yP3eTqyvu2Y3muNXrsLiKtH
	 UoHFgBTwBhd4a78fOBGWh3zrabrXbkXggFRGpOT1ED5yqOh3iK7zsPdw4kkMsImeyW
	 FN7BfOMlkdxOzzS4r39ZdMoNOvysGCKZguM5YlmuAoP/siFTu3WcMMgERW6KG/UFdZ
	 nxWl5U3JO7gIHSs1Gl/Bb0HCH+z5l7lye5FfzijYD5kaWka3fSI7M7OVUmOda+HjLd
	 30RlALQ7inW3DYXGSBQpgqvGc+2F0JVHn/PsDGKVGJGAS3CdtfL+fyC+AatjPaS2vg
	 fupQXGjYwUArQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dave.stevenson@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 22/34] drm/vc4: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:58 -0500
Message-Id: <20250126145310.926311-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 81a9a93b169a273ccc4a9a1ee56f17e9981d3f98 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-10-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e3818c48c9b8c..e86123009c905 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2193,9 +2193,9 @@ static int vc4_hdmi_audio_get_eld(struct device *dev, void *data,
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
 	struct drm_connector *connector = &vc4_hdmi->connector;
 
-	mutex_lock(&vc4_hdmi->mutex);
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
-	mutex_unlock(&vc4_hdmi->mutex);
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


