Return-Path: <stable+bounces-124084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D35A5CE80
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B1D3AC2B6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412A2638AD;
	Tue, 11 Mar 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcIYL7Pd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613E262D37;
	Tue, 11 Mar 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719727; cv=none; b=HLVWzsI3v9k8jzi6jrqpi13c4FMFIxppTwihX7OrvVVZzof731KLT0iTTkz7aGnoHSFRpLnxzB6nQSexre35nb53etNOsS3VJcon6eWPpSuatYG9TaFqjCKMqII7trRgHP4cWgwzDUXx3iF5PAacmlg2DQOT0UGFaiC4HVH2ghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719727; c=relaxed/simple;
	bh=ZyKzSu+s1wOfR3oHKYaz0cQlG4dgr/gjkEwJavyClh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dFKV/D/HtDD7SmdTStmHYl/n3NNydLi9K2yMzNWm73XoQhM9ZOWSTwIyBZQ4AdeRUdrErkCPf93yqAvWm5vj9UEbHWH4TGwjuln5yjOXj/WJH4AVb4bGUj153MKagaGAQy3NMwRM3447854LX2TUrtW94RlCvMXopI4FWFrgw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcIYL7Pd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so14350285e9.2;
        Tue, 11 Mar 2025 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741719719; x=1742324519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM/C0Y6KtCo6GXxz4sTkdCklkA06E/YKrVilZFUzRyI=;
        b=NcIYL7Pda1XBjInNUJICIMj7kAsZqWoRQXgY04wjFQ5m44DueBKzx85gPe2cubln/O
         rt7o+9mA3ChGCPHbr4ymf/xI7Sv35GyLzbKejLJiEI4xEPCyPEvHuQJuPRPiKNFwLjz4
         EuJMjl76er6Zhgw6k6OSq+94x2JlOA7A2SVFhSR4wKJuw8ajnHAFioB/+JRFJxFF4dcp
         olI7vGu0Wu6VtUpWTpKx1prMbJAADTH9tlqMtuRSR01o5FRViM+TZmCrQYpi7Vmq0gvO
         BXC6ndPsdCWoJYptrE5CiiwlNzfJZ7XK6UHW1QOj7M21Mai+sC05/fQ0EHuQF6E9kHCq
         3EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719719; x=1742324519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM/C0Y6KtCo6GXxz4sTkdCklkA06E/YKrVilZFUzRyI=;
        b=J71HXE3ToejnpKNijdzuFPX35ptOJRzAWmKEois8GsoE9ZfoF8n1KK8EfQfLrIiZ+f
         /O3BFIZ8Yqx39Ivy4YaafFMGtGBhrHO1X31Y/2PlvgHs2Y+vmQocqJzPr4DNwXgCrJNI
         1d9cH8Hk9mNW3EIA8g3j/p1YHckys2NlEw6vfaMOrdU0p3ryll/O4kV6oJe8Si3w6e0/
         RicEoHDV8g0RPsJk4Spwq7E6AjK+J6tLECsE4ai4qeMcvbEccUro3iOa0oqYyobunC7z
         LfFCrh8aW19GpCLyTdtx/RnUrFppBfDPIQ25lFvIMCmejfmoa2u7DAg3Uui9LZP4fHRt
         zRdw==
X-Forwarded-Encrypted: i=1; AJvYcCV5036/7UGGl2yvhEOYNpaImj4QJQggymaL7y/WC7cN77+Q5g3LAb2ExRniutwWknmN+WQOuxIevi1sct0=@vger.kernel.org, AJvYcCWwJf/3tvbqBDfitKkqhpPj3a6s7CONgSCQe4zKL1GzWvMf0hAy4PkU+XQDNiK9s8G75900Z3U2@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHGITXqfXD+B26v994t+5vHO4JjWXKk39Ik4LD6mHtt35HFGe
	3b9bQcbk0jdCIXsN5/zvYIZP27bKPrq5Jy/8xiKbD3ckBJ1GPpOY
X-Gm-Gg: ASbGncsLU+0P6R4RuA/hAdRStklHLNLLfaoUOmomtLS4XVEMtcol3Ou+RLE7SSBABgg
	g9LABeiVmuQ6icxf9v9DCr7AraQ2J8zoyL5IWDGAAKsy+9idNmtmvnelQWtFsqaJkRw+sYDlWRX
	jOILxtfOFzm14O5YAlqYOFmq7N5bkofDCKkvfzJtGiBzqB3tPcMYf+EawIbzE3CrthwTff4i8ea
	RpGP857tT7xcMr+T0Awnky1Q7Ahw0cmQVUSQl8/Qbt0DPSmI8uavgUMgKKzJDRJSPKfMfOegtzo
	5GfwEZh+foYq+U+XIHT1Y/i8dEXOS0pmfkxIOHzaft3CGQ==
X-Google-Smtp-Source: AGHT+IF8L17vBaDo66fasMWl6iiHkxzIXdBOdv+IvwdgmD89ZI0aTDkON53jTbr9t1d4zfPaflVzqA==
X-Received: by 2002:a05:600c:4ecb:b0:43c:eeee:b70f with SMTP id 5b1f17b1804b1-43ceeeeba17mr82834005e9.24.1741719718920;
        Tue, 11 Mar 2025 12:01:58 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:e969:4b33:5aa2:11e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfcbdd0a7sm64617655e9.11.2025.03.11.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:01:58 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: christian.koenig@amd.com,
	ray.huang@amd.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	thomas.hellstrom@linux.intel.com,
	Arunpravin.PaneerSelvam@amd.com,
	karolina.stolarek@intel.com,
	jeff.johnson@oss.qualcomm.com,
	bigeasy@linutronix.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm/tests: fix potential null pointer dereference in ttm_bo_unreserve_bulk()
Date: Tue, 11 Mar 2025 19:01:38 +0000
Message-Id: <20250311190138.17276-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ttm_bo_unreserve_bulk() test function, resv is allocated 
using kunit_kzalloc(), but the subsequent assertion mistakenly 
verifies the ttm_dev pointer instead of checking the resv pointer. 
This mistake means that if allocation for resv fails, the error will 
go undetected, resv will be NULL and a call to dma_resv_init(resv) 
will dereference a NULL pointer. 

Fix the assertion to properly verify the resv pointer.

Fixes: 588c4c8d58c4 ("drm/ttm/tests: Fix a warning in ttm_bo_unreserve_bulk")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index f8f20d2f6174..e08e5a138420 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -340,7 +340,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
 
 	resv = kunit_kzalloc(test, sizeof(*resv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
+	KUNIT_ASSERT_NOT_NULL(test, resv);
 
 	err = ttm_device_kunit_init(priv, ttm_dev, false, false);
 	KUNIT_ASSERT_EQ(test, err, 0);
-- 
2.39.5


