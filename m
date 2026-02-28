Return-Path: <stable+bounces-220360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCXFMtBGo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:49:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA31C7658
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70946318DAC0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7639FE85;
	Sat, 28 Feb 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epxD7boY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E6480331;
	Sat, 28 Feb 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300257; cv=none; b=dqFgNVfATGyXjUQx9/S7q+PHl0zMyir9DzL3zaFppUef6LxCnz83AcQLY4oHM/EeTcAQwrgDSCWNxk3zodg3yv3nWU1xE4a0PpuARii6QdvANL3slxrIv9GWQoDGbUEiUB48g8LyEs/o6CxNIraH5xd/jTeMM8syuAEKnjvgviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300257; c=relaxed/simple;
	bh=S+vAKVZSypWTg0uCfcPyfYz9RZ+EQOAVcvk32yYo9cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKn/71VL0qiDkgcrn4wshWeotxVNSZOz4tFwXAPM0jwPjQczWTa+TisHswmc+x+4Cn3C6Ywb+C/4K4jUQMjTweAQt6VHTZaxQEDR4vCZTQOUMHPQmDWDhiKF7QTyB5yrJHssH7B3xUe8t/yCiFoNtO7RUTZ4AcoJ88nwNY1pr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epxD7boY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFCEC19424;
	Sat, 28 Feb 2026 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300257;
	bh=S+vAKVZSypWTg0uCfcPyfYz9RZ+EQOAVcvk32yYo9cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epxD7boYJe050N2t3OkFg+OV/iCg59y7ilpXlwNe9ny05VWsxFPSVF4j5Rv/T65Lq
	 RiP8zc3yThjh7Ut5Uu0Yi3sHUOzXlrfPy9CcaMPSI+i7XoPlUSl3UaGJV86ZlVlslo
	 c3L2dBNydZyY6kr7ZJ+SWLAM7rT4z5h+qMJVKLjBWN+EAHkZ2JsiNMNzLNShzvbyu0
	 FAfZzKj+TS/3Mf4Cw2dsBAFXgN2WLfQCSAFFjelVduod32YsDp+tsw9Lt+xfNoE6gn
	 t3VFrBIg9wprCfxakaiYUJdhUYZ+h+T4lN1f+nSJOXyHEc7JtNgjHmtsX8mRx1vBPG
	 IgYOalBna5hcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 282/844] wifi: cfg80211: allow only one NAN interface, also in multi radio
Date: Sat, 28 Feb 2026 12:23:15 -0500
Message-ID: <20260228173244.1509663-283-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220360-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E6BA31C7658
X-Rspamd-Action: no action

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit e69fda4d07701373354e52b0321bd40311d743d0 ]

According to Wi-Fi Aware (TM) 4.0 specification 2.8, A NAN device can
have one NAN management interface. This applies also to multi radio
devices.
The current code allows a driver to support more than one NAN interface,
if those are not in the same radio.

Fix it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260107135129.fdaecec0fe8a.I246b5ba6e9da3ec1481ff197e47f6ce0793d7118@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index a04f96dc9a1d7..16ccf6fb28b21 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -661,12 +661,8 @@ int wiphy_verify_iface_combinations(struct wiphy *wiphy,
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-			/* Only a single NAN can be allowed, avoid this
-			 * check for multi-radio global combination, since it
-			 * hold the capabilities of all radio combinations.
-			 */
-			if (!combined_radio &&
-			    WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			/* Only a single NAN can be allowed */
+			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-- 
2.51.0


