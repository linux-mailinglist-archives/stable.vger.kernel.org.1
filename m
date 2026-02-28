Return-Path: <stable+bounces-220329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJm/MO4xo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A91C5AED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D361301DEF4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4939733D;
	Sat, 28 Feb 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVgvRl8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16422397335;
	Sat, 28 Feb 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300230; cv=none; b=uWQVXRYwGW0DTJA2N6lxgU8z+qjfqEvn7ooMWsWehS0emo8EO67S3Z8iDgOPtgddDDJIKtSpdqV2UzIsC/Te2z2fIOzpAQTyRzAWC061V8HhhR8pBL27sngbERK1NId5omJpRODtxBjFlz9bM0+9i+Y2h7MUMCUxVnyDO0w2N/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300230; c=relaxed/simple;
	bh=CqTb2ncDZyCvY79JtpCtWTkhOpSciKWJvwe2gLjveiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahCMDBGYjlaeDWfToxS4Q9IZ9gYMaVyVZ5qtiGan93XeAWlzq/DDBmUR9sX/iXZ2e9IOEpalhdmIXSxHNub9/BYfwMFf7YThv0y9b2XxXSE71zrS7mUBzudRAeQ6FhiDAM3s6Q+Hj4f38Vt5U92M94QjIGtVResZ6rIvipWiqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVgvRl8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46242C19424;
	Sat, 28 Feb 2026 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300229;
	bh=CqTb2ncDZyCvY79JtpCtWTkhOpSciKWJvwe2gLjveiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVgvRl8r05+zhGH/DLg9CpaS3tRkb/XMYfRMrrlj8QE9y04YsUrYqHPlWy4VYGvp7
	 tbOUUvbm3E1OPEpiLVvCMhuIOU3vakeayNpzYtA2ZsD869BYStoqyPqK/7al+GH1DV
	 rzEPIhGO5tFpsugItgOukYWXxwZVc/FXpXXXYowedUGtUBY61oECCWzHMX1TECjc8K
	 z4fnCe2M7gx43KaVPVmQk+6gFKo3/IMGrlE5OklzQVftLcqfjMn+3ddGIiiEYnt/FU
	 SfBL7u62+cLxqc6m4j2Pq99OJNjv3/NCOApLmc8tilELkBwhxEhVOCeuWVKgiiMLct
	 BvNm7kRIJpBJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Peshkichev <roman.peshkichev@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 251/844] wifi: rtw88: fix DTIM period handling when conf->dtim_period is zero
Date: Sat, 28 Feb 2026 12:22:44 -0500
Message-ID: <20260228173244.1509663-252-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220329-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 636A91C5AED
X-Rspamd-Action: no action

From: Roman Peshkichev <roman.peshkichev@gmail.com>

[ Upstream commit 9f68fdcdc9dbf21be2a48feced90ff7f77d07443 ]

The function rtw_set_dtim_period() accepted an 'int' dtim_period parameter,
while mac80211 provides dtim_period as 'u8' in struct ieee80211_bss_conf.
In IBSS (ad-hoc) mode mac80211 may set dtim_period to 0.

The driver unconditionally wrote (dtim_period - 1) to
REG_DTIM_COUNTER_ROOT, which resulted in 0xFF when dtim_period was 0. This
caused delays in broadcast/multicast traffic processing and issues with
ad-hoc operation.

Convert the function parameter to u8 to match ieee80211_bss_conf and avoid
the underflow by writing 0 when dtim_period is 0.

Link: https://github.com/lwfinger/rtw88/issues/406
Signed-off-by: Roman Peshkichev <roman.peshkichev@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251125180937.22977-1-roman.peshkichev@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/main.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index d93d21656f26c..f72d12c3b2bc6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -730,10 +730,10 @@ void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel)
 }
 EXPORT_SYMBOL(rtw_set_rx_freq_band);
 
-void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period)
+void rtw_set_dtim_period(struct rtw_dev *rtwdev, u8 dtim_period)
 {
 	rtw_write32_set(rtwdev, REG_TCR, BIT_TCR_UPDATE_TIMIE);
-	rtw_write8(rtwdev, REG_DTIM_COUNTER_ROOT, dtim_period - 1);
+	rtw_write8(rtwdev, REG_DTIM_COUNTER_ROOT, dtim_period ? dtim_period - 1 : 0);
 }
 
 void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 43ed6d6b42919..1ab70214ce36e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2226,7 +2226,7 @@ enum nl80211_band rtw_hw_to_nl80211_band(enum rtw_supported_band hw_band)
 }
 
 void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel);
-void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period);
+void rtw_set_dtim_period(struct rtw_dev *rtwdev, u8 dtim_period);
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
-- 
2.51.0


