Return-Path: <stable+bounces-78040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBA9884D1
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E8CB21AC8
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F018C347;
	Fri, 27 Sep 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JY7UNfMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79318C323;
	Fri, 27 Sep 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440257; cv=none; b=R4csKCMe+ykqPOEi/8jBrUEwl8eAEdTLODZkFyhHWtMP5JLJobIiBbCTAH46Ky3JFwoFyjII6r8mO9m8d5yWx5UELlQllMzfGr/8qyRweVqIWRKyHBSdtyOZ0NSxeRylghewi+EG4h+XR2Civ5J4hvIT1rXY5dlF5BQKiNbaZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440257; c=relaxed/simple;
	bh=FXcd/w03wFD59vrDCgoZSF4H6PmTBoRZVx+HbJNiocM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JygpEFmYUsHbZpV5RQfOcc7ikoT8/zVjNbtR9rzCNAiXlbzqpQlP0lmyQK+eeR4FGbYx5i/ftGpLgpz08ew9nssDLiGq3ZdrLWwgtmxeMF65H5z/9gfyd3jctrvEqUvQ4pKxg8c5X58+wjv4FCa7Hykwh3hHkDL774q9fd+47wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JY7UNfMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F66FC4CEC4;
	Fri, 27 Sep 2024 12:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440256;
	bh=FXcd/w03wFD59vrDCgoZSF4H6PmTBoRZVx+HbJNiocM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JY7UNfMnJAhQLg+3cmpxgjlgHjJmNthX65WerCnSMphZ1dqWUuNrZsu4AYzYLIy2q
	 akOtl5hS6SADRceWxVIQxqMiNPjyyzo9EvnllS6FulqaxGjPaf5n2oC0f250Y2Jdtp
	 WpsrU+Or9QXIg3BYmrVTBCHRet5uJX/Gz3bjx8PM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 17/73] wifi: iwlwifi: clear trans->state earlier upon error
Date: Fri, 27 Sep 2024 14:23:28 +0200
Message-ID: <20240927121720.566907967@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
References: <20240927121719.897851549@linuxfoundation.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 094513f8a2fbddee51b055d8035f995551f98fce ]

When the firmware crashes, we first told the op_mode and only then,
changed the transport's state. This is a problem if the op_mode's
nic_error() handler needs to send a host command: it'll see that the
transport's state still reflects that the firmware is alive.

Today, this has no consequences since we set the STATUS_FW_ERROR bit and
that will prevent sending host commands. iwl_fw_dbg_stop_restart_recording
looks at this bit to know not to send a host command for example.

To fix the hibernation, we needed to reset the firmware without having
an error and checking STATUS_FW_ERROR to see whether the firmware is
alive will no longer hold, so this change is necessary as well.

Change the flow a bit.
Change trans->state before calling the op_mode's nic_error() method and
check trans->state instead of STATUS_FW_ERROR. This will keep the
current behavior of iwl_fw_dbg_stop_restart_recording upon firmware
error, and it'll allow us to call iwl_fw_dbg_stop_restart_recording
safely even if STATUS_FW_ERROR is clear, but yet, the firmware is not
alive.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.9d7427fbdfd7.Ia056ca57029a382c921d6f7b6a6b28fc480f2f22@changeid
[I missed this was a dependency for the hibernation fix, changed
 the commit message a bit accordingly]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3b0ed1cdfa11e..7fadaec777cea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3131,7 +3131,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 70022cadee35b..ad29663a356be 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1472,8 +1472,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
-- 
2.43.0




