Return-Path: <stable+bounces-134868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98325A953AA
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20863B2F2C
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC571DE884;
	Mon, 21 Apr 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWAShO0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5661D5CF2
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250087; cv=none; b=jI/Bicy2SrqEgzYjrFS5uY+niKSv3M+W5vIUdn9KgIk8hUAp1lZlevapxBdBRqQ2BZMHnVt/CZJfkOCZ9JIdHF5T5x4ufyeWqJX89YAJzNBUi2gVTfM1L4Mn0tnV6v0E9HKhaYkMhWTIXQaauqfUiGK/FIrJhyTewFMSbDwCixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250087; c=relaxed/simple;
	bh=Dm6Nr2Y8W5I2P0JDjcye60RrHBt9LuXmwvoZe5zVVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=old9lj0dUHD7h5zrI63TAIkdzne8/yFAJU4Ibc8trOj8Ig+ECdPDNasgJcU6m5ha/1IOunITc087jtebJF3yrG560bquKj2hVmKevMiLOQIKIOzY6lWF6wUSHgkqmR9s8q3ot0HQP4KG1WSav9V+vKSFjcBvegsnj80a0QqKqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWAShO0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB292C4CEE4;
	Mon, 21 Apr 2025 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745250086;
	bh=Dm6Nr2Y8W5I2P0JDjcye60RrHBt9LuXmwvoZe5zVVFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWAShO0VSwD94XHOU0rEZQMOtbYQXI0WOE4JOB1cnV/mi+TWMCyEa/348s3NIUAQ+
	 MDWKd4hvw2HIfBakC6kVwxEdg6b+oa54BOu/bPwXSYz37qBJaWSCPQ8AHVQVCO/JGU
	 qSAkD6AsEgWV/vOKOFB37bnqylwH1ZesDNVK6XB00Crfjfx5czWRZagdH4um0QFdXA
	 mMmI9eCBGhpcjXWN7ZKxtxrUDDq+DC4W7XAiONdolkmlIvoFFi/39Tdp1kCsLpICIV
	 R0ZzXbWB++50557a3SQA5mxCzRvLSysRLgbOPCAsboA4KjKS1UVVReC5eww/yGME9L
	 xON+w7Z42IT5A==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	kees@kernel.org
Subject: [PATCH 6.14] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Mon, 21 Apr 2025 08:40:59 -0700
Message-ID: <20250421154059.3248712-1-nathan@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042119-imbecile-greeter-0ce1@gregkh>
References: <2025042119-imbecile-greeter-0ce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.

CONFIG_UBSAN_INTEGER_WRAP is 'default UBSAN', which is problematic for a
couple of reasons.

The first is that this sanitizer is under active development on the
compiler side to come up with a solution that is maintainable on the
compiler side and usable on the kernel side. As a result of this, there
are many warnings when the sanitizer is enabled that have no clear path
to resolution yet but users may see them and report them in the meantime.

The second is that this option was renamed from
CONFIG_UBSAN_SIGNED_WRAP, meaning that if a configuration has
CONFIG_UBSAN=y but CONFIG_UBSAN_SIGNED_WRAP=n and it is upgraded via
olddefconfig (common in non-interactive scenarios such as CI),
CONFIG_UBSAN_INTEGER_WRAP will be silently enabled again.

Remove 'default UBSAN' from CONFIG_UBSAN_INTEGER_WRAP until it is ready
for regular usage and testing from a broader community than the folks
actively working on the feature.

Cc: stable@vger.kernel.org
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250414-drop-default-ubsan-integer-wrap-v1-1-392522551d6b@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
[nathan: Fix conflict due to lack of rename from ed2b548f1017 in stable]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.ubsan | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 1d4aa7a83b3a..37655f58b855 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,7 +118,6 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_SIGNED_WRAP
 	bool "Perform checking for signed arithmetic wrap-around"
-	default UBSAN
 	depends on !COMPILE_TEST
 	# The no_sanitize attribute was introduced in GCC with version 8.
 	depends on !CC_IS_GCC || GCC_VERSION >= 80000

base-commit: d12acd7bc3d4ca813dc2360e6f5ca6bb1682c290
-- 
2.49.0


