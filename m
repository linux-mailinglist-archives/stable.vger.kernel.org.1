Return-Path: <stable+bounces-92541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C044A9C5662
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F433B22116
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406D9227BBF;
	Tue, 12 Nov 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EafmqK2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD9227BB7;
	Tue, 12 Nov 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407860; cv=none; b=TUJ3w+o3Vmf31tja+yosNWPfMTKd8zR8AXd7+ibttk6XzAwvyZpoYeU5SPzjieCLSl/GpUl+0d8iki9mGQP3Z5sla1wTyVHNOANTVqLmw4mBa/A1/QcuGXaq94kJJZYvnFiRr2G4hTjutLyobf3LKMxenh6Q7aZEymujcjKoOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407860; c=relaxed/simple;
	bh=qdWgcfyKGVXdA0wrJRrU9EglvC2lqyCHhSITgPoypUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOYz6QLLS688H5DsiFoQghnEJ721o6nD3pD9WRU40YZZM3pb7CevPytRRbqsL/1Rs6KCQcktc/bcIicYQ2Catnn5hO4ukTwZEFfbiYswW+yqUQR5BSNVsVnFq0BzcTUTpOKREYzU3/v/xuMzbmWE2TtWY0aiOglwsPop6SI5VYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EafmqK2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A280AC4CED4;
	Tue, 12 Nov 2024 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407859;
	bh=qdWgcfyKGVXdA0wrJRrU9EglvC2lqyCHhSITgPoypUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EafmqK2+fxmJYzu8XVGhuqddJZBdjsGCseEyTTYK9/+VR4zImFo+o3c6bG1+VDi4a
	 jHYzlA6AQahImOTkYaWdx+SfQVIWzi6zjU3GZLHXczPp4nrv2tZxtlavzXVK85vnfE
	 B7c0WxOcVXb6EI/C0T5KFaTxU4zgANirOEPAPCgAWlejZGge0XIs1HuIyBS3qmLoLF
	 Lhqzod+nFYPV+XZtO5vmlWRqAtag4iLmKj2qU7b1qHF+XKc0mV78VpAZGVtxh+EiwS
	 sInkNJxS5UPRNt+WY0BfXy996B67kWn8laFZPvQ9p9So00fnCSoKSe5pLg7AzwFRqY
	 t9mL2pH2U+2KQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 11/12] drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Tue, 12 Nov 2024 05:37:13 -0500
Message-ID: <20241112103718.1653723-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 052ef642bd6c108a24f375f9ad174b97b425a50b ]

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240825132131.6643-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 5b2506c65e952..259a0c765bafb 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -403,7 +403,6 @@ static const struct dmi_system_id orientation_data[] = {
 	}, {	/* Lenovo Yoga Tab 3 X90F */
 		.matches = {
 		 DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-		 DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 		 DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
-- 
2.43.0


