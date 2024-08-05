Return-Path: <stable+bounces-65437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A7948121
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B90B24A9B
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67216C436;
	Mon,  5 Aug 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBh0ZCI4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C7165EEA;
	Mon,  5 Aug 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880718; cv=none; b=oyOf8uidEXvLAkK/2Ve7k6oBzKslHDvvj3WUu1J/vrGDcZbIS538vFZ+JlZBQqN/ZfS6TV9rXv/LlZL1y3W3fAv6Aarpd5I0R22XE2pg12pGKMct3aDp2rsVDtpzirTukI7aXuvtuck3RIsARhys1rLPiXF9R+c+GN0Bok8MbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880718; c=relaxed/simple;
	bh=RRDV/CmIBNFMCcfOFkxZeKbtfZsrblNvgdeMEQIeIs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctt/sMMDiYRInbpp2F4UiNCVjP2aKSLf1nxbht/3QexRRzqK1mgGNQKFZssn6HxD1lQjXHuPNMblfP68hePaSbJ7TvYcUrGJu5Q015/CRxu8V1/nelinLtjQyU6FyYG87C/UwQMTogIj1A/Y384VAsE2Oq8H7u/wu6/HOp9z/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBh0ZCI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EFEC4AF0C;
	Mon,  5 Aug 2024 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880718;
	bh=RRDV/CmIBNFMCcfOFkxZeKbtfZsrblNvgdeMEQIeIs8=;
	h=From:To:Cc:Subject:Date:From;
	b=GBh0ZCI4QnySrz37BgRiPlRcRhNkkfGr9GBm6BJwC3cuNiQLlWgX+qf7CiqVBPuqj
	 RvsFKInKHeSCPUFpVrFZ/clB8CTbpcLq9MRzkTVN1SPyx5tstKUrOLCyvXi95lOXGF
	 Xr8tspnGsHUgJWIWtIfEwqRcM1eRWHOYjJXRdlh52hXYRERWsUic/Ic99YbRIX+grp
	 5AOhlVOjCfQPHr4hbrV+UgohqwFnlsgu8pzSCBaMfGvDWMocVJxsPh5qhNUuZ9IGQ/
	 1kAm43be1glsp+FJk30HRNKOLq7/ohSLa9dWm+welPv2yQATJ9c5iycrbk9A75SynO
	 jGm+8df+l5iWw==
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
Subject: [PATCH AUTOSEL 6.1 1/5] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon,  5 Aug 2024 13:58:24 -0400
Message-ID: <20240805175835.3255397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.103
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


