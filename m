Return-Path: <stable+bounces-58075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA607927A63
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77359B262E5
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DBA1B141D;
	Thu,  4 Jul 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nEoQnD2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39F1E861;
	Thu,  4 Jul 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107940; cv=none; b=unDL0fp3mnDF/yDkL3g4WAaSbjVLGhETo231K1L3Qw41EQhJLgF7Q2MdTUkYErIoiFDY58D8+YIltRIA1Fmvjg4jczz8+5oV8w0d/dssyIjO4MhmfXcEzogCBGlC5CAGVQfVadvVveFaKBr/y+2liJ76v7URi7uXVfWgcd14o4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107940; c=relaxed/simple;
	bh=ABMVNkvqtrZ/U1ZII4FD6j1jgFGa98djSfjOO8yic2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOcLPn+/5+2YV3CmWxJw+Q8bbe1DIZ6oDRyrZbB2hnyAyr/DTd0NlHxmmUWHGG01rc4pTh5Etbz2WlzP3T6XI+qmxTPwj+VHw1rPAfl0B6nIkhOaMPDHacDU7hlwuVkgEXfTwQYlwcGpri1LmWOBEUvuA3B6QvwTtM1hkb4M/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nEoQnD2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1963C4AF0A;
	Thu,  4 Jul 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nEoQnD2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720107938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdPYOGd7uDAvF3bTb+aC67tpnJm2eaZYe1/JFj22kaM=;
	b=nEoQnD2c9hmwTsMxhnC/R7KzPcrRe4p3eWpJm22zEM5xsztcrCDo2MtrSDL2gFpNxHVlqq
	m6xxUAsOAfqQ9bZIj2vyxGPxrfFiDnC9KdjwfEzDvCz3oCkei7jygIjNjnjWBLlOBGwCgq
	OtsE7rhXh4NwoP8JR4L0JMYJw2heJ44=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dde21d07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 15:45:38 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/4] wireguard: selftests: use acpi=off instead of -no-acpi for recent QEMU
Date: Thu,  4 Jul 2024 17:45:14 +0200
Message-ID: <20240704154517.1572127-2-Jason@zx2c4.com>
In-Reply-To: <20240704154517.1572127-1-Jason@zx2c4.com>
References: <20240704154517.1572127-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QEMU 9.0 removed -no-acpi, in favor of machine properties, so update the
Makefile to use the correct QEMU invocation.

Cc: stable@vger.kernel.org
Fixes: b83fdcd9fb8a ("wireguard: selftests: use microvm on x86")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/wireguard/qemu/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/Makefile b/tools/testing/selftests/wireguard/qemu/Makefile
index e95bd56b332f..35856b11c143 100644
--- a/tools/testing/selftests/wireguard/qemu/Makefile
+++ b/tools/testing/selftests/wireguard/qemu/Makefile
@@ -109,9 +109,9 @@ KERNEL_ARCH := x86_64
 KERNEL_BZIMAGE := $(KERNEL_BUILD_PATH)/arch/x86/boot/bzImage
 QEMU_VPORT_RESULT := virtio-serial-device
 ifeq ($(HOST_ARCH),$(ARCH))
-QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off -no-acpi
+QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off,acpi=off
 else
-QEMU_MACHINE := -cpu max -machine microvm -no-acpi
+QEMU_MACHINE := -cpu max -machine microvm,acpi=off
 endif
 else ifeq ($(ARCH),i686)
 CHOST := i686-linux-musl
@@ -120,9 +120,9 @@ KERNEL_ARCH := x86
 KERNEL_BZIMAGE := $(KERNEL_BUILD_PATH)/arch/x86/boot/bzImage
 QEMU_VPORT_RESULT := virtio-serial-device
 ifeq ($(subst x86_64,i686,$(HOST_ARCH)),$(ARCH))
-QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off -no-acpi
+QEMU_MACHINE := -cpu host -machine microvm,accel=kvm,pit=off,pic=off,rtc=off,acpi=off
 else
-QEMU_MACHINE := -cpu coreduo -machine microvm -no-acpi
+QEMU_MACHINE := -cpu coreduo -machine microvm,acpi=off
 endif
 else ifeq ($(ARCH),mips64)
 CHOST := mips64-linux-musl
-- 
2.45.2


