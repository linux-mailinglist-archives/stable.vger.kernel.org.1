Return-Path: <stable+bounces-95095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB259D7338
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF03284830
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECB81DED7F;
	Sun, 24 Nov 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk0nKJl0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40C1DED4B;
	Sun, 24 Nov 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456007; cv=none; b=rX23YVKWN5kRfc9VfXhyRHTmcvQSZay0U4MBkuvJmHlYo0qEzE5j6Xg+88scS1qbAhKGLx3zWoGVdIbKzL/kiNNz3wN0W/KvCrAa6EAF7Wi8t/amdxmSkX5W32XbVLWX0ROGwVNUn37sWGwgmZ6iC69jxVKcFEURVOT+utMRX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456007; c=relaxed/simple;
	bh=Gfpt/WfrzJ/1Kk4TqUo4RaGL7b1jGBBk5YGmNBjr7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3wBAvTEdmDkV4SZvxHAhotSDeEp5itXhoVW+T2sKRJ3m+uQIL3zjVnt4kEFKwjT0yCDSvHoRkvam/vlmXX4qHlYr1KnKkJF1iDQOV3KN/nPcfHOHBRVAu/RZ7jCsoOUbmLHQbkazYrLkFq9i99fPNu1LaNzjNsfN72POqOWZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk0nKJl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B707C4CECC;
	Sun, 24 Nov 2024 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456006;
	bh=Gfpt/WfrzJ/1Kk4TqUo4RaGL7b1jGBBk5YGmNBjr7mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gk0nKJl0aKVK9qpa+zf1mSv0JmLNFajrsfZZhBLt+xpw5Waxf/hItHA4Q426JOTro
	 klZAvym1oX5Vq1eiiUTnmu8LWzQAU86hyA7Ae3EU3re1axEB8RRZ7sJdyC7M0OatkP
	 +mLjuEIhjc5KBliNOaV5Gei/ZzCGpjeb0LCgiejxmvk2TMhQGFLS8cj5je+F8BSatL
	 dzvA6BqFxBeiZ4ejc7rLtnE1Y7NVY1jw69RyxaX8KK3Ux5dpL+EasJ9yXJ9XdLJ420
	 c2jw9pKnxwDU93dnB9V9s4+z65TXnVWUBN5Cl6p0JQhsCj4kuw4GNL1SeNE3NWG5NO
	 EEHkE8XHSKYwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 05/61] drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK
Date: Sun, 24 Nov 2024 08:44:40 -0500
Message-ID: <20241124134637.3346391-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

[ Upstream commit 428656feb972ca99200fc127b5aecb574efd9d3d ]

Add quirk orientation for AYA NEO GEEK. The name appears without
spaces in DMI strings. The board name is completely different to
the previous models making it difficult to reuse their quirks
despite being the same resolution and using the same orientation.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/40350b0d63fe2b54e7cba1e14be50917203f0079.1726492131.git.tjakobi@math.uni-bielefeld.de
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 87ab8009c8fd4..acf2dd02aad14 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO GEEK */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "GEEK"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.43.0


