Return-Path: <stable+bounces-220378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLyjCwE0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C931C5DA2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36D9830E49F7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420433A4D1B;
	Sat, 28 Feb 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZki4Q4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E33A4D13;
	Sat, 28 Feb 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300273; cv=none; b=teCruZ0zdueeo9B/G9LeXjOmkabLAT1arzXf35eyZNhZFeOyDzE9tKD0cwM2F8kibk4POqWAgRDCck66qfOIYxZi6W5sXVdOkJmr/m4NPAAfK8GFla8wUJA7S9lS2EZMKovHR/ggyPDMHregzVe/sQZCHusa7ZQ9hP2NuIGLARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300273; c=relaxed/simple;
	bh=fDYPcimZDZhPGyE2cEZ+FxCWO3FkJ2vofv7HgYRbTFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy8SNduusTcrS3I1pVt2Qkx6zc7uScDi81qh4JryTe2uH42oB5y9yNYv3fjMlP6ao+8uoGanzJfGzSIFPfFird+XNf70iB7MHRAOgyU2mQZloE/S0CZc1i4kwdZ6xOApq6LfeocEmhrzc5sDkuLMT+7L6LqMNgHFabUVMen1DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvZki4Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24628C2BC87;
	Sat, 28 Feb 2026 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300272;
	bh=fDYPcimZDZhPGyE2cEZ+FxCWO3FkJ2vofv7HgYRbTFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvZki4Q4nXV3dETx1LsvyRYgxBHZSqa2UWkFRCAmifWVKUlw8jQk6CFGyFXtVJ8Bf
	 9VCy4bgwivzKM3pmnCtp88cCT3qtZWw1ai0TuKMZ5HQJuAClVzMeOA+ukzLo7gX4wP
	 62inojGDY6958imEGCYy6fKD8rNSFgDv24wqw7o3aQRx+RzZjcJwBBujBi3OCso8g1
	 XubS5k3muWzn4tYEpMOijeqjwZ4c7fZGoGMHDUSQifpUWSaAvbhDLnwJSgr+6PO+xU
	 tXC9ExGi4k5/bYQzWKviTlP8ixuDRKHZ3rvySlwJQF+J3UUKWLf2v9g/XVuiJriQh1
	 NWbGTXgAC5L+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 299/844] wifi: iwlwifi: mld: fix chandef start calculation
Date: Sat, 28 Feb 2026 12:23:32 -0500
Message-ID: <20260228173244.1509663-300-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220378-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C7C931C5DA2
X-Rspamd-Action: no action

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit d2fcdf36554316cc51f7928b777944738d06e332 ]

A link pair in which both links are in 5 GHz can be used for EMLSR only
if they are separated enough.

To check this condition we calculate the start and the end of the
chandefs of both links in the pair and do some checks.

But the calculation of the start/end of the chandef is currently done
by subtracting/adding half the bandwidth from/to the control channel's
center frequency, when it should really be subtracted/added from/to the
center frequency of the entire chandef.

Fix the wrong calculation.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260111193638.2138fdb99bd5.I4d2e5957b22482a57b1d6ca444e90fcf73bf2cab@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index c6b151f269216..1efefc737248f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -844,9 +844,9 @@ iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 		if (c_low->chan->center_freq > c_high->chan->center_freq)
 			swap(c_low, c_high);
 
-		c_low_upper_edge = c_low->chan->center_freq +
+		c_low_upper_edge = c_low->center_freq1 +
 				   cfg80211_chandef_get_width(c_low) / 2;
-		c_high_lower_edge = c_high->chan->center_freq -
+		c_high_lower_edge = c_high->center_freq1 -
 				    cfg80211_chandef_get_width(c_high) / 2;
 
 		if (a->chandef->chan->band == NL80211_BAND_5GHZ &&
-- 
2.51.0


