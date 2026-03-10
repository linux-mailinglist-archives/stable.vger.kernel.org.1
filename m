Return-Path: <stable+bounces-224420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIsjDMsDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2236224B680
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4205F30B22A0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4504218BB;
	Tue, 10 Mar 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxmky5b7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A0387368;
	Tue, 10 Mar 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142153; cv=none; b=sTofOJN/+qbuFDQINociXO+a2J9lZrujzofSE+XtLfZ3zLDK2h9AsTXfBt6kPMP/xBY1c3apiZ5WoEjvf1q3lti62xB41U8qIoHjww+Gdh0MDZLXs7QxWnSwcuuWQ5zOI3DACYyz4DovSvC/SWp35/ON8cUe79536IV0wUEXhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142153; c=relaxed/simple;
	bh=SMidLc9Tfva4X8YsSIgugrA4Ulq9vBbcND4pl0/0pr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTxy4aTJzH/qo930201mqJttTuwK9o7TEE1zB4fcaHdw9tZfKgE3yB/EOUZeAUmJvjrG0/9G066uH4lAbCXR2vI/xzRzwyeUIyHL+u0R/JAJDitzuKAfBByeWQRRfeArFllUhxejaWrfghaUQDMEQcxR9VwR42kRc6eMaoe4Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxmky5b7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9682C2BCB0;
	Tue, 10 Mar 2026 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142153;
	bh=SMidLc9Tfva4X8YsSIgugrA4Ulq9vBbcND4pl0/0pr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxmky5b7G5VDZUQSKDyI4hloZuK+ooi6MbN+LpTHQ98D+YIH1+yJZ3yY1atuTwxrB
	 uhsFow1hySuS/z2+0+KzN2/QiOrnhXNsG20iSXA8bOzPwOa+467v9uh8t1RvkcBD0M
	 nyUKq/J67/gMyjxy01YVsFM5jEoJdEIRTR6dSu9HcKpkWQm0b3m54O+0Q9XJ23QOUY
	 0FuVxg6raO6n1LMBxnhDknMYZIYL1IFAxWDxF1HqEQ8bwoHHX5R/zOwmiNv4XtgxYA
	 zGw8RDMTfiP0cGCqc+HK44QFQ5Z7a/MyI9PfxUWWs5z4w8ow4e/2KCYGfj7PaD2hUI
	 njJzk+/szxssg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 241/314] wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac80211_config
Date: Tue, 10 Mar 2026 07:18:20 -0400
Message-ID: <748d9f3305605dbb63fe9a9cdacc5f7c7f3e8b10.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2236224B680
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
	TAGGED_FROM(0.00)[bounces-224420-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,puri.sm:email]
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


