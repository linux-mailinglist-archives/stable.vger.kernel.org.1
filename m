Return-Path: <stable+bounces-95539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D09D9A84
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94DB28259B
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366D1D7E42;
	Tue, 26 Nov 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMVsaJDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414B1D63DB
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635556; cv=none; b=cGyLmcbEvQwJEdrPZI/VUPzBaG7cvBtnrgOI3QJ3+d1WCQROePYc95iv4hsI9BwYWFFe0UnM8DXWASqxw5fqYrLSz7hbDLihp/iHzfR0Dw6TfQ50xO4eIF/466HTnlL8tHIFeJjWY95fcbOWKNK8LMznxNmvhkWZNdWeHmdQZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635556; c=relaxed/simple;
	bh=ik+7otu9KBhWAIh1ZyFUdtS4LkyDfLhsvwRcePm/esc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm0ZmN75elfmq+ZvxQizLU5Saj9iQ73T05OKhi1F4ksWigkCC8U90icTKvVG8dbbEBsygaVhQYRTiGpx8jNmT6iQttM7dI015xrgumvrysW6Cjzaj6pXO2qYS8KQTomW3WHNWrVTVzbC9RFhOzJHvL/EjWCDD/H3GxrvtEVlx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMVsaJDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC5C4CED0;
	Tue, 26 Nov 2024 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635555;
	bh=ik+7otu9KBhWAIh1ZyFUdtS4LkyDfLhsvwRcePm/esc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMVsaJDda3PHta/xOj6NyavTQ0XxtaZot95uBhdG52NCpHeXhbrO8K8J25bIvlhbR
	 31DBLz2mi/HLrYnaQ2Y5g4hGjdfQTdQngrq5CMgMDB7nuIQpXUz6aOa8+TweAMo20G
	 7yyP6mGRLHRq0jFj3HUjtl2ijbvpty3YH07bGlw5Zde8alI+q2kqy2yzZnf13IyB8r
	 ClBVjlzoE6d8Xm4NtMEmVFPFzoVl7ewHaqcM4hyrQHwTHJNgJTsP1UOUO8qbeeq3ZX
	 556LoKHbNcrJWrTN5cEoZ7vCV4BKQP6V9OY7s9eHZMP6yvS/31CVOJ2WbuXMt9mzN8
	 +z7jUiD3Zsx2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
Date: Tue, 26 Nov 2024 10:39:13 -0500
Message-ID: <20241126081101-eef147164300553a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126062537.310401-3-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: f53e1c9c726d83092167f2226f32bd3b73f26c21

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 8c3f7943a291)
6.6.y | Present (different SHA1: 4883296505aa)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 08:07:32.599317773 -0500
+++ /tmp/tmp.XHyzHU5ddN	2024-11-26 08:07:32.593820712 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit f53e1c9c726d83092167f2226f32bd3b73f26c21 ]
+
 If mgmt_index_removed is called while there are commands queued on
 cmd_sync it could lead to crashes like the bellow trace:
 
@@ -12,15 +14,17 @@
 Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
 Reported-by: jiaymao <quic_jiaymao@quicinc.com>
 Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+[Xiangyu: BP to fix CVE: CVE-2024-49951, Minor conflict resolution]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  net/bluetooth/mgmt.c | 23 ++++++++++++++---------
  1 file changed, 14 insertions(+), 9 deletions(-)
 
 diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
-index e4f564d6f6fbf..4157d9f23f46e 100644
+index 5a1015ccc063..82edd9981ab0 100644
 --- a/net/bluetooth/mgmt.c
 +++ b/net/bluetooth/mgmt.c
-@@ -1453,10 +1453,15 @@ static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
+@@ -1457,10 +1457,15 @@ static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
  
  static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
  {
@@ -39,7 +43,7 @@
  		mgmt_pending_remove(cmd);
  
  		return;
-@@ -9394,12 +9399,12 @@ void mgmt_index_added(struct hci_dev *hdev)
+@@ -9424,14 +9429,14 @@ void mgmt_index_added(struct hci_dev *hdev)
  void mgmt_index_removed(struct hci_dev *hdev)
  {
  	struct mgmt_ev_ext_index ev;
@@ -49,12 +53,14 @@
  	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
  		return;
  
--	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
-+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
- 
- 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
- 		mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0,
-@@ -9450,7 +9455,7 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
+ 	switch (hdev->dev_type) {
+ 	case HCI_PRIMARY:
+-		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
++		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
+ 
+ 		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
+ 			mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev,
+@@ -9489,7 +9494,7 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
  void __mgmt_power_off(struct hci_dev *hdev)
  {
  	struct cmd_lookup match = { NULL, hdev };
@@ -63,7 +69,7 @@
  
  	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
  
-@@ -9462,11 +9467,11 @@ void __mgmt_power_off(struct hci_dev *hdev)
+@@ -9501,11 +9506,11 @@ void __mgmt_power_off(struct hci_dev *hdev)
  	 * status responses.
  	 */
  	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
@@ -78,3 +84,6 @@
  
  	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
  		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

