Return-Path: <stable+bounces-220376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDaWDPozo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9AC1C5D84
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B32A430DF3B5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F407480352;
	Sat, 28 Feb 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avt9UWA1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323073A3517;
	Sat, 28 Feb 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300271; cv=none; b=imWT7WsTcgpSMl3ZwoUk0of9tdTAr0zYWwrYQ0BirOdGFu7qDsT72F6nECNPO19FGYa2JLbdXr4UCNfWHdu8rc6lXAOsuarsxHCKDfMpKI7Ml8tzpt7wtuct0MeZ1r5F64n86M0wFHdstRs78BHiTPmsaDMBuS4gJ3Wt6zF09zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300271; c=relaxed/simple;
	bh=J9hh2TDRS52hjtfXWjezCpSO0luovuop9OjDEah+r/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ7IhBI7/I6PB3x5QiwFAAPN8Hiv4/+YX5w4p2Vpl6Di3ckbtrYb3WHM2j4b/8Ir2y5VkrnSm031eV7T0h8uCqbtE+FqPhNYE/gWz47FZflM+BPJ05OC0O9HvCoEuwotnb/deYgTePfHnEtneJCHJNnw9mtnztlxDSuv1FPUf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avt9UWA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F17EC2BC87;
	Sat, 28 Feb 2026 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300271;
	bh=J9hh2TDRS52hjtfXWjezCpSO0luovuop9OjDEah+r/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avt9UWA1X74I+QscRvM5ISxL6K+aHtBOocfbRT8TgsBKy/0hjjZ4A7MCgzhv9krlV
	 J6rQxBgpPasy5EL3cxEKcXIDAr4a3FYfl78liFAmbvdMvY2ta10MorJe0Fj2GShxkT
	 kxzEEpRUHopG2w5Q3NA8KpBgeenPjegy4u2M7MTGMYYYJ1B065oCzHuLmiS9akA0EQ
	 5gxboTWZFNLq2rOwe58+Dgm/6NjCZY1GC36aS8VFrOrMDtRmxlbSY5Ez5MxTm4+hOe
	 UF5/AY+AhB4kmwtD/jZ4bGhSgyogeBI1p8+vuUPDIMLLdiGHXE3fKBR8zpxnIctDLP
	 HdDDepXo0WAWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 297/844] wifi: iwlwifi: mvm: check the validity of noa_len
Date: Sat, 28 Feb 2026 12:23:30 -0500
Message-ID: <20260228173244.1509663-298-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220376-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD9AC1C5D84
X-Rspamd-Action: no action

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 1e3fb3c4a8e6c581d0f4533dba887fabf53d607d ]

Validate iwl_probe_resp_data_notif::noa_attr::len_low since we are using
its value to determine the noa_len, which is later used for the NoA
attribute.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251110150012.99b663d9b424.I206fd54c990ca9e1160b9b94fa8be44e67bcc1b9@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 867807abde664..49ffc4ecee855 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1761,6 +1761,20 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
+	/*
+	 * len_low should be 2 + n*13 (where n is the number of descriptors.
+	 * 13 is the size of a NoA descriptor). We can have either one or two
+	 * descriptors.
+	 */
+	if (IWL_FW_CHECK(mvm, notif->noa_active &&
+			 notif->noa_attr.len_low != 2 +
+			 sizeof(struct ieee80211_p2p_noa_desc) &&
+			 notif->noa_attr.len_low != 2 +
+			 sizeof(struct ieee80211_p2p_noa_desc) * 2,
+			 "Invalid noa_attr.len_low (%d)\n",
+			 notif->noa_attr.len_low))
+		return;
+
 	new_data = kzalloc(sizeof(*new_data), GFP_KERNEL);
 	if (!new_data)
 		return;
-- 
2.51.0


