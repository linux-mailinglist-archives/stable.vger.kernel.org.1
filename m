Return-Path: <stable+bounces-124098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEDBA5CFA2
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CD717B98C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F272641F0;
	Tue, 11 Mar 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtJ8QrRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7D1925AF;
	Tue, 11 Mar 2025 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722236; cv=none; b=jauUCCLTwCkmS5UId8QV9zNjB8PrfEoDri+pRrbvPdF7g+ZDK8NjYh8GY4pLwVlIbrAtCtk1fT7cZrkr44Pho17rcYzKQ3+Uuen9Wb7ahsuMU5DwyjVLC4rAwEv6CqHl5StU/XTxEGEjET/rm/yzsYgbhuPb9YmblTL8Swkf1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722236; c=relaxed/simple;
	bh=6CumdRSXH7JR76ASCBI2D6itGYdbqs/RRrbSSuL1/1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zt+VaL8x2LLV+NwMThgaU8xKAGYykuRCfQ7mtMFwEg7OKT8UTld7zRf4b6CgWePZYfNpRhHauJpwovjrg+k2uNem3qlmPYq6R8nTOQM2wbfCe9JqaF6aQzSeXTqbR7ZJ9T6DDUAzGbL3vXFz22rAeQXG/vr5kSp+G64GnNjxIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtJ8QrRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B5BC4CEE9;
	Tue, 11 Mar 2025 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722235;
	bh=6CumdRSXH7JR76ASCBI2D6itGYdbqs/RRrbSSuL1/1E=;
	h=From:Subject:Date:To:Cc:From;
	b=dtJ8QrRGG1PP7j6FoFhKm+bfdhMkba2frzhFSbOX8g2w1NZGS2XyJa5+XaXumZZpV
	 WSmIv+iZaVNENj/I/wTv8FOFabN3LpjFE5YQ2fRXPe5cKE85G/UrNCsfZqegWy5JoF
	 uU/oXQ64QfuHAfip+wSLAC9vqcnKHbZXk5RDScrQCSZLiHNB8uCBp9JtX3jo+tTzcv
	 OV5BUYTUbFcmWQvN7xy0/DwrDBdN4NuSaCLI6XknNU3ghU1wengnkrfopfpQy8Oryp
	 aRjrgU3kH8u8bg/lHh4GToTCpv22PZI6cXgWO99FAlvw/nUwFpwgC2c3gdmreGTc/i
	 i8iH+nlNB9d+A==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] ARM: Fix ARM_VECTORS with
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
Date: Tue, 11 Mar 2025 20:43:41 +0100
Message-Id: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2S0GcC/x2N0QpAQBAAf0X7bOsOF/kVeXBnseFoTyj5d5fHq
 WnmgUDCFKBOHhA6OfDmI+g0ATd1fiTkPjJkKjMq1xo7WXHgG09yxyYBLz4mXNjPJNg7wiovSmO
 VrQZjIVZ2oaj/h6Z93w+tnhrGcQAAAA==
X-Change-ID: 20250311-arm-fix-vectors-with-linker-dce-83475b0b8f5b
To: Russell King <linux@armlinux.org.uk>
Cc: Christian Eggers <ceggers@arri.de>, Arnd Bergmann <arnd@arndb.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Yuntao Liu <liuyuntao12@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6CumdRSXH7JR76ASCBI2D6itGYdbqs/RRrbSSuL1/1E=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkXJlUyCyWuT3ta8MFbRfqN5bXL3AG9EpufZe80mL/p8
 ZprUknGHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiTpGMDKfPHKsTUHnVV2C7
 5Hh1HPvUkpl/TOcu51l69v5t5srZP2IZ/meu10lad/WXl9Tc4J81TXMffVBfqBG+L+b7pf51Llv
 dalkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

Christian sent a fix [1] for ARM_VECTORS with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION that exposed a deficiency in ld.lld
with regards to KEEP() within an OVERLAY description. I have fixed that
in ld.lld [2] and added a patch before Christian's to disallow
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION when KEEP() cannot be used within
OVERLAY to keep everything working for all linkers.

[1]: https://lore.kernel.org/20250221125520.14035-1-ceggers@arri.de/
[2]: https://github.com/llvm/llvm-project/commit/381599f1fe973afad3094e55ec99b1620dba7d8c

---
Christian Eggers (1):
      ARM: add KEEP() keyword to ARM_VECTORS

Nathan Chancellor (1):
      ARM: Require linker to support KEEP within OVERLAY for DCE

 arch/arm/Kconfig                   |  2 +-
 arch/arm/include/asm/vmlinux.lds.h | 12 +++++++++---
 init/Kconfig                       |  5 +++++
 3 files changed, 15 insertions(+), 4 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250311-arm-fix-vectors-with-linker-dce-83475b0b8f5b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


