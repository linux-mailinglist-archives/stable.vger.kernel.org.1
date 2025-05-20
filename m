Return-Path: <stable+bounces-145041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B2ABD2A0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F67A4479
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC10263898;
	Tue, 20 May 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYIPSvLu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB825DCF6;
	Tue, 20 May 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731659; cv=none; b=rqiH/fSjZE5QSbK5IZhzIwjCqu/HUAz7QYCAc0NXwse3kjRlah4PJqXPSOC4AGpPCuYRZuG1fEoLopCc8rQcBW6H5GKHajRZecVYo2qAnpRQ+O3vx27VxJel7OKAfmzXKRirlx967qI8mtfjr8DFffDYmGyQZIjc4I62AUgsIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731659; c=relaxed/simple;
	bh=Sbd+zJnx+HI1egmkPtFbJtHU98+ZalvESNI2kyat2sU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+I4EtNYvcAD81QiaK7mBc6HCkD9RYt2KZz441Jxz9xsYWxzy5jEjJguXPpTuzvSuuSNCA8lOsQ1CT+B6Knpu2KwaDgJg9P5w8VeRxwJqVorkj5V7zAkfZGv25we/RbAgTlynRieOv0KKneJwE169DL6Q4C+sYODso7VEFcDqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYIPSvLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FDBC4CEE9;
	Tue, 20 May 2025 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747731658;
	bh=Sbd+zJnx+HI1egmkPtFbJtHU98+ZalvESNI2kyat2sU=;
	h=From:To:Cc:Subject:Date:From;
	b=NYIPSvLuMdYWWajIZ2CmvF/UcHeuvn9cntCXh+UQvEWrr0/pVo3Vf3wfuN4cnNtpD
	 xL1nmdVhiuOHFk2amsQI5u2HjNcffHeESB9FNt71RntcI/BgXSyJ2GkbCeF3NeS0Pk
	 YSzyLpxMY4LIbiTMlN8BnaqdVK2eTJb+SGx2JT1laNvjT1FXcxNvIBJiMDZhEz21/8
	 if/2f8bC8ROBvkuQF9Tyj5U5IURi3KNkTPbY1LiXwro8HGN0U3Wxo9cu8rm6fMAZEQ
	 fSjCw6qWmCrjJbbf36rpuIRMSJchlno5X7/bDwRmhiWIOQSVVLVkeYsdaDOZi5DrFI
	 kNMDSzVm3RWGw==
From: Arnd Bergmann <arnd@kernel.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	stable@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: fix building with gcc-15
Date: Tue, 20 May 2025 11:00:46 +0200
Message-Id: <20250520090051.4058923-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The decompressor is built with the default C dialect, which is now gnu23
on gcc-15, and this clashes with the kernel's bool type definition:

In file included from include/uapi/linux/posix_types.h:5,
                 from arch/parisc/boot/compressed/misc.c:7:
include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
   11 |         false   = 0,

Add the -std=gnu11 argument here, as we do for all other architectures.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 92227fa813dc..17c42d718eb3 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -18,6 +18,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
+KBUILD_CFLAGS += -std=gnu11
 
 LDFLAGS_vmlinux := -X -e startup --as-needed -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(addprefix $(obj)/, $(OBJECTS)) $(LIBGCC) FORCE
-- 
2.39.5


