Return-Path: <stable+bounces-80138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 014CF98DC16
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A995B22909
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C21D31A9;
	Wed,  2 Oct 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T8Vevo4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5261D26F2;
	Wed,  2 Oct 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879494; cv=none; b=NY2oI0gmDYyBzcpeze62wmRstdYV3U9l1F9j6bBQWklYJExOiRoMeUseUJ7ih+EpWarh8EzCKOw21uPodkmV/4fG/exbRAxF2ZU4dE/7eE4/g+c5LDgUpQ8C6oRobh+x92zJJqt0FQ50t3QR1j5Df42Dww+BoPdze7QwpZeUwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879494; c=relaxed/simple;
	bh=OMx0Ed7l3NnGHb7SoqwKEr3QdForwDIe6HlwaGZV1nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shYzUbGVW67GEjtCoOKI1LDgbXMRTxWwaH/+Ohq9mFHDvoOWMXT3D9u/i+ZDs1Zb61qI77p8vLb0UYE2w5RVt64e4Q/pNpM8WICy63HdgeAb7/3rA5PoMGTgeF4qCvH1kpgCPsAF/62OWGUn8lRGmTk+B6lNjTlz0FOWjwIxzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T8Vevo4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547DCC4CEC2;
	Wed,  2 Oct 2024 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879494;
	bh=OMx0Ed7l3NnGHb7SoqwKEr3QdForwDIe6HlwaGZV1nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8Vevo4mFeUS7ejvobJoG4gNaFekKA2UY/KoXy4xPrcUGFtgtbUjEGqaThyrZ88ll
	 gG9zO87QmqcE9MSts3Tw3z240+0cOQ55s7MelkF1i92tZaKM1LFa/R1DvnQe7NhLQk
	 8HTkgiA0pL1lqi0FzbCatHXl+rV6iztoLfG6+QU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 139/538] drm/stm: ltdc: check memory returned by devm_kzalloc()
Date: Wed,  2 Oct 2024 14:56:18 +0200
Message-ID: <20241002125757.728266161@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




