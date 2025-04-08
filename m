Return-Path: <stable+bounces-130335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2EDA8044C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D3D4666E5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AE268FD9;
	Tue,  8 Apr 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/VBJnVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAB20CCD8;
	Tue,  8 Apr 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113446; cv=none; b=GFJDFYBtTCPtL9qee0uQ55RcNYYjtPO7Beu3DeU2hZ3lNSxZaeaHScjwLwZhCR1Z5s/1AUyRcbNtQRw1JioCA9j19NqsZsY7m+TNsFIDV7iK+C9NXBRDB54/ppKEpoAGk7efn3ueNOtCSvLyk7E3OeOUAL4TXtYR7h3y9niDnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113446; c=relaxed/simple;
	bh=28kz5tWN5w+Cf2t3Nro1yMdNwqVkImSKLBC3Q1EtdoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx2Qj9wnQ9DOee5ZQju75tOkLagGG/N/wns02Sw724N1Qj86ZK1/W7sE7JUDoL2eoiA2Amryd7cgowLO4+lS3r0HgXIN10Vd2mzZbo0cQ8cY2hG9HjMz1Jv1PaRWZ9638QB73Opif0at8/DzMx0ndcUi1vBwuxxXtUzN9b8ERjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/VBJnVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F64C4CEE7;
	Tue,  8 Apr 2025 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113446;
	bh=28kz5tWN5w+Cf2t3Nro1yMdNwqVkImSKLBC3Q1EtdoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/VBJnVNxnh4Af00mVLK8VhXt/2NUmyK0xX7HAgNZ3ImEd39VknJH+yQIOHcs1kPd
	 gaLODl9cSsyT/UiQxbNrDyllhYGwTDFtz9RklaAGBdaZZ5lSmTWCMGMFUtvbzYwwTQ
	 3p1hKZnVdg8eLcYJuiqgQkKw3N2CdqNDo0rtNrBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 163/268] wifi: iwlwifi: mvm: use the right version of the rate API
Date: Tue,  8 Apr 2025 12:49:34 +0200
Message-ID: <20250408104832.948576033@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
User-Agent: quilt/0.68
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

[ Upstream commit a03e2082e678ea10d0d8bdf3ed933eb05a8ddbb0 ]

The firmware uses the newer version of the API in recent devices. For
older devices, we translate the rate to the new format.
Don't parse the rate with old parsing macros.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250209143303.13d70cdcbb4e.Ic92193bce4013b70a823cfef250ee79c16cf7c17@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 8cff24d5f5f40..e4efd3349bc1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1275,7 +1275,7 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 	 */
 	u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
 	u32 rate_n_flags = phy_data->rate_n_flags;
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 	u8 offs = 0;
 
 	rx_status->bw = RATE_INFO_BW_HE_RU;
@@ -1330,13 +1330,13 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 
 	if (he_mu)
 		he_mu->flags2 |=
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
-	else if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
+	else if (he_type == RATE_MCS_HE_TYPE_TRIG)
 		he->data6 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
-			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
+			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK,
 						   rate_n_flags),
 					 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
 }
-- 
2.39.5




