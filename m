Return-Path: <stable+bounces-95013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0C9D7567
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA48B64F65
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BBC1CCEF0;
	Sun, 24 Nov 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1q3hGg7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C71C3F34;
	Sun, 24 Nov 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455684; cv=none; b=dkHTqxFx+VdqgquFTdrF7NVW16lv7Bsjdr5w0dpRZl8WrXjOnsTwExOrxjo59PO+sFiLOs6BpHe9dLgZnqxVR+zBk4CWtOHAbX6k5O6g+JICKQU0qjwlv3Kzf5SezAKsjTYmcbgE57uowhVWcxdv6xOcuBSsqnnY3U+sFU1fynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455684; c=relaxed/simple;
	bh=LFKXMFYP9bbfDW7M1QzHLN90jPp22tbaEbRFPt/fbzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S05MtU99KunkqpFd0wJ13fDtMqIEvGXtXZ4kFriUfmoLqsG13LQC+kFS6mMRXELsZjV7dzHAEX6+3JLqMnD2u0S9DhQRQWcmEJFV3cE6YnqUtlg1xFRtCEccFEuDv+g/X0ga8Gp8aWiBBAEXTS9NA7UNBKTUVED2TBupTkcGApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1q3hGg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65746C4CECC;
	Sun, 24 Nov 2024 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455683;
	bh=LFKXMFYP9bbfDW7M1QzHLN90jPp22tbaEbRFPt/fbzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1q3hGg7rd89jdOHngd9gKpDdtIv98JnLx0m+K8ABM49dVEV4HtG75MJU9QYq3XRe
	 dad8cVfQqBmB1IfiIcdXUp+8MNEE7cl03+HbB//bAmLTADN2E6y+oS1aLZby+iPAgY
	 z0fvR+7fyGklxWcr552fCpz/0yXscsYYice8LR88LKoe4CSZAbynyYRnFjKt4SgWaG
	 bQNHzo7fAy3Hr4d3DcJ69Q7XG9nUdfpclmGYJLgHO56sqjA3h0ClY8ezwjNt2NSzwA
	 OoxdD6AHSGu1kbNp/B2wpvTZPKuG9Ul1M65FQJm/RRD4qreL6TK9+iliwb9EkxG2CN
	 8tg+ny+dtGGyQ==
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
Subject: [PATCH AUTOSEL 6.11 10/87] drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
Date: Sun, 24 Nov 2024 08:37:48 -0500
Message-ID: <20241124134102.3344326-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

[ Upstream commit d7972d735ca80a40a571bf753c138263981a5698 ]

Add quirk orientation for AYA NEO Founder. The name appears with spaces in
DMI strings as other devices of the brand. The panel is the same as the
NEXT and 2021 models. Those could not be reused as the former has VENDOR
name as "AYANEO" without spaces and the latter has "AYADEVICE".

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/f71889a0b39f13f4b78481bd030377ca15035680.1726492131.git.tjakobi@math.uni-bielefeld.de
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 035b6691f3d04..4dd9ecfa5f957 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* AYA NEO Founder */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.43.0


