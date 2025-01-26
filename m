Return-Path: <stable+bounces-110510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA3A1C988
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A891689F7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735919E998;
	Sun, 26 Jan 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4xtvciG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970319DFA5;
	Sun, 26 Jan 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903221; cv=none; b=h9wTxoBc27sXPq6nBg54CyyCScVTHlIPWkTLdh1C5KcopPgWlvrPJccg1OSbfwj3fTX3NOAG/mdSznrBwL+nmrdQlbTg+uW3MMUqr+Qe1rgkM96f2G3wJG2t/2b1uZacW/8B9ytRJgcqXIhi2bH6wrsPf73g9TADEt+lMqf9C8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903221; c=relaxed/simple;
	bh=cSU342SHfm5sEU97zxcpswrgFA+24zyFUoMzYMVW89Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzbtdinb1lOrHSxdRMwI/NJqjQG9RMGVPcR+cpjlJ4inCqKIPKc6Vg1UI3GLn6884nFAb4SWHMF/K6/tf21F3oR5+6wRvpCxkr8OScyGyASP968paG0ZfeyYV+tXorAg+itePHi2Drygd9HsyxmV27qKJvSdEIwymmGjbZs8MWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4xtvciG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB4C4CED3;
	Sun, 26 Jan 2025 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903220;
	bh=cSU342SHfm5sEU97zxcpswrgFA+24zyFUoMzYMVW89Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4xtvciGcNRZV5g8hCxj30N9SW9ea8eBRmYMIKZ1QhRPGbQuiqSZZqmWmoIpklfnd
	 gmwJ1061EJx/AIumXCbo2hjYpZ7ZHT8rIxGg2DSMTu8FmTC5CTiqZ0uIOre4A/EqEV
	 kiew6qasvmZKMW54sFDYaFfky0sFV/qSlEwBy4kOEzZcgxIeLl5vjnUn5XEyrDA2e3
	 ckUwNUTXx4etDwJ2Nk3CVWO1hQ+9FH3cIZ+4QlfEjY10fE4ecwmcO7ZQgBDIuLT1/X
	 smvClSejYTp2x+Nyc9YjBB1aZzFLi1uB3FKm2aQesBagSbn5Z/vZbUxSTZWTNfkZdj
	 VGPL57cIW8JKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dave.stevenson@raspberrypi.com,
	quic_jjohnson@quicinc.com,
	victor.liu@nxp.com,
	ruanjinjie@huawei.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 08/34] drm/tests: hdmi: handle empty modes in find_preferred_mode()
Date: Sun, 26 Jan 2025 09:52:44 -0500
Message-Id: <20250126145310.926311-8-sashal@kernel.org>
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

[ Upstream commit d3314efd6ebf335a3682b1d6b1b81cdab3d8254a ]

If the connector->modes list is empty, then list_first_entry() returns a
bogus entry. Change that to use list_first_entry_or_null().

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241130-hdmi-mode-valid-v5-1-742644ec3b1f@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 294773342e710..1e77689af6549 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -46,7 +46,7 @@ static struct drm_display_mode *find_preferred_mode(struct drm_connector *connec
 	struct drm_display_mode *mode, *preferred;
 
 	mutex_lock(&drm->mode_config.mutex);
-	preferred = list_first_entry(&connector->modes, struct drm_display_mode, head);
+	preferred = list_first_entry_or_null(&connector->modes, struct drm_display_mode, head);
 	list_for_each_entry(mode, &connector->modes, head)
 		if (mode->type & DRM_MODE_TYPE_PREFERRED)
 			preferred = mode;
-- 
2.39.5


