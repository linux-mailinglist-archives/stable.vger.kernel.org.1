Return-Path: <stable+bounces-162857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097A7B06042
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3035A0FCD
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1072E7BB2;
	Tue, 15 Jul 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1c2yvHWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB842E5B39;
	Tue, 15 Jul 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587658; cv=none; b=J6MBg9y59hTjX01kwqT5IrLIINn4Hxt0AAVkNdhwNNTfffcQ65tAwHlga+j2iJHFilnYmK2eyQMEqqsiSQXrwv6d7qMCJTDKfQ6+cDK2At/f9V3Cr7qwOPuAPubYUm/HQMUVVoDMa4sHxzeIdxuYAGiEFrFZWmcTN8CEeKIw62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587658; c=relaxed/simple;
	bh=7NNwaxDLLRkcf4D4SuY7SCyqaYwtJt0HFsEI9IKJ4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz9Na32KqpUgbybdTB8Pwy3MGWA9YU0s+5B+ZwBvKSwBt1yegSZ4ZDLbtwEMfWDjnEWVJXGtdvV5cNkqMb8zplDm0pSoRvlWdWmadWRH5cAJshM0nbvAfW666zB457FUCIU6D9nQYkkp5nNxAJNJd0vwKQLHS/h4og6t+YSNv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1c2yvHWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50039C4CEE3;
	Tue, 15 Jul 2025 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587657;
	bh=7NNwaxDLLRkcf4D4SuY7SCyqaYwtJt0HFsEI9IKJ4ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1c2yvHWKJeIUWMASnDsuF2uTI6T7T8cystRnD1OrEDzR8OUJxwvS1pBHJi+4DG7Dx
	 uVHYUIRVBJKiGw6nIBq8ZCN2Jci65M/dNhm43CVd1GoMuUkmJrdzLhp2v7Ukw3bM3V
	 YKKefmvWT6Zzp4V+XaUTajTvfwKC2ewEiKaBVQNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 093/208] drm/i915/gt: Fix timeline left held on VMA alloc error
Date: Tue, 15 Jul 2025 15:13:22 +0200
Message-ID: <20250715130814.668069333@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

[ Upstream commit a5aa7bc1fca78c7fa127d9e33aa94a0c9066c1d6 ]

The following error has been reported sporadically by CI when a test
unbinds the i915 driver on a ring submission platform:

<4> [239.330153] ------------[ cut here ]------------
<4> [239.330166] i915 0000:00:02.0: [drm] drm_WARN_ON(dev_priv->mm.shrink_count)
<4> [239.330196] WARNING: CPU: 1 PID: 18570 at drivers/gpu/drm/i915/i915_gem.c:1309 i915_gem_cleanup_early+0x13e/0x150 [i915]
...
<4> [239.330640] RIP: 0010:i915_gem_cleanup_early+0x13e/0x150 [i915]
...
<4> [239.330942] Call Trace:
<4> [239.330944]  <TASK>
<4> [239.330949]  i915_driver_late_release+0x2b/0xa0 [i915]
<4> [239.331202]  i915_driver_release+0x86/0xa0 [i915]
<4> [239.331482]  devm_drm_dev_init_release+0x61/0x90
<4> [239.331494]  devm_action_release+0x15/0x30
<4> [239.331504]  release_nodes+0x3d/0x120
<4> [239.331517]  devres_release_all+0x96/0xd0
<4> [239.331533]  device_unbind_cleanup+0x12/0x80
<4> [239.331543]  device_release_driver_internal+0x23a/0x280
<4> [239.331550]  ? bus_find_device+0xa5/0xe0
<4> [239.331563]  device_driver_detach+0x14/0x20
...
<4> [357.719679] ---[ end trace 0000000000000000 ]---

If the test also unloads the i915 module then that's followed with:

<3> [357.787478] =============================================================================
<3> [357.788006] BUG i915_vma (Tainted: G     U  W        N ): Objects remaining on __kmem_cache_shutdown()
<3> [357.788031] -----------------------------------------------------------------------------
<3> [357.788204] Object 0xffff888109e7f480 @offset=29824
<3> [357.788670] Allocated in i915_vma_instance+0xee/0xc10 [i915] age=292729 cpu=4 pid=2244
<4> [357.788994]  i915_vma_instance+0xee/0xc10 [i915]
<4> [357.789290]  init_status_page+0x7b/0x420 [i915]
<4> [357.789532]  intel_engines_init+0x1d8/0x980 [i915]
<4> [357.789772]  intel_gt_init+0x175/0x450 [i915]
<4> [357.790014]  i915_gem_init+0x113/0x340 [i915]
<4> [357.790281]  i915_driver_probe+0x847/0xed0 [i915]
<4> [357.790504]  i915_pci_probe+0xe6/0x220 [i915]
...

Closer analysis of CI results history has revealed a dependency of the
error on a few IGT tests, namely:
- igt@api_intel_allocator@fork-simple-stress-signal,
- igt@api_intel_allocator@two-level-inception-interruptible,
- igt@gem_linear_blits@interruptible,
- igt@prime_mmap_coherency@ioctl-errors,
which invisibly trigger the issue, then exhibited with first driver unbind
attempt.

All of the above tests perform actions which are actively interrupted with
signals.  Further debugging has allowed to narrow that scope down to
DRM_IOCTL_I915_GEM_EXECBUFFER2, and ring_context_alloc(), specific to ring
submission, in particular.

If successful then that function, or its execlists or GuC submission
equivalent, is supposed to be called only once per GEM context engine,
followed by raise of a flag that prevents the function from being called
again.  The function is expected to unwind its internal errors itself, so
it may be safely called once more after it returns an error.

In case of ring submission, the function first gets a reference to the
engine's legacy timeline and then allocates a VMA.  If the VMA allocation
fails, e.g. when i915_vma_instance() called from inside is interrupted
with a signal, then ring_context_alloc() fails, leaving the timeline held
referenced.  On next I915_GEM_EXECBUFFER2 IOCTL, another reference to the
timeline is got, and only that last one is put on successful completion.
As a consequence, the legacy timeline, with its underlying engine status
page's VMA object, is still held and not released on driver unbind.

Get the legacy timeline only after successful allocation of the context
engine's VMA.

v2: Add a note on other submission methods (Krzysztof Karas):
    Both execlists and GuC submission use lrc_alloc() which seems free
    from a similar issue.

Fixes: 75d0a7f31eec ("drm/i915: Lift timeline into intel_context")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12061
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Reviewed-by: Nitin Gote <nitin.r.gote@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20250611104352.1014011-2-janusz.krzysztofik@linux.intel.com
(cherry picked from commit cc43422b3cc79eacff4c5a8ba0d224688ca9dd4f)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_ring_submission.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 6aaca73eaee60..af57192a7846f 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -576,7 +576,6 @@ static int ring_context_alloc(struct intel_context *ce)
 	/* One ringbuffer to rule them all */
 	GEM_BUG_ON(!engine->legacy.ring);
 	ce->ring = engine->legacy.ring;
-	ce->timeline = intel_timeline_get(engine->legacy.timeline);
 
 	GEM_BUG_ON(ce->state);
 	if (engine->context_size) {
@@ -591,6 +590,8 @@ static int ring_context_alloc(struct intel_context *ce)
 			__set_bit(CONTEXT_VALID_BIT, &ce->flags);
 	}
 
+	ce->timeline = intel_timeline_get(engine->legacy.timeline);
+
 	return 0;
 }
 
-- 
2.39.5




