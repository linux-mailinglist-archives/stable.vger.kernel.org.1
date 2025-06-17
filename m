Return-Path: <stable+bounces-154351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A6ADD8C8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5329219E26A9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE42FA635;
	Tue, 17 Jun 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpxm0PkU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91E2FA628;
	Tue, 17 Jun 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178919; cv=none; b=uSOgtgY5GbgxldgF0smfm+dQKJasq8XBZUKZF7coswbNAuqZXLqT+4qP9bMFKtjpLxGQkahWOHYmO4L9qvDkGOqcp4haXG6dTwdItFsxO9wq/lqtw9TOtAuPRekWP16kqtEA/98JQz6c/lMFEAX53gdlR/HGkdcjqNGgCahCm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178919; c=relaxed/simple;
	bh=tVlvpykHaR/lcrm7j6Ffa+WJKkln0ug5YR0IFvmvICk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWPK1IBWOACoRcmX9yIiSJ+5eqHoW32VFLwU+irQE/Z939AiM18xGRb6KQa42ZUk/dByv55hsoMbC1HuDtteWrBDu5jcwrWTvAYMP9H0t4ucSmgwrI8Tv+gOFTDc521+1m41x7hWWJsucKPnlkXiT4xv2ZeS1e0XO1Xq+6/pWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpxm0PkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C11C4CEE3;
	Tue, 17 Jun 2025 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178919;
	bh=tVlvpykHaR/lcrm7j6Ffa+WJKkln0ug5YR0IFvmvICk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpxm0PkUrChtwScVZEQgtvxdRccgLyFCCJleSCWWVBeyTkwOGIr7deKJP49gKFh4l
	 d1q+A2LlZOc0zTnUnQOjT7CZu3HzYFunFB3Vq+iWvs4KNONHJQuKUS5J9D8+eDtoJ4
	 5dxLNUZoNPKyVVgPqpCdU8FUXSmQsm4FNy5NnLmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Hay <joshua.a.hay@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 575/780] idpf: avoid mailbox timeout delays during reset
Date: Tue, 17 Jun 2025 17:24:43 +0200
Message-ID: <20250617152514.895343941@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit 9dc63d8ff182150d7d7b318ab9389702a2c0a292 ]

Mailbox operations are not possible while the driver is in reset.
Operations that require MBX exchange with the control plane will result
in long delays if executed while a reset is in progress:

ethtool -L <inf> combined 8& echo 1 > /sys/class/net/<inf>/device/reset
idpf 0000:83:00.0: HW reset detected
idpf 0000:83:00.0: Device HW Reset initiated
idpf 0000:83:00.0: Transaction timed-out (op:504 cookie:be00 vc_op:504 salt:be timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:508 cookie:bf00 vc_op:508 salt:bf timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:512 cookie:c000 vc_op:512 salt:c0 timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:510 cookie:c100 vc_op:510 salt:c1 timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c200 vc_op:509 salt:c2 timeout:60000ms)
idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c300 vc_op:509 salt:c3 timeout:60000ms)
idpf 0000:83:00.0: Transaction timed-out (op:505 cookie:c400 vc_op:505 salt:c4 timeout:60000ms)
idpf 0000:83:00.0: Failed to configure queues for vport 0, -62

Disable mailbox communication in case of a reset, unless it's done during
a driver load, where the virtchnl operations are needed to configure the
device.

Fixes: 8077c727561aa ("idpf: add controlq init and reset checks")
Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c     | 18 +++++++++++++-----
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h    |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 3a033ce19cda2..2ed801398971c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1816,11 +1816,19 @@ void idpf_vc_event_task(struct work_struct *work)
 	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
-	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags) ||
-	    test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
-		set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
-		idpf_init_hard_reset(adapter);
-	}
+	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
+		goto func_reset;
+
+	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
+		goto drv_load;
+
+	return;
+
+func_reset:
+	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+drv_load:
+	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
+	idpf_init_hard_reset(adapter);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d2413b8684fc..5d2ca007f6828 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -376,7 +376,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
  * All waiting threads will be woken-up and their transaction aborted. Further
  * operations on that object will fail.
  */
-static void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 83da5d8da56bf..23271cf0a2160 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -66,5 +66,6 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 
 #endif /* _IDPF_VIRTCHNL_H_ */
-- 
2.39.5




