Return-Path: <stable+bounces-87759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CE9AB535
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F081C229CC
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26681BCA02;
	Tue, 22 Oct 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jz1MPplD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0F1A4F01;
	Tue, 22 Oct 2024 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618654; cv=none; b=BfQHSK3JpiyWA+F/bzHfUKwRbrBdVh7rjrcqvpjqQr/rVEN4cY2JPWSg0slYMm8KFcKGhjzU5TyNvrcFuEhPx0gUfwlPRx7cBXOymeeuLNkx5md711PmI+YI2AacSBvD+vbynaJE4z+gBfPOTkr0SpL9kfXlkZxeIrSaGhc3N84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618654; c=relaxed/simple;
	bh=VOKzmBVGbvPlb5H+Olv9BCx3x1/04Fkz5mIxchcqAS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEbEEEfNzIGymOVCtdppQmUbIi5D71onJhsLDvj1WSiNnjKj2RIfNfmXts5QCzRou20Nxe8euZjwFZExvgNnMtMq0SgIa0jIbTgY69JCxJrZxxMfx3kiZYRLevsjY7UPc04cOylRMeCKFifWkwpK6ZvUVgBeSaaM5lNLsoGYAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jz1MPplD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729618652; x=1761154652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOKzmBVGbvPlb5H+Olv9BCx3x1/04Fkz5mIxchcqAS8=;
  b=jz1MPplDBKzj27wKjSAKmbriuEVaRisJnRNuMq8SpjICyce9TWsFTxmE
   mLxiPui2xXjfqVLvteILsrZi4iPiWV72XdizdTlfP1RP8CJ8WcY43hbNv
   KE+gDOFj9bH9lr/w4ZCNKEa5XSpOIthZJZslELGfZDuLYYXNesqAo39MD
   FSOxicxplxV1jJTexHQJ74Z/hQU+jvlMhIheG2BVkbKMscwPXMdg15tif
   rJhyqSUvP/kln4ZN5wkQS342obwQUYO2TkNva88WGu39Gq4xqBCIuVEa8
   gW7jrQMJRNh4Uf52TfJZKpYr1A7kJmXzpq2511IrEr4/VpVyAp9j/EDyX
   Q==;
X-CSE-ConnectionGUID: oZ24oNRcQ96vqb/DIBiV9Q==
X-CSE-MsgGUID: w4rFra5FTZKZIIHvz4bQ2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39721924"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39721924"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 10:37:27 -0700
X-CSE-ConnectionGUID: JaSDGfPKQVuD+nilC9dVRQ==
X-CSE-MsgGUID: J39hMIQ4RxaGQCg/e8D08g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79862541"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 10:37:27 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	stable@vger.kernel.org,
	Tarun K Singh <tarun.k.singh@intel.com>
Subject: [PATCH iwl-net 2/2] idpf: fix idpf_vc_core_init error path
Date: Tue, 22 Oct 2024 10:35:27 -0700
Message-ID: <20241022173527.87972-3-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022173527.87972-1-pavan.kumar.linga@intel.com>
References: <20241022173527.87972-1-pavan.kumar.linga@intel.com>
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
and mailbox deinitialization in the order which they got
initialized.

Also remove the redundant scheduling of the mailbox task in
idpf_vc_core_init.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org # 6.9+
Reviewed-by: Tarun K Singh <tarun.k.singh@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 1 +
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

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
index 3be883726b87..d77d6c3805e2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3017,11 +3017,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto err_netdev_alloc;
 	}
 
-	/* Start the mailbox task before requesting vectors. This will ensure
-	 * vector information response from mailbox is handled
-	 */
-	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
-
 	queue_delayed_work(adapter->serv_wq, &adapter->serv_task,
 			   msecs_to_jiffies(5 * (adapter->pdev->devfn & 0x07)));
 
@@ -3046,7 +3041,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 
 err_intr_req:
 	cancel_delayed_work_sync(&adapter->serv_task);
-	cancel_delayed_work_sync(&adapter->mbx_task);
 	idpf_vport_params_buf_rel(adapter);
 err_netdev_alloc:
 	kfree(adapter->vports);
@@ -3070,7 +3064,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	adapter->state = __IDPF_VER_CHECK;
 	if (adapter->vcxn_mngr)
 		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
-	idpf_deinit_dflt_mbx(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
 			   msecs_to_jiffies(task_delay));
-- 
2.43.0


