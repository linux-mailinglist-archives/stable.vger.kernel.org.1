Return-Path: <stable+bounces-189940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D348BC0C64C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7696018A49CC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B962F12AE;
	Mon, 27 Oct 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4QL/wD8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B102E543B
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554597; cv=none; b=XwyZVh+0DzxZ75yfVaMzbQWew0Lmn4aE79UHM+91klrE4O6hLA3DuiFmXbjJTQwH2e5YC9Vvqw8OCH34m4efnOmRlFRnJ9QgjYxy6JV/DPyyLlSN05nBjckcdoYxu4BeOzeMjHZnA5uIKJD0J2E4+8zR8Pbx9o5FJC3qCCdLqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554597; c=relaxed/simple;
	bh=oMKB4koHGfhFxqW7ZtCA1mWeRO3jC3K1GWY5reJ1TjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seo/25NbLjSB//rRHfXg/7pf/wxBYVLgmF1LwbVr9fLOzT64zhJzBx9z20yL0WqyHJgKc/gX9GdGY1Aujf5LibnjHrOb8aet5L+3466QsJZXTlYsWABFwhrtm72g2btsu5ccbUsj0V/4M2Ahp4dSBuPoIRzSvmS4yOiRXcepgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4QL/wD8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290c2b6a6c2so45983595ad.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554595; x=1762159395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHwoqgImEy7LQLhZWFXUDhaPJoy+ecZ3A4KynxwsxS0=;
        b=A4QL/wD81Yvir5jIrST7pzfQaM9QZpokBqwsDOqDCVFFEmisx8cL8/ippltZKwHfQp
         J/sBY3cOIyEnN7WGRv1vXjsReKrIQBM3w66fn9L6FbWwrz2pANSGC+x2Cpu1dGYMnjOC
         gRs+ERyUe/jt2zawSqhSFbqbqDzW+lGvDG3UbklrwKcXdmvCGPTwOp5JKkVah56Mzn30
         m1tAeioxL5V+hA93o9x1gk+9X+cEu4lxnIKoECEhtyCaLgR7GRJHAu40wtANzRsff66b
         92rIJnnw9m5dOnpYl6k0l0iBZcBNQl8QPYKGkrVjJPoUkDn7ohuhSZPDAUnzGMy2mHIR
         qzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554595; x=1762159395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHwoqgImEy7LQLhZWFXUDhaPJoy+ecZ3A4KynxwsxS0=;
        b=XiHEAPYfkVXlwXUl7YM3w6gdmrtIxzjSyTU1/sV4nGKXW2/BzmOGN7H2T8tJpZCCOx
         Y9HS9SyKdRDMZ2U4ILL3MaQmB6XZTyZAlVzvnfySPuP55rQvcGtTGWqIVbTPF2RjT850
         M5C8W/EpVuyxNYn9OAZA5FrouceyS6OYFfPbycUxfeglllnHXRJEAc2W+AcwgucZJxBj
         oG6vDceSD8WtpGoZstLYJjPi2I9I5hWHNZhSFhquvkPRxgQmdZOuyo9MKGs+Trt/OAat
         waVpho0h4Cygy/MAYWpinYnRv7GFbOAjst1OM3UKBS6VZ0j187f0PrpFZ+DUcLeJ0gSp
         xIKA==
X-Forwarded-Encrypted: i=1; AJvYcCW8qgX2iKSlqv+91XBOA15uFOZNA0CbCxEKlkplNZSMmR6hCz8CdZLUhBu+TYRsrCGIq9CRfHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuD6ElpHy0rbwI0txwoPebNSADRgh2PZMfZbTUTYXDEocrRQQv
	lDQEE88UepTbI6TF4bpp6UbHBQ5SvEL8CHfYCtAWwyZxm1gIwmbkVd98
X-Gm-Gg: ASbGncuyAlNXPGzwB8z+AJWd64G4mtZbEqeqTWZ1ou6lfZNgege7VrBugdOWp/fwnL6
	lAUp3N+pMVfe26y5YQZ8yiszDIHfWj8vabanGZrhxXxiyBgq5WjP+rTZfTlDj9UucbAs5lrUz3y
	LaSZ/kI+alf7smH+KEA42ycVN9zm+9sACTQT4pEvobK0TTIz4W3TC+rW9RqdrKub6AlDtLkcwjA
	vZZyJo+6VxhaiEHBYsxx8owYBfEH9rgA+ZatwD6vmokyodxcY3bEilkFLugY6jIGK3dM9aXbO2v
	5QpjxHCe4G1CXiT/LNm98KcuuFlCKPppjOSNtVXOoO4CbOpzkb8MmHVRdIgwubY//x7aiZtwQGT
	LEDaowxu5LRpwJXNE+wTQXbxAq/dUqtREE4kGzVzzljLHh5aUw/dKtlYlYv9HQeVbyMorNQeIGk
	dPloUHgto4icUAAJgwrRluThq0Nmny6KTdZlKxaiAdz6M=
X-Google-Smtp-Source: AGHT+IHwgVcslq+1mjD8C6Vh5GqRLux2tDGUe1R/TUV71B2G9ynp6h0rzEeVb0xZxIg7lRsdj6RNXQ==
X-Received: by 2002:a17:903:247:b0:294:c189:68dd with SMTP id d9443c01a7336-294c1896977mr7969545ad.44.1761554595286;
        Mon, 27 Oct 2025 01:43:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e3d2aasm75349815ad.88.2025.10.27.01.43.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:43:14 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nicolas Belin <nbelin@baylibre.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/meson: Fix reference count leak in meson_encoder_dsi_probe
Date: Mon, 27 Oct 2025 16:42:58 +0800
Message-Id: <20251027084258.79180-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_graph_get_remote_node() function returns a device node with its
reference count incremented. The caller is responsible for calling
of_node_put() to release this reference when done.

Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index 6c6624f9ba24..01edf46e30d0 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -121,6 +121,7 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
 	}
 
 	meson_encoder_dsi->next_bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	if (!meson_encoder_dsi->next_bridge)
 		return dev_err_probe(priv->dev, -EPROBE_DEFER,
 				     "Failed to find DSI transceiver bridge\n");
-- 
2.39.5 (Apple Git-154)


