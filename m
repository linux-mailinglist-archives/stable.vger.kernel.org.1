Return-Path: <stable+bounces-184491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0603BD4078
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A065F1882316
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4D2E6CB3;
	Mon, 13 Oct 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eecgEs3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F97083C;
	Mon, 13 Oct 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367589; cv=none; b=Y2t+10RNMgPQiv3zwomyAqcxRsejNTlRaZ7lvD4Iev1PIUt087M6x1/lkKa7ls70dpjo+y7+Rd+d4lkxR5GTQnArXBWji8EZzgg1bB+YLuBWnlmTzEP4MXY7oBHDJiVzlH0vbx/zROpjjGJ5n6eBAfAzo5nLuKJ+HBLVrt6Opj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367589; c=relaxed/simple;
	bh=ZPnOFIi1hTaagiowsQpodocCHmtEgKm+unR3Z5Y7060=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Epw8BBReFWvXfViTw0J/oMTbePB2LhnITqwZ4frVFUFoD51IfkKhqd2HQc0nNRhGL6J731o1eoiQNtzG3AoLG6RHgSd0pf4Ry+ST+guVIKMNS0CZC2iJ2a7HGzQA2jJTrJQrEhYQRD8Y3w/QCxPuHPtL88snZZkG9Vr3vgkDbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eecgEs3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D69CC4CEE7;
	Mon, 13 Oct 2025 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367589;
	bh=ZPnOFIi1hTaagiowsQpodocCHmtEgKm+unR3Z5Y7060=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eecgEs3hxEJ+dx9+Ew/BD52UEt+Xnqjzf+bzXpyLRHW7NlB3PwyX3iWfmoZ4hQmtG
	 IB3/Dm2gw8DVfOrTvlUn6s+aML1QPJY7Z+bjs+6hjbwe35RrLIDHM1HutaKaOIYEcZ
	 kQdZ+Z6yWxd+PelcrM9CbA/5oxJJqxC/tP1m6bP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Brahmajit Das <listout@listout.xyz>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/196] drm/radeon/r600_cs: clean up of dead code in r600_cs
Date: Mon, 13 Oct 2025 16:44:14 +0200
Message-ID: <20251013144317.475243619@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brahmajit Das <listout@listout.xyz>

[ Upstream commit 260dcf5b06d519bcf27a5dfdb5c626821a55c170 ]

GCC 16 enables -Werror=unused-but-set-variable= which results in build
error with the following message.

drivers/gpu/drm/radeon/r600_cs.c: In function ‘r600_texture_size’:
drivers/gpu/drm/radeon/r600_cs.c:1411:29: error: variable ‘level’ set but not used [-Werror=unused-but-set-variable=]
 1411 |         unsigned offset, i, level;
      |                             ^~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:287: drivers/gpu/drm/radeon/r600_cs.o] Error 1

level although is set, but in never used in the function
r600_texture_size. Thus resulting in dead code and this error getting
triggered.

Fixes: 60b212f8ddcd ("drm/radeon: overhaul texture checking. (v3)")
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index ac77d1246b945..811265648a582 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1408,7 +1408,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 			      unsigned block_align, unsigned height_align, unsigned base_align,
 			      unsigned *l0_size, unsigned *mipmap_size)
 {
-	unsigned offset, i, level;
+	unsigned offset, i;
 	unsigned width, height, depth, size;
 	unsigned blocksize;
 	unsigned nbx, nby;
@@ -1420,7 +1420,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 	w0 = r600_mip_minify(w0, 0);
 	h0 = r600_mip_minify(h0, 0);
 	d0 = r600_mip_minify(d0, 0);
-	for(i = 0, offset = 0, level = blevel; i < nlevels; i++, level++) {
+	for (i = 0, offset = 0; i < nlevels; i++) {
 		width = r600_mip_minify(w0, i);
 		nbx = r600_fmt_get_nblocksx(format, width);
 
-- 
2.51.0




