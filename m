Return-Path: <stable+bounces-164591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67538B107E9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6425A1CE37A1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8262676F4;
	Thu, 24 Jul 2025 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="XTjetLu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED0267715;
	Thu, 24 Jul 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353631; cv=none; b=AEBmwfSgR2qqkpDH8rVE0fkJ5ejHXDXIunAqZ1H8cYa2Y8kA+OFsL+n/0OI+fAK9CAww6oEecdVPVnQ6Ue2kE1GIZGbDD6S/DK4wCrpyYMxNi0f+mUH5WXAJ4zDiVnClK3DbThxbwbFWXGtZQgb1nBqJB3jC9T9L1doQa7dDNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353631; c=relaxed/simple;
	bh=Y9JrkBs6/AHJ/jtw7YK1U4nAQTPwDGnhSXLxNcAPncw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUfF0yedxlUjfGz9adjXmhESRtzKOob67WVND100lwYY5xDhYqhxyvZ0oJnxr9JzHDg274uRugG7x44r8CV8FtrI+5i+cfa8WhW9/0lmdVojWEqaifh9eqiesFX9D96C94QtHUyeCn2Rzphk64UyFt8Fkdvv0h2w+GJ6n8WmVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=XTjetLu9; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1753352707; h=from:subject:to:date:message-id;
	bh=Y9JrkBs6/AHJ/jtw7YK1U4nAQTPwDGnhSXLxNcAPncw=;
	b=XTjetLu9+2eM1ii2DfR9qPXlXANLeK5jOimYq62LAdeBLzC33Blnsyh8Q6zgLmEf5VZ4VxleQ9f
	Q1WZ2/5spjH8ocieF+a6z6fqvSUEXzLCgK58Vn3ByFxBmJkyFHHVyL3ABfLn6Z0lyLm28sB+QLNy1
	/YAf5CpgS0NPINEJe+0Of+ZURXXu/Ra79LIUTK8uq60hRtFVX3Auxe+3CrvRT4Dcwn1jmmEa0YybF
	w8OQyOd9BArLVzCj5rus2teewKdO9T1LBTEMBSLTRVnkHAak1orYECdvFPTaJ/C5zJPuYFXbED18u
	9gpEkID9FYzpk8EZ0klYeAR3Y2fKg2jmc5NA==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>, Jerry Zuo <jerry.zuo@amd.com>, Alex
 Hung <alex.hung@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.15/6.1] drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
Date: Thu, 24 Jul 2025 13:24:49 +0300
Message-ID: <20250724102449.63028-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724102449.63028-1-d.dulov@aladdin.ru>
References: <20250724102449.63028-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: Alex Hung <alex.hung@amd.com>

commit 5559598742fb4538e4c51c48ef70563c49c2af23 upstream.

[WHAT & HOW]
"dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
cannot be a null pointer. Let's pass a valid pointer to avoid null
dereference.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Daniil: dcn20 and dcn21 were moved from drivers/gpu/drm/amd/display/dc to
  drivers/gpu/drm/amd/display/dc/resource since commit
  8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
  The path is changed accordingly to apply the patch on 5.15.y and 6.1.y. ]
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
Backport fix for CVE-2024-49923

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 04b370e7e732..877acdbb9d8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2817,6 +2817,7 @@ bool dcn20_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2839,7 +2840,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 257ab8820c7a..4dcfdb2c013f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1190,6 +1190,7 @@ static bool dcn21_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -1230,7 +1231,7 @@ static bool dcn21_fast_validate_bw(
 			goto validate_fail;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-- 
2.34.1


