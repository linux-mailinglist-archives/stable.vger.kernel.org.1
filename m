Return-Path: <stable+bounces-139662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F110DAA9135
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0752E188F07D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6551E3DDE;
	Mon,  5 May 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dega3J5Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059714D283
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441220; cv=none; b=n5umqq4eejfAxd5UIAN+9eJSf8gBAiomuYoeh4pj8JQbCmSVb4RNtqZCr2BYKGR+F1uKNh9l1hBcJeJ0PEOLh+Nbf0Xl7xaNTb1oVlAKtbZhFajNFdc0ykCqTimiwDGpivoD61u2EcsuZquJ8EafgrPz1GroDz/H/+uurLnageg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441220; c=relaxed/simple;
	bh=LLD8dc5DZN1EO97S/+ZURw8hDxCWHxZIMRth7LK0g3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSvZcriclY0u3JMZCGDux5hcRnZTjpUSzw1GnP7q/drUAIds7GWXgZylgUbHp6NnoV26cJIqDdKl+mWBnqKOQF9OTuKSm9KyWW82H5rIGHCC1u5MutxeD4LfJ+8Zh4YhUUMqrO7dIOJBMDvT2yKpZy4G05a2zMO5IgGqiN+70CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dega3J5Q; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746441219; x=1777977219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LLD8dc5DZN1EO97S/+ZURw8hDxCWHxZIMRth7LK0g3k=;
  b=Dega3J5Q13aoiI0OHP+wcE2gO1fPT6hcc42NypoOcC0ZMsLUOl1d+5CZ
   MSehXRqjI1xUllGhxg+f+eyHSZgwDEfOUmmGMnYjFsLGBTTOW2ToNuAqZ
   Vr3ycv+3dIBMGBC1IptuNedOGGo46ARrH+mBYBRltSAYTNebCRmHogaZe
   c7fXkyWGwKlCrLy7Q1+bgcwo+iQFD7+ydDDvAC8i76Y2RcUxTxA90FMn6
   P3hotozoz96v7u2NsV5tncHvGQ3Flw6sFcBxBfxP1/4bCYdQ1t8FY2xUT
   MzwiValDAE6B9qgSQqV3eEi7dB0SXVcHlxasYkeYPDs6pISooE8GAp5hY
   A==;
X-CSE-ConnectionGUID: J3KPy8pqS/urnE0IuiQ0kg==
X-CSE-MsgGUID: B8/PxGDnR++NmXDSMmsTMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="47301797"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47301797"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:38 -0700
X-CSE-ConnectionGUID: //tnpvdlRF+oiF1Rc4x00A==
X-CSE-MsgGUID: IvJTjBmuQXuFUx6hNwxpuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135186835"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:37 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH v2 0/7] accel/ivpu: Add context violation handling for 6.12
Date: Mon,  5 May 2025 12:33:27 +0200
Message-ID: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
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

Changes since v1:
 - Documented deviations from the original upstream patches in commit messages

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

