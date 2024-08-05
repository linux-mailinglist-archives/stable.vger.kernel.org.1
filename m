Return-Path: <stable+bounces-65423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF19480FA
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22382B23F8A
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97781166F37;
	Mon,  5 Aug 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnzuUtuT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57365166F31;
	Mon,  5 Aug 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880661; cv=none; b=Jy9pH9qQ/1jJa0Bst+/QY4hxMkBl4PqBMOhZB+7B0pQsHcQNfprMtvEAK2QKtyISHJeQl0cUMWS5/Yb4YxUSSM21YON6G77+co005wtR756jVY4nGc6xW6idi8qd5kevSBDYxLMlVAM9aDWmuCXNCI6rtAhC9NPIjiT8riLQ+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880661; c=relaxed/simple;
	bh=RRDV/CmIBNFMCcfOFkxZeKbtfZsrblNvgdeMEQIeIs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO/2vMVv762ZCT9ycR8vwS+bLm7Z3u8Ayn+8Rm3CCJj7yQnJQKcu0C71kGdL9FBiDscqSjPp55x2Hi9pZZtdgyJLxRhudR4CyhWUJo6fD/oA43jGwvrv9mpv8zXc42VQcW5uOAC5drJlC7WRP1yTT3gVXn0OE7Ilj802we+t+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnzuUtuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE023C4AF1D;
	Mon,  5 Aug 2024 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880661;
	bh=RRDV/CmIBNFMCcfOFkxZeKbtfZsrblNvgdeMEQIeIs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnzuUtuTAuO5gPAafJ3dv1E64AY7Zf+h90wZbKFocA+8IrRdLzeBMVf7G+kK2k6Fh
	 JMEyWNsVAOsU/tw9Jsu6V4HIVKIIZ2aRqy5p8SkMFvJXRf/SATRsYHKcKoaXJOVARE
	 dGHQG0afFX7loql4TqDrJk6MAwR3e4GzDmAictPnZs1gDPyBFktwi8BAlsD2bLIwdp
	 6O9n2bY9kZbyOt0bkPfrwmeNl/FRICG7px7gTdiNpI4Pt9RCuzL2wo3kIhLb27yEH5
	 8DGPlf0Hl1qOhFxyJjgGSYefPeWHmUdK/2nMiFo/G4RterPx3MLBPqQhFUi/kowxxv
	 f5xEdT20URosA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Mueller <philm@manjaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 02/15] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon,  5 Aug 2024 13:56:59 -0400
Message-ID: <20240805175736.3252615-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175736.3252615-1-sashal@kernel.org>
References: <20240805175736.3252615-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.44
Content-Transfer-Encoding: 8bit

From: Philip Mueller <philm@manjaro.org>

[ Upstream commit d60c429610a14560085d98fa6f4cdb43040ca8f0 ]

This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming
Handheld.

Signed-off-by: Philip Mueller <philm@manjaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240715045818.1019979-1-philm@manjaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 5db52d6c5c35c..039da0d1a613b 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -414,6 +414,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OrangePi Neo */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.43.0


