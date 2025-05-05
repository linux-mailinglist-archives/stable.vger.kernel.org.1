Return-Path: <stable+bounces-141139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6CAAB0C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5781B7A5E3B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11699328A61;
	Tue,  6 May 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7NRojKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F729CB49;
	Mon,  5 May 2025 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485281; cv=none; b=ILzeQVWnqs4sAS4ZWz5Sd/9mqjn8QutQxa6AO54cqm7IeuA0E4bToojlR1VUIIfhoaL8tnO283VJ1UEVwBqQ8CwGqsv1CGVC8c5ZcGcRDqNIH54ih4TjEvlHU58pOt+dngw3dwDlTz6gd4RuHNfA98t7CMmqe5U4CanjbFxcVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485281; c=relaxed/simple;
	bh=Svz4wnp7COiUCkLASvgsNelQAE+ZagYIac/R1LzByOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ivh9vhohltidVb85+5HzM8Pcii4cHKGvABcyq5WbXZtMG86e4CR2OQ2GMBgcCw3deVByyHgI+v7fESqhLWtFsYXP+nYwCBRvNfWkpCDdMbHmneHmybgybcmBZWglWVVSmNBDq6dJ+WFB5ZOznZ6/04+T8Ikk3nNvcZ1/olESRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7NRojKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1440C4CEE4;
	Mon,  5 May 2025 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485281;
	bh=Svz4wnp7COiUCkLASvgsNelQAE+ZagYIac/R1LzByOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7NRojKoPV/A/pxs5He/OQYX0z7vsNDhB4Wd5Y/TzDHUbYhJuLe60MgCVGlQUr1DB
	 FHczpphjNj8G6U7jPllzcXk/3k3Il9O6YMoYWgF9PPiL4lxtYCQpjNfD1+d1S4Lc6v
	 p3V6OZ6wpL8pITLND0561Al9qdellX83jAfljWqjWL9lyrApMbki+ZPGpKxIQj6SeD
	 YP1zYJAevaJYqj2G4hLT7LS04Tud2AwFqkTLHPtOZzpyEDdABdFvyn3o/dNPSW5Oln
	 MK53zXKA6U66p4eOlACGOw0XhTmXt5dib3tUUMTDw5YE+zCexz9gA17qzpX/cEw5EW
	 czIC23xbABbAA==
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
Subject: [PATCH AUTOSEL 6.12 251/486] x86/build: Fix broken copy command in genimage.sh when making isoimage
Date: Mon,  5 May 2025 18:35:27 -0400
Message-Id: <20250505223922.2682012-251-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


