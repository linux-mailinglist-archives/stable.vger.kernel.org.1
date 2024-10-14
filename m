Return-Path: <stable+bounces-84662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74199D147
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A9D1C213F7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FF1AB517;
	Mon, 14 Oct 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJuNiW7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4843AA9;
	Mon, 14 Oct 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918775; cv=none; b=k0WULYo6xYF/NiV0mbVCekrTqSye/nmLze+W8P5ViZ5WRcw+C8UM/lKoK0XwpMvoyIpdLzYuKaAzHNvYbvij0kjZu1n9gywJ0OYun2bvnzDelevoZQs5kiO9iJjJ1PWAcj/JxzHK9p9GkVCEpcq+COHB5dKS7DxhFn8yronKXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918775; c=relaxed/simple;
	bh=78asXAYAftSf0otNAz16SKc921LUaXzot1juj5P37dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUXs58y0vlQZNC4HVutgTAZOhmms73Ow6VdVbnUZlM3NJUVJ8QoN3cdMNbIsuT9UNrOCqpRyFZruXCXppk2Bc1C2wVZu2+vU50bbnVoFsN20m3DbDZ1sGeDGCXASaXAA7fuvfGqrYvGPAKL6vNssswZZh6MzPof+eGSWz34it2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJuNiW7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB18C4CEC3;
	Mon, 14 Oct 2024 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918775;
	bh=78asXAYAftSf0otNAz16SKc921LUaXzot1juj5P37dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJuNiW7Sf71Iy9DW5wLdym6LiRng0gAjYmbyoJ1/JCbRUJU5UxFjQOcxp9tg8JI+M
	 qVgktg4akPKt+K/M0NG6aiHne597+wD3pELCR5KmhlWapx23icRKWYIGqHOtgB0roT
	 BQ/CWp6zY/L2RCpEKqM8u8iDGYESDlluu2kg7Kpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 420/798] wifi: iwlwifi: mvm: Fix a race in scan abort flow
Date: Mon, 14 Oct 2024 16:16:14 +0200
Message-ID: <20241014141234.450323575@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 87c1c28a9aa149489e1667f5754fc24f4973d2d0 ]

When the upper layer requests to cancel an ongoing scan, a race
is possible in which by the time the driver starts to handle the
upper layers scan cancel flow, the FW already completed handling
the scan request and the driver received the scan complete
notification but still did not handle the notification. In such a
case the FW will simply ignore the scan abort request coming from
the driver, no notification would arrive from the FW and the entire
abort flow would be considered a failure.

To better handle this, check the status code returned by the FW for
the scan abort command. In case the status indicates that
no scan was aborted, complete the scan abort flow with success, i.e.,
the scan was aborted, as the flow is expected to consume the scan
complete notification.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825085558.483989d3baef.I3340556a222388504c6330b333360bf77d10f9e2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 13 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 42 +++++++++++++++----
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 7ba0e3409199b..09b4dff7cf394 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1111,6 +1111,19 @@ struct iwl_umac_scan_abort {
 	__le32 flags;
 } __packed; /* SCAN_ABORT_CMD_UMAC_API_S_VER_1 */
 
+/**
+ * enum iwl_umac_scan_abort_status
+ *
+ * @IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS: scan was successfully aborted
+ * @IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS: scan abort is in progress
+ * @IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND: nothing to abort
+ */
+enum iwl_umac_scan_abort_status {
+	IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS = 0,
+	IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS,
+	IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND,
+};
+
 /**
  * struct iwl_umac_scan_complete
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 20c5cc72e4269..1785fded6290e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3037,13 +3037,23 @@ void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
 		       mvm->scan_start);
 }
 
-static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
+static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type, bool *wait)
 {
-	struct iwl_umac_scan_abort cmd = {};
+	struct iwl_umac_scan_abort abort_cmd = {};
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
+		.len = { sizeof(abort_cmd), },
+		.data = { &abort_cmd, },
+		.flags = CMD_SEND_IN_RFKILL,
+	};
+
 	int uid, ret;
+	u32 status = IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	*wait = true;
+
 	/* We should always get a valid index here, because we already
 	 * checked that this type of scan was running in the generic
 	 * code.
@@ -3052,17 +3062,28 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 	if (WARN_ON_ONCE(uid < 0))
 		return uid;
 
-	cmd.uid = cpu_to_le32(uid);
+	abort_cmd.uid = cpu_to_le32(uid);
 
 	IWL_DEBUG_SCAN(mvm, "Sending scan abort, uid %u\n", uid);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &cmd, &status);
+
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d, status=%u\n", ret, status);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
-	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
+	/* Handle the case that the FW is no longer familiar with the scan that
+	 * is to be stopped. In such a case, it is expected that the scan
+	 * complete notification was already received but not yet processed.
+	 * In such a case, there is no need to wait for a scan complete
+	 * notification and the flow should continue similar to the case that
+	 * the scan was really aborted.
+	 */
+	if (status == IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND) {
+		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
+		*wait = false;
+	}
+
 	return ret;
 }
 
@@ -3072,6 +3093,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 	static const u16 scan_done_notif[] = { SCAN_COMPLETE_UMAC,
 					      SCAN_OFFLOAD_COMPLETE, };
 	int ret;
+	bool wait = true;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -3083,7 +3105,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 	IWL_DEBUG_SCAN(mvm, "Preparing to stop scan, type %x\n", type);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
-		ret = iwl_mvm_umac_scan_abort(mvm, type);
+		ret = iwl_mvm_umac_scan_abort(mvm, type, &wait);
 	else
 		ret = iwl_mvm_lmac_scan_abort(mvm);
 
@@ -3091,6 +3113,10 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 		IWL_DEBUG_SCAN(mvm, "couldn't stop scan type %d\n", type);
 		iwl_remove_notification(&mvm->notif_wait, &wait_scan_done);
 		return ret;
+	} else if (!wait) {
+		IWL_DEBUG_SCAN(mvm, "no need to wait for scan type %d\n", type);
+		iwl_remove_notification(&mvm->notif_wait, &wait_scan_done);
+		return 0;
 	}
 
 	return iwl_wait_notification(&mvm->notif_wait, &wait_scan_done,
-- 
2.43.0




