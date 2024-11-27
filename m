Return-Path: <stable+bounces-95640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F69DAB8B
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BE165000
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AF200B82;
	Wed, 27 Nov 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaV8g6by"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C71FF7DB
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724114; cv=none; b=FIzwdDo1QFEasKCwnbX3kd4UWl9Yiff+beGbxbEZOVLghQfdn1PoCpESUSv4hElez8j3TRcjZBZZpFbJAxTzbu/t9kF0cwxzeuGlF49+MWFvK4WuRRMa8OpCtsNGcbQRWQ+xGfpwwSFymz4ll8fu1In4uOC1O87zKYe+xJHJlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724114; c=relaxed/simple;
	bh=kn/RqTxAPfN+XofBCm4ReCO91uXQ7YIGcJfNrTj1cdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6FKQpMdPzkgMr3gyT7lDQt7QCeiBAoXTKrBRJNBiq5T8pgdpW/OT/7vOfnFF3QrbbC4UrFjFj+TlGlb9PnN0bjsatxW/Y1k4U5Kt5fNbhwDQrFScvnDf4caG8M/SZd8Y/jmeGXC8z5x22/DeAVwGWp7AYE4Ns7Wzz7AmFRmhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaV8g6by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFE4C4CED2;
	Wed, 27 Nov 2024 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724113;
	bh=kn/RqTxAPfN+XofBCm4ReCO91uXQ7YIGcJfNrTj1cdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaV8g6by9AX+C+s89w2JXZElUUxQcF0hLDZtwUeLu8VfTRUg+D6RIyIWVk0eiYXsx
	 XAFG7s3U/Jhw2m6TwY+lH21TE5SySj27qaZKMm202hDiL+jI/5Ptbsw6mDrROm1O5/
	 OLbCJkAsXwrXsfji1A3I2VYo9llqapbUr5bc9zngTii/W3qI/FOe7or6VXSsgp9J7+
	 H1hDQJKns8uaxZwHhoTsCuXb84uDH8v3pemPMbbg1UqHQHpUkVHfBUzy/9mNYtNH3+
	 VIt/AtopMeXNc7L0OS2Fom9hjXmfGzLy+eMl7/1fq+pPFaDB+Ko1BSx0SEh83UHFKI
	 Qo/O8WiHNAc8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] wifi: iwlwifi: mvm: avoid NULL pointer dereference
Date: Wed, 27 Nov 2024 11:15:12 -0500
Message-ID: <20241127111449-fb2921100b76debb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127114959.1859460-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 557a6cd847645e667f3b362560bd7e7c09aac284

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Miri Korenblit <miriam.rachel.korenblit@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: c0b4f5d94934)
6.6.y | Present (different SHA1: 6dcadb2ed3b7)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 11:10:11.665423970 -0500
+++ /tmp/tmp.HPjq0KxGeN	2024-11-27 11:10:11.649712662 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 557a6cd847645e667f3b362560bd7e7c09aac284 ]
+
 iwl_mvm_tx_skb_sta() and iwl_mvm_tx_mpdu() verify that the mvmvsta
 pointer is not NULL.
 It retrieves this pointer using iwl_mvm_sta_from_mac80211, which is
@@ -11,15 +13,17 @@
 Reviewed-by: Johannes Berg <johannes.berg@intel.com>
 Link: https://patch.msgid.link/20240825191257.880921ce23b7.I340052d70ab6d3410724ce955eb00da10e08188f@changeid
 Signed-off-by: Johannes Berg <johannes.berg@intel.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++-----
  1 file changed, 7 insertions(+), 5 deletions(-)
 
 diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
-index 7ff5ea5e7aca5..db926b2f4d8d5 100644
+index 76219486b9c2..43a732b0c168 100644
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
-@@ -1203,6 +1203,9 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
+@@ -1105,6 +1105,9 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
  	bool is_ampdu = false;
  	int hdrlen;
  
@@ -29,17 +33,17 @@
  	mvmsta = iwl_mvm_sta_from_mac80211(sta);
  	fc = hdr->frame_control;
  	hdrlen = ieee80211_hdrlen(fc);
-@@ -1210,9 +1213,6 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
+@@ -1112,9 +1115,6 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
  	if (IWL_MVM_NON_TRANSMITTING_AP && ieee80211_is_probe_resp(fc))
  		return -1;
  
 -	if (WARN_ON_ONCE(!mvmsta))
 -		return -1;
 -
- 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
+ 	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
  		return -1;
  
-@@ -1343,7 +1343,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
+@@ -1242,16 +1242,18 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
  int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
  		       struct ieee80211_sta *sta)
  {
@@ -47,10 +51,9 @@
 +	struct iwl_mvm_sta *mvmsta;
  	struct ieee80211_tx_info info;
  	struct sk_buff_head mpdus_skbs;
- 	struct ieee80211_vif *vif;
-@@ -1352,9 +1352,11 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
+ 	unsigned int payload_len;
+ 	int ret;
  	struct sk_buff *orig_skb = skb;
- 	const u8 *addr3;
  
 -	if (WARN_ON_ONCE(!mvmsta))
 +	if (WARN_ON_ONCE(!sta))
@@ -58,6 +61,9 @@
  
 +	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 +
- 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
+ 	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
  		return -1;
  
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

