Return-Path: <stable+bounces-57273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C5925BDD
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E38A1F22615
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78698194C8B;
	Wed,  3 Jul 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpZJA4Kx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA2191F7B;
	Wed,  3 Jul 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004381; cv=none; b=mQrgK4KLRom9rGJzaKHKcBr15uRmST1KMYd2EAxH8mi8hNo8qKWVH/DliZGDFEucsK1us2HsiuAG0wviQgsfHo/4j1z/wOwPerriz8Wqq5qoQ8Pw09VUf8Oj1RzmdWV4z2DJSf5XQbmWPR8OvPCDqsCyZHv0t1vFr1rmCrLZbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004381; c=relaxed/simple;
	bh=mnUVkVYam6ohkN4qg/9G5IGGFJOB7DDtcPCv2+R+KmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFbMnb9h3tzuIorg5hJfmsJyn9iAMvXT8HK7fi5HptLyHmEVz2p68CLT9HXsX19Gu6zOZJoDb5ET4qjWIyUM9O9pfX/tYEzXMUEnTNjXzl2sc7fEuEzrBq27RPsQiD31gxXl49u5VLB8YVpC3YOxwDOYeRXdAR2IOYmGR4eeNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpZJA4Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00B3C2BD10;
	Wed,  3 Jul 2024 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004381;
	bh=mnUVkVYam6ohkN4qg/9G5IGGFJOB7DDtcPCv2+R+KmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xpZJA4KxzJbob/cDOvz/9PSQKMP9BcSQi/n1PwA2iqvzjNwKD8qRFJ1HDmi7p7XaD
	 m1YuxBgIFjtFVbIBd8QYSp4FNfn2bz1LUg+Fs92k8Eu8M/p2DsRZri0pfvez0Ddzq7
	 QR+n2BX8wH1g0FOXxUX8gOuaGrTpsJlp8yIdcoEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 008/290] wifi: iwlwifi: mvm: check n_ssids before accessing the ssids
Date: Wed,  3 Jul 2024 12:36:29 +0200
Message-ID: <20240703102904.496440955@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 60d62757df30b74bf397a2847a6db7385c6ee281 ]

In some versions of cfg80211, the ssids poinet might be a valid one even
though n_ssids is 0. Accessing the pointer in this case will cuase an
out-of-bound access. Fix this by checking n_ssids first.

Fixes: c1a7515393e4 ("iwlwifi: mvm: add adaptive dwell support")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240513132416.6e4d1762bf0d.I5a0e6cc8f02050a766db704d15594c61fe583d45@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 17b9925266947..a9df48c75155b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1354,7 +1354,7 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		if (IWL_MVM_ADWELL_MAX_BUDGET)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-		else if (params->ssids && params->ssids[0].ssid_len)
+		else if (params->n_ssids && params->ssids[0].ssid_len)
 			cmd->v7.adwell_max_budget =
 				cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 		else
@@ -1456,7 +1456,7 @@ iwl_mvm_scan_umac_dwell_v10(struct iwl_mvm *mvm,
 	if (IWL_MVM_ADWELL_MAX_BUDGET)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
-	else if (params->ssids && params->ssids[0].ssid_len)
+	else if (params->n_ssids && params->ssids[0].ssid_len)
 		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 	else
-- 
2.43.0




