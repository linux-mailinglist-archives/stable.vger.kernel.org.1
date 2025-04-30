Return-Path: <stable+bounces-139149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98499AA4B5E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7128A9A612B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CEC258CC0;
	Wed, 30 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hvvk/dMD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78721C9E7
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016628; cv=none; b=eSsa06X8sd2qk+fLX/7c9mlfIKbDYmGi4XeaWlzRjqBUmVEdfd9bSAB3j4nJQNA7PDA4Cum5b9QdcyAh5RFtnXOh7zAyqeFhSAbGflBVWMWhlT4lFuI3c0p6b96AMGULjByyJTU0LhheJGWorq0q7u3X0444+m/UNO9H1XDKDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016628; c=relaxed/simple;
	bh=ykRJM9Jr3EeHzRrRUZMfpk4pn83GNbHJp76ZcFRGwZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsnUQbQNzCQQXshsCaz5NnbzKPt9RL0zP1aIvwku6OfT8kGt6zj1u9vn8NsxPodwgxHVA5MHgO8+zbqnD6qhEQ9YUjy2/1TRrcmf6EOCf0KNhWEwcV8FCVXFEztQo/lti/LQhfJvVoPnmCdnjTBk275eFioG2a1uTX3oEkhkE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hvvk/dMD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746016627; x=1777552627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ykRJM9Jr3EeHzRrRUZMfpk4pn83GNbHJp76ZcFRGwZs=;
  b=Hvvk/dMDbYN9BO3y7J05tcdLQstdIozMYw9DplrWmR1zwjQLiQY2RHLW
   zXgX3EsYyocQC94kxJQs6FEaE5wtMJ8+HHBc/y5fG+VBY/GVagYjVt9eS
   VtD9cLPODbreftwDVwGQJXzDruoeamOZa46fkHARc1XQC0PieIQOEA9Fv
   V1pvnU0BIy7W8fL7w+oqDshJ0N0WRg3a110RTeLTVYjF6I1ubpRw3DTr1
   5xvKZN2SAgHACsa2D6c7AK16e8jqJalxtRIOYnfWS7n7NV0Tw/pF0Kr2C
   eIfnYq6Y7QrPBxx6KIO3sigIUPAnhpGJWjGJDYS73m8RH0jkbL8Rgu1U1
   A==;
X-CSE-ConnectionGUID: obHqYCz0TcSjXnkGSn1oHw==
X-CSE-MsgGUID: hGKkED8+T6myOAGB0RALZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51336925"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51336925"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:36:58 -0700
X-CSE-ConnectionGUID: 6WDoGooHSzC9f3eefE7mhw==
X-CSE-MsgGUID: VB1FT8QzRkC2jfnmbpA9Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165201907"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:36:55 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 0/3] accel/ivpu: Add context violation handling for 6.14
Date: Wed, 30 Apr 2025 14:36:50 +0200
Message-ID: <20250430123653.3748811-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patchset adds support for VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
message added in recent VPU firmware. Without it the driver will not be able to
process any jobs after this message is received and would need to be reloaded.

The last patch in this series is as-is from upstream, but other two patches
had to be rebased because of missing new CMDQ UAPI changes that should not be
backported to stable. 

Karol Wachowski (3):
  accel/ivpu: Abort all jobs after command queue unregister
  accel/ivpu: Fix locking order in ivpu_job_submit
  accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW

 drivers/accel/ivpu/ivpu_drv.c   |  32 ++-------
 drivers/accel/ivpu/ivpu_drv.h   |   2 +
 drivers/accel/ivpu/ivpu_job.c   | 111 ++++++++++++++++++++++++++------
 drivers/accel/ivpu/ivpu_job.h   |   1 +
 drivers/accel/ivpu/ivpu_mmu.c   |   3 +-
 drivers/accel/ivpu/ivpu_sysfs.c |   5 +-
 6 files changed, 103 insertions(+), 51 deletions(-)

-- 
2.45.1

