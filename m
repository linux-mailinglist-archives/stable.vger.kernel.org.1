Return-Path: <stable+bounces-105498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC239F9834
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC311633AA
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9870236F8B;
	Fri, 20 Dec 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZBYosb7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAD236F85;
	Fri, 20 Dec 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714846; cv=none; b=TACy75/6k8gT0IogEXj1HzoQt91hMbBaoD89xCLR74YiiYNuX7HdTvhL5rtvF/cQud8bVCuH8uDSDLVrbf5nXOzrdhCj3uhWOuE+bzHO14ClJ86hPHBle94DAaRLanrZ6UJAAAwn4wRlZQdlDz5dx2Clxaw37806Ds2Nuu2dnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714846; c=relaxed/simple;
	bh=sEQTWj4HR8HWZedc1zbWiSWdQRj2vhJ8wMiBQ22nxcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kayrpIkvpdhO66bFR6NDS9is9kX3lUPKJubKE71gWAs8DpQJ5Sis15JXxFcafmsgMzbVkoB25gq7tY6hYEhp0zZlP772+I2JRGDrQFazKmJKpPqq5SmXBBjD0x9J1ZGuo2NPPqUVdgeg340n3qwPrXdV7LAUuPjSvYRP1kMg5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZBYosb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79910C4CECD;
	Fri, 20 Dec 2024 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714846;
	bh=sEQTWj4HR8HWZedc1zbWiSWdQRj2vhJ8wMiBQ22nxcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZBYosb72XB1VE4fehqN4e+OIJf7YoOkAmQ53TgbYAEEquHgr3PT5xvzXeWH8JLX4
	 azuW7862U2fOYorDmSQvEInbtP5EMpiMIFuUUulLJaDoVrtaNloVBsa7QBinN7EjuE
	 UO8RYS+4rchAMjSxLus8XoxGpgXjZCzd6C551c7yiWfrqM4Dwxkmp0opf9W/kGv1ZB
	 phgFcyVrPV/+kYlgu6EtIeH8jcnqs8M/59s9gi8EbEi4SzhqroWdenYYjj2j/dDUMx
	 kp+jqyrAa9RLTo2djS0ss9oDOybTAKRkflYH+RjYMuGfI0EV/DUpnPrmcrsz+FAa+V
	 yaTUA+YvCrjjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 9/9] ARC: build: Try to guess GCC variant of cross compiler
Date: Fri, 20 Dec 2024 12:13:47 -0500
Message-Id: <20241220171347.512287-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171347.512287-1-sashal@kernel.org>
References: <20241220171347.512287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
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
index 8782a03f24a8..60b7a7723b1e 100644
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


