Return-Path: <stable+bounces-252239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AZTCGEEDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:58:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AC59781A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40D53100F68
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244E3F6C5F;
	Wed, 20 May 2026 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUoY7ZhX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7F3D75C7;
	Wed, 20 May 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300157; cv=none; b=ijYcagwnz6KcQG8cbTkxie89MY4iGdxamMcCMEZqZtnERbZHh6uJFIxDrmTFYwnFsR/pxerelBjzWcjSfm426aUe+vuzEi1AKkI8fgRPzh48WxkA+ReTWFaUg5PAgPCmBHYdvbYQoul9C1STqeac03hIwNjqRvi7dWJgLf+wyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300157; c=relaxed/simple;
	bh=E00V3Rzyu/nHtgphMOR/f2YKlS9fNphLJgbZaL62MrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRH07Svj1E4sHuJrDWznJooDM69DBme8xB0fF25Pla8MOuK5mKp9kdOOndWZck28fYDgaNtN+EcMs76ZLM6NS/nzHNCG+ie9fG5ZhEgloFx05IqMKJhAryADXYS6EWLJDfBjG3vOFMTNRTtrNBgxW9771FpLBK1jec+WAq4qtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUoY7ZhX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2191F000E9;
	Wed, 20 May 2026 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300155;
	bh=Nl5zLXFYBNg9ipm2MdQZ8ZpQZkHHk6E2QnRtt6JJlc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUoY7ZhX4m6pCZI+EHjv8kXaHhPEyXUWDHfxTO+KeBlhXyIiczY3okt6fnFoeKTBl
	 MqeqtYImbO48i2x0WMLET4PZRY9g7MFbh8HgoPXIFsLJ5H1JDxHWf0/qFzJW/lwpN1
	 ThCJRTBmQTfdBiPy7crH4SByEf5OjVxFGN0Jvob0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Escande <nico.escande@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 067/666] wifi: mac80211: handle VHT EXT NSS in ieee80211_determine_our_sta_mode()
Date: Wed, 20 May 2026 18:14:38 +0200
Message-ID: <20260520162112.682731417@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-252239-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 547AC59781A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Escande <nico.escande@gmail.com>

[ Upstream commit b5b8e295973083abf823fb66647a7c702a8db8a7 ]

A station which has a NSS ratio on the number of streams it is capable of
in 160MHz VHT operation is supposed to use the 'Extended NSS BW Support'
as defined by section '9.4.2.156.2 VHT Capabilities Information field'.

This was missing in ieee80211_determine_our_sta_mode() and so we would
wrongfully downgrade our bandwidth when connecting to an AP that supported
160MHz with messages such as:

	[   37.638346] wlan1: AP XX:XX:XX:XX:XX:XX changed bandwidth in assoc response, new used config is 5280.000 MHz, width 3 (5290.000/0 MHz)

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Link: https://patch.msgid.link/20260327100256.3101348-1-nico.escande@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 835316fd3cd76..20e5f513a27a3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5304,7 +5304,8 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 
 	if (is_5ghz &&
 	    !(vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
-			     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ))) {
+			     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ |
+			     IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))) {
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
 		mlme_link_id_dbg(sdata, link_id,
 				 "no VHT 160 MHz capability on 5 GHz, limiting to 80 MHz");
-- 
2.53.0




