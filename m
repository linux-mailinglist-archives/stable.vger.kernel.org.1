Return-Path: <stable+bounces-105459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217669F97C3
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724A816E889
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B3229B0C;
	Fri, 20 Dec 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkRsdlcO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBD21C19D;
	Fri, 20 Dec 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714752; cv=none; b=QBb8bfHKOz6pdQsLl33n7d+ar/feDGdTFyDj42lpvkk8iTHnyXYFto1R5bLVr0tg9jhKvlL7tVPbX3417CkOEBuluiuL7pVvHkkP/rxN0hG0JXr3H1gK5kLgID2g4cYBPfqcGBXSYRwXNpW89eo4jvWd8xi8vZtGCpQGGAsLS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714752; c=relaxed/simple;
	bh=s0STJfAFIP5+6UO4H5FBYvKDuYRxeyInv+oPb0VXi8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldAJxxZtADCXwLAlQQX/oaDLvhdrSEl6dsOUegkAkUncYLo4qBmCnUX2de+eF/ROMdjm/GwTWu1xN+QRtWKiEtPvgJ+uSHuTBk3DAOqRZtOumgeKR3YWl/kKVeu9QOI+BYH7moDHWnX3jUrFAe0FnEuyRHh9BTVlUqfr3J0AykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkRsdlcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9045DC4CED3;
	Fri, 20 Dec 2024 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714752;
	bh=s0STJfAFIP5+6UO4H5FBYvKDuYRxeyInv+oPb0VXi8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkRsdlcODen+3qSICOc5rqoqCFIyvn655Cptsd9vSSIe77szG5DNMeMy5bhu9yV5G
	 nlehtFNCDkH1HFwSwZGbCzo5p4QCBgZFfyCWABB7nfzuXiAr/uDVy0qLi9kYZj+AMJ
	 HmLfMkXodsMoZ6WQ7jNcM7DeSBnDbAFkDieE3ru83Hbw5oZg3Fsli0ut+Lw/NSRQTo
	 8ZkZjLhW0WyGQZv60aDT6HtYxdhJ9ECTFPLtvQ11+nzc7QNgx3CiwM8eLa4v6cBh3c
	 Xq+a/Yn/EDOhgE72kBJiL6bE+Y59tFaNznNYRdoQlX7zcF6jtVmEDghCn6fE1rphOR
	 +4O+6/G3usbWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 27/29] ARC: build: Try to guess GCC variant of cross compiler
Date: Fri, 20 Dec 2024 12:11:28 -0500
Message-Id: <20241220171130.511389-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 824927e88456331c7a999fdf5d9d27923b619590 ]

ARC GCC compiler is packaged starting from Fedora 39i and the GCC
variant of cross compile tools has arc-linux-gnu- prefix and not
arc-linux-. This is causing that CROSS_COMPILE variable is left unset.

This change allows builds without need to supply CROSS_COMPILE argument
if distro package is used.

Before this change:
$ make -j 128 ARCH=arc W=1 drivers/infiniband/hw/mlx4/
  gcc: warning: ‘-mcpu=’ is deprecated; use ‘-mtune=’ or ‘-march=’ instead
  gcc: error: unrecognized command-line option ‘-mmedium-calls’
  gcc: error: unrecognized command-line option ‘-mlock’
  gcc: error: unrecognized command-line option ‘-munaligned-access’

[1] https://packages.fedoraproject.org/pkgs/cross-gcc/gcc-arc-linux-gnu/index.html
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 2390dd042e36..fb98478ed1ab 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 KBUILD_DEFCONFIG := haps_hs_smp_defconfig
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux- arc-linux-gnu-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
-- 
2.39.5


