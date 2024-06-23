Return-Path: <stable+bounces-54927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21610913B45
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5463D1C20CAA
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B781946D4;
	Sun, 23 Jun 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPEcG3vK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56111946C1;
	Sun, 23 Jun 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150309; cv=none; b=NzLi8hHs78QrG+qBXR6W3g9vI9LSRPx5MFlSAq9KJkO2OlnLiAS/dZvEx6ut+JUaE+HwBNqcpJ0dH1ih9GVV0L5F7wcmFNx7spj4KUDmeySyGZ/+o3ojIkBU6D80sffPKD2Dia4xlD+7VaaD+MlIAkaRFvLjT0yhvZUVXsSwy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150309; c=relaxed/simple;
	bh=4nkdyw11JFFQf6jwYWNjBj2N7W+HZsqxpLYv6cEgvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk5ZHGf9SL7lBRDA4iGli4QlrXC6w/O0dGNmYJEQVT3D6LUAWuBLrrawS9ZE/BC90QKMGe5BLXhQerlMJEZHWFOeQJk90qfnVP8dOu3foRt1hiCgaFVOpBbw/raT5QHPQOydCvmNxfQ/PDENM+spGmMntu+FWnKANg5RWlhaj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPEcG3vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1D6C32781;
	Sun, 23 Jun 2024 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150309;
	bh=4nkdyw11JFFQf6jwYWNjBj2N7W+HZsqxpLYv6cEgvGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPEcG3vKgufaqQ4nauVUasp+8bKunM6BKpPM5CCc8WJWaxJe+Kkb+QAlLPKDd+rlf
	 Mm3ulDNWTiwgVr9FwxTmfnH7Xo10r34GsKPoXK1u5qhzdXTYpw2rdDkhYpm5/Yvxv5
	 W/Mwq6kzvhLITwod+n2hPXTcym4fIc3qE71Sdv7qFVwsobWhxSiBCNJpu9ovmYqXlb
	 ljP4ACvpnLfjR0DuKEkm62q8HAfTPB1ryMABK8iNG4ufe76fqqc9ExDz6v9zhIk/q9
	 4ilP3NsD1m69Gu6dpt4ydYCEzW7ySn4qReNmqzO3GikZfI+vdRh8wb5JGEomkzevEo
	 aMHkxLboOAqWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 13/16] drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
Date: Sun, 23 Jun 2024 09:44:42 -0400
Message-ID: <20240623134448.809470-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

[ Upstream commit f74fb5df429ebc6a614dc5aa9e44d7194d402e5a ]

Similar to the other Aya Neo devices this one features
again a portrait screen, here with a native resolution
of 1600x2560.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240310220401.895591-1-tjakobi@math.uni-bielefeld.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index aa93129c3397e..2166208a961d6 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO KUN */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


