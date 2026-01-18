Return-Path: <stable+bounces-210202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58472D3950E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5D8E3003864
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613127FD74;
	Sun, 18 Jan 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="LXFNRwp+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C04594A
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768740665; cv=none; b=oDq2hbbV+nH+IEKhonlPo6gOQ+Ctngn6L7gBl80B2onj9Wi7YdRUiDCUa4DW5+PlZO0qRkhpjijS2SeyYUnEXC5hBD4W0vl38seW1qpN7CwXfCa1XoRV8wrgyHPV5ebMmlPFo4biKZ9pNmqsQZA7KXEETGxiDnsw5yUKimFpyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768740665; c=relaxed/simple;
	bh=eElOk8g7UCh3kELyARpOwDD+9etfEltZoJTvNohjmas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WkAvm7mt+MpDbe0ALmQXiUo7Obqg7kEBauKCDiRATTDyb037zySgvI9uv2IiQAjCj8cbWiahgfp4t/8Tm2f8F6EicpZwNoNipNJYiVKtBrSFsMn35KutG2fkn/Zmqgyfm6GVLWHMhjMQeS/j9MGGy1XJGXWzer72hAyvrArnDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=LXFNRwp+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f42cd476eso60739b3a.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1768740663; x=1769345463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yf6MwQDQwh28ZBZ3XFwBnvm7ZJiNkyLpf2ZCMRITZCA=;
        b=LXFNRwp+nMu9Pftu9Swr+0XkrOqDWHMvEc3A9JXVpZUectvZUcMpRctO+xfE30Pc1v
         UDetew5an9CA1IUtXXKdNKvdYLUgxEOZDO7chC0YxmfIFm4qrGPSQVvSBBGeuVhgCOgl
         fduPvzz3D4cJfVaLx9F3OnXyrqnpsAF4s/ya3RP+huEF0J2h8PdDCB7RHG0tirJk3w2R
         tdZqPMbw8HaNYp0fqJDymqT/gM6Aa7BfmZ3nzAZQClV44u1b+mi1U4B1Ofl8sK+6iPij
         kLFiK4EhuoWLjJtVv1F12cLmyUPgOlWQNQrAiuG8d4BvHrrwUsg37QcBjRXRThTgGrSL
         L+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768740663; x=1769345463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yf6MwQDQwh28ZBZ3XFwBnvm7ZJiNkyLpf2ZCMRITZCA=;
        b=cStU6g1YV2jHu32Ht7rubb2PZq5evsC9JU0duauQT/c+Bc5SVLqRKBwu/3w4WwLWbS
         fT0KrAh5iI4mW9l5jLJeYuIUNmsQ25bM6au9SgaWZgocqSXPfSJ3ZFJs0sHf1gXG2DHz
         1eoDWfYtXTW37Eb2K7krhpdoG6UrpYSkWNFV2jC1QlQLDuG/77rciak6qujamQ5AL8Xb
         +pblXjCcUCN7UHCcoa6lz/kCvaCmvR+RGsP0IYhg45a9d6GLhepN27YAN0Gq0doDtGUH
         spBR3di7U9gVQoCKgWAqQWfiHX4QyXV4QzWjFEPXz4O/6t8JOyrsrf8UyOPIkxHAu8KB
         yTpw==
X-Forwarded-Encrypted: i=1; AJvYcCUueA5TGP2LeHygMIH70riLTwfnu7diG8CsyevkBQusZLt/38O9eT1x7oEZToaHMNT6XMF8idA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/Fi3uhIDm+3yP4M/4gh1iGD+K8hamBx8xmkzp2ytZPzHmMXW
	Lfn3wZN185NLKvd3hNENpBtojcCyBPUdkvmjU+UOZXI2hzvSrChPO39TaLwotoiAtTQ=
X-Gm-Gg: AY/fxX5rvY1BLcNnu+iBW8djyXjUJMFBFdwd62lL1sMJJZcu9HZLju6lyGkxshUL6nv
	oEUSp6bD+xylOLCQjNxqFJLLE7OFnJiYYvIYdmku5+CQkO+mC4jROZL1E8+cOCgrd1PPAdqK6aX
	rx7sVhfcYxF14kKs+hHg2RE1S2zc3sZP3cKKNLs2yTfzCNUOX1D0sMaOtStyNTf+eLFScTp1IrY
	RPT3JZkn0zM7n/Vyh/s8ldPzDM6r27lUh8cdKOFMTKwjZ+qXOExbVsIs0d9lN5/qZK1dLsoCn7A
	r16x3t/RcbYkwiGGpd/RdA74H2mE5znZU6x8JzDrVvkbD+rNEzhjrNc1yINQJlSmC4JJoLqdRIw
	qTPcEfWy7YAtQjm/WjzPDz/dSFhKhGrv+mtLaZPHUFL8u9g7b1bALvSjpI4w2CuK+9DTRljpbfA
	kvP/+cCpAN/CWR+G/eJxU=
X-Received: by 2002:a05:6a00:26e8:b0:81f:4960:f2f3 with SMTP id d2e1a72fcca58-81fa03964d1mr4275410b3a.6.1768740663367;
        Sun, 18 Jan 2026 04:51:03 -0800 (PST)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-81fa1278056sm6646026b3a.34.2026.01.18.04.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 04:51:02 -0800 (PST)
From: Shenghao Yang <me@shenghaoyang.info>
To: Ruben Wauters <rubenru09@aol.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shenghao Yang <me@shenghaoyang.info>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/gud: fix NULL crtc dereference on display disable
Date: Sun, 18 Jan 2026 20:50:44 +0800
Message-ID: <20260118125044.54467-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dc2d5ddb193e ("drm/gud: fix NULL fb and crtc dereferences
on USB disconnect") [1] only fixed the initial NULL crtc dereference
in gud_plane_atomic_update().

However, planes can also be disabled in non-hotplug paths (e.g.
display disables via the DE). The drm_dev_enter() call would not
cause an early return in those and we'll subsequently oops on
dereferencing crtc:

BUG: kernel NULL pointer dereference, address: 00000000000005c8
CPU: 6 UID: 1000 PID: 3473 Comm: kwin_wayland Not tainted 6.18.2-200.vanilla.gud.fc42.x86_64 #1 PREEMPT(lazy)
RIP: 0010:gud_plane_atomic_update+0x148/0x470 [gud]
 <TASK>
 drm_atomic_helper_commit_planes+0x28e/0x310
 drm_atomic_helper_commit_tail+0x2a/0x70
 commit_tail+0xf1/0x150
 drm_atomic_helper_commit+0x13c/0x180
 drm_atomic_commit+0xb1/0xe0
info ? __pfx___drm_printfn_info+0x10/0x10
 drm_mode_atomic_ioctl+0x70f/0x7c0
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 drm_ioctl_kernel+0xae/0x100
 drm_ioctl+0x2a8/0x550
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 __x64_sys_ioctl+0x97/0xe0
 do_syscall_64+0x7e/0x7f0
 ? __ct_user_enter+0x56/0xd0
 ? do_syscall_64+0x158/0x7f0
 ? __ct_user_enter+0x56/0xd0
 ? do_syscall_64+0x158/0x7f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Add an early exit and disable the display controller if crtc is NULL.

[1] https://lore.kernel.org/all/20251231055039.44266-1-me@shenghaoyang.info/

Cc: <stable@vger.kernel.org> # 6.18.x
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202601142159.0v8ilfVs-lkp@intel.com/
Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/gpu/drm/gud/gud_pipe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 4b77be94348d..a69dee71490f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -610,6 +610,9 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	if (!crtc)
+		goto ctrl_disable;
+
 	if (!old_state->fb)
 		gud_usb_set_u8(gdrm, GUD_REQ_SET_CONTROLLER_ENABLE, 1);
 
@@ -633,7 +636,7 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
 ctrl_disable:
-	if (!crtc->state->enable)
+	if (!crtc || !crtc->state->enable)
 		gud_usb_set_u8(gdrm, GUD_REQ_SET_CONTROLLER_ENABLE, 0);
 
 	drm_dev_exit(idx);
-- 
2.52.0


