Return-Path: <stable+bounces-158248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D8AE5AF5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381837AC477
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 04:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09322F74D;
	Tue, 24 Jun 2025 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClvpBdvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FC2222A9;
	Tue, 24 Jun 2025 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738316; cv=none; b=JeXAWgZdh0peHIZVdve6RH6aut91mbqmpv5J1PokfU0/qN5+U+S0nV6eChIy4VcLXXd5V+lRBwqE1XhuWKRSJ2AEGDGkOpmDoMTHfDEloGU9HjHN98TRDBjYphYD2TWzrYL1epTzDr6qufOV+qSeK9khEittce2dMSl/jBW4cGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738316; c=relaxed/simple;
	bh=PUbBgl1S7yccJqzpc7ZYep/VMsO951so4rQQUqrHD5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXQeTk464l4f19ssjxJt4hgr7jw5m/GEZDbCOT3TAlhj68KWucLd6iwf8TqXACEGG1YrBJZjFEGVLhxR7AksDT0eHNPdPQW/3b8llHd9/+46H3mKocylhNji0z98p3zCarXgU+avCyr8f4b44UaUs+Dr4s0y3MUvND6sVQZW0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClvpBdvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7660C4CEEF;
	Tue, 24 Jun 2025 04:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738316;
	bh=PUbBgl1S7yccJqzpc7ZYep/VMsO951so4rQQUqrHD5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClvpBdvQYgpbcBy+x2p8yleUZuQlisxBlIyZgSYUNdtxdcSm2f5+nCFisa1a74PO0
	 zclYOHeyS8s07PKEub1ytSiRAKBIcSPzQ7FWj4IGthgr2d2DkniNcAlhRScIYji1kr
	 g3srpJdqqzZ6DEKHHu1muuFg7AYLd44ifsOyw+EjeEsGKu6WU9uiVgDYPI6WDb3YAW
	 vsFQ9pY3h5l7KEuiLqQ5SH2SIolsRyu2psyoZyOOtQlDg0qV541ehETU3QSIZE+QS8
	 +mPEl0TLre1x9+tVM2wK5Zy9MUkEQzMfjAB/EXPewqmcKIRWgqXy+i7Cq7ez8r5URG
	 G64ky+csrogyg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/19] ata: pata_cs5536: fix build on 32-bit UML
Date: Tue, 24 Jun 2025 00:11:35 -0400
Message-Id: <20250624041149.83674-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041149.83674-1-sashal@kernel.org>
References: <20250624041149.83674-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.34
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit fe5b391fc56f77cf3c22a9dd4f0ce20db0e3533f ]

On 32-bit ARCH=um, CONFIG_X86_32 is still defined, so it
doesn't indicate building on real X86 machines. There's
no MSR on UML though, so add a check for CONFIG_X86.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20250606090110.15784-2-johannes@sipsolutions.net
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **It fixes a build failure**: The commit addresses a build breakage
   on 32-bit UML (User Mode Linux) where `CONFIG_X86_32` is defined but
   MSR (Machine Specific Register) support is not available. This
   prevents successful compilation when building for 32-bit UML.

2. **The fix is minimal and contained**: The change is a simple one-line
   modification that adds an additional check for `CONFIG_X86` alongside
   the existing `CONFIG_X86_32` check. The change from:
  ```c
  #ifdef CONFIG_X86_32
  ```
  to:
  ```c
  #if defined(CONFIG_X86) && defined(CONFIG_X86_32)
  ```
  This ensures MSR usage is only enabled on real x86 hardware, not on
  UML.

3. **Similar pattern to other backported fixes**: Looking at the similar
   commits, we see that:
   - Commit #1 (pata_cs5535 + UML) was backported (YES) - it added
     `depends on !UML` to prevent build issues
   - Commit #2 (dmaengine: idxd + UML) was backported (YES) - similar
     UML build fix

   These show a pattern where UML build fixes are considered important
for stable backporting.

4. **No functional changes for normal users**: The fix only affects
   build configurations and doesn't change any runtime behavior for
   users running on actual x86 hardware. This minimizes regression risk.

5. **Prevents allyesconfig/allmodconfig breakage**: As seen in similar
   commits, UML build failures can break comprehensive kernel build
   tests (allyesconfig/allmodconfig), which are important for continuous
   integration and testing.

6. **The issue affects a subsystem driver**: While pata_cs5536 is a
   specific driver for older AMD CS5536 hardware, build failures in any
   driver can impact kernel testing infrastructure and distributions
   that build comprehensive kernel packages.

The commit follows the stable tree rules by being a minimal, focused fix
for an actual bug (build failure) with very low risk of introducing new
issues.

 drivers/ata/pata_cs5536.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index b811efd2cc346..73e81e160c91f 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -27,7 +27,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/dmi.h>
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86) && defined(CONFIG_X86_32)
 #include <asm/msr.h>
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
-- 
2.39.5


