Return-Path: <stable+bounces-28852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60398880D0
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 00:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032231C212DD
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D39137926;
	Sun, 24 Mar 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PES7IwWn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10D13791C;
	Sun, 24 Mar 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319830; cv=none; b=Pcd+Su1EyiY9b2HGldY7lPwZgLychPTf+n+gSen8vn8SrxqeHKLnAO/puAHzzPEGn3LIMi9bme7FSKq3MA/HYa/Clis4LRy92clVTsjJ7dmnvn9p+VtBILVfOnlZ2vDSI9IbrbW8PDXSM3F58kOn5dLVlxC9zO0LIZiAJSO4g40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319830; c=relaxed/simple;
	bh=/DKVbN6tduAwbcxg3CQbSjcbip6MeRF1LCLPOK6gFqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMK+k0V7FaItgPeRyubfGHIP9pEDF5GPKO0yELDT3dCIEBU+x/RauD+25/Jacmgeks5ejDuniqHiU8lmIF8uxgApOMA32/rS7R6dr4ArwU8hoXb53iWiG8clne422qa3L9+u2vxINLlNSFblvf10OKvhbhQiiklvitlsk7S2RQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PES7IwWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D2C433A6;
	Sun, 24 Mar 2024 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319830;
	bh=/DKVbN6tduAwbcxg3CQbSjcbip6MeRF1LCLPOK6gFqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PES7IwWns0Pmim+PGGBhL3OD5iV1/qT7S8qetMYnhfJohWGscrTrqIOi3gpPZkREj
	 d5MV9p0JEtbObBdBlaHBe0I6dtFQsFQ+cdfRKa2lKGXnZ5IkuMsbG2fCabf3R6yWkh
	 yef7cWGIyEaS9Rp6iG0Sn4qblvvWDLDjR7QfQjQyWQeA5CfT1ThBRJJSDEetqjnpqC
	 3ltt5uses5091ltZEA3enNF8Q4oA+7Y71v/fWGoi22o8UzGe0j4OenySf/SM6HIS93
	 N4xMJvS0DPZm+QjVaO6D1Er/uuc+V9DA81BhJzc3atNLdZCL4ddKx+Z/p9PB/8a85d
	 1866ZdKOxTVOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 132/715] wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
Date: Sun, 24 Mar 2024 18:25:11 -0400
Message-ID: <20240324223455.1342824-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 0fcdf55fced7121c43fa576433986f1c04115b73 ]

ADD_STA resets the link quality data inside the firmware. This is not
supposed to happen and has been fixed for newer devices. For older
devices (AX201 and down), this makes us send frames with rates that are
not in the TLC table.

Fixes: 5a86dcb4a908 ("wifi: iwlwifi: mvm: update station's MFP flag after association")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240129211905.1deca7eaff14.I597abd7aab36fdab4aa8311a48c98a3d5bd433ba@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 346512696bd1c..f60d4258e1b95 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3809,13 +3809,17 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 	mvm_sta->authorized = true;
 
-	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
-
 	/* MFP is set by default before the station is authorized.
 	 * Clear it here in case it's not used.
 	 */
-	if (!sta->mfp)
-		return callbacks->update_sta(mvm, vif, sta);
+	if (!sta->mfp) {
+		int ret = callbacks->update_sta(mvm, vif, sta);
+
+		if (ret)
+			return ret;
+	}
+
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	return 0;
 }
-- 
2.43.0


