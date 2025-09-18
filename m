Return-Path: <stable+bounces-180510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF727B843DD
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 12:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AD27B1247
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15802FDC52;
	Thu, 18 Sep 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOBs5Ri8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4C286427
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193052; cv=none; b=Y+GtzVWb3VQUheMoN4vJlOVC2VIJ/l8mgBHVaFOVCkxgitTo8QOLr5Jbkd1xE9/9Am7Ugvb8FO6l1BC1R3SP89hIEb0h9yAkQZidMe1aQGOW3L3FCdn/3sQIYb+OHFgFjdSmbfXByQKmhWpGJXlcqS3YFSApyQtK6LkXrFh8L4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193052; c=relaxed/simple;
	bh=wjiK5CmLhEgdRLWM49IZmO6ruBGI9L/RMNVue6ozAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB/O4udHcLRVquiw7MCX1fxomF0V1G+0+zRlax9eFHywHruoxj5SPMyOnRC5BsinyTMADc2Iv2kHRLJQcQO75RIxR/D2lFU12+9mbxT0i4jrMfp6LIdkue1B+NBkRJEg6pyxJ3LyI6f4FUt3jOHaBePFbtT+/sZuQtwQt8p00uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOBs5Ri8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77dedf198d4so63017b3a.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758193050; x=1758797850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8fD1CQqjJUvOAUt7m+V26PDaC5fPrsIK+KI3nVmRl8=;
        b=hOBs5Ri8lDEXadmm5znXJ2GdO4YwNb4+QoLPbn7hxBXctHHrmq78mUhYCgmFceexi/
         3q+jxWjwVk7x18uOZuaAB3nHkgZAlrdIpTgfHjpBl+5pJAbIKaUxWiRSpo+FV55NX1T0
         xo/nOCiWdcTgYEbSxPNzGQOQiUlQRtSqLiiPGRiHsUMFm3wBZiyDcbjAAUUS9nLAFq0x
         kHIFqLjzCB6HzGrfN0SBbfBskGd1RQBzIjTW806k7EHdPpi2/EZSG+KgZ7yQXH0uWIQk
         clf/BFekBFrTFtvINhXba3cibo/Sldbx1sXjcbTEzYcRhjTC/hyJIM70g+YE0QynsCL/
         C9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758193050; x=1758797850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8fD1CQqjJUvOAUt7m+V26PDaC5fPrsIK+KI3nVmRl8=;
        b=bWm2qIuruetJCBeJ5Y3rKRHZVlYiBNopzqGJfG9Sjau/QhGKWYk3lGSK29qLUux2bh
         8zJAaI8U8/vspjhHVF0973t7RlhQKbuFfZtdcHbvv8xRBr74luKYTm4K7/sj/adaFqK5
         aadmuKSBu+6yz+5gnEG0XCQPB4s23owZ8PXdv70y/J3OwoisbzrHr5jgIa3HFGHjbMiX
         WzxY6qtkoGJC78stHcW1ERSdZ+QPFhdkGga1OFTg1Z4Ptl/mrjImO/9453IqSzK9n/QK
         CfPlrhTcPz7yAgZJRSdga54J0CZP6alT7rUkR8HHwJEkhbs19ocxRuPE8BU4MTrDqYAi
         LDPw==
X-Gm-Message-State: AOJu0YxciumVboM1gna1BjcWzRuqmSUSy9RyZ+ce0bobtl25YKp1YjRo
	8VqNcskTkf/E0+lflhZKSuMnpmoIBx/QkJQxlx/+ZdZ0AynLYRM6lwsV
X-Gm-Gg: ASbGnctEo6wR5T1eePFSjdxpxW4jIU1AfljRuQA+2mFy399fs/vtGo8gIP1571miA97
	32P2iIE8bO8RIBQjeuwcfI+h89VyY1vdotqbWE2AmQtJ1U3RvKDG4vBt7XVIlfgzBouaakAi8Sv
	gSSuyG0BW0jKHEV2Je5WNIGMC9z13ErV4n38LUIffXQHMuUWXh4FBvqe8sSvDnxH1J+d5yr+W+b
	HwXJy0hjQDU0hn7eS32lg2miUkM1T8PhaOR0qp5HBUx+gNL0ocu9igsbsEAyNLHWio0p3OlpQkQ
	mYUtt9XU5fWYql+loJvQjBZgPDpjr0kvPz5VoSMETj/1OQo5DrzQSqOBtjGGYCoVjN1kiwiuNql
	U16T/mZ9wQddMVjiyQcYw6rb5tapQb36eXc+ioc2QR4l9j4VGFw==
X-Google-Smtp-Source: AGHT+IHJVja8HNkuglOhZxfUAvb71rTHrEahoyXZo6qnEi+bdQYnLOPRyp4BgI/iBJSnqYyXbwrbzw==
X-Received: by 2002:a05:6a00:92a8:b0:776:4eba:de33 with SMTP id d2e1a72fcca58-77bf7cbf514mr7097558b3a.14.1758193050346;
        Thu, 18 Sep 2025 03:57:30 -0700 (PDT)
Received: from lgs.. ([223.80.110.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc34078asm2071491b3a.35.2025.09.18.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:57:29 -0700 (PDT)
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
Date: Thu, 18 Sep 2025 18:57:05 +0800
Message-ID: <20250918105705.3480495-1-lgs201920130244@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/atom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 82a02f831951..bed3083f317b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1247,9 +1247,9 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
 		if (!ectx.ws) {
-        	ret = -ENOMEM;
-        	goto free;
-        }
+			ret = -ENOMEM;
+			goto free;
+		}
 		ectx.ws_size = ws;
 	} else {
 		ectx.ws = NULL;
-- 
2.43.0


