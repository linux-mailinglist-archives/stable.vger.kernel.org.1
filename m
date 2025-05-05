Return-Path: <stable+bounces-139658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B075AAA90EB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3D31896A1C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C531FC104;
	Mon,  5 May 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e23t5Lp5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F81FECB1
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440599; cv=none; b=mbQyiICHVrStEj6m9qMLFqGTS3ly7LM0Jtfe7vaIp0y/wR9O4KlmhImTI4W2BSRMUgj80qnI0MmYfny01jtCzKS69RZskURYtSTWLJmukovHVmaLgKobCu40yakowPpvw/qMsRImpTBXeqDt2QEqJzgm+IpRY6p7fVZrGb6nLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440599; c=relaxed/simple;
	bh=MIrZPHsia9oyBjG8Qg/kNkF0/VRnU2/q96uLqPqc7Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7m84eryayFI7Ph9VRCQufVWBj5QobVQai+OrzgMBAxXwYW7PtjGeu+VXPjCJXdHQlCUJFN9GMhMvUXyXLoreJy7AWU0oR1XQF6JoOwOUlVQpBORm5ANc4qVQ5hZ50QSzNyT8nfJd7VFcnmkO0W88FpNKTnM1VXIV9IqcdijME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e23t5Lp5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746440598; x=1777976598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MIrZPHsia9oyBjG8Qg/kNkF0/VRnU2/q96uLqPqc7Pk=;
  b=e23t5Lp5EzQYwbChz7qgLMc1+cC7WBuXeoIWTZG7BK3xeUzzpvnmPwfG
   YlI3eCKeA+31ooYlOV9/rXfKyETn1r138sEv7W9QLTSqmbqO9rIU3/dYX
   FxsUOmXa/+5y3FuOozAEBN3m75W7PE95y3kR6ZK8+iD6oBV0vItn4B6EZ
   3mNo0a2nLaWFm1kb/NaTj73fe/rtW/BSuTEKv28iuN6T9A1SRmYtiTIGe
   HKdGUjbGfDs8DrXdiAlFGWFDNphyKan43MCAZDIalZEt7RPB0PoauNMNr
   7WUGYci0TNeOlnG7Z+5xuDq4nFePUrCQUgjul3yU3CRP3ul0ZTjXZi0Te
   A==;
X-CSE-ConnectionGUID: lFA+abrZSEGFPzuies2aUw==
X-CSE-MsgGUID: 7/mC3E63RVKrBwO51CZEbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="65447855"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="65447855"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:23:15 -0700
X-CSE-ConnectionGUID: 64ZmEPl3Q9S3vAi9Zdd/xw==
X-CSE-MsgGUID: CFLv80AZQny6yUuHOozC0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135170570"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:23:13 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH v2 0/3] accel/ivpu: Add context violation handling for 6.14
Date: Mon,  5 May 2025 12:23:08 +0200
Message-ID: <20250505102311.23425-1-jacek.lawrynowicz@linux.intel.com>
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

Changes since v1:
 - Documented deviations from the original upstream patches in commit messages

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

