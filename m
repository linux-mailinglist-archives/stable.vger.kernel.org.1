Return-Path: <stable+bounces-92520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521719C54B0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083191F22A7D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1AE21FDB7;
	Tue, 12 Nov 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5uIo/SF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949621FD8F;
	Tue, 12 Nov 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407832; cv=none; b=DY6j1ymztNOOZ+IJzFLn/nYlmau9ahCY2n3kheUNWloSOeVl17btp/1gcyUIwOeiKx+57XweYAiERZizS1nxpToAKW9wf9Ia1NXcX1kr38ZFEWUNof9XBAOHR0IPRkgRZlhIKcwSXOpjE8em9qeS5uqu2WgLwUhvKk3YeBS/28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407832; c=relaxed/simple;
	bh=qdWgcfyKGVXdA0wrJRrU9EglvC2lqyCHhSITgPoypUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwM3KwMODvNYjbvibzn9fExBc9dMOZ1gwD1XPlUdgv9YXUBviXS8KxhX8k6/GwlzeRYftqPZ3EvWGJvl8gTeQ07K1cZMQND1gxarE7v3qfn+bTu+rwiDCJD+irijpHJ0d+BtiOo/bl6W4G1tM3YpV8Xdcsq+ALIQBXmc3l8vfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5uIo/SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905A4C4CED9;
	Tue, 12 Nov 2024 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407831;
	bh=qdWgcfyKGVXdA0wrJRrU9EglvC2lqyCHhSITgPoypUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5uIo/SF2CPz23lazbTl/5jSfCEvizmF4zwA68lx86Ci1dQzdGSfXV7JWvA0zBqyi
	 MsZL9YF+VlESSpZ8KKCpb7jngQy4EEb0WT2ZGdqmOosYYqE/qHoKb6ZfBqOT2Dltl2
	 n0eiwKCPrGsmbvmZo3bj9UwO1F2emaQoOFpSaftGxRgTYtQGU2HE09wL9m5DfVUrby
	 NX0bY6i8V1ikI/HYjgVbI7X4D8NdSMWE0X44nvoBwgg1InnRA2FItvyJMZitQ9uf0c
	 z4jxNuTRcll9JNene+z8p5wdkZDlaXSEAHvCRgsMJvVWEnqHryc8Alev1D4H3ORmme
	 KDFDSNFoVZVSA==
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
Subject: [PATCH AUTOSEL 6.6 14/15] drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Tue, 12 Nov 2024 05:36:35 -0500
Message-ID: <20241112103643.1653381-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
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


