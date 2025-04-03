Return-Path: <stable+bounces-128044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB7A7AE9D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022681889138
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3621A45D;
	Thu,  3 Apr 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJSeumiD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B8219A9D;
	Thu,  3 Apr 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707843; cv=none; b=nXe1LTAUP9I3Jjcnq3NqMN3Q5dq/ehA6GBHrLu4IX6Tvh843VJZIxdyfjuteoQnnTEw4leLzyL490SHpn6WvnOWFrZRtsZ22sizn8RyhPV2XKg2rq1kv4FeDDMNHjNGBhxtbFrqXpdRqDy4Pi5hWgHyPGEq22UBR0x/rBK+sGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707843; c=relaxed/simple;
	bh=JG9o+2DiGLyPMtpFhDYyS5uR6JY8pzMIK751yPtdzZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cG0ZQmgNv1tswKMHUq52f+VQJYPSgO62C4MvhXJ7Y9TPRVKRgGJQgWgNVn9DGDKs8c6vbaJVIvL17irQw1BuV9sC0lZEsXdG5u0xY87MPBqmFIr6qeKdNy8v5KejVSQcMMjsTxgyLzpmNs4BmVHSLt2MUOcEkx0fam9dmwL3TCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJSeumiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071ABC4CEEA;
	Thu,  3 Apr 2025 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707843;
	bh=JG9o+2DiGLyPMtpFhDYyS5uR6JY8pzMIK751yPtdzZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJSeumiDWOamU2LYGO97g1A9QRMz7Ca9gXKRhBosAawEi7juOBp2+XSbzLkue3S+T
	 VLSZFO9bmprl8vAE4yjv0TnN+GLJpuTQghKDiDLBPx9MH1fKTy57E8tgGVLAsBpY+a
	 5KUid5cXDQk/t3cR2bBVHeF/efMroqKh6fNrlJ/ht/7XTua+5OwcxCddOzHsGaB4Pr
	 60zKmzPywxetadXc7mQNUJ0tEDLFGAa6SlAMsoDXehdTUpGed7uHrr2WPMza2PKB6S
	 SuB10Rslg868YHdcx9OB1iUspTmRUfn7hZLfaAFw+OEEF3NCSlF1AUd+6UOAhNsIkE
	 t0RmDZno5XE4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Wyatt <fewtarius@steamfork.org>,
	John Edwards <uejji@uejji.net>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 06/33] drm: panel-orientation-quirks: Add support for AYANEO 2S
Date: Thu,  3 Apr 2025 15:16:29 -0400
Message-Id: <20250403191656.2680995-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

[ Upstream commit eb8f1e3e8ee10cff591d4a47437dfd34d850d454 ]

AYANEO 2S uses the same panel and orientation as the AYANEO 2.

Update the AYANEO 2 DMI match to also match AYANEO 2S.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: John Edwards <uejji@uejji.net>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213222455.93533-2-uejji@uejji.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4a73821b81f6f..f9c975338fc9e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -184,10 +184,10 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* AYA NEO AYANEO 2 */
+	}, {	/* AYA NEO AYANEO 2/2S */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
-- 
2.39.5


