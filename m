Return-Path: <stable+bounces-47742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0118D53E4
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 22:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC53C282DB2
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603A2E417;
	Thu, 30 May 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYjvKKId"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BF25634
	for <stable@vger.kernel.org>; Thu, 30 May 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101195; cv=none; b=AGhE4IMFvsQQQiOdIS7Bk/53xcSdpItS23/DAjbwXDszZBL/R/WbnGe/jsk7KfsU00rOplebWQx4MjJe/ScS/+c+Ff19umgEXbFnMso6XCpOsChfV9cKF6w5kZi/bRg8GOQY5lic83VO8g0bf+JMFaLWp/B/oCLY7V5CFh5hu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101195; c=relaxed/simple;
	bh=AzxFLEUbz0ATbdQruuBVs4RvEnXo9giQwnx2+L6UjnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S77outkom0yxrRAHUPvYWMwtCVabzc+1a1ygrbwP/VRNFK0L9/Z+smp8yVGr23LJ/cYBrSd4L+w0NDAol28G2NXzmT9y3Tim788sD5tJIOT4kFHvQZZp7jfzLqmIBjGvy/9cIqbEllK+I0NScYEznZuhYIS1+f6KwpCC7aSss3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYjvKKId; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717101194; x=1748637194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzxFLEUbz0ATbdQruuBVs4RvEnXo9giQwnx2+L6UjnY=;
  b=QYjvKKIdUIeNazQKWPLK2xaz3ywI4hLI4jSQV7JE6FsJO/5uN2lee+q/
   VxBoZOM6X19D7l4YsKxpqiZ/0zBsJmzNgzE1nioiAELELHDIQa+KcmlQM
   UnAUKZoMRmJNAA40r5GaUYxz/nMSqcKv+veqDAWABIfpTV8o6n3QBciTL
   prByEG3BhhehsWRftYe6OOhxQuY2mPubP0ayf4uJ/Iq26+HkoCnIpbhFk
   EcDVmb5lU3Rv9VYdisg4O1pV+uAtKAlyigLvKW95eySBqwDZk6Ugnpffy
   LIdta29t0BLrcCQF4NVivqv9h13TnTFyHYqex73s9PdgEDYkByB3dJ/Or
   w==;
X-CSE-ConnectionGUID: HML5Wt18RfqJzNr4ffRT8w==
X-CSE-MsgGUID: h3dsQOlfSkCjjfKByOh78g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13788655"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13788655"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:33:13 -0700
X-CSE-ConnectionGUID: kW7xKhdITtSN7pEgKVxCVw==
X-CSE-MsgGUID: pj7S7OgsR22aGEra1S197w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35977284"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:33:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix NULL ptr dereference in devcoredump
Date: Thu, 30 May 2024 13:33:41 -0700
Message-Id: <20240530203341.1795181-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kernel VM do not have an Xe file. Include a check for Xe file in the VM
before trying to get pid from VM's Xe file when taking a devcoredump.

Fixes: b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 1643d44f8bc4..6f63b8e4e3b9 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -176,7 +176,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	ss->snapshot_time = ktime_get_real();
 	ss->boot_time = ktime_get_boottime();
 
-	if (q->vm) {
+	if (q->vm && q->vm->xef) {
 		task = get_pid_task(q->vm->xef->drm->pid, PIDTYPE_PID);
 		if (task)
 			process_name = task->comm;
-- 
2.34.1


