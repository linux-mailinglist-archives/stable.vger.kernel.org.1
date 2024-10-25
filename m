Return-Path: <stable+bounces-88191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB29B0D81
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AF81C22B5B
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC020D4F2;
	Fri, 25 Oct 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0SI5eTF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3A20BB57;
	Fri, 25 Oct 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881546; cv=none; b=eNjgo50wF3Hh6QySqQG+ZFzsMetOGieIYwNPu38nY3W8ekIHQCM4e0ZYQqLPG8OuKYfxnD/k3KmkWXsDmKHH1ZoJW8dOH4Q4By8rUqVyr72VCViNiRwNvzSSQZvuTlNAa1QOF/COWVEzTcGd+1FTmoJPkejHMb1biw+P635gnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881546; c=relaxed/simple;
	bh=I8YZGZ9p3OeghO1769h9aaICc2jEgTapOOmPgdolGSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzgojP1Qy9ZWpw0clyqmldBYws8cltv2dkc0OT3IdCtMfDSUCU9EX3Fkk8TA+kxpkgZCLP2PPoI+V48NTbAxtDUaa95XxfT3cgDWwl0V/NOy+NbGJgsVSWvsa9DHn8wHxGv/eEUPN5b/a8vgq+9X+IR1AA9UgD1eze9pjp8SO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0SI5eTF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729881545; x=1761417545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8YZGZ9p3OeghO1769h9aaICc2jEgTapOOmPgdolGSM=;
  b=J0SI5eTFFkAXxmE4/i2/ys29+y2FnruKVxgvKy1RSRz2gDP3/+4GGSyt
   Tr/0ggC9PFKnwLYBfpGbz6Bb8wK2Ye0UCwKywUJNGv+RaTISyQwQ1Y4Vi
   +WHiV3q2yXN/QQjFRFs6e4ph8HerHA/ctoHcBEXngtOLgE6fNr2BtdsZD
   y1Lq3axtmOYhoyW0itkfH5cRbp+Gi2X5gaM/J8SbKdLE77OzVZQ7UOBsu
   xW8+fqDNY05+YuVoWvwxHAXq0l/TttGE6prsM/KH01YuNZCwiQvUwDoQi
   T3+xZ/Jt7yofrUM/5dByxw8oql1TdVHg4V89RPrYdG9mtEqrh+DR1i8np
   Q==;
X-CSE-ConnectionGUID: wkAQWEx1Qm6tjJMKUDNbPQ==
X-CSE-MsgGUID: 06GSvXOnQgyLxPQTHr07cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47043918"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47043918"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 11:39:02 -0700
X-CSE-ConnectionGUID: 3SK9+lIgQBWWmJEB/H1QtA==
X-CSE-MsgGUID: 2p0lTE3lQKGAi7JjqjbOoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111801069"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 11:39:01 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	stable@vger.kernel.org,
	Tarun K Singh <tarun.k.singh@intel.com>
Subject: [PATCH iwl-net v2 2/2] idpf: fix idpf_vc_core_init error path
Date: Fri, 25 Oct 2024 11:38:43 -0700
Message-ID: <20241025183843.34678-3-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
References: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an event where the platform running the device control plane
is rebooted, reset is detected on the driver. It releases
all the resources and waits for the reset to complete. Once the
reset is done, it tries to build the resources back. At this
time if the device control plane is not yet started, then
the driver timeouts on the virtchnl message and retries to
establish the mailbox again.

In the retry flow, mailbox is deinitialized but the mailbox
workqueue is still alive and polling for the mailbox message.
This results in accessing the released control queue leading to
null-ptr-deref. Fix it by unrolling the work queue cancellation
and mailbox deinitialization in the reverse order which they got
initialized.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org # 6.9+
Reviewed-by: Tarun K Singh <tarun.k.singh@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
v2:
 - remove changes which are not fixes for the actual issue from this patch
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 1 +
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index c3848e10e7db..b4fbb99bfad2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1786,6 +1786,7 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 	 */
 	err = idpf_vc_core_init(adapter);
 	if (err) {
+		cancel_delayed_work_sync(&adapter->mbx_task);
 		idpf_deinit_dflt_mbx(adapter);
 		goto unlock_mutex;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3be883726b87..e7eee571d908 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3070,7 +3070,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	adapter->state = __IDPF_VER_CHECK;
 	if (adapter->vcxn_mngr)
 		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
-	idpf_deinit_dflt_mbx(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
 			   msecs_to_jiffies(task_delay));
-- 
2.43.0


