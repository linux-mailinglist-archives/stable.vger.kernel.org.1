Return-Path: <stable+bounces-133218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B38A923DE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861DA1626B7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533752550C0;
	Thu, 17 Apr 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwGvfpDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B704139CE3;
	Thu, 17 Apr 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910538; cv=none; b=d9yI0XxdkZVcIZ2tijAD97AbJX1U6E5mJJMZRISathp9FZSKX+lqKnY1syUP6cVKS/kRxmDDD4QSeQput8kxAs3/dd4mkY019Kg7+P+dLQbk38YLUem8hCFC2LXatOuoIxlg9MyjzshnZivsVDsRDkdABoS39lFeF7e7bdZf4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910538; c=relaxed/simple;
	bh=n2y0CS5aOrvadnYjaE0BF+yGrB4aZ5tPcmVJhwzLnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CPZPk5/V6eU2USMw0tWdI4KWSn0NhBmhgqSGYgOAYjBRwZGoR+xzrd5guGUBt6IXZhyeiiTL+6qMIb6tBFoW4skLqE9HKR1mC91j/5dte1GDkQ20XLzD0tRm6udViWu7UJJk9a2tuCRq5UIuXJiSsJL9VDSGdkZ/DDlhPlRnoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwGvfpDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BAAC4CEE4;
	Thu, 17 Apr 2025 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744910537;
	bh=n2y0CS5aOrvadnYjaE0BF+yGrB4aZ5tPcmVJhwzLnYo=;
	h=Date:From:To:Cc:Subject:From;
	b=UwGvfpDd7TPhukQBmk924er4s4Tw9UprUrqNlno1+IGcfgw9fEcLb/voCSukCl/up
	 e6iSyDK4b6OGvB556b3rPQdZAnwcMYzvIaqRKDnZ6c8vCVo487VJreoXx8w96eSR1g
	 AfZw7aE8Sha+lpmU0Bsx8YGTL0XTKyyd1xQ+rXmWKSAzAaPAsU8UbVs7EOUm5f66on
	 rke9Dpvrnva1LGvchV6f7uasEbhxN75Y3sbqEM1NtdAzk2Y9sZYcIz7m15G/P3Zeyl
	 SdaDMwaVYO0Gczy23cbSXWW9jOGptMRMkIMU7wkH+ajbQsWX2AHYhPRCc94cFyjrYD
	 CMoI5YVg8ZECQ==
Date: Thu, 17 Apr 2025 10:22:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Please apply 8b55f8818900 to 6.12 through 6.1
Message-ID: <20250417172213.GA1197662@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="375avBN/oRxIdj0e"
Content-Disposition: inline


--375avBN/oRxIdj0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please consider applying commit 8b55f8818900 ("media: mediatek: vcodec:
mark vdec_vp9_slice_map_counts_eob_coef noinline") to 6.12, 6.6, and
6.1, as it avoids a warning that breaks arm64 allmodconfig for certain
clang versions due to -Werror. It applies cleanly to the first two trees
for me and I have attached a backport for 6.1 due to a file location
change. Please let me know if there are any issues.

Cheers,
Nathan

--375avBN/oRxIdj0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6.1-8b55f8818900.patch

From 062b81d06d45f6ef9b9045a6fd3b4359bb80e481 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Oct 2024 15:14:42 +0000
Subject: [PATCH 6.1] media: mediatek: vcodec: mark
 vdec_vp9_slice_map_counts_eob_coef noinline

commit 8b55f8818900c99dd4f55a59a103f5b29e41eb2c upstream.

With KASAN enabled, clang fails to optimize the inline version of
vdec_vp9_slice_map_counts_eob_coef() properly, leading to kilobytes
of temporary values spilled to the stack:

drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c:1526:12: error: stack frame size (2160) exceeds limit (2048) in 'vdec_vp9_slice_update_prob' [-Werror,-Wframe-larger-than]

This seems to affect all versions of clang including the latest (clang-20),
but the degree of stack overhead is different per release.

Marking the function as noinline_for_stack is harmless here and avoids
the problem completely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[nathan: Handle file location change in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cf16cf2807f0..f0e207044bf3 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1192,7 +1192,8 @@ static int vdec_vp9_slice_setup_lat(struct vdec_vp9_slice_instance *instance,
 	return ret;
 }
 
-static
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
 void vdec_vp9_slice_map_counts_eob_coef(unsigned int i, unsigned int j, unsigned int k,
 					struct vdec_vp9_slice_frame_counts *counts,
 					struct v4l2_vp9_frame_symbol_counts *counts_helper)

base-commit: 420102835862f49ec15c545594278dc5d2712f42
-- 
2.49.0


--375avBN/oRxIdj0e--

