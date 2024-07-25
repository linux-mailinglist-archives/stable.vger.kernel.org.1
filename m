Return-Path: <stable+bounces-61768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3082493C6EB
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626511C21D95
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043C19D89F;
	Thu, 25 Jul 2024 15:59:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BD54759;
	Thu, 25 Jul 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923176; cv=none; b=DIv2cmqWj+U6PRyPzOrtdlR4yfMJKSefLgcKQ34yJnFZFXLXUrF59mzidWFH7b1msAObzhZaHNPKUcWzBFtpz6eG4TtlDDwZ8kimOENFCWFOcnrUAQhiZuOo98rpp6gKEfmnZF5GMbGXKeJ+7p3e1CGal1hsfGKlyiQEb4voRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923176; c=relaxed/simple;
	bh=gDOU6QQOrbtz6N9UbEfgvHFGXIdB4+i5OpwEQYFZphY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggGSiShcoPNgA9Gjjy1aboyH7yA2AVYzpF99Au8LmbDf9Y36aztg/1DuxhGpoyzEd/i2l/cItploi6HqekqO37USrgNafgD6UA2+utttYsqhg48qKMmhWgaNaBKlyu8svSgYK2G+gIdJpVQMdM+pPpkLeT0qiO8LeBSb0ZJ/tI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 25 Jul
 2024 18:59:29 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 25 Jul
 2024 18:59:28 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/i915/guc: prevent a possible int overflow in wq offsets
Date: Thu, 25 Jul 2024 08:59:25 -0700
Message-ID: <20240725155925.14707-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

It may be possible for the sum of the values derived from
i915_ggtt_offset() and __get_parent_scratch_offset()/
i915_ggtt_offset() to go over the u32 limit before being assigned
to wq offsets of u64 type.

Mitigate these issues by expanding one of the right operands
to u64 to avoid any overflow issues just in case.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 2584b3549f4c ("drm/i915/guc: Update to GuC version 70.1.1")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 9400d0eb682b..908ebfa22933 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -2842,9 +2842,9 @@ static void prepare_context_registration_info_v70(struct intel_context *ce,
 		ce->parallel.guc.wqi_tail = 0;
 		ce->parallel.guc.wqi_head = 0;
 
-		wq_desc_offset = i915_ggtt_offset(ce->state) +
+		wq_desc_offset = (u64)i915_ggtt_offset(ce->state) +
 				 __get_parent_scratch_offset(ce);
-		wq_base_offset = i915_ggtt_offset(ce->state) +
+		wq_base_offset = (u64)i915_ggtt_offset(ce->state) +
 				 __get_wq_offset(ce);
 		info->wq_desc_lo = lower_32_bits(wq_desc_offset);
 		info->wq_desc_hi = upper_32_bits(wq_desc_offset);

