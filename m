Return-Path: <stable+bounces-1038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5897F7DB5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9A8282244
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067CE3A8E5;
	Fri, 24 Nov 2023 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/YFvvn3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9E3A8E1;
	Fri, 24 Nov 2023 18:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C81EC433CA;
	Fri, 24 Nov 2023 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850404;
	bh=oCt0HykvEunDrqCfPpOXJlinRpeLYxOt4nm26pcKcHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/YFvvn3vkSaJl9kqDLBAl0W1plcLxCOjpolcAUXB45ODOFSjjGFYPLpZsS5+JMwx
	 ymzjdT3Xac+rBItd3T2/3hZZf3Hm7WCU9Huesfk/XzjY3hxx0HLkbnOCKbSk47F3Zx
	 mYqh1nmxKUOpQ7JV/rG4fr7Y1lVnIRJqjLRnMGG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 036/491] wifi: iwlwifi: mvm: fix size check for fw_link_id
Date: Fri, 24 Nov 2023 17:44:32 +0000
Message-ID: <20231124172025.781661380@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit e25bd1853cc8308158d97e5b3696ea3689fa0840 ]

Check that fw_link_id does not exceed the size of link_id_to_link_conf
array. There's no any codepath that can cause that, but it's still
safer to verify in case fw_link_id gets corrupted.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231017115047.3385bd11f423.I2d30fdb464f951c648217553c47901857a0046c7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 6e1ad65527d12..4ab55a1fcbf04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -60,7 +60,7 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
 		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
 								    mvmvif);
-		if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
+		if (link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf))
 			return -EINVAL;
 
 		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
@@ -243,7 +243,7 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int ret;
 
 	if (WARN_ON(!link_info ||
-		    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+		    link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
 		return -EINVAL;
 
 	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
-- 
2.42.0




