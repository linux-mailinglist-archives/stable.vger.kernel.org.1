Return-Path: <stable+bounces-83541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5A99B3BD
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FBB1C2216C
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C01ABEB0;
	Sat, 12 Oct 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDy13rao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D31ABEA6;
	Sat, 12 Oct 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732463; cv=none; b=eTgD5DeYMeYswLV+QxWpmo9PVVX4Otjg5FAldaIkWqT3tPKEeShMGxT18qmr0OvMF0TQp8gXKXNQGzWe/4MUbmvmlBhiwdYDgKmYVwxxLkOafDJy6XwuJfsXfnUJuqeIyrU9+hNJVPFv8qUkH8jgPUjK4zGed4osQ0F8hE221tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732463; c=relaxed/simple;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COBjzkKq+RxgfBH3czUGP0E2LR8MzvOfy7Nq/0oh4paELSyQX0EIxgD16mTd8pRstfthMLzHyeYAh1R5NAZL7MHEmxA2hE/MJMs7Jrn9q1j8fQ6D5Lwk3u8XyC6sc1ofDz9AcYnkwIYCxpVm4fMjlz9YFXFvL0UNQX5rcotSXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDy13rao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413E6C4CEC6;
	Sat, 12 Oct 2024 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732462;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDy13raotE2JQ+6s+/kNHOsZ1RaNdO2y/rotCX5GvaF+GwK3g+9qb+fKo/2M3Ji4L
	 IsMvpV8DYrzvjN6EAkYPN/tH4sjmzEPO/b+rgJutV4McQGnX2PWcAc1/25RzcCLaas
	 giajqOXvmeORViYkuIqE28ImPZw95zpkoMwjZARR5GkV4zl5TFsSe4DOcH8q93mnDK
	 +WtAQXC0teeZNUzrobns8GkX+dk8ABYJOuCU5pyYFPjXXNyOh+O8nF+xprqGV82yx8
	 VPtkISs9pMgRRuGcxLhHeHUil8sLBRPZ4WArUOSherxXcgSvvb6aPLCODTF1O9g9QL
	 LreXq3EayHlAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 11/20] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date: Sat, 12 Oct 2024 07:26:43 -0400
Message-ID: <20241012112715.1763241-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>

[ Upstream commit b86aa4140f6a8f01f35bfb05af60e01a55b48803 ]

Add quirk orientation for the Ayn Loki Zero.

This also has been tested/used by the JELOS team.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240728124731.168452-2-boukehaarsma23@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 5db52d6c5c35c..21f2f3abf90f0 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


