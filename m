Return-Path: <stable+bounces-160397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA2AFBBCD
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1197A736C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05D26563B;
	Mon,  7 Jul 2025 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXMbflxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DAF2135CE;
	Mon,  7 Jul 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917175; cv=none; b=sb/vpHpHMewmM74ZPCSIrPhMe8/jqhi5Tk2ENoD0twejXV2xWH8LmohMnOfd+g3w08YOOdeF/B/9rwvJbjx0HmggsfGczbkVWnN4GgdMA8XFiXFojiZC++bZiFrIeXceIgHrC2v1jr2LyOhDbBEcCVEB21BWY9c5RIQa6iTd1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917175; c=relaxed/simple;
	bh=vD+Zu2itQbTuNoEYx5YOHNiH1Sj1hED/r1A1/mPbDF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nz/OhmS709qvYpilF9oqXul4n67rgYTKr6u7KEyRA6T/wxLXVYy1brihuozLRLRpCNb62wQwTV83+lIjUsKzqRiV5Z+9tE8P981zKqDjlnMOnAw2v0Jaodq1vtUdTcP6+ptl5L/piSX5lo13cBFl7LxoQ/N2NcEZ6t2iygEnvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXMbflxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3713CC4CEE3;
	Mon,  7 Jul 2025 19:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751917174;
	bh=vD+Zu2itQbTuNoEYx5YOHNiH1Sj1hED/r1A1/mPbDF8=;
	h=From:Date:Subject:To:Cc:From;
	b=nXMbflxZm2eHRoBHA21zgMYOHf3a9FRcSEESAeBJUVTHl47ClDJGsKe3DIIA7zpj+
	 EuSDQCYoXWkDOxyVr1WicSnSb4cujoNmuLPyVxSThA0gZz2NO5JP+P/LHNDlKdTzJp
	 m1Ixe1lwd260HrmQwZvGo6mxY40SFIX4jTp4OALG0Rm1opToiAkKM01/N66qjh1TcX
	 fAvFJ/hUQqYGEQbvFWJ8ls/lXGfzI3vBFWgdsERCjnTz23I2v8NtVNn3WZMGDAoi63
	 Z94AVMv4ybHd5xTh5HsCRWJhsYVTmoa8mws4Lsl/yvSa8dC8KjZlz2UVJEsVrbiwRJ
	 YF+rByvr/wb+w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 07 Jul 2025 12:39:26 -0700
Subject: [PATCH] ARM: Fix allowing linker DCE with binutils < 2.36
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm-fix-dce-older-binutils-v1-1-3b5e59dc3b26@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG4ibGgC/x3M0QpAMBSA4VfRuXZqFg2vIhebHZxidIaUvLvl8
 qu//4FIwhShzR4QujjyFhKKPINhtmEiZJ8MWulKGWXQyooj3+gHwm3xJOg4nAcvEWtjK1u6Wje
 +gTTYhVL5z7v+fT+xNyabbAAAAA==
X-Change-ID: 20250707-arm-fix-dce-older-binutils-87a5a4b829d9
To: Russell King <linux@armlinux.org.uk>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Rob Landley <rob@landley.net>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=nathan@kernel.org;
 h=from:subject:message-id; bh=vD+Zu2itQbTuNoEYx5YOHNiH1Sj1hED/r1A1/mPbDF8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBk5SiU2k0On3muc5uQicD7hcN6pWTYF9+Se1Wkt9ZiQz
 RboPKm1o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEwk4w0jw6QPX94Wzzp2wPiS
 5jMrCaYl8a9udTB+8+W3vX5GsGBzzyuG/2m99/UiZcK5xPLdxK9IFv1+ubXT0Deis9ng15Yzb1I
 6WAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit e7607f7d6d81 ("ARM: 9443/1: Require linker to support KEEP within
OVERLAY for DCE") accidentally broke the binutils version restriction
that was added in commit 0d437918fb64 ("ARM: 9414/1: Fix build issue
with LD_DEAD_CODE_DATA_ELIMINATION"), reintroducing the segmentation
fault addressed by that workaround.

Restore the binutils version dependency by using
CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY as an additional condition to ensure
that CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION is only enabled with
binutils >= 2.36 and ld.lld >= 21.0.0.

Cc: stable@vger.kernel.org
Fixes: e7607f7d6d81 ("ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE")
Reported-by: Rob Landley <rob@landley.net>
Closes: https://lore.kernel.org/6739da7d-e555-407a-b5cb-e5681da71056@landley.net/
Tested-by: Rob Landley <rob@landley.net>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3072731fe09c..962451e54fdd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -121,7 +121,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD) && LD_CAN_USE_KEEP_IN_OVERLAY
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250707-arm-fix-dce-older-binutils-87a5a4b829d9

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


