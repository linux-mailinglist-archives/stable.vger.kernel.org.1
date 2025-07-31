Return-Path: <stable+bounces-165704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362CEB1792F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D6A1C239A9
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDA22B8A4;
	Thu, 31 Jul 2025 22:49:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839E18D643
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002198; cv=none; b=RxZx7BYROg1ahG06xkv9l8/X9HKGL/07QnaKrYPuvyxwEuasHF6rW1B/sgv2cADf540jLvdbhQyNMOjqU9WtwhB0Ll43utBm7JDPEZA39oLv2JXYaRJ7v8DDxjWwQ3y9bT0Qr9tEdOpBcwI9B9KTq5SVRYGhL+D0tRaLeF7Aqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002198; c=relaxed/simple;
	bh=J+kxgdYQNw0K3uiGFtWlOheuTN+IoeQgPDtpKxj8WmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrW21PaJT89fMPcATc5I6LV592bplp5RxoIXKNjdUxdjtZPT+biLvZKs4+E/4Bmjm4euAbaZzPHrYgXKReO2nEYnmrxjoHZ/d7ZvMeT3e/4d9sUjFsvqOGR/u8yKbmAvq1GUEV7tGp9QRTtwq5fAD2zmwm85+5nqKdkMcjGMDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so204437f8f.0
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 15:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754002193; x=1754606993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc9ek6aaVKonfIPjNqyESsyoNzdJmvCzdh+JBlfPVC4=;
        b=GePG1zbMqN7dGJtDn1oQs73KVzGMhMloaXP27suCTkXwCfIM8SUR5kFJR+fRfo0s5v
         tt7ipmo14IYy3Ct5Ro6NQhrhuw4x2tr6Sl2zgFugLAwAY47rudqso4uNUmbQMbKb7r5X
         h2K0Rv+Be2/lBt0hDp6qdEzYng3lMA6+QcDhR/y4MkZtTZHXVp8gS1UqpTYJDWOFG2le
         7HOCdf1yhs0x0MiwxcTlPLd2lzAX0XOAexwmz+X6euym7IJrq1GSgB8qOy6bStuG1wlW
         o5FGoOrkTv9w5/E8TEofalEWDzMmyv6Q88ZmmxUchQB0bgp3AJmnNYCQBJAX2XT1IFsi
         XW0A==
X-Forwarded-Encrypted: i=1; AJvYcCXUUw1ca7ZkN2s//VrU4eHfRciB2Hb3AiH1l1xW+cD7HF/P1iGoc7Q2HUkPdN+3enhtdUpFKy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEVqx4Jj2krJw5bWEBbrNe3EQr5gJgl6qmRKXfoqMwZ0UdtBC
	8noZZAo36UNZF4OISVhSBTeG/XwZ2bcfx4pEwg9l/CRs5dtuPxovQxpv
X-Gm-Gg: ASbGnctWbHrCap7vWI8GLZRogBC3zPXXscNJ8RP5eKGaH5RmUjfsqeBXeJqDXZLrGy3
	Cv2kD7NBWjk8Pxs1AWJjoCmZUWGWtJKvCTZiSEWcxFp/NdOJsvnJGETJ5rFRUtGZg1Dm3U28mI7
	xneMKHkM37JphQQKq+7YRmw8RQhTJKS9GG3eI9dvjyM/REtR/hWz2uWroUa/j0KULWn6MXvXamF
	1zSJ/tabjyqYc66dFojfr7h6Q3sbMLuQaLQZj3aX2Qgu9zr8oVtDPBtTlDITmgxxMUwj6iFjv/A
	T2VqMcfTnoFhE0G/EygNpYA846ss7xcdQIrUfq6ugqitg1ywFLnC31OYi3hl3wELczByDeMRsba
	4gtEX+oWyYUCjZpjfastuJSHLH5FHSWSkW3JVegzufTrR
X-Google-Smtp-Source: AGHT+IH/QRfHUl0ze+TBD94j9NRq5TgwFo4oY5S1WrliB480E7I6ymna+pJOU1WNQcbWSpmQ/ifiSw==
X-Received: by 2002:a05:6000:2585:b0:3b7:8b1b:a9d5 with SMTP id ffacd0b85a97d-3b795018812mr6881190f8f.51.1754002193375;
        Thu, 31 Jul 2025 15:49:53 -0700 (PDT)
Received: from xavers-framework.fritz.box ([2a04:7d84:aac9:db50:f8c3:4ba6:f1c6:fef5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm3692560f8f.52.2025.07.31.15.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:49:52 -0700 (PDT)
From: Xaver Hugl <xaver.hugl@kde.org>
To: amd-gfx@lists.freedesktop.org
Cc: xaver.hugl@kde.org,
	alexdeucher@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] amdgpu/amdgpu_discovery: increase timeout limit for IFWI init
Date: Fri,  1 Aug 2025 00:49:51 +0200
Message-ID: <20250731224951.8631-1-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a timeout of only 1 second, my rx 5700XT fails to initialize,
so this increases the timeout to 2s.

Closes https://gitlab.freedesktop.org/drm/amd/-/issues/3697

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6d34eac0539d..ae6908b57d78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -275,7 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	int i, ret = 0;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		/* It can take up to a second for IFWI init to complete on some dGPUs,
+		/* It can take up to two seconds for IFWI init to complete on some dGPUs,
 		 * but generally it should be in the 60-100ms range.  Normally this starts
 		 * as soon as the device gets power so by the time the OS loads this has long
 		 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
@@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		 * continue.
 		 */
 
-		for (i = 0; i < 1000; i++) {
+		for (i = 0; i < 2000; i++) {
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
 				break;
-- 
2.50.1


