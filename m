Return-Path: <stable+bounces-20824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9CA85BEE6
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965EC286C46
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED52667C61;
	Tue, 20 Feb 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrFMxz88"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B562C6AA
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439747; cv=none; b=DuM+HtZuxhf9fWh7nLtLGXhKiBmy+FzcmF01PnAje6Rvz225K4omgZQu4SkEJztlVY1pNYDlgIQmrWLcCmn98o3IgnYpdOOa8ZNwIPIno7vwAacd3ftnOJ/bTl/SnJjRXvmRFBOOPJ4HjODnqGfcThk9MtcvrOamAi1p9YM33bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439747; c=relaxed/simple;
	bh=L5rCQTAbVFRIicT6ICpuZqDXkISjg9xUW9pkXiUreuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+VSiyIFOABniT9hZZor+AcSg8/mazmMYQ05Sz17U8LgxFvvg5dNRjSM4I5YKc8ddDVMESboXyvdES0P97wt4GQ5PqlNQqLNfuFvaKtXW9j7H5JtLyAcPjnDaQbRMaBmx/m4sTVIwYBnUEAJZB8HJ+NIbWtIOvkPZpRepoqonnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrFMxz88; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439745; x=1739975745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L5rCQTAbVFRIicT6ICpuZqDXkISjg9xUW9pkXiUreuE=;
  b=HrFMxz88hrfrx1uXUraPhQnP2YHn1+PgxK2h3krilZ8j9jy5fnoaaHut
   bqmEcAZWHniOGjsY6JTjNKoTEs9qTfPvuy2N4fDhdd8OlW7q7rus5JoUv
   XuIgTwpUUHZlBmCS9pwu+1fupKTDf+bfIGcjPOOPLNUj5TKNUx256Y8+Y
   FF2xx3+wTrwtsXYrYE7v6kj2GQZ1/dL2SMpusgR+qhGcR/L7mvhsXVnaV
   Y3QJJY/hA9jWL1Eqijs4N8rBMy2URUGEmwqG+pu51Ib/6Z3pvJHXM+4yO
   kun6QPRbn+n4OXo8eSJEtQdoYRyZhxOq3pm3HHY/AyodzpGjuCxafalJ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6367444"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6367444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:35:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4961870"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:35:42 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 0/2] Disable automatic load CCS load balancing
Date: Tue, 20 Feb 2024 15:35:24 +0100
Message-ID: <20240220143526.259109-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series does basically two things:

1. Disables automatic load balancing as adviced by the hardware
   workaround.

2. Assigns all the CCS slices to one single user engine. The user
   will then be able to query only one CCS engine

Changelog
=========
- In Patch 1 use the correct workaround number (thanks Matt).
- In Patch 2 do not add the extra CCS engines to the exposed UABI
  engine list and adapt the engine counting accordingly (thanks
  Tvrtko).
- Reword the commit of Patch 2 (thanks John).

Andi Shyti (2):
  drm/i915/gt: Disable HW load balancing for CCS
  drm/i915/gt: Enable only one CCS for compute workload

 drivers/gpu/drm/i915/gt/intel_engine_user.c |  9 +++++++++
 drivers/gpu/drm/i915/gt/intel_gt.c          | 11 +++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  3 +++
 drivers/gpu/drm/i915/gt/intel_workarounds.c |  6 ++++++
 drivers/gpu/drm/i915/i915_query.c           |  1 +
 5 files changed, 30 insertions(+)

-- 
2.43.0


