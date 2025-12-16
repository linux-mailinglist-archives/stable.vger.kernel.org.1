Return-Path: <stable+bounces-202045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9144CC2932
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95AFA3023EB3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCF3587C9;
	Tue, 16 Dec 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4qWlR1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A883587CE;
	Tue, 16 Dec 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886643; cv=none; b=HvA+eOYn5VmEhnryNp1EHZubM2ynlx6TGY3+lS6fG0DkNYpfuNHbMsbD0gFCGmH4z95pcjQ63srrReLSOAqB0JXPOZM/FbWQPjawMBsB2Czk1iux0m+vCBjRcrtqqf+ZSiCcA8OtXy8D3xVcFK8v1BHsOWVJHFncOO1NYiFOQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886643; c=relaxed/simple;
	bh=Eek1ollwa8aqIeGtISGOZ5pxi+Bp1+kMvFDWa5trPlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk6Z2Qq0vtR86GmsM6KDafc7ngOmueEna7vza7P4E0/hw1lC54K0Gk8PdGBjDdTFO0500iQlTLR5KW74yKP0pkoU7Il6lV0Ka9ONRqiV7oQNDGiNZ6TH2O92nvB72Kxfud/q7+/hiRGtbNP+cEgQt07mzBFRlw0fMMO1HRes41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4qWlR1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA730C4CEF1;
	Tue, 16 Dec 2025 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886643;
	bh=Eek1ollwa8aqIeGtISGOZ5pxi+Bp1+kMvFDWa5trPlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4qWlR1zN7wkq3tni0EMyJNCzZlAFwFEx33clFaXgbAaJuXsQEMDHZg1TXRCrtOB6
	 mAWgyXfTnV4Jm8UD8NmUQxuUOWRrvgkyRXY04B96JjfH9Zj0dxfiPbBxpPcmUe4LXV
	 m7I81HKDMGnCivVkseC0Ztrc5NaPgDoUmW9qLtMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 464/507] drm/plane: Fix IS_ERR() vs NULL check in drm_plane_create_hotspot_properties()
Date: Tue, 16 Dec 2025 12:15:05 +0100
Message-ID: <20251216111402.256383465@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 479acb9db3199cdb70e5478a6f633b5f20c7d8df ]

The drm_property_create_signed_range() function doesn't return error
pointers it returns NULL on error.  Fix the error checking to match.

Fixes: 8f7179a1027d ("drm/atomic: Add support for mouse hotspots")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patch.msgid.link/aTB023cfcIPkCsFS@stanley.mountain
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index a30493ed97157..4cadea997129d 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -338,14 +338,14 @@ static int drm_plane_create_hotspot_properties(struct drm_plane *plane)
 
 	prop_x = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_X",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_x))
-		return PTR_ERR(prop_x);
+	if (!prop_x)
+		return -ENOMEM;
 
 	prop_y = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_Y",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_y)) {
+	if (!prop_y) {
 		drm_property_destroy(plane->dev, prop_x);
-		return PTR_ERR(prop_y);
+		return -ENOMEM;
 	}
 
 	drm_object_attach_property(&plane->base, prop_x, 0);
-- 
2.51.0




