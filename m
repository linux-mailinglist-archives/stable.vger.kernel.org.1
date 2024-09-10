Return-Path: <stable+bounces-74249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6A972E47
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3300D286994
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD718E776;
	Tue, 10 Sep 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6rLAwrq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57F18C90A;
	Tue, 10 Sep 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961252; cv=none; b=BgvBMNJaztYXvfHlZ9HI5zLz7crnTBdCR94YVtkSC9Zdy9QzIAhfmiN5EnZ0LOgCCKK9pYjkGFSQhIVDr3PIc+CMdBHj6AIAKWJTiLNC1BCNiL4g1VWM1SB5n14K/MBCQFUsm7bDzYcffvODv9xO3/RacE3xHoW7qR2evaTqcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961252; c=relaxed/simple;
	bh=1sUj+Pv6lh2GCiV6xOZK6sLJ+j6zk8joa9Ntqx/B2gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkW3Nyr1CVMyi+HsCr3fd+rnMixSIj7LmjCt8rvxzJzcNtQ5NJE4JK0FhrA/Fb1ys3mPNXpevOd0r/YiNdJKuBR74AB9cDJjwpTieNpsNIr7uOYiPKajw/HAVSoR4zeHaaiXzkzv0otP1eDhr5uQGFOIcYgBieImWApq6DPIjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6rLAwrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C55C4CEC3;
	Tue, 10 Sep 2024 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961252;
	bh=1sUj+Pv6lh2GCiV6xOZK6sLJ+j6zk8joa9Ntqx/B2gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x6rLAwrqvqHpj56WBVeAEK0pyRHJUiurRlbgEK8UhcR4j3FjtHNZN3HOoW9qW2H1Z
	 jlpgtWlL2XDrqwOFk0pCLWSr9ky7rqeNXalPTMqhVy2EPh4NjNULKN01Ky99HUoDEo
	 ax/hkXzuSs7f8phLI2wb3m0px7tCqkuwTMALWc7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 91/96] drm/i915/fence: Mark debug_fence_free() with __maybe_unused
Date: Tue, 10 Sep 2024 11:32:33 +0200
Message-ID: <20240910092545.533286435@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f99999536128b14b5d765a9982763b5134efdd79 ]

When debug_fence_free() is unused
(CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=n), it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

.../i915_sw_fence.c:118:20: error: unused function 'debug_fence_free' [-Werror,-Wunused-function]
  118 | static inline void debug_fence_free(struct i915_sw_fence *fence)
      |                    ^~~~~~~~~~~~~~~~

Fix this by marking debug_fence_free() with __maybe_unused.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Fixes: fc1584059d6c ("drm/i915: Integrate i915_sw_fence with debugobjects")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240829155950.1141978-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 8be4dce5ea6f2368cc25edc71989c4690fa66964)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_sw_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index c61e50659ed1..bcc997d217c2 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -67,7 +67,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 	debug_object_destroy(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 	debug_object_free(fence, &i915_sw_fence_debug_descr);
 	smp_wmb(); /* flush the change in state before reallocation */
@@ -105,7 +105,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 }
 
-- 
2.43.0




