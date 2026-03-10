Return-Path: <stable+bounces-224086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAi0IsX+r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F624A7D0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE8333216379
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254A389462;
	Tue, 10 Mar 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElWYfRTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7A389456;
	Tue, 10 Mar 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141220; cv=none; b=oQ0RInVXH0LIXnM2/uduJT18ce0rXCyw4cSDoQTDGTPfiU7xAedsaeGm74lQVLbp5yzUj8MctvMWUR3vfKRKZHaOm7QBagceb1TyMftoVIa1B2rJth99CEteQnugrY4z/AL5BXeUAkUjZS6Wtw0HQO8+MVrGsVqqgJCKPNMLBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141220; c=relaxed/simple;
	bh=SMidLc9Tfva4X8YsSIgugrA4Ulq9vBbcND4pl0/0pr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HioXAaS9B1D1xGtBcmhMwsKam5z2sAgajjru2eb6gNXa9mfGpwTEtrHG3LgzwmRl7XN8HI61ta/LhS57zHmpW+pXiFM9x+X1aqCrPBerY1HIcp1jMZR0Xffiy6ck4oP953PARtUXI4WnM3Z+qaAJEB5PV3uPbJU9LuiTPof+uDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElWYfRTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F830C19423;
	Tue, 10 Mar 2026 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141219;
	bh=SMidLc9Tfva4X8YsSIgugrA4Ulq9vBbcND4pl0/0pr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElWYfRTD+hhA4vG1c/Rf3eHtFToYooIx3/kvd4OrkXgc2ruR2uI7Pstci7qpQlE+I
	 as5LfaARY+Ouy+1ceyUT/xAEOjLSVaZRN6dxTrnH91r+uQ+af2U5i/P8wFXnWxjyhZ
	 iBNNXnXaYAMDMS36UKZ2zSMO8gt8lS+gyyei4ORg5jHwdAXh4dAnnmaNcJszRD7PpO
	 bqxipXMIv0V8NJuL4VSmp61W5RIqrb6Qv+IwO4bz72/hg54aIGmtOz6syhIz2rVNPL
	 7WrWUYRUfCk4YoiG9302EM6id7zaff738VfMHeR0EpCrYQFH1nsWmEU34piKSPSizo
	 O5GBHOCemC0bA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 221/311] wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac80211_config
Date: Tue, 10 Mar 2026 07:04:28 -0400
Message-ID: <7e4e2f850854eb23c84368f0dbd8627af8837339.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC7F624A7D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224086-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit d973b1039ccde6b241b438d53297edce4de45b5c ]

This triggers a WARN_ON in ieee80211_hw_conf_init and isn't the expected
behavior from the driver - other drivers default to 0 too.

Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Link: https://patch.msgid.link/20260221-rsi-config-ret-v1-1-9a8f805e2f31@puri.sm
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 8c8e074a3a705..c7ae8031436ae 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -668,7 +668,7 @@ static int rsi_mac80211_config(struct ieee80211_hw *hw,
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
 	struct ieee80211_conf *conf = &hw->conf;
-	int status = -EOPNOTSUPP;
+	int status = 0;
 
 	mutex_lock(&common->mutex);
 
-- 
2.51.0


