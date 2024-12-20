Return-Path: <stable+bounces-105489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C19F9826
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C32316DCF2
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DA234963;
	Fri, 20 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkupn39x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070832343C7;
	Fri, 20 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714827; cv=none; b=qEi2GK6V29DBIzV4BzmZ912epANdoDzdiIFQejfkODXNZbFYlZkkRrB/LzgPXHCcRcGIrLGx1K8wPW7vi+jF3s2Lxw0VxGnDr97D9GCIbIaMKHU+fHfwVmCl5IaSGpsMOBKElMaBmLh4Yj2xiMiwgCcbfOQwtx5+UWLumCZvLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714827; c=relaxed/simple;
	bh=yn0Z0aegbw1mIQcLSMM7arnwATrsIPNePoLxI448R+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWD6xiM7Rw1uB6gP8FzZbtvcXpjBl0xq+1HjObqbyT6rxdKJV80uhk4kwvU/VVzhpFcFAgQ/3T72Dj5YjRSRgIBtD3/FH3JvJogjZzOuOTGMgir4VV7WnNZ6LXyOn3TFdsnJy3Sf19pEknY+VEkQqVGuObliRyhDQ/doyl6YwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkupn39x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B435C4CEDD;
	Fri, 20 Dec 2024 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714826;
	bh=yn0Z0aegbw1mIQcLSMM7arnwATrsIPNePoLxI448R+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkupn39xNwsxs2fSoNmvbgM50gZituSVOGK4QMg+HuTo6GnDLu7mEAC4ceEDN8riG
	 1yZVRLRVg4BGzMCx05X+gesSB7NAb19HFzUadYfnKzSd4yjb2+yXlGo/4tCpvTfIQ6
	 RUlAqIUiLZvBZ79D6gWidBsUhg2aDwKd8p/OgwWOT+tftGhKJTkreNxeeNSzSU/zq7
	 zlzFROryZ84E/lJpfLyZp79doN2PeMq8iH7aQrvnRBRR4mZ+mUTbR3uIsuGV2UVSFv
	 c2DZhx5dJozt38fimnOTsw9tIOKnBOugRSldnljJc/yCz3dcyRQOvg4AyaUUwl+AZ+
	 5WuglYcoeceFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/12] ARC: build: Try to guess GCC variant of cross compiler
Date: Fri, 20 Dec 2024 12:13:17 -0500
Message-Id: <20241220171317.512120-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171317.512120-1-sashal@kernel.org>
References: <20241220171317.512120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.121
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
index 329400a1c355..8e6f52c6626d 100644
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


