Return-Path: <stable+bounces-184717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14030BD42BE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31131889C68
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63B3126BC;
	Mon, 13 Oct 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQ86XmvN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB33126B6;
	Mon, 13 Oct 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368237; cv=none; b=Yf8tMNpwa92QGrsZWxQd5Ckdu0AZmQzDcHiuRoQQURNtvI/SQFbAHD7tU8/+OACKLD2EREiQCA0olEKq59YYrWEwKk3a5YF5raZs2tQj7MWexYgEeDvUIci9sbEsBAOXCuLNxr+6BY4mLeqvYdKpe4RwwCXhTGQJ9iihggq+lKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368237; c=relaxed/simple;
	bh=HWOvGk1DdFAV3O+hkYRjoq8WSdNZJ3WntlCPHx4BEF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyrJKESF9UBThLbnJdXIs1AFks+Wgu43Dl5Mz4fNNDoe7ULf8da3X0Ub/O1ENjephRvBrBWaP15rrlZw5+gClTdwXRyDtADKiB62YBiYVNpYcLuxl7tGs6rbOIlSRlvPdaL92K6XKCkf3cXuUuqGT/UU5bMfBU5iPCynenXC+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQ86XmvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72C3C4CEE7;
	Mon, 13 Oct 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368237;
	bh=HWOvGk1DdFAV3O+hkYRjoq8WSdNZJ3WntlCPHx4BEF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ86XmvN6Mwd3iLH+VKHGD/S1ng08Qrmbu00jlLj/dd+pN0/VT2KKF1gK4jMZNVbH
	 ufmAjqgSca2i0GV0BezwnA+v/bdTV5naEk9WsXgNMmr0H+3lOIRIjsMFMGepMYw5kc
	 BcgLRJng6D2jxaTVMScdJr7MNjMKetofoHn9huxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Brahmajit Das <listout@listout.xyz>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/262] drm/radeon/r600_cs: clean up of dead code in r600_cs
Date: Mon, 13 Oct 2025 16:43:53 +0200
Message-ID: <20251013144329.405900176@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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




