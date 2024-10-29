Return-Path: <stable+bounces-89202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980F9B4AF9
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EDF1C226BC
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E3206944;
	Tue, 29 Oct 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qYcv+KYz"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920542AA2;
	Tue, 29 Oct 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208736; cv=none; b=hKJsLVcND0YV1ca/DhuNb9TQE7qaNW4mnG0cJAiclLysn6QFCDHG7xsTULSmluDbgKbxkDDFb3lKt4lwUyHJtaXGaeMUk8kGVlKrXuNaLKC4DrIasdkXqDQuvFu/NRWwAa/7D79U5lJrsWcghu6JtQdv39HOA+XWOV2Inj7sKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208736; c=relaxed/simple;
	bh=1PO/i9v1dGFveU8bsYnjpc8mXK7pQdjjQDm9v1+si7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjfCKEDoJoJkRGkq1YqgSxnp2/HtvjdEPEwuPTaGrTB6COp5QcFOw5M05aPxju9PEq1WSJBCbFrEZp0Ar7f8LTgkBjrvzAHjrjZOIqv0fmTh2FsRAU8Q3AiEgPupunV/Y6+Hqkr9j+q4iKBZDBXqTpwt+GCNl/+EImSp62GYf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qYcv+KYz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 65B6F40AC4FC;
	Tue, 29 Oct 2024 13:32:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 65B6F40AC4FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1730208724;
	bh=CY9WpoB1ebMA/1wZn75hZzNlIToBl0ATXQ6g1HGBfV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYcv+KYzIcnp9KmvvsZoD3pjgBb8IXPILX2ZHTC28ZQIXspvwCHxjVFAKXs1+SQ0c
	 RKAiILnJmK3fOtbz2a3+dTYjF0GndeEk8kOSiZ5/aWDs8Wm0HmEvN89e+cj1zULCDt
	 UzTZ2CkomfK4bQ4LMTuMeh/BKCKwmr6679HHLSeQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 6.1 1/1] Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"
Date: Tue, 29 Oct 2024 16:31:41 +0300
Message-Id: <20241029133141.45335-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029133141.45335-1-pchelkin@ispras.ru>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7c887efda1201110211fed8921a92a713e0b6bcd.

It is a duplicate of the change made in 6.1.105 by commit 282f0a482ee6
("drm/amd/display: Skip Recompute DSC Params if no Stream on Link").

This is a consequence of two "similar" upstream commits existence, one of
which has been cherry-picked.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1acef5f3838f..855cd71f636f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1255,9 +1255,6 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	if (new_stream_on_link_num == 0)
 		return false;
 
-- 
2.39.5


