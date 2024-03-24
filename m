Return-Path: <stable+bounces-31177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F68896D1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CD21C2FF0D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9991FB716;
	Mon, 25 Mar 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUWF+Tor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2043E48E;
	Sun, 24 Mar 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320664; cv=none; b=i9rJqh5kzvLsTWnoXH48CDUrZkEpCF66H2OskgQY5wzSv54Ep+vVd11tzTDLfpD6v6oFWOM/zsPBL+pbwJNVLHJfsZ0QFHQCfIX+kcGsnxLvCTTWd7d5wIi0/lm0qCBRElpyKX9aQMMzkJW7CLXFuxCiZDsdySMr8P1QgUS9uuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320664; c=relaxed/simple;
	bh=1PGCOGFGQekBR5Mt3AhH2f54nkQPkDJdQWf0hZtQN5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuyKQasMkMQw9rdNxyJxgGmCN62CAmaz/dExjt73ha069aGK6z1n3GYsPiXlZq39ibD4F5h3ZAiEmGDKcRbo7kwqykBCPiwUk5f+ov26t5tYvf6HmWcK1ZEsEyf72SJE0QBI/vBr60OgEjs0bNbWu9/xvmVLizUQWqCbUBixOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUWF+Tor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19627C4166A;
	Sun, 24 Mar 2024 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320663;
	bh=1PGCOGFGQekBR5Mt3AhH2f54nkQPkDJdQWf0hZtQN5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUWF+TorbshlAeGV/s7d/Wx1jPp6yHr9kd3aoabxqSdzKIzfN1vupRj2EPgm6h2r6
	 0w08ZuZczopFRaOQ0Xrq2xTNW7rJdShlToAg/RIQXTBkD1syZzRH6lqQc/A1YLKOTM
	 gVg3UzAkY/tEg6eovN/c9foevjOzsbemb5M6TymPh1h3XmhfE3nFFLfkI0f+vVAkU8
	 UGuKruHOk7rohcJcyaZznWOKCWsZ4meIWkZbZdxXPwxPB4TGkOBiAv1lDadMXnWEDR
	 RcOtj9XmeiCG20qwG3SFqnAU60QsIXx8iG/5SOp167DtV38vFfCw6kDcOUZ4EZoBqh
	 RwIo5OeZM13iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 226/713] wifi: iwlwifi: support EHT for WH
Date: Sun, 24 Mar 2024 18:39:12 -0400
Message-ID: <20240324224720.1345309-227-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit f51d6431824f0afb9f73d68971d154c47c26b86a ]

sku_cap_11be_enable should be set to true also for WH.

Fixes: e1374ed25324 ("wifi: iwlwifi: Add support for new CNVi (SC)")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Link: https://msgid.link/20240204235836.a6d4097cbaca.I8b00fa7b6226b4116cd91f70fb0b15e79b4dee5a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 678c4a071869f..d85cadd8e16cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -2090,7 +2090,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
-	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM)
+	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
 		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
-- 
2.43.0


