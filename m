Return-Path: <stable+bounces-61099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF4893A6DE
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1CBB225C6
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8C158845;
	Tue, 23 Jul 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hZPFW1mX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560A1581F4;
	Tue, 23 Jul 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759972; cv=none; b=qThoJhpgpyv1Uw1XL8IMUsnGfs+hmz6I/90h4NnDh/iQaDitqEpVyI1zFttcdAW6t1DLH4yFXwhFIxeRStOZLrFUKa2ZWWz9yusF4MSYNI1iJiWbT2UbDUsu7MkLf7zFcUMRYnZG6652XI+zXMwaZPOZs57RehPVX8jKIsm/jAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759972; c=relaxed/simple;
	bh=YL+dcMehirCVDsU7MVoqYwEHiaMeetOtCJct8mpzYvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AciB1rfFweLRrFSeVupFfeLTO64d5DYIYSZEtuvUjW83ARyaybHDb0r4ctN95a4aK7waUcd9G0bt3goAoHicy7vVfFwZ8PjxgemBfP4sjMU7sX6Z17MzmRTbGSPwzfYIsTIXOawjirVlowTNUGIpj+r9tvzrnxhGhSvDY7Y1OkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hZPFW1mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942EDC4AF0A;
	Tue, 23 Jul 2024 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759971;
	bh=YL+dcMehirCVDsU7MVoqYwEHiaMeetOtCJct8mpzYvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZPFW1mXUE0jRkEwlMhMqBjE/rjYPjqgYccE0XCknq7DbT0tryv2V1WSBcoDOGdya
	 vaH3C+3uZnSCXsPTye12NPyVTHWIkQA1cqP2QMw1vWLGaTr+slgSbh3pyzJ+6+uyhq
	 HDjIFpCvN9MvY0KHV3VvRhOVTOZCBNpL7Oiibpdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 059/163] drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
Date: Tue, 23 Jul 2024 20:23:08 +0200
Message-ID: <20240723180145.754122309@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

[ Upstream commit f74fb5df429ebc6a614dc5aa9e44d7194d402e5a ]

Similar to the other Aya Neo devices this one features
again a portrait screen, here with a native resolution
of 1600x2560.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240310220401.895591-1-tjakobi@math.uni-bielefeld.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 426bbee2d9f5e..5db52d6c5c35c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO KUN */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0




