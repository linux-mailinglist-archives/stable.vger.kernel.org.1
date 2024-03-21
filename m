Return-Path: <stable+bounces-28565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2298885B87
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 16:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F7FB209B4
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4286246;
	Thu, 21 Mar 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFwmgme6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686341775
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034319; cv=none; b=YIw5084AvOR6VQnLSeN0Ac2Jwt7LNOkcjfi+m7SWxubnRZjKAkjO5tR4PCJNInzEc0CAvDEvhCpAkPBM+4T0qDgEtxqbzrj29uAO0Q0lX8lLVokAeoHLF63FNiM1cglOa8rDpiO39/p3tB6eZ04kFCekfg92FJRu13jY/XQJ8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034319; c=relaxed/simple;
	bh=vTq6eMlEVlwDOrRT3eh/Y4LPJlYJFenbxEIwPcIxpYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFDkkwU8x/DamyFIyedYVl1thWMKZMCbHTaRzb9/w4XI3Pwh5Se9uJrv7ZHYuyVAufKCpDztV9Ri07T0M6EMhLUvf5f0idVVpzh04PBMFJpipA/E56mlhzsex+JMKomiwKb//Hr51Pa5q6syXgovJrj5vA6n5HNYs5HnRAuRO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFwmgme6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711034318; x=1742570318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vTq6eMlEVlwDOrRT3eh/Y4LPJlYJFenbxEIwPcIxpYQ=;
  b=UFwmgme66tdUMNeXjr6SqEpzI3nz+G3xdb25BSnbnQdI2hQgg1hviAp5
   opn/BwpZ34WfgIiiMTI6ijw7ZH8e3jwp8NQjV1R9tcMG1CHra3WMPJHQz
   3tcSurHnTVXLzIFBP96hQ3Uj6+0/4DW5501jiDnMJMSwKoUVipIkzthMH
   YsTw5P44OlxAZQcv0StDS3TS5xNLkclIXH7c+qWGGVDBZERZ99zdeguQ/
   jo8hCfP71RHbNsjah/nrNgkoOEZdtu259zM5GSWbBEbiujEgw50v6Rn1+
   9YOeuzujOkQqkOguEkdH6o48wEJ2CnX5efYzOVbsPAs0hCkmyi65aPYeu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9813521"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="9813521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 08:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="51976905"
Received: from unknown (HELO intel.com) ([10.247.118.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 08:18:30 -0700
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
Subject: [PATCH v2] drm/i915/gt: Report full vm address range
Date: Thu, 21 Mar 2024 16:17:26 +0100
Message-ID: <20240321151726.207866-1-andi.shyti@linux.intel.com>
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

In the former patch the reserved space was substructed from the
total amount of the VM space. Add it back when the user requests
the GTT size through ioctl (I915_CONTEXT_PARAM_GTT_SIZE).

Fixes: 9bb66c179f50 ("drm/i915: Reserve some kernel space per vm")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
---
Hi,

Just proposing a different implementation that doesn't affect
i915 internally but provides the same result. Instead of not
substracting the space during the reservation, I add it back 
during the ioctl call.

All the "vm->rsvd.vma->node.size" looks a bit ugly, but that's
how it is. Maybe a comment can help to understand better why
there is this addition.

I kept the Ack from Michal and Lionel, because the outcome from
userspace perspactive doesn't really change.

Andi

 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 81f65cab1330..60d9e7fe33b3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -2454,7 +2454,7 @@ int i915_gem_context_getparam_ioctl(struct drm_device *dev, void *data,
 	case I915_CONTEXT_PARAM_GTT_SIZE:
 		args->size = 0;
 		vm = i915_gem_context_get_eb_vm(ctx);
-		args->value = vm->total;
+		args->value = vm->total + vm->rsvd.vma->node.size;
 		i915_vm_put(vm);
 
 		break;
-- 
2.43.0


