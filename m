Return-Path: <stable+bounces-216563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK+EItfpkGkfdwEAu9opvQ
	(envelope-from <stable+bounces-216563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:32:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F513D90D
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDBD0305E33A
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F21309DB1;
	Sat, 14 Feb 2026 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U10/DzGr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF929ACCD;
	Sat, 14 Feb 2026 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104406; cv=none; b=DPl1Slvo5G4MkJLt+LylJ/EYSE5NBHCxZMxSxXzdwGlXFPMSHTZ0o9itSv8EysQ2CSG0dEtRxWA6+azgUEWFywXlTaTqN2yKRunpl68qF/Y9MoCgKuR0PeiocpGdAWNfQw0GBsMwTV7Xbubr2vart6k7TYyG8pOE7DWcGJRV4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104406; c=relaxed/simple;
	bh=VmLhGHW0EUvOrf9TIBV1CZZi9uF9PDA06c86biELA3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWNE1mE22nNbXZUAGwtvow4j31RVK0IwIZj7RMT84ftKnF2BfSHF2nJKOEO8qZF/j0vxrG9EhFBV4dWjijJcYpIZXGcx58f2FToYpndLPw0xUne+RWte74YVkVy269B163BZGB3BGhZ0Ws5Q1WkYiQ5FhfTMF5aOu5uOIF+5tMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U10/DzGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AE2C16AAE;
	Sat, 14 Feb 2026 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104406;
	bh=VmLhGHW0EUvOrf9TIBV1CZZi9uF9PDA06c86biELA3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U10/DzGrZ8hl6ZnujnZ9mp/gytiiG5f3N1kqDNgD+skz7gygog6j+0tPdjtHIkplu
	 ZWiEJmoU54cTQhOpK0RUZWn8ob71+C7us6OMIGkvZAHhBCnieu5LHXp+SQljBrZmaf
	 3Ekk1mHIIfi1vcf0lPxAubxo7fwr31trcIDY2LNHmv4Pk3gYvn0CNOn18Lb3faNi1t
	 cG2Mm2CjzXzl0g1ViKAVTPw+xgJ1KCg2LmYfx0eXFBTlYP+VttmPCM+Y31cEVt/vLt
	 wAXJBaiipLM9rlojszgLrtYPT9Xz840G/5ZWGRgD8QFuKIRRIxwZR3OLij6xp+HGQL
	 0AafQTHeCVeLA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes.berg@intel.com,
	ilan.peer@intel.com,
	neil.armstrong@linaro.org,
	pagadala.yesu.anjaneyulu@intel.com,
	nidhish.a.n@intel.com,
	yelangyan@huaqin.corp-partner.google.com,
	gustavoars@kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] wifi: iwlwifi: mvm: check the validity of noa_len
Date: Sat, 14 Feb 2026 16:23:31 -0500
Message-ID: <20260214212452.782265-66-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: EB4F513D90D
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

LLM Generated explanations, may be completely bogus:

Good, `IWL_FW_CHECK` is defined and available.

### 7. Summary

**What the fix does**: Adds input validation for the `len_low` field in
NoA (Notice of Absence) attribute data received from Intel Wi-Fi
firmware. Before this fix, an invalid `len_low` value would result in
incorrect `noa_len` calculation, which is subsequently used in
`skb_put()` and `memcpy()` operations when constructing probe response
frames.

**Why it matters**: Without this validation, malformed firmware data
could lead to incorrect frame construction, potentially transmitting
malformed or garbage-containing P2P frames over the air. This is a
defensive validation fix — small, surgical, and zero risk of regression
since valid firmware data will pass the check unaffected.

**Stable criteria assessment**:
- Obviously correct: Yes — the validation logic is straightforward
  (len_low must match one of two known valid values)
- Fixes a real bug: Yes — invalid firmware data leads to incorrect NoA
  length computation used in memcpy
- Small and contained: Yes — 14 lines added in one file, single
  validation check
- No new features: Correct — pure input validation
- Risk: Extremely low — early return on invalid input cannot affect
  valid paths

**YES** — This is a small, surgical input validation fix that prevents
processing invalid firmware data. It meets all stable kernel criteria:
it's obviously correct, fixes a real potential bug (incorrect buffer
lengths derived from unvalidated firmware input), is small and self-
contained, and has near-zero regression risk.

**YES**

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


