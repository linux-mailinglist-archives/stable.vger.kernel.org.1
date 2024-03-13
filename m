Return-Path: <stable+bounces-28083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ACF87B207
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D82827C6
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166379DD;
	Wed, 13 Mar 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI9bAHPC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3E405DF
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358786; cv=none; b=iNWV0L8pAX83SG071IVY/61nsH/BtyxEnAIjXS/FO/oaW3KCkb1CyeiUeDGlCDX7pbWFcRCETw0f8rhsx/51w2X2v5Zt0pJ558QjGHKEtYwDg0MVXl4E8HaXVUH4oLoEdM9Uky6TafEjz7BIum6JPulpflG/2Eopgvuiwk0Dqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358786; c=relaxed/simple;
	bh=hP51Mm0AciQDP+IQLyCe+K1HU+tgmUtTsBVz5z5MNlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDSzMCqL4HBKP9etoitFw/GK+xKPXDkb7zW7T6vMSaD6defsp1wk/5mbpbUtDLUnUMQpkXA2y7BZWlC31ATaSQt4Co4lKMblD6Dg+10SfwobcrHYzSnwCuT2jfQZingJ8L+Rex+jMQTzv1xmggRkOHu7yFCjiJNZvMmsmXRHfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EI9bAHPC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710358784; x=1741894784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hP51Mm0AciQDP+IQLyCe+K1HU+tgmUtTsBVz5z5MNlE=;
  b=EI9bAHPClIgFScvNHl6Y+iBcrZVJCv9P2v2ZAg1in0+i2RCib6U4qHtY
   mc9yDTqsw0j9uOmg1L7VcZ1VbcZgprx7asSw5Iv2f4QhHYlP9mg0U0Aki
   UEBS1xhqSrqbC6zVeH77hJLMhivlwmLDTg/LWP7P2sKOh7RtvQqqftbyb
   Cxgtdh2vhv8r4ikv5zUjmyB6d8TNvMSt9EALVU8Gdvis8483xFIwZ7RIe
   rZ6zIG3moeQBVmBgGqXFcbqRsxpXVc9zk+uOECdOUq4TB+gd5Rg8g0STx
   669tsG7I/7CwZh2aU0k9i+N/7SaUey/vxtmnVodhFV33rHO1xap0EWd6U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="4996555"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="4996555"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="16633361"
Received: from unknown (HELO intel.com) ([10.247.118.152])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:39:36 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Report full vm address range
Date: Wed, 13 Mar 2024 20:39:06 +0100
Message-ID: <20240313193907.95205-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9bb66c179f50 ("drm/i915: Reserve some kernel space per
vm") has reserved an object for kernel space usage.

Userspace, though, needs to know the full address range.

Fixes: 9bb66c179f50 ("drm/i915: Reserve some kernel space per vm")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
index fa46d2308b0e..d76831f50106 100644
--- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
@@ -982,8 +982,9 @@ static int gen8_init_rsvd(struct i915_address_space *vm)
 
 	vm->rsvd.vma = i915_vma_make_unshrinkable(vma);
 	vm->rsvd.obj = obj;
-	vm->total -= vma->node.size;
+
 	return 0;
+
 unref:
 	i915_gem_object_put(obj);
 	return ret;
-- 
2.43.0


