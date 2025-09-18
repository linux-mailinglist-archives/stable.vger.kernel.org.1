Return-Path: <stable+bounces-169004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F9B237B1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536E15657F5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5630223DFF;
	Tue, 12 Aug 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zKGFHC/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3426FA77;
	Tue, 12 Aug 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026059; cv=none; b=JnvV0pLq/7oPCx0ZIZMBxbb+jEaGUZDPlbu3F7yXM5muEAVNglAXyRpRu7M1aL1CHlgv2s/pRC9J3RN81alvdguTy0xoNCKno518uafQRUugqAfxV7StaXYTL5ldTvn7wfAps+dfYuU0SMM6/5oHPr/Auj3ClkjxQYSn8nf4IfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026059; c=relaxed/simple;
	bh=OxO+58LzBqivghlQSGpKNUKztQVD20TEjN8pewrFWVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcPMcNihWWBHh2PxX/1qEyVmerEMmr1pcLc0/yeyNma68aXJPXQnP78ilQvVJERlXI6pPync/ksMoDDa34eSYxCZjmXAlQtgI09JdOfmrTyTcfTZG7cWwlFvql8npeNyNfYleBmG0gc2azSLC22XJuUBUfI3FoZNUyeBuNxMKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zKGFHC/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC75DC4CEF1;
	Tue, 12 Aug 2025 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026059;
	bh=OxO+58LzBqivghlQSGpKNUKztQVD20TEjN8pewrFWVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zKGFHC/Vq85atJXCCv9sZwmaw3yqlstGo35u5FVHbobBRc5dgYuJcjL/mblmONOL2
	 YQ4A7m8hpIWvWF5CW2Zho0WrcT/dFPe0RBuXuVGhR9rn+qn7i/CrLsXgCEmSLeRhAw
	 vhxpY4njHycW2K0y+j3fgOXOwBpwp/aQw1gTQf8o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 191/480] wifi: iwlwifi: mld: decode EOF bit for AMPDUs
Date: Tue, 12 Aug 2025 19:46:39 +0200
Message-ID: <20250812174405.378138015@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit bc404dfddbf6817cae9b170c34556dc72ea975e5 ]

Only the EOF bit handling for single frames was ported to the MLD
driver. The code to handle AMPDUs correctly was forgotten. Add it back
so that the bit is reported in the radiotap headers again.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250723094230.195be86372d5.I4db4abf348f7b6dfc75f869770dd77655a204bc7@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index c4f189bcece2..5a206a663470 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1039,6 +1039,15 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
 	}
 
+	/* update aggregation data for monitor sake on default queue */
+	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
+	    (phy_info & IWL_RX_MPDU_PHY_AMPDU) && phy_data->first_subframe) {
+		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+		if (phy_data->data0 &
+		    cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
+	}
+
 	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
 		iwl_mld_decode_eht_phy_data(mld, phy_data, rx_status, eht, usig);
 
-- 
2.39.5




