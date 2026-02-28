Return-Path: <stable+bounces-220375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN6bIFJHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:51:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD81C76FB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19ADC321AED1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94573A4438;
	Sat, 28 Feb 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krd5snGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D23A442E;
	Sat, 28 Feb 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300270; cv=none; b=cJ/WNhhZ4Vaqrp3CtzPefcBVtQdq3KQ/v3wvxG++rWTn3j4pevwWfKD3BUdDfxCvD7ZqWmbpUQAI9N2Anyl1giXMRsxvBQ+rQKdB/bOKDs6PZ6LCMjUwxSJDvoEFVhNPHSYZ6oxjjRzo3r+D3CFg/LcKfED1wDXN8P1xxe+rFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300270; c=relaxed/simple;
	bh=bJq2LZ/QHMgMd9+Pf3DGjsGyDKmiuUdJu/6wChtH6Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R44kulU6forg9T5kLErbmRZi6oz5nYg166oi4ODBfRqTlDxgtlfl8pVmb59Hc+dszhJiN5muOwzL00MwkySp63/nIqEIqeLb3ZyjpZfVjMkW9gAf2cDKKJ1SzbM3a893JlLlxj53rG0GV9XH7dxpl5eh0gx0tHpn5wzgddsWIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krd5snGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B552BC19425;
	Sat, 28 Feb 2026 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300270;
	bh=bJq2LZ/QHMgMd9+Pf3DGjsGyDKmiuUdJu/6wChtH6Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krd5snGXchRFuJxYUiTbf3bitRcX2Ypgny81OwTOdr3J1cz9P4CPVp2n43+zIKJuW
	 W6MKWHwFXkItFVq8JXOLpwhXVaF8AR/ursGqEAa2uTepzrVirzXDSWQ4/PuKZ4JJAV
	 m/1rBWvwSzhCUfGZuSQDvM78LznQ4eBc2mXyppLWwVoO3IL7aCEHxN4sTxbq1Tk7A7
	 0GdhshPTrPb83TEtxNAO182qx8cgL81ufhbn5uTiYdctG4c8d5E4GHuE72rGkf2YPs
	 WufQ+xR7vdKS99ZdwpBfviTaU/isUTOf1icJZC2kqwpB7JWEMlUbWn5GLbxhoyf8n5
	 lDKw/HQz6n2OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 296/844] wifi: iwlwifi: mld: Handle rate selection for NAN interface
Date: Sat, 28 Feb 2026 12:23:29 -0500
Message-ID: <20260228173244.1509663-297-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220375-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: ACBD81C76FB
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit dbbeebece03050cd510073ce89fee83844e06b00 ]

Frames transmitted over a NAN interface might not have channel
information assigned to them. In such cases assign the lowest
OFDM to the frame.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251110180612.72046f98f878.Ib784931fffd0747acd9d7bb22eabbbec5282733e@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 3b4b575aadaa5..e3fb4fc4f452e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -345,6 +345,11 @@ u8 iwl_mld_get_lowest_rate(struct iwl_mld *mld,
 
 	iwl_mld_get_basic_rates_and_band(mld, vif, info, &basic_rates, &band);
 
+	if (band >= NUM_NL80211_BANDS) {
+		WARN_ON(vif->type != NL80211_IFTYPE_NAN);
+		return IWL_FIRST_OFDM_RATE;
+	}
+
 	sband = mld->hw->wiphy->bands[band];
 	for_each_set_bit(i, &basic_rates, BITS_PER_LONG) {
 		u16 hw = sband->bitrates[i].hw_value;
-- 
2.51.0


