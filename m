Return-Path: <stable+bounces-65474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D4B948C1D
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6BE1F248F8
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162A1BDA80;
	Tue,  6 Aug 2024 09:23:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41291607BD;
	Tue,  6 Aug 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936195; cv=none; b=p22dXJwLp3vUU2M8mBW8rN17iCBYA6Ni/tlPS8g+03hKZitVTIO1DJ9aUWPgz03+v13mqTqcVSDWH02owv2h/4TFlZqcA3Rx+ZXzo2MpqKkKWclig1zLOfOWzx+SqZEEqAZ+bO9bIRLyF1HAxfjfPwx9WcWLPmRRckZTr9s7+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936195; c=relaxed/simple;
	bh=1nZEE/R5Jbb3keFbXoWB0AAm+u6TPnfskG8wpL9BoyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qQ0xaDTvkBTY3+twpppJ+Skh6CL3MsgEVSBLxIwafuQ4WSZEGcaSY7Rmxw1I5hOyjEszacSWjGCwZd0IE1/AjT0RAr6ePKll9Wo7H/Am7CduLUvSDmPMJariUa3BCjfMUyGtZwrLkZlta4XVhQs5IM0goh6O4g4Ten7IIqjp2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABXfQBq67Fm3g3cAw--.39396S2;
	Tue, 06 Aug 2024 17:22:57 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	ville.syrjala@linux.intel.com,
	stanislav.lisovskiy@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915: Fix NULL ptr deref in intel_async_flip_check_uapi()
Date: Tue,  6 Aug 2024 17:22:49 +0800
Message-Id: <20240806092249.2407555-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXfQBq67Fm3g3cAw--.39396S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy3JF48Aw4UCF1rury3Jwb_yoWkKrgEgF
	1UArnayry5AFs0va17Crs3uFyFka4qvFWxZ340qa4ava42k348u3yfur1rWw1S9FyjyrWU
	Za1jgF92kwsa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

intel_atomic_get_new_crtc_state can return NULL, unless crtc state wasn't
obtained previously with intel_atomic_get_crtc_state. We should check it
for NULLness here, just as in many other places, where we can't guarantee
that intel_atomic_get_crtc_state was called.

Cc: stable@vger.kernel.org
Fixes: b0b2bed2a130 ("drm/i915: Check async flip capability early on")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index c2c388212e2e..9dd7b5985d57 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6115,7 +6115,7 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
 		return -EINVAL;
 	}
 
-	if (intel_crtc_needs_modeset(new_crtc_state)) {
+	if (new_crtc_state && intel_crtc_needs_modeset(new_crtc_state)) {
 		drm_dbg_kms(&i915->drm,
 			    "[CRTC:%d:%s] modeset required\n",
 			    crtc->base.base.id, crtc->base.name);
-- 
2.25.1


