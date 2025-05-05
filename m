Return-Path: <stable+bounces-140067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D84AAA4B2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0861886843
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B427AC3C;
	Mon,  5 May 2025 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUWWforv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30427AC37;
	Mon,  5 May 2025 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484019; cv=none; b=UFXSt7qe/CA4Kt/XnCB4IsfhTn+GSmQg6IwBP5LuxcqVcXtClsO6Xn2YeWXyxWcE/hP+Vm9pbuu9D1kX+R5uhYCbPNmSJm3fYWDqgkKkW6EUBWj5pWzq8RrBm/dD2eZxvzkTV3YbzNfRqzGQjvSU1eE/WUvtRDPpplyYfDga2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484019; c=relaxed/simple;
	bh=Svz4wnp7COiUCkLASvgsNelQAE+ZagYIac/R1LzByOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8Y6O3vGB4jz70wpiGJBA6HqGHSRP0zdOeIt0FVPI9oSWZS1jAvh0HrNCfm+S8qzQKUFFinK38qWhDBKlku9/oN8ekQ2g7mQh4YsQQywdqSxWIKaPAci4LS18a6edDOnH14Dm3NFimtgMn6t3mqtnL0U9rXZnx3eWhbbpDcddZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUWWforv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73054C4CEE4;
	Mon,  5 May 2025 22:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484018;
	bh=Svz4wnp7COiUCkLASvgsNelQAE+ZagYIac/R1LzByOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUWWforvhdyqYzGDp18dT+q1XHnOCVjtJdrOZ/FfG4nVK+g02HM3WgpoKJ/f6CuEA
	 syLLroLaHdOwpJw9Hi/XPa5OFrqxb3GjJ4/JzkxLdOVUw3tAyOCLEsGYJrxr3AkgOG
	 O8+D8SfgIrHSFKsFRMESdlbfMic72g25zlDy3j98vBdGhQ75NxAkvywaW08qM1qVvU
	 0TAPPk/k6fLVpKfWlO/IieJ741PiVVO5MKx3NHfJkOZnAiyMaKHz9n4ue2IuGhGzXe
	 luvrzM0wkQzgkhGpKtf04azU7CrQWXczLzfEFPoFCOsNDDnMp9TGKkjHPfPY4KaBCJ
	 0Uw4iD0mpjsxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nir Lichtman <nir@lichtman.org>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.14 320/642] x86/build: Fix broken copy command in genimage.sh when making isoimage
Date: Mon,  5 May 2025 18:08:56 -0400
Message-Id: <20250505221419.2672473-320-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Nir Lichtman <nir@lichtman.org>

[ Upstream commit e451630226bd09dc730eedb4e32cab1cc7155ae8 ]

Problem: Currently when running the "make isoimage" command there is an
error related to wrong parameters passed to the cp command:

  "cp: missing destination file operand after 'arch/x86/boot/isoimage/'"

This is caused because FDINITRDS is an empty array.

Solution: Check if FDINITRDS is empty before executing the "cp" command,
similar to how it is done in the case of hdimage.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Link: https://lore.kernel.org/r/20250110120500.GA923218@lichtman.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/genimage.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/genimage.sh b/arch/x86/boot/genimage.sh
index c9299aeb7333e..3882ead513f74 100644
--- a/arch/x86/boot/genimage.sh
+++ b/arch/x86/boot/genimage.sh
@@ -22,6 +22,7 @@
 # This script requires:
 #   bash
 #   syslinux
+#   genisoimage
 #   mtools (for fdimage* and hdimage)
 #   edk2/OVMF (for hdimage)
 #
@@ -251,7 +252,9 @@ geniso() {
 	cp "$isolinux" "$ldlinux" "$tmp_dir"
 	cp "$FBZIMAGE" "$tmp_dir"/linux
 	echo default linux "$KCMDLINE" > "$tmp_dir"/isolinux.cfg
-	cp "${FDINITRDS[@]}" "$tmp_dir"/
+	if [ ${#FDINITRDS[@]} -gt 0 ]; then
+		cp "${FDINITRDS[@]}" "$tmp_dir"/
+	fi
 	genisoimage -J -r -appid 'LINUX_BOOT' -input-charset=utf-8 \
 		    -quiet -o "$FIMAGE" -b isolinux.bin \
 		    -c boot.cat -no-emul-boot -boot-load-size 4 \
-- 
2.39.5


