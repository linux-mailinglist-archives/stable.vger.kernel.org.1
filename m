Return-Path: <stable+bounces-83134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6930995EBD
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7769E28588C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5115382F;
	Wed,  9 Oct 2024 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VrXQH21R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C038DD3
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449508; cv=none; b=klI4BgSHBXuyfjsL80Eox/NHCOI26whJF1EYd3GU/WQjc1B29MSDCgNN9tNWNMN17ZZgfvqw5pXp6uhZdI6Pi4Ey8qGxPZ+QDvSZW5o7ujq+I3Pre8OHnoTYz+/94dmclJhAqo6gQEZKNXOAP9whsagoFrn35HNtdYIX4Tpi0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449508; c=relaxed/simple;
	bh=ThZybFV5/EgwplJWTgkpspYJXQaeXvAlcJV+3DzFnMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKHZ3QyxRf2gLSQkTviU07NgT9lqhcic6OI0V2x4cJXOFBXVTzNnq3/ejLaA7fes8T+LqZFT1zMmRYq7nH5dHwj6f0I54x0NQ5p/NUPLIFin5obN9R7YUPhLUBi3McEqe7+s3+UU5HH56ky+YUKgBWk7D+6lA3KEB/mPHBWmw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VrXQH21R; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e10ae746aso1405511b3a.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728449506; x=1729054306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl9NJq0y9so1t9cHn/1cXbFpF0LaI6ua0I7Hb511hxU=;
        b=VrXQH21R+yI4NCIpG97LnH9YRAkm64BfHNaOnmZNbtGd51ZE8fudBLB2p7h98r6DvO
         EDJR94K/N+y7116wnTL2HTz/v9KvnNhFE0yLaE+Bfyb+dyqWp8JnNmioj1i0CC+PmfaU
         a1bIQ90JtnpPzsTq25ruEU6CvGqhBj8G4/Zis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728449506; x=1729054306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gl9NJq0y9so1t9cHn/1cXbFpF0LaI6ua0I7Hb511hxU=;
        b=XB4dx9pGkRrq2wGbYFAnQqvnTLM4DQa9lb362+T3YoqGrfM/znyZa/UKwF1JBVliDX
         1NNNRuejwCSSVWdaPjioDyU9kacD1nSXv58pfvc0QT3Ms9kdAdmw4/D0zkWutWKzvM6Y
         xo4z6Jf/IK8AM4jS6odHJr7cEdEJ2wu6tPE9Y+y375fJPYo/3+GZyy3LeO0QsFTf5kcm
         ONHj7BNfcY/yBgNi6WTOYNQL3sTHiVk7SRHPe40D4Ctycgry+CGnszhiJlDmVcjTyMIV
         N6rmJhDNIeRITeJHXcN53ijIbM+65DvkLyFgLtT9+M+XI9seTzOLyoMYbi4DZvSHsvSx
         ntow==
X-Gm-Message-State: AOJu0Yy2xu5lsgfIJtBwX4z9/ZuPVt3HUM77+/lhDSCTlV7EH2Naiycx
	e8FZifC4pmdmQp0HQn/oC4N98HHd9KFgz5Mv5TMsL+qidDMEa1sKQ8dOjsS7iAutfGRBWtub6JT
	HXw==
X-Google-Smtp-Source: AGHT+IHaqdszCbZwBkifQLKvajZGmSt/wrVGQ9CRCnc/xfecK6+u8xjLiKlh/IR/RlQC4vgSadBQkA==
X-Received: by 2002:a05:6a21:a24c:b0:1d7:83c:bd6a with SMTP id adf61e73a8af0-1d8a3c9e1c0mr1849301637.47.1728449506203;
        Tue, 08 Oct 2024 21:51:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c49803sm7667123a12.79.2024.10.08.21.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:51:45 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y 1/2] zram: free secondary algorithms names
Date: Wed,  9 Oct 2024 13:51:39 +0900
Message-ID: <20241009045140.840702-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <2024100724-used-ventricle-7559@gregkh>
References: <2024100724-used-ventricle-7559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to kfree() secondary algorithms names when reset zram device that
had multi-streams, otherwise we leak memory.

[senozhatsky@chromium.org: kfree(NULL) is legal]
  Link: https://lkml.kernel.org/r/20240917013021.868769-1-senozhatsky@chromium.org
Link: https://lkml.kernel.org/r/20240911025600.3681789-1-senozhatsky@chromium.org
Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 684826f8271ad97580b138b9ffd462005e470b99)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06673c6ca255..db729035fd6b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1983,6 +1983,11 @@ static void zram_destroy_comps(struct zram *zram)
 		zcomp_destroy(comp);
 		zram->num_active_comps--;
 	}
+
+	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		kfree(zram->comp_algs[prio]);
+		zram->comp_algs[prio] = NULL;
+	}
 }
 
 static void zram_reset_device(struct zram *zram)
-- 
2.47.0.rc0.187.ge670bccf7e-goog


