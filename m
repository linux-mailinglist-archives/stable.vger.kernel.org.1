Return-Path: <stable+bounces-220382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKdDHeYzo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA11C5D5D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30498328A5D3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7493A696B;
	Sat, 28 Feb 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf9Jmkut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019F3A6960;
	Sat, 28 Feb 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300276; cv=none; b=iXcJoKg6R3hnxuMaZDi5KLr7G44bmpSdJP8Attx1L7SmmTTnqABpUBQ5448/O8MfO6Ha9QMBSTB8JW0Wn4WAyTIxpGLcDgm3hkYYXqRCA1VAOJ3+YcguPzFAsRRH3BY0Dq8EwMM2u8Bpuhet6uQxmQzK6fjOsiakixDTeElysZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300276; c=relaxed/simple;
	bh=uI126Z1WtTNezlLB3PPjgMNZ2JlP6lOGG8iNb1PxktY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJd3QYYxiQxCvJ1qx5o+rJqEV2x3pEYzU+Xy7pQL2Ce+MshLAu7WC2xbxbOiNkkWxihpj7ZnVE4p8nZKrsi/BZBlnRbEHiUd+OGKdiRB04OXQRACGk+lK4ULUuEzgpuozDfk4AQ9DrJFj4mVezsH64n6O6y7si7QiwpK2PeRf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf9Jmkut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8460AC19425;
	Sat, 28 Feb 2026 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300276;
	bh=uI126Z1WtTNezlLB3PPjgMNZ2JlP6lOGG8iNb1PxktY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kf9Jmkut1Qscl1IioL/JnbUDjxBsSTiHnRjb/MWkqGuC1GAPcKJpXEPSsSu5D+TWC
	 +uflZpY12esiDU0aqru7Q6bsRAGrUf6iZQAciffwGJ1UvDfZobs9IWVHjCZ67HbGR6
	 GvsHDnU7GREZl1AYt40GmrwPAD0CQGqq9cw8Xwe5JY6Fxfo8Z5cPLgpg4FHBQV+9J4
	 0tGGrSzxdYkMPSyWUzJTgb8HIxJlUjCJEQ+Z7R7+60Uy9914OGDdPNCt2xB7m0HTYF
	 RcnXLVhufjtjADXdqHbVjWZdEhYSpQziCE6DydRwnbwOGFzpqWYdULoTEJDufR/Qcg
	 vzWS9ydwxm11w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 303/844] wifi: rtw89: fix unable to receive probe responses under MLO connection
Date: Sat, 28 Feb 2026 12:23:36 -0500
Message-ID: <20260228173244.1509663-304-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220382-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E3EA11C5D5D
X-Rspamd-Action: no action

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit 6f6d7a325fbde4f025ee1b1277f6f44727e21223 ]

During MLO connections, A1 of the probe responses we received are
in link address, these frames will then be dropped by mac80211 due to
not matching the MLD address in ieee80211_scan_accept_presp().
Fix this by using MLD address to scan when not using random MAC address.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260114013950.19704-13-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7b9d9989e5170..2f68a04cc028f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8114,6 +8114,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	struct cfg80211_scan_request *req = &scan_req->req;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_chanctx_pause_parm pause_parm = {
 		.rsn = RTW89_CHANCTX_PAUSE_REASON_HW_SCAN,
@@ -8142,6 +8143,8 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		get_random_mask_addr(mac_addr, req->mac_addr,
 				     req->mac_addr_mask);
+	else if (ieee80211_vif_is_mld(vif))
+		ether_addr_copy(mac_addr, vif->addr);
 	else
 		ether_addr_copy(mac_addr, rtwvif_link->mac_addr);
 
-- 
2.51.0


