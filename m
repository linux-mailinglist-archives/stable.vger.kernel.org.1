Return-Path: <stable+bounces-105511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6629F9851
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE305162383
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29C23DEA5;
	Fri, 20 Dec 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUQgAcLx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DD23DE9D;
	Fri, 20 Dec 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714872; cv=none; b=R4iPMCa8tljHx9GHC90OB/P2zj51jt6UPlXziSrI0VjXpObGpY6iSOALER7LksH/Uc4RWme5mUTeyOXQcl/ZCga4G3e6OyExKbD9DFzY1jNd5/MgoEa03qY4+5+9xOYKUPdVDzrU/+N9dDFYeXI4PALHy5G9eqo3gv0mhC6YFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714872; c=relaxed/simple;
	bh=9GTWoR6PqFOG4LQ05T1IJwxSFN+f5JKVLAdh9xrqC9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOl/n96gfVnF2ZscuxE9GRXwbJ0SFQUA4uUzujrwdImWGto1img987cPOcc95mWh4jQpeo8gFDVpm/CLxfNuBjKs04jUFmydmOt1Uw2KtKTkWripCf85ZrMR0EUHNipglETngMHszf6WJDGnnHyVgyglOh+CNli254tyJYePd1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUQgAcLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA899C4CECD;
	Fri, 20 Dec 2024 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714871;
	bh=9GTWoR6PqFOG4LQ05T1IJwxSFN+f5JKVLAdh9xrqC9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUQgAcLxhng8RILIvGMIZIj6VUMIPc3waDT7Lhl0nz+CNlwE7bnJORB2FXcgD144t
	 ShvlJr5I0zLK1k1yBI/7lXdFx/oky45RXGgU39C/zNsw+Z345hOULmtz40WkPN8VOw
	 PrTzISEaCPdPA/prAJUv2HOcedUlvxFcPUrtINErpgBhnpfUbKEaca8vII9nUAj/vQ
	 vjUFBRvd4uw5wZ5ExNCtrjUASIpknDaj07Pf9qNOZjcvvjK/4nvKKQrXtwbFpeHmOD
	 kep4ubOcTK5pPj6wR7V2vJS9RvsjoAz8oVEZiz2/36MIJyX7TstIIXWA4SwioYgRyf
	 xTbVmMaaJNjWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 6/6] ARC: build: Try to guess GCC variant of cross compiler
Date: Fri, 20 Dec 2024 12:14:20 -0500
Message-Id: <20241220171420.512513-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171420.512513-1-sashal@kernel.org>
References: <20241220171420.512513-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.288
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
index 6f05e509889f..d72d9f4dfc3d 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 KBUILD_DEFCONFIG := nsim_hs_defconfig
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux- arc-linux-gnu-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
-- 
2.39.5


