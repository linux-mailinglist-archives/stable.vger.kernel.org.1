Return-Path: <stable+bounces-240740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHxsHeJx62ndMwAAu9opvQ
	(envelope-from <stable+bounces-240740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3C945F34F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94A2A30221F2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520253D3D04;
	Fri, 24 Apr 2026 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BiH/NMoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7F179A3;
	Fri, 24 Apr 2026 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037714; cv=none; b=Xq4iTgXfKcuxUxpBLFhiNBmUZaFsnDuZwwXxNKdiWms58BS8JhUgK8nBNUpmgIs0B0xVNEcR/UMCKVnGCHmKrrNJG+Hei4LuwLJKsjUSh+rp6SjHGZUSg/Ss1C3+SZy1mB6jPUPBQy7cN39uTlxw16rQVP5bCJIJSX7665B+TIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037714; c=relaxed/simple;
	bh=G3hPNXMau6vNdh2wYiAv3fQnXiFf9DJUhK5cu3Ce0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBYIALjV9R4qQnNd+mY5+v+x7M89HkMnmLZVQHtA+TZ2JsFsf4zOil99iTwABF02rfHno9TW7ogA7SpokaanB3qqwlkUsA4gdq0vwwMurl7gz+MTqV7sETkmVKFbukUdJMh7VGvy/C3WufmnI6AoamPXwG0lUjNT2seH2Bf7AXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BiH/NMoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A061AC19425;
	Fri, 24 Apr 2026 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037714;
	bh=G3hPNXMau6vNdh2wYiAv3fQnXiFf9DJUhK5cu3Ce0v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiH/NMoCl4GBacbUVGIVdiAiWBCHZr3EMQ/hFM4WiJ4vxBLB+yo59NNHIJObNKgto
	 lWDD9uzH2J/BkiMaSIrU4p5Fv6JzkkwukYqnzgxUemYcDh4Kjm9oiy1J9eVF7TYa2L
	 DeI5otKu4WbBsJeLHLo4Krw0SCn1oMD3KFUDx1B8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 014/166] wifi: wl1251: validate packet IDs before indexing tx_frames
Date: Fri, 24 Apr 2026 15:28:48 +0200
Message-ID: <20260424132535.863271591@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EA3C945F34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240740-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 0fd56fad9c56356e7fa7a7c52e7ecbf807a44eb0 ]

wl1251_tx_packet_cb() uses the firmware completion ID directly to index
the fixed 16-entry wl->tx_frames[] array. The ID is a raw u8 from the
completion block, and the callback does not currently verify that it
fits the array before dereferencing it.

Reject completion IDs that fall outside wl->tx_frames[] and keep the
existing NULL check in the same guard. This keeps the fix local to the
trust boundary and avoids touching the rest of the completion flow.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260323080845.40033-1-pengpeng@iscas.ac.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wl1251/tx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index 06dc74cc6cb52..2b316c78eefc9 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -402,12 +402,14 @@ static void wl1251_tx_packet_cb(struct wl1251 *wl,
 	int hdrlen;
 	u8 *frame;
 
-	skb = wl->tx_frames[result->id];
-	if (skb == NULL) {
-		wl1251_error("SKB for packet %d is NULL", result->id);
+	if (unlikely(result->id >= ARRAY_SIZE(wl->tx_frames) ||
+		     wl->tx_frames[result->id] == NULL)) {
+		wl1251_error("invalid packet id %u", result->id);
 		return;
 	}
 
+	skb = wl->tx_frames[result->id];
+
 	info = IEEE80211_SKB_CB(skb);
 
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK) &&
-- 
2.53.0




