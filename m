Return-Path: <stable+bounces-89765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8049BC104
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 23:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA36B21BED
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4351FE110;
	Mon,  4 Nov 2024 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1iFxLiX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4A1FDFAC;
	Mon,  4 Nov 2024 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759808; cv=none; b=HCeb6o7fqFi0LOPAX3/TQZKHKiT6H4zNv7s6mYZ+A+sCzl7nNH5ZL93LeHejGLXhri3ygOSabP6UOBa2iMqnvn7N2TRMUJEnAakdwvJqxsMNgHsGORBPjQp4xT9iVDVdT7NsPx4olawXiUpOTxoZ+CZMJQScJxqlnUJRb1LnhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759808; c=relaxed/simple;
	bh=s25n+lGXySaaa5BNfdNG6reGej0xd8Kh1yklFjZEAaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyV+Us7bfj0vN5VEUxIYOL/0eVbwoC7a2UUMNauxbJEayVXYJkgLMDfRIZQF6Jyto8enaQfFZ4TAhZtGEK+wOe9U2axEMQxy1Kg6Eo7cQqpGyTf1fPDfEHkFXFCkZuPJDUHKld48sRYjjuhmWRE9CK2y4x77VEbVPrhDOJ2dyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1iFxLiX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730759807; x=1762295807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s25n+lGXySaaa5BNfdNG6reGej0xd8Kh1yklFjZEAaI=;
  b=h1iFxLiX0PK1FIpLrTVDOtn180+xgCdZFiqEyjxxErmERP04pWHLtuo5
   4ycY6RUhcKdLDNdddfBY/bJux2RiqJf8v+qw0YBafsFJB2j8blQOCGrbG
   s6jmqfvynrHreR4bAk9SH7RJoqB6khCX2QDGEiBlntW3wK1wpnjgdgnF8
   1G5ebgTEiviF/s7JhLZI8rlr/KACc3OJkwP/rfYOb7WWI88W8uN28Jv2a
   6YFmG25Yz/0tA7Tr20ERqR3NOd616w8Fpq7dl/ILeDWWKMk0QIF9v8Hv4
   K/vIcMOVZ4QG4psxlZxD9JhnwUPQbYWtQ3OiXD8LXW8cwAjhXKKDqBUax
   w==;
X-CSE-ConnectionGUID: lD3no64SRg2afAnk9wTtRg==
X-CSE-MsgGUID: xkyg9h7mQE2Wc/rCo7smfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29901657"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="29901657"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:36:44 -0800
X-CSE-ConnectionGUID: Bo7c++GbRVanT2tiItashg==
X-CSE-MsgGUID: KeTma+axRRKBV2sP6pVO0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83316982"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2024 14:36:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org,
	horms@kernel.org,
	Tarun K Singh <tarun.k.singh@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 4/6] idpf: fix idpf_vc_core_init error path
Date: Mon,  4 Nov 2024 14:36:32 -0800
Message-ID: <20241104223639.2801097-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
References: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

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
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index ce217e274506..d46c95f91b0d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3063,7 +3063,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	adapter->state = __IDPF_VER_CHECK;
 	if (adapter->vcxn_mngr)
 		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
-	idpf_deinit_dflt_mbx(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
 			   msecs_to_jiffies(task_delay));
-- 
2.42.0


