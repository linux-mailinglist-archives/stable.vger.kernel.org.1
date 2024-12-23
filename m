Return-Path: <stable+bounces-105628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF69FB030
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261C316CB26
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E21B414B;
	Mon, 23 Dec 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT3MYmjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A8224D7
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964537; cv=none; b=M9PtMGjjA1B+2LksVvilLofSfuBdegF+CEv6hEuMDQd59K9SljI6x9tMBRKkiPwglxZXFyGynp2LOxVMd6bqJOHkYuU9khCMdYbH8+Qs/17cibnrZYFbnS3U85/wXR7Mz6EkKO91/Mt4Fb1YbjxHxd8OheH6cHB+2GC23HyanU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964537; c=relaxed/simple;
	bh=HWyXfhOv0bLGU+qWLZfHZwkv5dijIwb3bhbIfWww3/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSH7+ha52qkbj6vj8Jy+72I9SJBByBHgNbFz8ygmKWQ1kvzWR1SdF8teOlP7TyCnVt2SuPDC6gLZd1d5A2NmfrgC+lx5j+vLBLl3pXz8Tk/ffDmWkexPLSdQh8CY/ZNWaK8vwXy78EDXzPAmJeHhaUUfrpLtxzQmPwyd12IB4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT3MYmjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048DDC4CEDD;
	Mon, 23 Dec 2024 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734964537;
	bh=HWyXfhOv0bLGU+qWLZfHZwkv5dijIwb3bhbIfWww3/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WT3MYmjU5xA1g7jPVGGkBqA5cprZFyb7viSlxjQ6rA9dKv8krHznUWIzBO+C1vglh
	 TIdETG/iqXygRGkqqGnVsXXFA/PupG3+Th/fCLeVFjfjGUJBTrU3ccb+dugkWKkgYi
	 +OlLzM5KRLwqWbtPrUBCjvTB2hSORMp69G8ItO6hDbUA6rCY7QDa9Iq269Slz3LbHF
	 3NoYFqvIsQewFfUfSaycBJgzK2vtkrhephYI1yGkm3yTvsqzZAb5VtAVYPIo5VqKLH
	 pAUzIUUj3o/LnL4zcwx9OmoQd44OGTje4IUiOGpe2CwH5ypKjXgxHJ72X3rVxdjtFf
	 wc6n0FEa09GLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] wifi: iwlwifi: be less noisy if the NIC is dead in S3
Date: Mon, 23 Dec 2024 09:35:35 -0500
Message-Id: <20241223093130-c43ea648ac07fcc0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241223121359.65312-1-emmanuel.grumbach@intel.com>
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

The upstream commit SHA1 provided is correct: 0572b7715ffd2cac20aac00333706f3094028180


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0572b7715ffd ! 1:  b10ffc08e8ba wifi: iwlwifi: be less noisy if the NIC is dead in S3
    @@ Metadata
      ## Commit message ##
         wifi: iwlwifi: be less noisy if the NIC is dead in S3
     
    +    commit 0572b7715ffd2cac20aac00333706f3094028180 upstream
    +
         If the NIC is dead upon resume, try to catch the error earlier and exit
         earlier. We'll print less error messages and get to the same recovery
         path as before: reload the firmware.
    @@ Commit message
         Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
         Link: https://patch.msgid.link/20241028135215.3a18682261e5.I18f336a4537378a4c1a8537d7246cee1fc82b42c@changeid
         Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    -
    - ## drivers/net/wireless/intel/iwlwifi/fw/dump.c ##
    -@@ drivers/net/wireless/intel/iwlwifi/fw/dump.c: bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id)
    - 		/* cf. struct iwl_error_event_table */
    - 		u32 valid;
    - 		__le32 err_id;
    --	} err_info;
    -+	} err_info = {};
    -+	int ret;
    - 
    - 	if (!base)
    - 		return false;
    - 
    --	iwl_trans_read_mem_bytes(trans, base,
    --				 &err_info, sizeof(err_info));
    -+	ret = iwl_trans_read_mem_bytes(trans, base,
    -+				       &err_info, sizeof(err_info));
    -+
    -+	if (ret)
    -+		return true;
    -+
    - 	if (err_info.valid && err_id)
    - 		*err_id = le32_to_cpu(err_info.err_id);
    - 
    +    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219597
     
      ## drivers/net/wireless/intel/iwlwifi/iwl-trans.h ##
     @@ drivers/net/wireless/intel/iwlwifi/iwl-trans.h: int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
    @@ drivers/net/wireless/intel/iwlwifi/iwl-trans.h: int iwl_trans_read_config32(stru
      			    u64 src_addr, u32 byte_cnt);
     
      ## drivers/net/wireless/intel/iwlwifi/mvm/d3.c ##
    -@@ drivers/net/wireless/intel/iwlwifi/mvm/d3.c: static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
    - 		ieee80211_resume_disconnect(vif);
    - }
    +@@ drivers/net/wireless/intel/iwlwifi/mvm/d3.c: static bool iwl_mvm_rt_status(struct iwl_trans *trans, u32 base, u32 *err_id)
    + 		/* cf. struct iwl_error_event_table */
    + 		u32 valid;
    + 		__le32 err_id;
    +-	} err_info;
    ++	} err_info = {};
    ++	int ret;
    + 
    + 	if (!base)
    + 		return false;
    + 
    +-	iwl_trans_read_mem_bytes(trans, base,
    +-				 &err_info, sizeof(err_info));
    ++	ret = iwl_trans_read_mem_bytes(trans, base,
    ++				       &err_info, sizeof(err_info));
    ++
    ++	if (ret)
    ++		return true;
    ++
    + 	if (err_info.valid && err_id)
    + 		*err_id = le32_to_cpu(err_info.err_id);
      
    --
    - static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
    - 				   struct ieee80211_vif *vif)
    - {
     @@ drivers/net/wireless/intel/iwlwifi/mvm/d3.c: int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
      	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

