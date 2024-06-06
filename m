Return-Path: <stable+bounces-48641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094518FE9E2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9897C289DC8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9C19CD0A;
	Thu,  6 Jun 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8hEip5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80569198E6F;
	Thu,  6 Jun 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683075; cv=none; b=M6ov/ju6iKjU5/K2CasYSBOODI5y4cFlNlEq8tcF67+JQu89xFSMzhArZpjra5ua/LN9XiVhIJFtbtVZLAVZPVBFZEt/VPLOrUzR/CHXNTRHPQU/SPgTaSLJ4hcWNs+2ZeG2TUP2kMqtI0iOgMuB2gD9aw+N7KnDFpBgHoCfyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683075; c=relaxed/simple;
	bh=mfYylneTSlSZYnaqXQEm/tMwR/v8LBkEjGmjrYgAbDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiKweSsAGb3Yz0ZNqbqSb1pZjoJA4Pv7RjqeCdhvixZ+65Pws/18vfJMDBt2eXUZaDsVlEgITvPoZyV2MXr3ls2265NlhnXQGney8/ZtGOE13agPcpoydC18OhL42CJscnX/2ORv4+KBEVX0IYpVZATUsUHWyD9BxkkhKf6fs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8hEip5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6158DC4AF08;
	Thu,  6 Jun 2024 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683075;
	bh=mfYylneTSlSZYnaqXQEm/tMwR/v8LBkEjGmjrYgAbDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8hEip5zcrjH7Zu4fL5Nr3LLztI7/Apu9z0tlhWde5c/Y1Dr9JjY7gbAQQrsGRPBZ
	 VzsPWr6kT31OxD1CRTLoRs2okdAaOccgLWPyo8AfvDsV5iLaGBq2YfL+VtjlJNAOGO
	 VZJkHTy/GH+QUpZs4siKL5gCXqX/0fmyS7LCksKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 341/374] drm/i915/guc: avoid FIELD_PREP warning
Date: Thu,  6 Jun 2024 16:05:20 +0200
Message-ID: <20240606131703.287174590@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d4f36db62396b73bed383c0b6e48d36278cafa78 ]

With gcc-7 and earlier, there are lots of warnings like

In file included from <command-line>:0:0:
In function '__guc_context_policy_add_priority.isra.66',
    inlined from '__guc_context_set_prio.isra.67' at drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3292:3,
    inlined from 'guc_context_set_prio' at drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3320:2:
include/linux/compiler_types.h:399:38: error: call to '__compiletime_assert_631' declared with attribute error: FIELD_PREP: mask is not constant
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
...
drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2422:3: note: in expansion of macro 'FIELD_PREP'
   FIELD_PREP(GUC_KLV_0_KEY, GUC_CONTEXT_POLICIES_KLV_ID_##id) | \
   ^~~~~~~~~~

Make sure that GUC_KLV_0_KEY is an unsigned value to avoid the warning.

Fixes: 77b6f79df66e ("drm/i915/guc: Update to GuC version 69.0.3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Julia Filipchuk <julia.filipchuk@intel.com>
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240430164809.482131-1-julia.filipchuk@intel.com
(cherry picked from commit 364e039827ef628c650c21c1afe1c54d9c3296d9)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
index 58012edd4eb0e..4f4f53c42a9c5 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
@@ -29,9 +29,9 @@
  */
 
 #define GUC_KLV_LEN_MIN				1u
-#define GUC_KLV_0_KEY				(0xffff << 16)
-#define GUC_KLV_0_LEN				(0xffff << 0)
-#define GUC_KLV_n_VALUE				(0xffffffff << 0)
+#define GUC_KLV_0_KEY				(0xffffu << 16)
+#define GUC_KLV_0_LEN				(0xffffu << 0)
+#define GUC_KLV_n_VALUE				(0xffffffffu << 0)
 
 /**
  * DOC: GuC Self Config KLVs
-- 
2.43.0




