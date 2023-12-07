Return-Path: <stable+bounces-4948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F066808FD1
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C4228109B
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC949F92;
	Thu,  7 Dec 2023 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZxKiu9Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEA10E7
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 10:25:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33330a5617fso1293658f8f.2
        for <stable@vger.kernel.org>; Thu, 07 Dec 2023 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701973549; x=1702578349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFhF+WHm92cVBxSbo98wCO9PJ9Iq9HjlgAyvaR9w2ck=;
        b=aZxKiu9Q36BIqn3iX1kBR24qvYfpyP2vtOJUy39fCA4x0bJfSot0AjAWef5yQgvpSG
         4FQZiCSe5m7KqY61xL08nQGTgUlmv118lZSwldranmhH//G+1Uza7W94Sefo6eSD220B
         +4VFF8dTFrRJBng3F0IDM5ok49vUF1DyMe/DCJ0UEkAK9ladyfpiAT5EVx71iu8ooEH4
         8aylesRM8QWmVS7J6vSbCxTR6numYsx5Sr6MfSPK8/BE0hyNuwqFO2B8xC4ypUXjexsG
         XYh64tLH3c7SoKJ6s4b/kRU5DInfjQ53gIlr8/bGsubJunwwLrc9T7pHi5vDsiSktSSA
         nBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973549; x=1702578349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFhF+WHm92cVBxSbo98wCO9PJ9Iq9HjlgAyvaR9w2ck=;
        b=SagAmtmwmLBljEoouAcv4LNe2lKVeMoGXGmt5t8UD2RIptk+9kmpzUsZo+kR9sit21
         j0Zxp6gqYhKRk6z3l4poC+ecg0Fn7axKe5tqG3Nx52f4DtUDI2Qr14NiCZZ7yhWbO4Qc
         stSagg7C6yba7YnhqZg8JP04KHdvdH5vFQ7KIs7ZCmleuGhu5tD8opMYB8AW/C/ExeQK
         BZyVwXsh3QFqIco+mx+ZtkDV6FlFuuRIY0IzYMQi+vEs1fwnRhrM1ivWpnN0d+rbWcF9
         olnPF6M2EK6+fdUFrHZIyYL0hlp6whromowOHaliuEOJe54vNvQ+eBvLGnXk+lzylCxc
         ElNA==
X-Gm-Message-State: AOJu0YzhRb0VOGWchf3iAadYqabifU2i595i4eIT16FbLJnGc6XH2xvh
	uKmoPspde0WNXaJwXmhO31o=
X-Google-Smtp-Source: AGHT+IGGXN4Wz5RSI2d7rXy0IjXkVfWyTq3KUtJRpnUAU8d6KvlTeEvxhdof7kcCZc1McgCdfOl2Sg==
X-Received: by 2002:adf:f303:0:b0:333:135f:a7f4 with SMTP id i3-20020adff303000000b00333135fa7f4mr1902241wro.56.1701973548815;
        Thu, 07 Dec 2023 10:25:48 -0800 (PST)
Received: from xavers-framework.fritz.box ([89.38.117.155])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d5650000000b0033344e2522dsm257302wrw.37.2023.12.07.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:25:48 -0800 (PST)
From: Xaver Hugl <xaver.hugl@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix cursor-plane-only atomic commits not triggering pageflips
Date: Thu,  7 Dec 2023 19:25:32 +0100
Message-ID: <20231207182532.19416-1-xaver.hugl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With VRR, every atomic commit affecting a given display must trigger
a new scanout cycle, so that userspace is able to control the refresh
rate of the display. Before this commit, this was not the case for
atomic commits that only contain cursor plane properties.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
Cc: stable@vger.kernel.org

Signed-off-by: Xaver Hugl <xaver.hugl@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b452796fc6d3..b379c859fbef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8149,9 +8149,15 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		/* Cursor plane is handled after stream updates */
 		if (plane->type == DRM_PLANE_TYPE_CURSOR) {
 			if ((fb && crtc == pcrtc) ||
-			    (old_plane_state->fb && old_plane_state->crtc == pcrtc))
+			    (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
 				cursor_update = true;
-
+				/*
+				 * With atomic modesetting, cursor changes must
+				 * also trigger a new refresh period with vrr
+				 */
+				if (!state->legacy_cursor_update)
+					pflip_present = true;
+			}
 			continue;
 		}
 
-- 
2.43.0


