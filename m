Return-Path: <stable+bounces-83556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC699B3EB
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A3F1C20FDF
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A311D1500;
	Sat, 12 Oct 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/wAd+lg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF91D12FE;
	Sat, 12 Oct 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732514; cv=none; b=jiq8H/n+bEgIrnfTHqq8wtIyipZcF3nwAx1zmoGrNyCBRUqsPfpI2XuZbMF9nk1mMnYEKTlCAD+uV1pKLDxGQKvzLx47dChaexcKhF+qD/EyPH911LtRA8HqUUXqgHJhMBhuS8J3twbs9J/D8IPyNfXNPNxDl2Mhw9jmVfBWQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732514; c=relaxed/simple;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ekb0m1NZhB7bHsKnlPq+j5I+3jltFqsvPWh/EBVXHrfVa9pWs6Vrrn3vSXHRAz+kuKKbgtZE3yL6UDlM0AhP6j6s/LLpyZHui1DXb2TYCsqexTymqMxSrpJonVrlHNkWy6R4XxXDBF7rzBRiTwvuxvPyuB9ZB9j6GjA2a/iyQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/wAd+lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844B1C4CED0;
	Sat, 12 Oct 2024 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732513;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/wAd+lgDNzo868vuQIeCvFYswF6D0mpI07iIk/O9SIuO6z5zkeiU6J3PvfwEUrXA
	 PKNHkktAyCx1MC4Wr4AB9UmMdEceAYGZ8FDZcTnI3Xi5s7GfCh/8k5la3cttPF9Jsf
	 sDhkmU3U4NiWGnzQFrW+PicZb1QAuUn+OkXTSsXTXTpDQ/l6w+8tfqm+JU/mAyrFXK
	 2FBM08WthZakSp/AlefvayFl/XMmMldPU8zbfQ0DnCilRa4EZrR35qtJQ/RVtDb3La
	 sSuBl26BvXkmzZDeOZCQbjC+FN/z9iG+qax8iD1nMaW0LBoBPk3+qbhEV+F5JnCZVX
	 xWuxcQg0BfdQw==
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
Subject: [PATCH AUTOSEL 6.1 06/13] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date: Sat, 12 Oct 2024 07:27:55 -0400
Message-ID: <20241012112818.1763719-6-sashal@kernel.org>
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


