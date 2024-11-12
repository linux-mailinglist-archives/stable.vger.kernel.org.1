Return-Path: <stable+bounces-92494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659999C5476
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B24E1F228E0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0FA21A4B5;
	Tue, 12 Nov 2024 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wks8Bv32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984B21A4A0;
	Tue, 12 Nov 2024 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407794; cv=none; b=MZF5rnvKxdSCf42Bx7DWHAQ3uAyB/oh1kzlm81IRCIjR3oRaAm3Zu1K88FN6Dn1N0kYp0aJ8abmQ4JiHOw0u0RRU2e/anqx9vuxIrK8MIBNoAWMf7r2qHGEzro9GcZhJS2k6d2uVTQAByC1pb1aEMouF4iOY4kt8k1St7OXAz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407794; c=relaxed/simple;
	bh=PoND+YZQMYMOf5xPwNfGhSqabPA/4J04iJxrkjswEgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXeWpcZ3LMz1U6cnPReKCEZkIHDUeVn1LQJlAvPPVwriwPDvpfFhcuUgdWsk8jF2uXOdDl89Cr7upliSsBSToVzKcyU3FNsG6hHFhsAwFOef1bS6QcK+mNsTw+EKJbF8kMFSrv2708d41b4L/i2ZTpHv6HF2Iigs/1sFCFEnC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wks8Bv32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBDEC4CEDB;
	Tue, 12 Nov 2024 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407794;
	bh=PoND+YZQMYMOf5xPwNfGhSqabPA/4J04iJxrkjswEgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wks8Bv32GMkfJHtK6+A2tzf5FaIPMci2mQrrtbqsDwiBGqoUnkXBLZ0rzfV5tsJ7u
	 YLSJPRyLCkN/26pctCPSNjUljepOBlozbvJgDNX4diT0xJ0IDkA/M3or6bmaMMoWf2
	 8Cys1seVD9ZJji0mCSszRh/gT3ESEabi1tqpMBRacq8hTSSvreqF6oxEjNbibjTw0T
	 QM+jPtqvyg6U2pJPbplghECimwy+e4xErSBtqJGdc33uQ2ZhL72H6gPyxxsin0YQFK
	 E/hcpDyaI2+Ba8EsA/wWeBedQhKztL6qqLk/8XWWqdPtc9U0nRuTJodUYiHqw6dLtf
	 c71MuJCijFJjA==
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
Subject: [PATCH AUTOSEL 6.11 15/16] drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Tue, 12 Nov 2024 05:35:57 -0500
Message-ID: <20241112103605.1652910-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
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
index 0830cae9a4d0f..2d84d7ea1ab7a 100644
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


