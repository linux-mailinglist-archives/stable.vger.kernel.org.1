Return-Path: <stable+bounces-262514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hAmiCSV+KWpvXwMAu9opvQ
	(envelope-from <stable+bounces-262514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 17:09:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49466A920
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 17:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=beims.me header.s=protonmail header.b=T04ywo5p;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262514-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262514-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=beims.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E41333113D16
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ED1421EE0;
	Wed, 10 Jun 2026 15:00:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625741B36A
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:00:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103646; cv=none; b=RiaZawbvLpLY3dnhi1CZUeHql/nSTfAe4fqy0wSqS6VuoT8RxDnVXlbbHp0yMXFqJ8295hWsLOHvrGFwAChnxcJYzsI5k4MhGYC7N1GZ8Vm7gs9/cB87DbsdlOU+ZqPlxMDNGZxWwOu/Gu/AK2Wu/SHUdyuYksdz+hUzvb/UL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103646; c=relaxed/simple;
	bh=ExU8I+jFwz9MuIoWGUGAt6iXGBCppzdr97tneYADt9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnCGt4AWnHsm0v1Ee4AdIp+hWGRfI2czMgLJI7wO8e39ZvmDe+Y1fRvhfKinm8+uDGS2hsGv4qfmjOqHAs/uSg8W6LmIqhVERQ3p1/CGeDtafnCzQaOYWcNxadqWXty96Yu3SNukwlH4xOv/z3PBHp4td1dgvM6ZTQ1vcjjwxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=T04ywo5p; arc=none smtp.client-ip=109.224.244.106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me;
	s=protonmail; t=1781103635; x=1781362835;
	bh=LZzMhW09wyyBdVGAAIu/QYUVauAh3HC8kvZJEvtausI=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T04ywo5p8BiuvzZ4oKFNJjzqrqlMe6VA2Ksc6s8sW2Dfqjx39mXLRuNEFNyUd5Jhe
	 CRkj04Ei0qgETRCD6ZfwoxTH7oPeALPwvMEk4FH18S8rO2mtLGNZzlgQyP5eAWVsUQ
	 qI6k7kXHgapD/MYkNYBtzvp0fHEN1EZuZ2WWmTlzlOrOt6vEBK2e/1DUXelKj49JKp
	 UjMPTmSyIA4xMqdC9et6DcL14N2CsAbKjhzmanaT95k2ZULsOESeXoAtwcLiSvrRDf
	 dnmmgqcgkD/smVcA+bTZSuawJ6U8MOn+2qNZWrLTK0/BYMLgXJUXqJC0td5AkQd0A6
	 0OorUuzAVPSEg==
X-Pm-Submission-Id: 4gb88w1XtKz1DF7M
From: Rafael Beims <rafael@beims.me>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: fix roaming to different channel in host_mlme mode
Date: Wed, 10 Jun 2026 12:00:18 -0300
Message-ID: <20260610150021.1018611-1-rafael@beims.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[beims.me,quarantine];
	R_DKIM_ALLOW(-0.20)[beims.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262514-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:rafael.beims@toradex.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeff.chen_1@nxp.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rafael@beims.me,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@beims.me,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[beims.me:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,beims.me:dkim,beims.me:mid,beims.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C49466A920

From: Rafael Beims <rafael.beims@toradex.com>

When host MLME is enabled, mwifiex_cfg80211_authenticate() transmits the
authentication frame on a remain-on-channel (ROC) reservation so that the
frame is sent on the target BSS's channel. The ROC is only configured
when priv->auth_flag is zero.

priv->auth_flag is set to HOST_MLME_AUTH_PENDING when the auth frame is
queued and advances to HOST_MLME_AUTH_DONE once authentication
completes. It is only cleared back to zero on a disconnect, deauth or
timeout path; nothing clears it when an association succeeds. It therefore
stays at HOST_MLME_AUTH_DONE for the whole connected session.

When the station later roams to a BSS on a different channel, the next
authentication finds auth_flag != 0, skips the ROC setup, and the auth
frame is transmitted on the currently-associated channel instead of the
target's channel. Authentication times out on the new AP and the device
stays connected to the original AP.

Gate the ROC setup on HOST_MLME_AUTH_PENDING instead of on auth_flag
being completely clear. This re-arms the remain-on-channel for every new
authentication attempt, while still suppressing a redundant ROC during
the multi-frame SAE exchange, where auth_flag stays PENDING between the
commit and confirm frames.

This change was tested in 3 different devices:
Verdin AM62 (IW412 SD-UART) - (16.92.21.p142)
Verdin iMX8MM (W8997 SD-SD) - (16.68.1.p197)
Verdin iMX8MP (W8997 SD-UART) - (16.92.21.p137)

There following loop tests were performed:
1) force roaming between two AP's, one 5GHz and one 2.4GHz, same
SSID. Use wpa_cli to trigger the roaming behavior, sleep 2s
between iterations.
2) force a disconnection to AP 1 and a connection to AP 2, test
scan. Use wpa_cli to trigger the connection changes, sleep 2s
between iterations.

Each test ran in each device for at least 3 hours.

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index c9daf893472f..abc703441c5d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4334,7 +4334,7 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 		return -EOPNOTSUPP;
 	}
 
-	if (!priv->auth_flag) {
+	if (!(priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
 		ret = mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_SET,
 						 req->bss->channel,
 						 AUTH_TX_DEFAULT_WAIT_TIME);
-- 
2.53.0


