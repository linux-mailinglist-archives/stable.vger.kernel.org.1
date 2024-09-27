Return-Path: <stable+bounces-77916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DA988431
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF21F22623
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947318BC0D;
	Fri, 27 Sep 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0dLv4egJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938418A92A;
	Fri, 27 Sep 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439911; cv=none; b=srfw4/HkklyMMQtRIdP68gl/2lD6P6KRK4a9YHGuPFL9RkAx5aSY8KxJS+s8Ttuuqab9AjQYiD7nHq5OzcsZXgt+Rw5IzEz0l+3VkWXAPtuB6Mde6ZJlZ9myPA/cWO7fk0ou96VUnGJz6RQ6T5pZpodvwZNamyCGWTNZNrsHxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439911; c=relaxed/simple;
	bh=Pu3mAyE0dFwKXC7w2ZdvIf6AxeVS8owwqNvsxEjl+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6v7TFliirJfLG6QeSC+HcsKlivRzyGHJR54ZlA8xFdBG5vez/+RBNUH6QafRs/ZZWvkFNbouFQpoc0V+nSaDEIRfQNWmwNAPVPfsH7BZQBjSRrmWSO7dgWihBjQ5256KkR6gd5ogzwfB0aYuqHqe0+uZp+AsS/FHhOmdXBJXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0dLv4egJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D01C4CEC4;
	Fri, 27 Sep 2024 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727439911;
	bh=Pu3mAyE0dFwKXC7w2ZdvIf6AxeVS8owwqNvsxEjl+sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0dLv4egJmGBSyvWtlBdyT2e+MhCUyu+gzkXMP6zPeczcoh48G7bJ0kQnsSYwUkqH/
	 /OBPi9PDR8gVW7FMY/RbZY4S0wafxu8D5A4ns4WstDesQlHTddgeFEXnNtQHWp+z4E
	 LvsPnqTK6ajhndISJ9pL60U06oxAwn1bKZ/YOezA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 20/54] wifi: iwlwifi: clear trans->state earlier upon error
Date: Fri, 27 Sep 2024 14:23:12 +0200
Message-ID: <20240927121720.520375643@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 62aee4965021d..2a408e1ce06ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3206,7 +3206,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9dcc1506bd0b0..e8f48cb8d2da1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1554,8 +1554,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
-- 
2.43.0




