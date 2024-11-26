Return-Path: <stable+bounces-95536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F989D9A7F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B4D282541
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54D1D63DB;
	Tue, 26 Nov 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2U78RLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25741917E6
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635550; cv=none; b=TLvySu0Nmy4eaPdpRJajgXMJrxsRviV4RgwBHWh/A+f/a/pA+LKCdwC/xg77shuum13QbhM4QmUiPUNxF0l4GUAQQ0qdUpFdjBJC7IGWcqvcPLuEMKmDlSwZBNtSndISKMfLtbCnPqhgTIzQwMART11GhGa7pjm2Ql8BXSgoJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635550; c=relaxed/simple;
	bh=FwK7db9F3emq2ZbhLfyU1No7tOeJZCbRfLQ20CwqTrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzsVxNZxkm4kmMRMQNvU9+o55ju7Xa0Pgndvee53Gl7dxqRqiSGt7Rr+Vd+QRLdhX2HLyrgWVHUli1SWLFXdTZX4Z9H9c+2/78PU9pPzBENBqs7AsjsZGHaY3M+ZazZkt96JKJ4mP4Z23rTEJcF+BIWGNqV1DzAQTQePhrF/Rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2U78RLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2206DC4CECF;
	Tue, 26 Nov 2024 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635549;
	bh=FwK7db9F3emq2ZbhLfyU1No7tOeJZCbRfLQ20CwqTrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2U78RLfpelDk4YnCP4XwOk4+dPnvlmMrHezRp7wTIrj3nSZ5HiUH2CnyeF0mkXpp
	 Wo9leDQO5bBi22lvlqXgI1O/mv5hYIlWcgR1hx2ks1Hzl/qM9wVLz/vY4cw6D5Zq5x
	 Bzl3uGUyHjCEE/g2/CeKHqYDybLdb807f+TuyQiKnqahfaT2TwoecuGrMa3tStXjtC
	 9EJ0qrLcv4cjWN4pCQL1wsPCwKNZ+1XZ+GD1SWu6+ofxoX34pc7LZbytz/fd3Mdxpe
	 jenBskfGKw301p6rWLUQ+IlYR3QJBuvC/M7c9J8z6YV+sApojWrV5CNUVLHtLNtYFF
	 fWymqM8nR4wiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
Date: Tue, 26 Nov 2024 10:39:07 -0500
Message-ID: <20241126080731-619cce443cdd4ef4@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126062537.310401-2-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 505ea2b295929e7be2b4e1bc86ee31cb7862fb01

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 1499f79995c7)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 08:03:56.550627469 -0500
+++ /tmp/tmp.7ZWCalBDha	2024-11-26 08:03:56.544829170 -0500
@@ -1,17 +1,20 @@
+[ Upstream commit 505ea2b295929e7be2b4e1bc86ee31cb7862fb01 ]
+
 This adds functions to queue, dequeue and lookup into the cmd_sync
 list.
 
 Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  include/net/bluetooth/hci_sync.h |  12 +++
  net/bluetooth/hci_sync.c         | 132 +++++++++++++++++++++++++++++--
  2 files changed, 136 insertions(+), 8 deletions(-)
 
 diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
-index ed334c253ebcd..4ff4aa68ee196 100644
+index 7accd5ff0760..3a7658d66022 100644
 --- a/include/net/bluetooth/hci_sync.h
 +++ b/include/net/bluetooth/hci_sync.h
-@@ -48,6 +48,18 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+@@ -47,6 +47,18 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
  			void *data, hci_cmd_sync_work_destroy_t destroy);
  int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
  		       void *data, hci_cmd_sync_work_destroy_t destroy);
@@ -31,10 +34,10 @@
  int hci_update_eir_sync(struct hci_dev *hdev);
  int hci_update_class_sync(struct hci_dev *hdev);
 diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
-index e1fdcb3c27062..5b314bf844f84 100644
+index 862ac5e1f4b4..b7a7b2afaa04 100644
 --- a/net/bluetooth/hci_sync.c
 +++ b/net/bluetooth/hci_sync.c
-@@ -566,6 +566,17 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
+@@ -650,6 +650,17 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
  	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
  }
  
@@ -52,7 +55,7 @@
  void hci_cmd_sync_clear(struct hci_dev *hdev)
  {
  	struct hci_cmd_sync_work_entry *entry, *tmp;
-@@ -574,13 +585,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
+@@ -658,13 +669,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
  	cancel_work_sync(&hdev->reenable_adv_work);
  
  	mutex_lock(&hdev->cmd_sync_work_lock);
@@ -68,7 +71,7 @@
  	mutex_unlock(&hdev->cmd_sync_work_lock);
  }
  
-@@ -669,6 +675,115 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+@@ -756,6 +762,115 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
  }
  EXPORT_SYMBOL(hci_cmd_sync_queue);
  
@@ -184,7 +187,7 @@
  int hci_update_eir_sync(struct hci_dev *hdev)
  {
  	struct hci_cp_write_eir cp;
-@@ -2881,7 +2996,8 @@ int hci_update_passive_scan(struct hci_dev *hdev)
+@@ -3023,7 +3138,8 @@ int hci_update_passive_scan(struct hci_dev *hdev)
  	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
  		return 0;
  
@@ -194,3 +197,6 @@
  }
  
  int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

