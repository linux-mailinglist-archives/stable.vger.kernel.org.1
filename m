Return-Path: <stable+bounces-220336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJrOCroxo2lN+QQAu9opvQ
	(envelope-from <stable+bounces-220336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55931C5AA3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55BB35FB5DF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEB398DAE;
	Sat, 28 Feb 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbYgvvPh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA816398DA3;
	Sat, 28 Feb 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300236; cv=none; b=qVJsKozXRQl1EAiWVkdEE//HEaA7YjoL8kESDYcVX2RdIwfgOp09CamOeQVXKVRMtb4lE/+WFbMzTBlPk9UjTdHLnUHffdUzTK1j38kvUB9maNL5mNxfGiB9KPNJJKRIwTxzADw9VxUsaLk7/vmhmmFXjhUcW6U+R1HskkonX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300236; c=relaxed/simple;
	bh=mE/essJse7VBB1BowCp7eNSfFoAK4XIAvuKvzT78N2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzDoQ7HA0vUFbJxJ0UiVDtyunmfkasqh2Ent1FxucVdIwP9F7WSE7cohIWUqeR4phXrr9qQxuOw9PyN0+8r+QcZYQy/6g0lPeC4uMlAiPVxx7FNXSehvCQuOWpqw6EQ8sES+Y6HaWy/7psyQddcqfjio8iyEkvkl2aNMGQsA4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbYgvvPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39412C19425;
	Sat, 28 Feb 2026 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300235;
	bh=mE/essJse7VBB1BowCp7eNSfFoAK4XIAvuKvzT78N2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbYgvvPhi7xIoT5kUc8bgRygmbzQDPUbOMS49T/21w2JKSGCyGEUPbpjNupwf+Agt
	 fO0TentJM7ZXuaej4jgIvWv0UFychP7eSwYqD93/2Og2EhXkzehJUh11ZKdqFqg+Sr
	 mI1WWJeafZbw490BtgYSCtfw34vMJ6LOqZljl/HC5pbaWRTvm+4iaugqjHtwkUPLzJ
	 RbjcC5kA3+RCYiG1dtCjDHfxVJZDTJzUrwxcgcEUNDGIUVR1l8ih3VfZXRH+X0Z75h
	 /ajILXmYuy/l9P3Vgdg3Je7sNBNxGw5cbVLaTRTg0gCh6N7SJatOKOY25VImgXfVgo
	 6hflD35oCtCqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 258/844] wifi: rtw89: mcc: reset probe counter when receiving beacon
Date: Sat, 28 Feb 2026 12:22:51 -0500
Message-ID: <20260228173244.1509663-259-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220336-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: B55931C5AA3
X-Rspamd-Action: no action

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 1b40c1c7571fcf926095ed92f25bd87900bdc8ed ]

For BE chips, needs to transmit QoS null data periodically to ensure
the connection with AP in GC+STA mode. However, in environments
with interference, the Qos null data might fail to transmit
successfully. Therefore, when receive the beacon from AP will
reset the QoS null data failure counter to avoid unnecessary
disconnection.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251223030651.480633-13-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 5 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 86f1b39a967fe..8fe6a7ef738f7 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2608,17 +2608,20 @@ bool rtw89_mcc_detect_go_bcn(struct rtw89_dev *rtwdev,
 static void rtw89_mcc_detect_connection(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *role)
 {
+	struct rtw89_vif_link *rtwvif_link = role->rtwvif_link;
 	struct ieee80211_vif *vif;
 	bool start_detect;
 	int ret;
 
 	ret = rtw89_core_send_nullfunc(rtwdev, role->rtwvif_link, true, false,
 				       RTW89_MCC_PROBE_TIMEOUT);
-	if (ret)
+	if (ret &&
+	    READ_ONCE(rtwvif_link->sync_bcn_tsf) == rtwvif_link->last_sync_bcn_tsf)
 		role->probe_count++;
 	else
 		role->probe_count = 0;
 
+	rtwvif_link->last_sync_bcn_tsf = READ_ONCE(rtwvif_link->sync_bcn_tsf);
 	if (role->probe_count < RTW89_MCC_PROBE_MAX_TRIES)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f39ca1c2ed100..d08eac3d99266 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -127,6 +127,7 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	rtwvif_link->rand_tsf_done = false;
 	rtwvif_link->detect_bcn_count = 0;
+	rtwvif_link->last_sync_bcn_tsf = 0;
 
 	rcu_read_lock();
 
-- 
2.51.0


