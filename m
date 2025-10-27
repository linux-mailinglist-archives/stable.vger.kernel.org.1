Return-Path: <stable+bounces-190370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C7C1059C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F601A2581A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E32261B99;
	Mon, 27 Oct 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtZ5PdmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AB32142E;
	Mon, 27 Oct 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591123; cv=none; b=cXbKVrJeFQHdUO985koTaLAJneLEWYEWcKu3OOu1pdq8Hp2OUAucQg0bmHPueC+Ic0rd+tiimZdD4vZRxjyBZkKn7E9yVf8NSoni9VeXnucTwt+zmmqyXa5lEEJ3VLlVqTZvyxMchnuf0gjboPwjnYp5kHTvAxLfjppPdZTC5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591123; c=relaxed/simple;
	bh=JM2n/BYf7r3QXv3Kr45cWgEHDRy+MgZSO/EPJdljIpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4j9Xre4+0NfHd5/LfBo3maSMPln6075pn3IJKK91JUIu9YPADoLp3QchAOb96PejOc/9qsN1wR82CJz5gm04/JYDVjLwQ/0qP7i64R/ypC+iw4AGpJ4Bp+BD/RLtOwStuH3sygV4KwxoeiE4j2mfqxfQIXgqtj4TOjj0gUalnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vtZ5PdmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D9AC4CEF1;
	Mon, 27 Oct 2025 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591122;
	bh=JM2n/BYf7r3QXv3Kr45cWgEHDRy+MgZSO/EPJdljIpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vtZ5PdmKqNH7JsaUL8pSQA3B+IJdoEHsKjemkN1E51iZIqdcb+119lVJwFCEuoOHZ
	 0pMSFvZqNGc3GM+owRHLPvkRvO/3yYYzD6GrNxp9yZVbX0koSz5RdT2WzL6irwPJOF
	 TjyfECIjEObd2oIBL5iuMEoPcFbSIZAKgD+AFj3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Brahmajit Das <listout@listout.xyz>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/332] drm/radeon/r600_cs: clean up of dead code in r600_cs
Date: Mon, 27 Oct 2025 19:31:32 +0100
Message-ID: <20251027183525.655309472@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index c738740f8b19e..9a13d0c174236 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1409,7 +1409,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 			      unsigned block_align, unsigned height_align, unsigned base_align,
 			      unsigned *l0_size, unsigned *mipmap_size)
 {
-	unsigned offset, i, level;
+	unsigned offset, i;
 	unsigned width, height, depth, size;
 	unsigned blocksize;
 	unsigned nbx, nby;
@@ -1421,7 +1421,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 	w0 = r600_mip_minify(w0, 0);
 	h0 = r600_mip_minify(h0, 0);
 	d0 = r600_mip_minify(d0, 0);
-	for(i = 0, offset = 0, level = blevel; i < nlevels; i++, level++) {
+	for (i = 0, offset = 0; i < nlevels; i++) {
 		width = r600_mip_minify(w0, i);
 		nbx = r600_fmt_get_nblocksx(format, width);
 
-- 
2.51.0




