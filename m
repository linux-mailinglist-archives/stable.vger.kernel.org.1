Return-Path: <stable+bounces-114984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED58A31B4A
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2341670BA
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208F5474C;
	Wed, 12 Feb 2025 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEC+dUIa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1279FD;
	Wed, 12 Feb 2025 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324603; cv=none; b=cNkwp8NUb3jTpUtsNjcnCO/RUwmgtar/XH1pEA+cyeHv7j3XPKYiUnAQzwNa26VsMEzMshCvQujRl4inks3zltMNvxbY7N/1l2pW2lj7kM6NGUDwlmy0O4nagyLzV7h5vGShbqwBkwQYB9T2wUCKq6heADCWO5AEr02Hl1+XA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324603; c=relaxed/simple;
	bh=E5GOAEhRD9j+u1CXK0RooAUO8b6h1E/vhZjKiq9wXqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/AgUq86LHUoiXvzFHHTK0lW0DJBXQWJqitnya6LSWqGJdNKZwllg3k146yMJ51rjtuMUeeWu7LMxW0ZotE3LszQff+iMDhL1+J5q/Q1Ujb2uUI2xh4nRPYczGVU12MB55SHtA58OIuMeu8oi4Fi4YBtuRAvICOUrGkg8x1mmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEC+dUIa; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so465229a91.2;
        Tue, 11 Feb 2025 17:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739324601; x=1739929401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YanI8iRaFnbYDLIbwSAL7fPqo0KzjFa50XedZ+8YIHE=;
        b=JEC+dUIanF2dK6PZ0Nz0nNY+2TcpJ6czC1Q+0aVAv8gXNxI6cHfdy03n9L1h/zO0af
         XGVHawdJ/0K/5pPo/e8tBEZw1/f33I3SUpqdasxfu3nMI4WpSQkLruE1X25YMatx0Bj+
         Y5NDNJSbV0pvZd+CHE7UWzPTmJfLXYsIkvRcYpvpydZawQaoXvt1M8+hsOvspz8e7o5w
         zN/9RM/odJWcyyVEPYfaCwZDLcHAGL+TfYS0O5G9l1LxqqAFBJW7pUDcxaOkZaqziFC3
         Re+18886Vi3QgHhGI9spNb0PnqKOgnvCZ6IREW9KEHpLjM2cL4HrMdyUWwD/EoJGKu+m
         Fs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739324601; x=1739929401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YanI8iRaFnbYDLIbwSAL7fPqo0KzjFa50XedZ+8YIHE=;
        b=gPstjFMs5TOJm68A+OQe17qIRomVUmfaCvqKr+h2AZSqj44hRuoqtcZX83cQNIfvON
         CNnJVQoaQ+28lNmD5stmw5c8UVENU1ilWULZAs04S8H/i405rkQuF1ar919+wo44HjBX
         JCJy7/+yMyCPij3PK0tv/5jLmUm0zcw3kdmdNvAC6wkn9y1700nUmRLhrhQDlqPYoUPZ
         y2/I79rDGn0wFsf7ai0+EA7RlBGl87/3b2QBvDsO2xNmLUOs5MIztyUAi8MOv3TsbNzj
         Jd8Y67tiC7DdrDMiOTWHF0U2Opt5OFfuko9RSBbc1iUPmgKw3nuZx1jvKlEICgzgXczp
         G1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUtwMf4paRjdE29J1WVr0uYPjog/vkQW5/xTC1adxmhL/t01qvGQhA6EcsC+zZYTo90RHvmju711hKd6A4=@vger.kernel.org, AJvYcCV5H0NjLK4oCK8emGqd6Y79XMP8GKdqXBZrQ5KjAOFd+TcaHBqf/1ZGiz8Pm2tNPoa38ZcUB17q@vger.kernel.org, AJvYcCWqDDAZ0zCUCSIyL35aA3iJMiwcDtrjEprztDauWWm607yNv4OecGluUMJq3wlS/y/hVMwCTuAhT8+B3fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEk1hYqQB0WnsZSjK6nEkfksnK8Mwd0CeBhMb9f++SVlRi2/dH
	DPmCW+OeboJUtmqXxQkzsBmzbqkXzWxNkoxQKt0jUF8mxsGHkaAsG5y9ohY0
X-Gm-Gg: ASbGncuwMsoarLORiyrbjHcqSffH1RUkDFh1fTd1F30zy53SLRTDD5UWC8EygyD3Brn
	p8w/R6d/9yZGYGwd66s3I3OAMf1SqjSh5bOwhqZ/STi6miBcFV0jtp0HGz5pnkHqSj8CPBjV1kw
	r55BZGkVSryOLSJhyVIis6YHLf+UaPj7DbyI9AUlJwFNe/yl27QdC8IwYK9LWUHDcM3xmC9++by
	i2OQzGRhfUISB2Oe5mOZFB/KtEhX/X5LP7wdug6uzK4rsg2UirUgGXSeYZ79AIWqIVPiN3waicH
	wDg6+loFyrdojyY9KBbNuDBSzGvkPwlhLw==
X-Google-Smtp-Source: AGHT+IHnk+a/LVCawfVCfdGlssi3Ze/Dz7OTqlOispTxLSEB/9y18V5ncQW0N0315vtYhNg9VT6u9A==
X-Received: by 2002:a05:6a00:1494:b0:728:e906:e446 with SMTP id d2e1a72fcca58-7322c4116c9mr2019902b3a.24.1739324601222;
        Tue, 11 Feb 2025 17:43:21 -0800 (PST)
Received: from localhost.localdomain ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10038023b3a.74.2025.02.11.17.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 17:43:20 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/tegra: fix a possible null pointer dereference
Date: Wed, 12 Feb 2025 09:42:45 +0800
Message-ID: <20250212014245.908-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tegra_crtc_reset(), new memory is allocated with kzalloc(), but
no check is performed. Before calling __drm_atomic_helper_crtc_reset,
state should be checked to prevent possible null pointer dereference.

Fixes: b7e0b04ae450 ("drm/tegra: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index be61c9d1a4f0..1ed30853bd9e 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1388,7 +1388,10 @@ static void tegra_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		tegra_crtc_atomic_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (state)
+		 __drm_atomic_helper_crtc_reset(crtc, &state->base);
+	else
+		 __drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 static struct drm_crtc_state *
-- 
2.34.1


