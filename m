Return-Path: <stable+bounces-121208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DDA547E3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD2F1891389
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479520458B;
	Thu,  6 Mar 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lomBbTCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CD1F63E1;
	Thu,  6 Mar 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257375; cv=none; b=fO93bkNQUYAESgYVJ0yIV4+BXRKcvSSA2/bMT6jc4E3I+x6qDL3UK1OYiZ92LTwnTEAKEvjSeeHtk6Hv9xqIGG3W0+osQ2hqC6hhxwYzKri50ZN9TpB3usaCmv286hbYK/oTWWwfmufzPP7x7tIXxiMFkEmNs3UZjy3G+PlFbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257375; c=relaxed/simple;
	bh=NW1/Cnt0mU7lWyczndd18IHQ1wItqkAw6BNi0vaR/hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/KXrPBEBi3/WYekYl8iBhLKVOF2RHsYhk/tpvInFC1fqvyVJVrM0qa7kMs3Uxi6dTRALVv51BLW5rvXc97ZDZIc2osspct44ifCIZltbjYf8F6/MwMoGYZJDid9tGw16h8dWB1Z88JTgiXtQEIWgDBCsWkjJqRWgVZtQERNXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lomBbTCl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5495078cd59so597537e87.1;
        Thu, 06 Mar 2025 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741257371; x=1741862171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MVkXRPG0DPog78nLFqW2ZPXVGeJ5h1mmD/8HDt9MY4=;
        b=lomBbTClcpedUKKLuBc+FYJbMZM3QwTclXoA707+HoW3XsGsYo0eJLUDPJS5Hjm4c0
         XU85FZVi7mMXPWXCQHcDx8WrnhvUEmrndTSk8vC11TGxSVnmqJ+dEyNw2AXtHZsT3Ux5
         yuTRISUBOWCju8rS4kpyGuyYIhtZySUCy+r/a5me9/TwdOg58ooiwrvH8MqpsX12CPkX
         Wf4VIPHJ4X9b2i2wB5RfzmOXcFe3jFwD38+Dsfnl1CZVxKQND2o5F4DcFORmtT5JNyZT
         GHct6HCyG9D7wx/WiLDjSx9Yd48TMgVy+UCt9/+pb43z766qM/UbiGpwAn1iV2+0CDxw
         pXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257371; x=1741862171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MVkXRPG0DPog78nLFqW2ZPXVGeJ5h1mmD/8HDt9MY4=;
        b=WXl19fNAdp7OmbWMAJnqZjdvmoX+O9fmGeuEHYsj85MvNu7YCTxJIwe9QVnMEfU1gV
         SdcaL1UTV4vS1HUkvNdB2nh/M/1fdTlWuLcPTmIvEyg6j2E5GLLIuL3baCRMOte1iS8G
         5VlvIz1jjzK9xlY5f9x6BFUw6ibDmkapqnDsDV1uONjOufbJHZcYAnFf/z2VBSypK7Bc
         VpfJTtO+cbydPqlCZRP+l98RLFrf0S5fyvQjARyyu0ibUJJHyHDCVjQF1Tnm28bqn78x
         9acDg3JIFEjDHnWCCYvk78xerkb2Yzf1ByNwOag98XVL0Qk0CQ7oNzUbkW72C/SRNIk1
         SeKA==
X-Forwarded-Encrypted: i=1; AJvYcCUDmNxnyw2hvpp3EKaW0OBk2fYbOOpEVAnS6Exv88O4//zUHZaXnwlzB+LC5D/KSeMZnzDWYaHA@vger.kernel.org, AJvYcCUbY/+PtRPRC1eqenJMRrpwGzVsUN4VnYRDrL0KFK9b8gOe9EocofZ/XRy/6ipiEegVCWU2v3xEPLfEOHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37kuJqPEexVXO2lTjZK9KJTU94Seezs7po+jluY87UdJv9jy8
	CQJ1H5NopSdtCaKt/aOwRO/jMn8Kj4a8ycHByV3OfPRMaKRx5uyd
X-Gm-Gg: ASbGncudFvVcSaUbaou5o1dEZXQqvIfUy85WUY1iEILc53mvoxHlt5g3Og8HsZeQXG+
	Qws/Ydoz+UrLsRI2PdxHK4Hom0q35wq026xiEThxNI32dNhHNrR/cjCsZvQWgVmv8kQQ6v+TIQl
	InvZ2xKUybUpY+gZfD6nmL0yD30K7bC/sKDWM4nx40D/Y+hOLYErVsCiQwgbKukF15PejrGG9k/
	rffd+DTzT10GRmQVBo8iZa5UHnE1eW+PPiY6om4Nqo5r+l+cmDmFBO0aBwR+PWytbyV6TZtDome
	FxncwiuGJDo0Y+ZzLDb8K02SnzyBC7NpMcSbeSm2FDXLWnTx0tNN8AQW8xVA+bChdxVlyb2I5LW
	IZOKpLO/LX6JEVQ9RKJqYpDB3B7KVB+HNt0xN64iApmE=
X-Google-Smtp-Source: AGHT+IG6KtRDh+F69rV7hy/nuHw4J4sKnbzSyyuUdpRjtB7N7ZDfH8cEooEy0RcqsW/KaB1XUi9UXA==
X-Received: by 2002:a05:6512:1392:b0:549:8d60:ca76 with SMTP id 2adb3069b0e04-5498d60cb90mr341916e87.38.1741257370731;
        Thu, 06 Mar 2025 02:36:10 -0800 (PST)
Received: from localhost.localdomain (mm-87-36-215-37.mfilial.dynamic.pppoe.byfly.by. [37.215.36.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46646sm138150e87.46.2025.03.06.02.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:36:10 -0800 (PST)
From: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
To: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix missing .is_two_pixels_per_container
Date: Thu,  6 Mar 2025 13:36:03 +0300
Message-ID: <20250306103603.23350-1-aliaksei.urbanski@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from 6.11, AMDGPU driver, while being loaded with amdgpu.dc=1,
due to lack of .is_two_pixels_per_container function in dce60_tg_funcs,
causes a NULL pointer dereference on PCs with old GPUs, such as R9 280X.

So this fix adds missing .is_two_pixels_per_container to dce60_tg_funcs.

Reported-by: Rosen Penev <rosenp@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3942
Fixes: e6a901a00822 ("drm/amd/display: use even ODM slice width for two pixels per container")
Cc: <stable@vger.kernel.org> # 6.11+
Signed-off-by: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
index e5fb0e8333..e691a1cf33 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
@@ -239,6 +239,7 @@ static const struct timing_generator_funcs dce60_tg_funcs = {
 				dce60_timing_generator_enable_advanced_request,
 		.configure_crc = dce60_configure_crc,
 		.get_crc = dce110_get_crc,
+		.is_two_pixels_per_container = dce110_is_two_pixels_per_container,
 };
 
 void dce60_timing_generator_construct(
-- 
2.48.1


