Return-Path: <stable+bounces-83557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1FE99B3ED
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DA1C2033D
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A51D1E68;
	Sat, 12 Oct 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF/23Tk1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F519CC1D;
	Sat, 12 Oct 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732517; cv=none; b=GzX2EZk7S/yJaifGvRILY2GCsRFoFEIc7qRgBpSm1IfFJowXhyPf4tEB0+sYp1fhu8Eq+DqgUsvIvN8bHcKxHGXPFPTm+sK9aULpVnZHexFm0Krfy0lFxiQc8xSgQPmiNuUAC4nXaMH+IfnURLRQ7R1rvcW6z9PQMi53SpXKeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732517; c=relaxed/simple;
	bh=a15rdXWBom+EVLMzVNGaBrVj+vIfKEsnXYhppLf8LRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU5NePcV/f7oKbx6JW5irjR79d9DsoSn2aq70dydALaTr+l7K3C9qQPZ9DiTBMyMGWHOUwkbikHHtzGGva1sq8feuPXS3sjWtZj/QtmrCPfFCS1kQEHXBJYQ1uUSC2kl/E4VyCr9fwHpLnrhs5ccB+ixJ+jXPvD+8bWfI2UNMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF/23Tk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5539DC4CEC6;
	Sat, 12 Oct 2024 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732515;
	bh=a15rdXWBom+EVLMzVNGaBrVj+vIfKEsnXYhppLf8LRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nF/23Tk1Vq0oNS2RyHbWOLzMejsDTHJ0K33U1o41wwYWqqpz+nlkdeLimdmWtHFnf
	 zRjo3MudjH3QZTfATsxXWEC+Sw0oN4NJUtfuG+5QfJoxnn0AgpVBAgX0mSTwcmn0mz
	 ygONyVzReyNAppCXQbr5z37iubN184Uzgs5nLnoZ5HUId2fK7sg2Sy0uruHjFElfnr
	 vSRwxQKwxZVVigveQu7EJNdYChrT2KArVxUhekvMXaHNjcrKXGCX/HmmugLUcyh47p
	 tnhrpwChizCTh//qAMb45JrXLWMJQEQtdsPzuqT7ZdQiaiEaEIqyXweKoMb6Ov1Lyn
	 vIOKPes69Dciw==
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
Subject: [PATCH AUTOSEL 6.1 07/13] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date: Sat, 12 Oct 2024 07:27:56 -0400
Message-ID: <20241012112818.1763719-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>

[ Upstream commit 2c71c8459c8ca66bd8f597effaac892ee8448a9f ]

Add quirk orientation for Ayn Loki Max model.

This has been tested by JELOS team that uses their
own patched kernel for a while now and confirmed by
users in the ChimeraOS discord servers.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240728124731.168452-3-boukehaarsma23@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 21f2f3abf90f0..df402f6c5dc98 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYN Loki Zero */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.43.0


