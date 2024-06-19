Return-Path: <stable+bounces-53868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44490EB92
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104791C24281
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37812145352;
	Wed, 19 Jun 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwugSurI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCB1442F1;
	Wed, 19 Jun 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801910; cv=none; b=NhWaI7hZgBUZehNUS+jZmeh903n5lrzTcqcfmefMnnIUAq9Pq2om5mWxABySEpPpeC7BQ/E/0tp2AgV5rS9ltI2IokGQBHcH1do8mzhP0MhVpxF8Uv/gNlXxPoRv1s7ZVbsszv5nKbCg0HtZHCT3ViuU5vJvftMxuGVzvrCsrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801910; c=relaxed/simple;
	bh=gKx9kV1eLFIz915bDwRP8KuKXtY4ZktEIuMap9aDkAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXym/dXa1vI+iFsXl6gSfXYIAzjGWIUgcwZ/+nqN1N5gWi9L0MdGnQB2wtOO7AnRKny+QJ7viItuxElp5hZc8EFQuGiXPESL5A2SoXXSlHJeLDJBcg20OWj1robUDwI2WnmcmYjbMJNPWrMoHCgmK84Ml3WOoSm5DUdEwYx1dJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwugSurI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7A6C2BBFC;
	Wed, 19 Jun 2024 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718801909;
	bh=gKx9kV1eLFIz915bDwRP8KuKXtY4ZktEIuMap9aDkAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwugSurI7aFeDxtNe8t0bOgIdPCa9QjACs2ikopBYWe2jPSYDgBIuI2JMNksSFeN4
	 TbLDD98kUbaRwoSxhwixdDBOIldwbUg3MyeQBAYQSDNk7QEg/Np1//oIrn9h9CT1v2
	 qo8Ynif+Ex1M+lA8NPOkkw8Vj0I41DgtQ/RIjprA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/267] wifi: iwlwifi: mvm: dont initialize csa_work twice
Date: Wed, 19 Jun 2024 14:52:37 +0200
Message-ID: <20240619125606.597174714@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 92158790ce4391ce4c35d8dfbce759195e4724cb ]

The initialization of this worker moved to iwl_mvm_mac_init_mvmvif
but we removed only from the pre-MLD version of the add_interface
callback. Remove it also from the MLD version.

Fixes: 0bcc2155983e ("wifi: iwlwifi: mvm: init vif works only once")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240512152312.4f15b41604f0.Iec912158e5a706175531d3736d77d25adf02fba4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index aef8824469e1e..4d9a872818a52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -73,8 +73,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		goto out_free_bf;
 
 	iwl_mvm_tcm_add_vif(mvm, vif);
-	INIT_DELAYED_WORK(&mvmvif->csa_work,
-			  iwl_mvm_channel_switch_disconnect_wk);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = true;
-- 
2.43.0




