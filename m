Return-Path: <stable+bounces-180548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F122B85668
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029767B5035
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10230CB54;
	Thu, 18 Sep 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7zcUp4y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB42FE05B
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207533; cv=none; b=W/E15v0+Vd4zVGlP2bActCihmW7+thhO9ACBfATL64tJMv5fMmgSxjH2+pLCQ7FEgAlyYiH5DsdX4j55o/UuSoyD1fcOdl2z395yYStKaktykaJ35KSxSOKAV7bGCSeuXCsD4TkikyxRvaf82RRCb7WxokIOlske/ULtJr0mTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207533; c=relaxed/simple;
	bh=PCvUwYmeYctAs7Oam52/mTCT/LJwGQnrjjbieYlZim4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2weTnY/T1aUsT79NPjNhrF5FcxWuyco37q/7uQfDLtyo1SRTdZBfKA/VE1O6MqNEcMLSIYGGJrYOlxSiaTgSagsNl3DdySefu74vsxOkxG3blObu7KoWDgxTXTD7wcSbxHa+utnFLniY91CdKPMxHUQqhWJ9PxuzEww3AWurn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7zcUp4y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7725de6b57dso1471800b3a.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207531; x=1758812331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=beNHBIORwWdI6jz0Xklt4Z8Y7brA2iCv2EEwx022pAc=;
        b=S7zcUp4yjhGPl3ee3EB0HXbzMmysIVoJgLVL8sZIVKXCE09KoxQYlStar3CCBWTn9L
         Ojx268SimqTI088I3Y90w/LBFi+LS8N8iGDM5zY/VNs+B1Uu7AmjbFO1uEGM3cPMWYh9
         K6EUNhJVUNDTdAsingzBZ5U/7c6sHd7tveSjq4T8D0mss6vQ9Ea0rwyms+Vh9tqbRTDs
         oJC5vVPwG431sCmiA896VTvAUtjRmE4UkbxrWLpbxD9/eBc5zl1XFsd0t6tn91uqb2tB
         6pNRIOGBOdgrzCMW7/m849bKSgxQ3LGrDp9EddKPV+SemJAA9VTC8XCldPi+ygA+S9D4
         Ujjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207531; x=1758812331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beNHBIORwWdI6jz0Xklt4Z8Y7brA2iCv2EEwx022pAc=;
        b=toDFu+peYDU7ZjB72zBrVKJEdw4dANDLgTYXUz/7NQQGBWII73PQYfBGidKFXMlZif
         KsOb39eseE8Bp2RxSS9dVAFYes58o+wTLEXdk8oe35YvnKHlUgOpwybZwdGOgDT+caQF
         Wzdz4q+pEuHl812dH489UvhC4tsPsYsBHxuTaHxkYawXR0VpBScEtT84knZE/jYoEgJz
         03jmzWt4F3znBd9FhHd4AYICJUIt5BzoMgKGttqI+Bgm5QES8us6cwHTfqB2EvlbTFt3
         r7bOv6p7P6Jt5tStfsvLlrh6CzBUaLRO1wTPPXHxrdfIMd7vJ1Q4gLhSm1Clo4j0MYBd
         h66Q==
X-Gm-Message-State: AOJu0YzjwfJ5uU8T7em3xziR6wKZfKxfphQ+y5lxUXy2OPbFYs8auN3g
	bzs96P1Y1SUpbIC02QDiU27/8jKLD2ACmN4MwXMQkrqgI2/2D0VmLLAXMZPhgV20Yo8=
X-Gm-Gg: ASbGncu+wcxhrcpezlvMihUyrpUj2Mg3b8ao/yzp3yTwIvMD1ZEfHptFtWQziucXxmq
	caigOxQOevYPAslG3680xYbnKHg9hZqOgt52pFfun0EN/dOBP7V070vx68hL7r4vS5miPdeVfc1
	aD6BmauAlKaH+ey0nlz7yxS19/B04pIezkCYNNsiYob54BTdDEDNkH9vObjSzkWEE1rsiH+89CL
	OIc6J/ejrP2+mND3vu6g9E2jg3Qmh2RCd5zTYX19LoDaRt+66ZchIhQ5woSCv5O+cHJzBmmyUYm
	xpvV+OQRbj8O9F5muOqo07IXP8ueJAf3sISDUJUijd7XA/l7eHNWly2BVLpbSAqDiP1E2H4Rsrv
	qmi4rQ/iSIGhZ/zi46G8nvgPqD8pRYRIlIz6s0Xq9L9A1CM/Va0El
X-Google-Smtp-Source: AGHT+IGIvBO3xzseHmX1P7b9dSF7ElctZYn/Sd/EuikFaigeHUhCCsSkueAeH62n8Nrlv3YnRL44AQ==
X-Received: by 2002:a17:903:187:b0:24e:593b:d107 with SMTP id d9443c01a7336-268137f2459mr75365495ad.32.1758200706397;
        Thu, 18 Sep 2025 06:05:06 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm424564a12.26.2025.09.18.06.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:05:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <kees@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()
Date: Thu, 18 Sep 2025 21:04:33 +0800
Message-ID: <20250918130434.3547068-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
remains NULL while ectx.ws_size is set, leading to a potential NULL
pointer dereference in atom_get_src_int() when accessing WS entries.

Return -ENOMEM on allocation failure to avoid the NULL dereference.

Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 81d195d366ce..bed3083f317b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1246,6 +1246,10 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.last_jump_jiffies = 0;
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
+		if (!ectx.ws) {
+			ret = -ENOMEM;
+			goto free;
+		}
 		ectx.ws_size = ws;
 	} else {
 		ectx.ws = NULL;
-- 
2.43.0


