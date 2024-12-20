Return-Path: <stable+bounces-105505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1629F983D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7BD7A42CB
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2D239BC7;
	Fri, 20 Dec 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH7801Zv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CAD22069E;
	Fri, 20 Dec 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714860; cv=none; b=siE283KZYdhlV7L4UeNRpzEv4cnApK4KlLLQjH2WfFw5hDHeimH6MC9QByxXasqR4817AaF1oa4JHmCF8i2t6pAgDVdzB3O7RYVmOh1xeEgDfM/tTTW3sS7ITG794bABqJORh+tdKhNGh+kAymdv2+WUJa6836UoQre+oevDzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714860; c=relaxed/simple;
	bh=cK40Yh5l8+Qul7VYoKGGByl+MrG6zQ4WpNS33BHo8pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQeKVZcLj1LgXnB7ZttciJGdDXBbOrAHgpRwB22+SYXw+5YlV7jhcd8XC1H1VJSyUT1jVIRBwGHhHMWlIb6a6T902miZlJniqPedWTH2DKyCpvb+PyHREo41L/gOoA4OLMGOpgxqSkuK1IdCQPaBETNWBBqvj4GbgJQoBSrQhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH7801Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F376C4CEDC;
	Fri, 20 Dec 2024 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714859;
	bh=cK40Yh5l8+Qul7VYoKGGByl+MrG6zQ4WpNS33BHo8pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WH7801ZvNsc1j2vpSjlTbjZ7nCETjHo5TDF1TRwAFZt7I2OAFfiv7vsDnbiI1H60B
	 UEUnhBPWmekjkyVJcHPO3y9sMyamfMv2YBy4JwtrR5//UgOxiGZ9i/UQWmFjbzycnU
	 vJdnr5Ng1muMevmjhgYt0NBZ5GpKAr4lzyy/95SzwkIw+BZXtiKE3mhERb971MbpUA
	 6FrXAqoV0f5cMq8ps0uy1plXkFfQU+VYVLHQRJpd9hkZisQrmIx3SGKyIyfWt5Oo9w
	 iBRIxYIERMpCIDk/qFfp/HAyl12gseV6+S+om9Tpf3A9ZUnqln7CLiED3u7mOYxbct
	 7GoZxq0f8EbBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/7] ARC: build: Try to guess GCC variant of cross compiler
Date: Fri, 20 Dec 2024 12:14:06 -0500
Message-Id: <20241220171406.512413-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171406.512413-1-sashal@kernel.org>
References: <20241220171406.512413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.232
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
index 578bdbbb0fa7..18f4b2452074 100644
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


