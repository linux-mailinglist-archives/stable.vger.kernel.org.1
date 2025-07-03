Return-Path: <stable+bounces-159429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2850EAF787D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7896A168723
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71B2E54BF;
	Thu,  3 Jul 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKPInmIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83519F43A;
	Thu,  3 Jul 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554205; cv=none; b=Aw0CfsnxQmbtNeKb8FgEQIT+IdePI+RJseF4iZUOIpQXM/KQvY4xcfr3lf3+EnryRpV63mgFeusBZ+OGM2ZZ85FijY0AZSHCumebKyvb3Tv6cLhlSGNETuEbrH6yoz6qsmuJN6MR6z155pI0zoqg/WacvAOH5AVp33a25NRryTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554205; c=relaxed/simple;
	bh=U1GDE8bY40T2tT9b7uC+tAHtjqbDJK+CIe9SYGUmvN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzGCZu/aenAggKGoC6GceIflRCMGPar7+vooltckW6rwLx4L9+J9+iuJVHVGVp3DcJc9477p/3wignfgfVUqh7E3S36pkHyikaplQLSe1s1uEissQg6b0oXRsjS9FkzELPBKV6sSkuFs3K73+jGMa8E4OWd7CizUcb+KHqRLYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKPInmIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB53C4CEE3;
	Thu,  3 Jul 2025 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554205;
	bh=U1GDE8bY40T2tT9b7uC+tAHtjqbDJK+CIe9SYGUmvN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKPInmIazoXxRCjEkKThOLTcvZ+bSLQKmHTnRvTzDxgRpFTFDH0cVP7Y3mR0+yU3R
	 0nwGUqXejBSBCpdUfJIfbpMbbKv+Oy3F/CL05dty6TfiAfjZx8ftwE5NuP/tLghfWR
	 NRZxfqWKEFBUFJMY2HqVR/s32CpDaeVKg9l+9viE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 113/218] drm/i915: fix build error some more
Date: Thu,  3 Jul 2025 16:41:01 +0200
Message-ID: <20250703144000.457496089@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d02b2103a08b6d6908f1d3d8e8783d3f342555ac ]

An earlier patch fixed a build failure with clang, but I still see the
same problem with some configurations using gcc:

drivers/gpu/drm/i915/i915_pmu.c: In function 'config_mask':
include/linux/compiler_types.h:568:38: error: call to '__compiletime_assert_462' declared with attribute error: BUILD_BUG_ON failed: bit > BITS_PER_TYPE(typeof_member(struct i915_pmu, enable)) - 1
drivers/gpu/drm/i915/i915_pmu.c:116:3: note: in expansion of macro 'BUILD_BUG_ON'
  116 |   BUILD_BUG_ON(bit >

As I understand it, the problem is that the function is not always fully
inlined, but the __builtin_constant_p() can still evaluate the argument
as being constant.

Marking it as __always_inline so far works for me in all configurations.

Fixes: a7137b1825b5 ("drm/i915/pmu: Fix build error with GCOV and AutoFDO enabled")
Fixes: a644fde77ff7 ("drm/i915/pmu: Change bitmask of enabled events to u32")
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250620111824.3395007-1-arnd@kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit ef69f9dd1cd7301cdf04ba326ed28152a3affcf6)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index c43223916a1b1..5cc302ad13e16 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -111,7 +111,7 @@ static unsigned int config_bit(const u64 config)
 		return other_bit(config);
 }
 
-static u32 config_mask(const u64 config)
+static __always_inline u32 config_mask(const u64 config)
 {
 	unsigned int bit = config_bit(config);
 
-- 
2.39.5




