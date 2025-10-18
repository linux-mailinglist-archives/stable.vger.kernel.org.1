Return-Path: <stable+bounces-187861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF65BED44A
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C18A14E4526
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297825392D;
	Sat, 18 Oct 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHkOVAD9"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EC2571C5
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806722; cv=none; b=L9eh92P0dhHxZYl3DeaJ2rGQz0FZbSbUOBv81oRrynyfDtdEECimCh8b9K/EauO4/eH41titeWkyUZf/s6pcFxQDsqI4UtFGFXetCiUYNI9QuMOVV4jmkcoFGyufjh3IhFU+RXlqzi0vYIo5qTt72JgVO5Zw9tOZa0CjqSrOXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806722; c=relaxed/simple;
	bh=23ewjXJ3BzVpzfN1aBXik27sMddVr01HXAy7SGZ8tU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KADKBubgKv9H2YGiNXSDQxaHAxXZOVz2ndykgAEDr5kzf1IsULtTn2cMPGh+13p7Y58Kx6e4dj9rervFFGP/G+tR34P3RS18zb2xTLSzBCN3v+Vbwb3Yx+9QyrbhXByCfXylaA/IusuteqetbavzmMA54Oyk2fvaSGBR9Hn6RnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHkOVAD9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430c17e29d9so12480505ab.1
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760806720; x=1761411520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEET0KVM5chlyitbvvEN7T7JusMwE1pBm8UXQW3X9tQ=;
        b=WHkOVAD9QLkkMVGKXcAB/R/ed7gB286klfPEU/ERp2vekD21cEa6XpKMIWabKT6kdY
         Lf7Wv7WB8uIxJkTSW102nDJDuZamlfistoxSxCD0b4l7K6/Z3V2kGR8FQaF7F9pXlbbq
         dAPrf+1gSMLUYvALiqBwIAJvydoq4kkq0jRkD35pXOcSTXQQB5lwLqPahMsgYwMDtHU1
         rHsiNdSuT8g4f86ayE2pphjvh9hfk8j9fA+vLrQ8WIiAMU1wKJV5qz3enV5IZXKpBnYe
         eHs0fvXENaok30KB6Pu1nU1d3t8iRRlWYxuhNUccd63TDgBWxQMJQVgvKb05ORKRPO1P
         f9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760806720; x=1761411520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEET0KVM5chlyitbvvEN7T7JusMwE1pBm8UXQW3X9tQ=;
        b=rO//YBavCat6WS5tMXqPgnvIBpMfPd7Ij3I+TUTBBbeTsJT49tFD0V6O646KtZv2HS
         9R+VadT1J6PGQYCljYbhMWEL69QANPMYRestGrbRGzQtGZYraMIynoUFEy6EUa9/A+mH
         PEV1r3KDlbmAMj/JLiGj8E1Fuz83Wg/QxUQwyQqPRWmqImdFrQro/N45WxRQFdcbQmk4
         zToFsbz/u7VsXk+gC3CeMB+IYQHmGYe1gfKK4KHylUNmFbX4SkKj2LmOhTuSpRHVv5e4
         HC//TA/dctb7jrpFEABqCkQfzc42y3P3BuolBNLIcGx4QiD3qA2DqeMEcJOKtY9wbR9c
         gNJw==
X-Gm-Message-State: AOJu0Yy4ytty/dxUMoVS8VLwohOuLr/M+/kuG8GWbuKwmoZi8bL49KMJ
	PbdadeYnwHzNxQzWmy4BPC6I5dG0QRJ9bJUeMmpN9e+ofhYlaxWTsYqjlaGyx1MKjcc=
X-Gm-Gg: ASbGncu8/qlesjqK5IzP17idlmh+mNFEH5hHeqs8YZkck9nDgYwsFB5XS+KTucKMkek
	Eg+NMss/4Afgj+XnkYvTClC++AKXYMiZVtHEfioGl6cliqWo0sJR0Usc2YZlTl1abx0chVJYbAk
	dkCEgXP25UihwkElRERqfBk+rHrmkEafkVtRBranyZ9eLNIxFSDrUqbyqwOVldnjZxQR82Qz18d
	OXELaL2qXiBXWpycIaxkOw58xG2npwYL6vCTp2BhP7hmjj5hNqJsgs4qsQfKFOyRAGns8YDhFkM
	9wBDbXLVmSTmXLZe5p+EPRBtIBF7KEknI9WK6OGggVXBFUXVM4cwlsUtkfdcp6DUjeuujyL6Now
	VS2A1bnPEmahpp3bdDq9BoA6LjhNS4JOO0xqAWW4r9yJnFlcC1NguWzsOjvsE4CDKAWjeiEIryB
	Yo0Z7CEBPu1BCpJfW+MS/ctq6MJlhFDqGB4q/1lcg4+cRjQ9hGXewx6mQk40s=
X-Google-Smtp-Source: AGHT+IFCNSF9mGRrBZYYhBS2A8zvP5w+BXMIBNv8w2krK5loOYKHGlSyH3pHY40YSUNyYon4Zl+PSA==
X-Received: by 2002:a05:6e02:2167:b0:430:ac80:7fff with SMTP id e9e14a558f8ab-430c52d772amr110212355ab.23.1760806720345;
        Sat, 18 Oct 2025 09:58:40 -0700 (PDT)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b4614sm11927545ab.33.2025.10.18.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:58:40 -0700 (PDT)
From: Adrian Yip <adrian.ytw@gmail.com>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Adrian Yip <adrian.ytw@gmail.com>
Subject: [PATCH 4/4 6.1.y] drm/amd: Check whether secure display TA loaded successfully
Date: Sat, 18 Oct 2025 11:56:44 -0500
Message-ID: <20251018165653.1939869-5-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018165653.1939869-1-adrian.ytw@gmail.com>
References: <20251018165653.1939869-1-adrian.ytw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit c760bcda83571e07b72c10d9da175db5051ed971 upstream

[Why]
Not all renoir hardware supports secure display.  If the TA is present
but the feature isn't supported it will fail to load or send commands.
This shows ERR messages to the user that make it seems like there is
a problem.

[How]
Check the resp_status of the context to see if there was an error
before trying to send any secure display commands.

There were no code conflict when applying to 6.1.y.
This backport gets rid of below error messages on AMD GPUs (per Shuah
Khan's machine)

  kern  :err   :
  amdgpu 0000:0b:00.0: amdgpu: Secure display: Generic Failure.
  amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: query securedisplay TA
    failed. ret 0x0

Compile test was done.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c760bcda83571e07b72c10d9da175db5051ed971)
Cc: <stable@vger.kernel.org>
Signed-off-by: Adrian Yip <adrian.ytw@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0bc21106d9e8..e22eaf9d450d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1959,7 +1959,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
-- 
2.51.0


