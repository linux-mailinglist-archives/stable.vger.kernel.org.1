Return-Path: <stable+bounces-78854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255E98D54B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D2B1C20F2B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB231D07B6;
	Wed,  2 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LiNsgHKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D51D07AE;
	Wed,  2 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875722; cv=none; b=XV7jQYZJnEogdNdoIeur4j1obl7IzjR6mtLTa6BusRSA55itz2kJc0DsbrhRAjwx1kI10MMVbCMpQeK0VGs4fND+PrTALuuFcKggnZaqqgyMx6BvMpQj2vlZ2/Uy5b4bq8+KGUBon1kf0jqUdqW1ASEsmw/fV3OpJIRaXyoa+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875722; c=relaxed/simple;
	bh=OvaLb3/c03vmXEg/1NF228PVrRpDY9LVde6YuquigO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkcl93drN9IeFMYS+W1Ua/6dW6RKv1fS/l8Csc4nq4kkFxwhja0KH/0RZRw+nu0MO0EcROsVQx4y/eeY1UcTn3GyPsEr7P12vZIrF2uEBoqoRJGa2b0EuhvHqG2qtlrrjqokri16rrJliL21VrCw58D2LBJWnPAvY9qe9efKq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LiNsgHKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43A2C4CEC5;
	Wed,  2 Oct 2024 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875722;
	bh=OvaLb3/c03vmXEg/1NF228PVrRpDY9LVde6YuquigO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiNsgHKrnRPiJW46XXGp7TLx7eremBVrarrL0HzhAKt51NvIve+c0n0SMaUtXhhMk
	 Es87ogMOmZvYpJdMLYdHvcRYVy7ESKUBNFA5x9AW7rcXYNyWJLyd33/wC+qDF+Af//
	 9xzTukGEplyEGIGpN/7rbbu58uqcJvQBRywxM1NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 199/695] drm/stm: ltdc: check memory returned by devm_kzalloc()
Date: Wed,  2 Oct 2024 14:53:17 +0200
Message-ID: <20241002125830.407480768@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit fd39730c58890cd7f0a594231e19bb357f28877c ]

devm_kzalloc() can fail and return NULL pointer. Check its return status.
Identified with Coccinelle (kmerr.cocci script).

Fixes: 484e72d3146b ("drm/stm: ltdc: add support of ycbcr pixel formats")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230531072854.142629-1-claudiu.beznea@microchip.com
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/ltdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae49623..5aec1e58c968c 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1580,6 +1580,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 			       ARRAY_SIZE(ltdc_drm_fmt_ycbcr_sp) +
 			       ARRAY_SIZE(ltdc_drm_fmt_ycbcr_fp)) *
 			       sizeof(*formats), GFP_KERNEL);
+	if (!formats)
+		return NULL;
 
 	for (i = 0; i < ldev->caps.pix_fmt_nb; i++) {
 		drm_fmt = ldev->caps.pix_fmt_drm[i];
-- 
2.43.0




