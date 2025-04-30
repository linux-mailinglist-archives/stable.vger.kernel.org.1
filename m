Return-Path: <stable+bounces-139154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C33DAA4BCF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF96D1C05941
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01602609D6;
	Wed, 30 Apr 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcHTb5A/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72325B1FA
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017305; cv=none; b=jISraUInYj+/AgyLfZzhZX5sNG3W5bFvRjYqI4lEnDlkFHMBFY7jAK/v9OOB3xqKihwE5n5CUxXnwNbHKs0HTFdOWW+M7A2r0pv/KTfwNFeJvuiMGia5D5/9VC8lLroFTCMv6xmT+gjSbFDK/Be3aRAgI2yf5lxb2a2cfrAPaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017305; c=relaxed/simple;
	bh=PoiQLktYAse7K0eXKfQLheCn9RjG3Sa1Fx3/mHUV5Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBLeC+++pcnntQYVJvcjt5xsNEti/mJz5bH2tNMr460DF4Bt938ccZ5bJzNXXhRzw11dPfpvOprHZU87S6Fsfw0WtXtvysXTsz9r8fRVNWZS7wDDoSkl6MWrkdn0QhTxV3XMNMK2RtzzetNiGylMYEOfHfH9ek6cMvBcLCP8BQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcHTb5A/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017304; x=1777553304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PoiQLktYAse7K0eXKfQLheCn9RjG3Sa1Fx3/mHUV5Tw=;
  b=FcHTb5A/fvg81lw1hx/4h8l6e6ANMQc2AwQ20D/sD7SJsnhZP5CHn4rO
   ZmGpehHcVawa63l8Qy2kT3eFbuxYe2pSUfDjd0B216OgSVNar4VmpiiCX
   Zt7oTALweSJyVk7ICOWzvjl2JeurauGjmVdzfEaI8nMbKCeKgSvUvKIJG
   RYx0kLQEUpPHSSbc3+fwVMpGegCs4SDGKzNZJhcW9cY3y5eF4TAboPp1m
   x556H+NPvh9vzANQdfeebIibmQ98L9gwmV1wBHE+f0N83sZ0iEnwLwKNP
   P0z1YTLEYKwHlmMH8CE2f8GSnix6YbKmC5hE+xOIkP49llzvDPs2qyxdz
   Q==;
X-CSE-ConnectionGUID: t4kVxiMAQWKawm8Ykecwsg==
X-CSE-MsgGUID: JizAXrqaR5i4Oi3UchRJNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488492"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488492"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:23 -0700
X-CSE-ConnectionGUID: BOarSC5vSO2ucTUE0Tf+Hg==
X-CSE-MsgGUID: AW8wTngxTH+Pw+oU1niyiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925400"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:22 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 0/7] accel/ivpu: Add context violation handling for 6.12
Date: Wed, 30 Apr 2025 14:48:12 +0200
Message-ID: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
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

Most patches are as-is from upstream besides these two:
 - Fix locking order in ivpu_job_submit
 - Abort all jobs after command queue unregister

Both these patches need to be rebased because of missing new CMDQ UAPI changes
that should not be backported to stable.

Andrew Kreimer (1):
  accel/ivpu: Fix a typo

Andrzej Kacprowski (1):
  accel/ivpu: Update VPU FW API headers

Karol Wachowski (4):
  accel/ivpu: Use xa_alloc_cyclic() instead of custom function
  accel/ivpu: Abort all jobs after command queue unregister
  accel/ivpu: Fix locking order in ivpu_job_submit
  accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW

Tomasz Rusinowicz (1):
  accel/ivpu: Make DB_ID and JOB_ID allocations incremental

 drivers/accel/ivpu/ivpu_drv.c     |  38 ++--
 drivers/accel/ivpu/ivpu_drv.h     |   9 +
 drivers/accel/ivpu/ivpu_job.c     | 125 +++++++++---
 drivers/accel/ivpu/ivpu_job.h     |   1 +
 drivers/accel/ivpu/ivpu_jsm_msg.c |   3 +-
 drivers/accel/ivpu/ivpu_mmu.c     |   3 +-
 drivers/accel/ivpu/ivpu_sysfs.c   |   5 +-
 drivers/accel/ivpu/vpu_boot_api.h |  45 +++--
 drivers/accel/ivpu/vpu_jsm_api.h  | 303 +++++++++++++++++++++++++-----
 9 files changed, 412 insertions(+), 120 deletions(-)

-- 
2.45.1

