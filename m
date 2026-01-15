Return-Path: <stable+bounces-209060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B2D264B3
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56A4A304435B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58ED2D0610;
	Thu, 15 Jan 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YxavZT51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5F258EC2;
	Thu, 15 Jan 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497621; cv=none; b=S9BRWGqEuzuNzEj8tRaepzWePpnvD91yxUVpWIqd0KA5mOxeqkMI1gKQu4FAMq58STGuWGR/Ept5JQyL+tJND4DgdeoNnjA8qQJG2ko9iMnJKVFxc4/jj4iTeZb1lEQJnrFJ6ddx1LUEIWz70tTTVDubRAfqwfMwr4gSaETtxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497621; c=relaxed/simple;
	bh=EKZhs2bbZt7lSKsqhdhBJub+16a1nW0/XyKU/184rRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjPISGj9rK8CLrRh2XEhJUNueG1WeOtqp+HefHGKN1A+M9fznI1/YVIfz8C8Ef07M5CutJGSA3h2OfogkuLqGTWml5c8ZaKIeZmHrDDXgcW1B3edxFQ6hvKr6bWXqvSugxXEbKsYQ8Af50FOL4S87AGhJUwx7YovMP9op3EnOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YxavZT51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E825DC116D0;
	Thu, 15 Jan 2026 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497621;
	bh=EKZhs2bbZt7lSKsqhdhBJub+16a1nW0/XyKU/184rRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxavZT51+VggmP6qzFShWUNxKxCX7HSb41FBVMZQ+oiIaD4S7pMT1uXqRUErwg1q3
	 Bdb/QJFKg8CR1TryBFauhhToAPxKYi2SdDgxw/D5E1pP8EkRV3GrJuJ6RRUPo+ca8q
	 d5YwAlnrLQNm0evyyuN+83RMrm/tBqk8ANOYCDJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 146/554] drm/amd/display: Fix logical vs bitwise bug in get_embedded_panel_info_v2_1()
Date: Thu, 15 Jan 2026 17:43:32 +0100
Message-ID: <20260115164251.543550168@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 1a79482699b4d1e43948d14f0c7193dc1dcad858 ]

The .H_SYNC_POLARITY and .V_SYNC_POLARITY variables are 1 bit bitfields
of a u32.  The ATOM_HSYNC_POLARITY define is 0x2 and the
ATOM_VSYNC_POLARITY is 0x4.  When we do a bitwise negate of 0, 2, or 4
then the last bit is always 1 so this code always sets .H_SYNC_POLARITY
and .V_SYNC_POLARITY to true.

This code is instead intended to check if the ATOM_HSYNC_POLARITY or
ATOM_VSYNC_POLARITY flags are set and reverse the result.  In other
words, it's supposed to be a logical negate instead of a bitwise negate.

Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 6bc8c6bee411e..bebdc9b53bb6b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1156,10 +1156,10 @@ static enum bp_result get_embedded_panel_info_v2_1(
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.HORIZONTAL_CUT_OFF = 0;
 
-	info->lcd_timing.misc_info.H_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_HSYNC_POLARITY);
-	info->lcd_timing.misc_info.V_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_VSYNC_POLARITY);
+	info->lcd_timing.misc_info.H_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_HSYNC_POLARITY);
+	info->lcd_timing.misc_info.V_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_VSYNC_POLARITY);
 
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.VERTICAL_CUT_OFF = 0;
-- 
2.51.0




