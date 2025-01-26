Return-Path: <stable+bounces-110598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F42A1CA6E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98F83A9ADE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3C202C4C;
	Sun, 26 Jan 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9D8K5fd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E406201271;
	Sun, 26 Jan 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903441; cv=none; b=O1LsjP8GQXknMcuqgCohlf0nLNaAymoql37sxiqD1JiDsds6zLkHyaJdWsz255Nqw910c3iECSzwgoMZ15rmuve1XfgdGhcHvC2G8CfnAkEHAeey6lSiqh75BssBPfA26yRfvRPeohNfEL+hj5kHBgelGl0ymhigqxsCFIhw97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903441; c=relaxed/simple;
	bh=Ojtx9cnNhIZFkkBxjxd7X5B5RT1T88qxeLuQRJvKuHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O68TaClmz2nwMsl7QLXPAklo12d+OgnkorNzy79Qu7j4gAiYKpVOfYGHgrpkE5AiAQDsjKZhv6oTMY3BNUCu3L0JmcF+c+gI6Ue4wAnLMXqUSFRznRAcPzBPjgYS5Xcm1+l9kyfy9U8l4tdoueoRdMcO2j6K56TkWaku9a+aM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9D8K5fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172C0C4CED3;
	Sun, 26 Jan 2025 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903441;
	bh=Ojtx9cnNhIZFkkBxjxd7X5B5RT1T88qxeLuQRJvKuHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9D8K5fdblHvHuKbKff/rTdig7iXWquiGj52RF/k05Comn8LmO/qNRIVJ1eWhcaNK
	 HxPFAQMYZgeVKZ2xpUSo4xgGHd+EgyxHh49pEftY6NSH9NiroINAAKuIA6VxIQT/h2
	 ia+m7iMEHZg1z4eWqOKo9ytNax7krRi25NGJiy1PpbgAqReMXFWoPcs0uczWypFJ48
	 7FqqXm31ELEuMGbIwwGisq5M7MUPLgWe3X4OXh2opC363B9iASYLI3FNjHygbrHnY4
	 E5ls979KE0ZxF57829bS0Qsd2n+YHTPwXwzDGt9qxlmeNMq0HILb7c06UgeuYMDYSo
	 WhN+9bbQUsYcg==
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
Subject: [PATCH AUTOSEL 5.10 2/3] drm/sti: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:57:16 -0500
Message-Id: <20250126145717.946866-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145717.946866-1-sashal@kernel.org>
References: <20250126145717.946866-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 1bcee73f51144..f5dd2aca097a7 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1213,7 +1213,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


