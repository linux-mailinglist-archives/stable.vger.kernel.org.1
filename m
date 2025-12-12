Return-Path: <stable+bounces-200858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF5CB7F6C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 06:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A9530528E7
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 05:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EFA19CC0C;
	Fri, 12 Dec 2025 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="aFf0tkfk"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897BF4F1
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765518415; cv=none; b=qGMlMVl6E/cWwWfqPz2QtNVnIt9oAIm/HwuRXr6A/swwfMKa5kZF6y9M0/TFosSD4BddnUdsFlB28QyPSfRpXVmoklcBIOYi/WNqcBZnhXO6vbcBpOXadNhIPjxauGF/2A9Sl7l4NN5Cau+p/Cmw7FPW8r3BIkONw7wHDn5+bEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765518415; c=relaxed/simple;
	bh=6Yxj5yO7qoVWNbxTKD4RxScX3CYpaVNO7VaM9SSPbMM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JQk44Bta1au5VdxoeVzCT518AEXywTHrLYfo8x4XztsbIlFk7gyxoOZWa75tWcw3UwkIroaaqMp671z4CaziRrhXB/u3H3kqi/hh8Dmpgu1QaVUpfXaG3P7e/zmBAM60bNhZU79WEPjjdDASk6XG29OU/oXUu1Xz+EqJmVzS+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=aFf0tkfk; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=aFf0tkfkpptftY4wrrPqjanN/tHIsiK9GUATXVHO0SSw9a/3tN0e9zOyJMgV8HnfZEGdv2IN/G7bW
	 rRFTK8kO7MUBg/Hny787f0LrubReC2pV5R9f9Bw24RH/vkmEkDYnjjuvOIMbZwFiTXqFd1sEKPZWvY
	 yl23oqADBy6AY8/0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.245.185])
	by rmsmtp-lg-appmail-36-12050 (RichMail) with SMTP id 2f12693bac3df7c-453a1;
	Fri, 12 Dec 2025 13:46:40 +0800 (CST)
X-RM-TRANSID:2f12693bac3df7c-453a1
From: Rajani Kantha <681739313@139.com>
To: andrzej.hajda@intel.com,
	andi.shyti@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15] drm/i915/selftests: fix subtraction overflow bug
Date: Fri, 12 Dec 2025 13:46:33 +0800
Message-Id: <20251212054633.2127-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Andrzej Hajda <andrzej.hajda@intel.com>

[ Upstream commit ab3edc679c552a466e4bf0b11af3666008bd65a2 ]

On some machines hole_end can be small enough to cause subtraction
overflow. On the other side (addr + 2 * min_alignment) can overflow
in case of mock tests. This patch should handle both cases.

Fixes: e1c5f754067b59 ("drm/i915: Avoid overflow in computing pot_hole loop termination")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3674
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220624113528.2159210-1-andrzej.hajda@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ Using I915_GTT_PAGE_SIZE instead of min_alignment due to 5.15 missing commit:87bd701ee268 ("drm/i915: enforce min GTT alignment for discrete cards")]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index df3934a990d0..cd0494b84959 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -715,7 +715,7 @@ static int pot_hole(struct i915_address_space *vm,
 		u64 addr;
 
 		for (addr = round_up(hole_start + I915_GTT_PAGE_SIZE, step) - I915_GTT_PAGE_SIZE;
-		     addr <= round_down(hole_end - 2*I915_GTT_PAGE_SIZE, step) - I915_GTT_PAGE_SIZE;
+		     hole_end > addr && hole_end - addr >= 2 * I915_GTT_PAGE_SIZE;
 		     addr += step) {
 			err = i915_vma_pin(vma, 0, 0, addr | flags);
 			if (err) {
-- 
2.17.1



