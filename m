Return-Path: <stable+bounces-109213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B4A13300
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 07:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3535163B81
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76E155743;
	Thu, 16 Jan 2025 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1Az2QHP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7E13B298
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008258; cv=none; b=FxKvu+STONh8VvBgatTaeuuzmrCP+8NHpc6fOj3UWELEYPMZ9Ut98/KkL2k4ITKID2Rtk+Q8z8vJKDN0IpNd+ejDpj9JMaqS04CMsMWUZFMY3wVshLZEsLlibwlK8fA+cPTGwT/6UGnM5zuHKmmJr5knBujb7Al6H2DVY/kS/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008258; c=relaxed/simple;
	bh=5oNE6Xzd/e+Yc8Ds6wakrrRBp2U9/BLga1YBBycGD3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KVMaejAq5WrIAjKcmqBvfZwSXw+JlYa2YmzcAnLvK0B2JfKyDCtlR8+DasOx2BF7mazbZ1ic07jIFsHeNiS2SSBkaxbFl6Juo/izLdZr5gruE+UI6i+ViucRyfLfZQd/1MZ1/WGDPMk3JiBkmKLJvt6lSBQCDN/eJIGieMWnk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1Az2QHP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-218c8aca5f1so12198195ad.0
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 22:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737008256; x=1737613056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUvvHlgdZilg/7BrPfKTFxihAKmCu4/7b/suHg28I7k=;
        b=V1Az2QHPT9VTXJ6flEYk8IDFDJubJgJZ9PZOeGYvu2LNm8W2AUF19ABhuvbv/scXrJ
         SVbBa3tGEUwYGHzYDq7A4haPwrjMMH8cqrgJKC0GGemUPNLBqw+JOvi6LPT3jJil3htR
         S9SHxvvwsf/B7rRvh8gRvTViNiJi0/I0n7Q71uCPgDOEWtip5C7KXYX93vQQYDHapqrg
         ZUXC/wxyC2nuupjISV6bv1mC9LQ0BZiO8EIZhtfq4jV5SoxDPJ/v/zJ8O+itYmYnCCh8
         sQ549B3ugXD5vYUyWyk0yZ1ywgXbEkFYAUHqYRVFFxN6QNt9GRGWSfNgYTVte++qCUVr
         AYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737008256; x=1737613056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUvvHlgdZilg/7BrPfKTFxihAKmCu4/7b/suHg28I7k=;
        b=WQZHyCKXkvgiW9ciOibz582t8J7ejTd3Bwek6Z81G+FoZjg295Toy4UaqlJ6LdUWRl
         tUtn8bt8OMaSzFrIZAWpAUPuOIVIht0lED3E2znf75UgFLEjYlywOSudwFtysEFliiZi
         YUk6grjLnRzEL4yRz42JwKogfM70CKkWVfvwz9Ih2U/JW9Ro3EJawskGp08Uyt1cNBSq
         rDyNMx87eXiEjJimcbzf4RcL6Qp063aTyBPldgDWTKqt7NY0Bap11ESeui+dCo6NZq7k
         1G8JOeJ3YCnoQfP2p2pJI9tG6EEUkkg1dqfyO3dTbbm7JpgqjaL7LvfeiVE8fAQkbNHx
         qYXA==
X-Gm-Message-State: AOJu0Yyxf7Vqyiw+Zp/22kPOApQMO79D8hPHA7ttjOpTuBn4WizEgNcc
	HRIPqx3c1vu8aT/wZl8QMOewl7XHTIjsFIyjm02njYchzqaGdA/uZceigcf27Yk=
X-Gm-Gg: ASbGncuXaIkBbmitl6EF37EUWMyWgzUWEdsZonXl6fPRvCDKIPQcMMEV9bqRALC810I
	LPLfvZ+VhC/acDZrHCMD7y53v99PC5d6YCQGQKzxYaljGmq1JMlFe0648zn6TwtyvlcPTcHH7Eq
	Vt3SGp0sxhDzllWpzD0DyaT9Pnfv3uuw3pzAdsR4GLnBwkH1BpUSwr4OwJ+HbNeK/8o8xhxJHRZ
	MbnEkPr73UohW6EP6bPNJpnTLtnCXl8xznibrUOXwh+7CJuon73Ad20XGWuolgCpekGRqqiBsnn
	9dde4vt4EZD1bHGV695946LV5vE=
X-Google-Smtp-Source: AGHT+IF0+2ulZcYcXfl+rY0dl4GVaDojqExgsx38TwfTgVPIQnKjcjIuA12RTbYgWN92qmDaT0CljA==
X-Received: by 2002:a17:903:187:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21a84009ab8mr489244105ad.47.1737008255795;
        Wed, 15 Jan 2025 22:17:35 -0800 (PST)
Received: from pek-xchen5-l1.corp.ad.wrs.com ([117.129.6.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f13c92dsm90733085ad.97.2025.01.15.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:17:35 -0800 (PST)
From: "Frank.C" <tom.and.jerry.official.mail@gmail.com>
To: stable@vger.kernel.org,
	srinivasan.shanmugam@amd.com
Cc: chiahsuan.chung@amd.com,
	Rodrigo.Siqueira@amd.com,
	roman.li@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	harry.wentland@amd.com,
	hamza.mahfooz@amd.com
Subject: [PATCH 6.1.y/6.6.y] drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
Date: Thu, 16 Jan 2025 14:17:26 +0800
Message-Id: <20250116061726.56117-1-tom.and.jerry.official.mail@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit ac2140449184a26eac99585b7f69814bd3ba8f2d ]

This commit addresses a potential null pointer dereference issue in the
`dcn32_acquire_idle_pipe_for_head_pipe_in_layer` function. The issue
could occur when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2690 dcn32_acquire_idle_pipe_for_head_pipe_in_layer() error: we previously assumed 'head_pipe' could be null (see line 2681)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Frank.C <tom.and.jerry.official.mail@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index ef47fb2f6905..2b5bd3aa3229 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2558,8 +2558,10 @@ struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
 	int head_index;
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	/*
 	 * Modified from dcn20_acquire_idle_pipe_for_layer
-- 
2.34.1


