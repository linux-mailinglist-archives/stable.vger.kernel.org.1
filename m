Return-Path: <stable+bounces-191577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602BC18BBF
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCB7C4E63A1
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39F30F94D;
	Wed, 29 Oct 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgf3Bxev"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF730216D
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723702; cv=none; b=JG3GuCfDROWR7hlrcMxLkGyEza94Et19fC3AgKL8AZ9Nn6r1wQvmzuvJO1bhuYsUJxAXIHU9k3q9VnC/zgzRrOj1p5toNdxHC8GJPMek919pF3JuEa4w5fSiENlmqCGOFj89C+JbWyB4LOlfHjlULea6D0LghxdJ5mWP/SXKE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723702; c=relaxed/simple;
	bh=vQSgQhpSPXq7YicGVSd0ynrLW5738W31iJ/iUBFQPSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kd/nlZ9YwyR3DXBkSROvDZBEZhRZyIcyCYl2mBUosMihgZrGwoFX+Ha4daid0zbaGEyeNI/DPV5qQTxL/o6UGGUZ4c+EANT7lGXYS1LxD9a/7hKIzBwyxeFrUpQTYzo1+o0dnzkO2c6XPuyzl2C8CsW5Z0CBa4wBPPnjfi+WqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sgf3Bxev; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290ab379d48so64999125ad.2
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761723700; x=1762328500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgvDUTgmwUbybBiqh6wci1MBiFa+WkYYBAxgF2SWiwA=;
        b=Sgf3BxevDX/53PJQwR6IpjVyabiMVmP/SxtSoawkI90iHgMd3jOybNIihdS47yLY/Y
         +cC3poZDv+IUy6Cuh71ayjcf5QT/qSxNx6j01x3Ze8PHac7Zp8LjdB0VIy3t1kql4FxD
         uLe3JD/M75kyyOOkDwg8datHGwCW29RDdje2lu9L/PF2mQelk6PG50knIpryktv8BixC
         X9IFzdNgHivJ0vkjHk2CDBzqw7urYaBojmZX6OvgrJHg+jN5/DHjWj7o30joH2gEYa6P
         RW6i+y0fJENk5+YErUTj/bjWa/cuVJcubkq3QqCXekeMSVQ6k0sllxf3gHMraphHt6ff
         tQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723700; x=1762328500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgvDUTgmwUbybBiqh6wci1MBiFa+WkYYBAxgF2SWiwA=;
        b=gnIPnCAaw4cH0rlanzWczFCsmVkp+LHI3xiGLUDze4DSdocMneOZfWuWH0uqjGqV37
         0UhP13fopAF7gyvBC9a1XjBWYvR4oqugRFZ8VaCaeHoHWMk8PFjdfMcKwymzv8bkF19W
         chw2ONosRo+ryBdZviTTSaB8hVizml5qJPpLYjQY/Io9NDvUezmmlqCbJWngWE8CItHW
         6IJ2y6hW9zfQU9QX9VTy+cFm7uG5l38vg3SPCxDGjYYIvIPjz4pZZUdygm/9zkjLlKyU
         dJCRMJgua4En0OBPu3eXzi9wB54hHasOWF+1B7FhJhI6LY6cxkTvd/oeFEPUcCoWhpMq
         kI0w==
X-Forwarded-Encrypted: i=1; AJvYcCX9xQ2HCdIE8vfTgn7bY2HXwO5bjjdMGjQ1ODLQ5848c+aA/QQzK/X8pdSkW+x3R0tXk9YYG2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFb4KLzIpJYkGatF9hxpNUQtLub44aPr/h8d9rgLJ00njFSAV
	Y9G6T99zzMx37Zqg0TPCQQTSYUg51OJURNFAhPzyqsZafSgX0LG6vsu9
X-Gm-Gg: ASbGncuuJgdXthzSemlZYZwhK7+brIjeT5iyzhKaCkVwQrVT0knNY9y4r74IZQlf8aT
	w5WUC3t7UiyZqw1MtOtFLwoCk/f0pR6cMiFwuWj5t603cHG1A4JFrbOkiKa33tYPcb752FtQfoB
	a7aFMlbCFXvUFeRNCgpL5qkvo9B29LL5f+WWkL0xOZTM5PMguxD7Ljx3xLT0bHVviz4eIiRd3Y0
	G+oX0hT0W4I06MPQzx4r06DgzCdB8PMR8px3X5O5rBOhAy7IRGOax7b0AjRgYTDgh6kkk8dtfrf
	vBkYJrHemzNU2Ihj62h9aV4+d2uS4wpu6kzpCpTx6bl3Zuz/r5XKVbepmGzgA/JwaZxLWz6tKCv
	MUQpdlb8Tu2nGtkgcQjg9UFIZ/Jijkcys/9zI5UBVWyakxIhCZbmAsquYvpI6QSLaRmT6RHRPiM
	/52q2E5Sy/vuc3o9l1pPh1ng==
X-Google-Smtp-Source: AGHT+IEAqSeL49I0O53+T8EYYG0n4Be/S9PQxC/LftWWFjftQd/hhQp8QU08hja4QrlQTuil7K/59Q==
X-Received: by 2002:a17:903:234c:b0:246:4077:4563 with SMTP id d9443c01a7336-294def2da22mr23417225ad.34.1761723699803;
        Wed, 29 Oct 2025 00:41:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed706449sm14495814a91.2.2025.10.29.00.41.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:41:39 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: samsung-dsim: Fix device node reference leak in samsung_dsim_parse_dt
Date: Wed, 29 Oct 2025 15:41:20 +0800
Message-Id: <20251029074121.15260-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function samsung_dsim_parse_dt() calls of_graph_get_endpoint_by_regs()
to get the endpoint device node, but fails to call of_node_put() to release
the reference when the function returns. This results in a device node
reference leak.

Fix this by adding the missing of_node_put() call before returning from
the function.

Found via static analysis and code review.

Fixes: 77169a11d4e9 ("drm/bridge: samsung-dsim: add driver support for exynos7870 DSIM bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index eabc4c32f6ab..1a5acd5077ad 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -2086,6 +2086,7 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 		if (lane_polarities[1])
 			dsi->swap_dn_dp_data = true;
 	}
+	of_node_put(endpoint);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


