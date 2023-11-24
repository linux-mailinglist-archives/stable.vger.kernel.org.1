Return-Path: <stable+bounces-662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A47F7C07
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0683281D4E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F753A8C3;
	Fri, 24 Nov 2023 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ED8huTWx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D243A8C2;
	Fri, 24 Nov 2023 18:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA4C433C7;
	Fri, 24 Nov 2023 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849461;
	bh=ynJO5bnLuwS4t8X6H2+zBtPns0TX91E1UWe35fuDYdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ED8huTWxF4c116BV54G4bqt4HGkH4G966axRYgV0/yptRTNxOkhVZH1W5Mbj16JI6
	 92in2RHMJG4RBKxBCvpPBqVPJWYxEFgPgCrzUua5bYZHPXSdhpvvVgxTaulZFPEXpx
	 HlyIHjuYf0RThg4TTq7Wbxl7QAdBn6o8TEcaot+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 166/530] drm/i915/mtl: avoid stringop-overflow warning
Date: Fri, 24 Nov 2023 17:45:32 +0000
Message-ID: <20231124172033.130625897@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 390001d648ffa027b750b7dceb5d43f4c1d1a39e ]

The newly added memset() causes a warning for some reason I could not
figure out:

In file included from arch/x86/include/asm/string.h:3,
                 from drivers/gpu/drm/i915/gt/intel_rc6.c:6:
In function 'rc6_res_reg_init',
    inlined from 'intel_rc6_init' at drivers/gpu/drm/i915/gt/intel_rc6.c:610:2:
arch/x86/include/asm/string_32.h:195:29: error: '__builtin_memset' writing 16 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]
  195 | #define memset(s, c, count) __builtin_memset(s, c, count)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/gt/intel_rc6.c:584:9: note: in expansion of macro 'memset'
  584 |         memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
      |         ^~~~~~
In function 'intel_rc6_init':

Change it to an normal initializer and an added memcpy() that does not have
this problem.

Fixes: 4bb9ca7ee074 ("drm/i915/mtl: C6 residency and C state type for MTL SAMedia")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231016201012.1022812-1-arnd@kernel.org
(cherry picked from commit 0520b30b219053cd789909bca45b3c486ef3ee09)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_rc6.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
index 58bb1c55294c9..ccdc1afbf11b5 100644
--- a/drivers/gpu/drm/i915/gt/intel_rc6.c
+++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
@@ -584,19 +584,23 @@ static void __intel_rc6_disable(struct intel_rc6 *rc6)
 
 static void rc6_res_reg_init(struct intel_rc6 *rc6)
 {
-	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
+	i915_reg_t res_reg[INTEL_RC6_RES_MAX] = {
+		[0 ... INTEL_RC6_RES_MAX - 1] = INVALID_MMIO_REG,
+	};
 
 	switch (rc6_to_gt(rc6)->type) {
 	case GT_MEDIA:
-		rc6->res_reg[INTEL_RC6_RES_RC6] = MTL_MEDIA_MC6;
+		res_reg[INTEL_RC6_RES_RC6] = MTL_MEDIA_MC6;
 		break;
 	default:
-		rc6->res_reg[INTEL_RC6_RES_RC6_LOCKED] = GEN6_GT_GFX_RC6_LOCKED;
-		rc6->res_reg[INTEL_RC6_RES_RC6] = GEN6_GT_GFX_RC6;
-		rc6->res_reg[INTEL_RC6_RES_RC6p] = GEN6_GT_GFX_RC6p;
-		rc6->res_reg[INTEL_RC6_RES_RC6pp] = GEN6_GT_GFX_RC6pp;
+		res_reg[INTEL_RC6_RES_RC6_LOCKED] = GEN6_GT_GFX_RC6_LOCKED;
+		res_reg[INTEL_RC6_RES_RC6] = GEN6_GT_GFX_RC6;
+		res_reg[INTEL_RC6_RES_RC6p] = GEN6_GT_GFX_RC6p;
+		res_reg[INTEL_RC6_RES_RC6pp] = GEN6_GT_GFX_RC6pp;
 		break;
 	}
+
+	memcpy(rc6->res_reg, res_reg, sizeof(res_reg));
 }
 
 void intel_rc6_init(struct intel_rc6 *rc6)
-- 
2.42.0




