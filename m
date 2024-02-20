Return-Path: <stable+bounces-20815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2EB85BEA2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BEF1F2382D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B56BB24;
	Tue, 20 Feb 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkvXnn+N"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82A6A8D4
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438865; cv=none; b=mdzDYHqsVqbHyvO6gGZ5+06o9uOkrjAX7232UETDmeTCB2qGzV/CQu7emip0VQqumTSPKv7DAdPaBJZi0WVqqT14A6tbozgWHreu3nO42IS2Tn73Akfix+ovpWnU7FkiiQLNsyhcjHrqUXzkO1CVgfs+BDd95/QT4GaIZE3HfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438865; c=relaxed/simple;
	bh=s28gQVWPZGE3H1osjrzS3iQPjQBdB6vAoufDHgxlyXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ro9dSeJVHiDN76EwtjZytup3VR9J1D+i9TY1XSQJCKobFPSDaWwdK5dj2FiyHVzM+vSq1VwO/nDJCop3ARi99BHRIJCNlaqDuDVEHy6iQ9PR4V/c6HHbuHAzWEsFlZ7tvqpETzCHCIa8RHhERWv1RJW0n3+uq8ij1YmJ04U8tSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkvXnn+N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438863; x=1739974863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s28gQVWPZGE3H1osjrzS3iQPjQBdB6vAoufDHgxlyXs=;
  b=SkvXnn+NOYc4rgQY3uqWvlk+xMtb4CUP2MnaDp7yBtsh4wiwF7qavy63
   iBbLAHn840mqrxXGN2fZ6VmGc10Rx+Z2901XRcK8QwuqM0UsvMM63gp/3
   jJu/sSjCkAkfhj7uQ+0tX2A8omuid6JKtXoN81xrCYcUbjHSi7S+tCyIP
   6ISD4SwFgeCzxIB7bvXIvXsLQo0gvpq+KUp7uBlMYhZ0d+qmHgWnkYIEw
   D1RiQCgPsKc/1xqWqRFgowusiXRmDjs3NML+JLsSl+HqpEghIHAgmZ4h9
   w3cLpC1IwUAr9ocwfG7a39OY7R9GFsFYgNAORY+RHTnHiGCHEDUUwe+ht
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2447021"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2447021"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="42283459"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:00 -0800
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
Date: Tue, 20 Feb 2024 15:20:32 +0100
Message-ID: <20240220142034.257370-1-andi.shyti@linux.intel.com>
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

2. Forces the sharing of the load submitted to CCS among all the
   CCS available (as of now only DG2 has more than one CCS). This
   way the user, when sending a query, will see only one CCS
   available.

Andi

Andi Shyti (2):
  drm/i915/gt: Disable HW load balancing for CCS
  drm/i915/gt: Set default CCS mode '1'

 drivers/gpu/drm/i915/gt/intel_gt.c          | 11 +++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  3 +++
 drivers/gpu/drm/i915/gt/intel_workarounds.c |  6 ++++++
 drivers/gpu/drm/i915/i915_drv.h             | 17 +++++++++++++++++
 drivers/gpu/drm/i915/i915_query.c           |  5 +++--
 5 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.43.0


