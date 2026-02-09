Return-Path: <stable+bounces-215172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE7SFMf0iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:52:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B38EE111242
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FED30427F5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA39379990;
	Mon,  9 Feb 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3ZXn51A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC636BCE2;
	Mon,  9 Feb 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647913; cv=none; b=TOmNN/gyiZXX01+4Vabpi8auuSREJiKLuoV3ZUOM6omRV5zaqXR/u9RIstuv6JEyQHBwCxpzVeeJeoIm9Zjc43N6YWPMws9hkuqk9a6NByxHMVpHHsDqj65weWBj5/G4sRywiwNBBaS903S/7dL3GYtQfAG+2LCb5fvtM10jH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647913; c=relaxed/simple;
	bh=w/xEqQP1hgnMQWdS5LQ/qII59G4Z+9y9o+chlmtSnJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scpzXN9BGhB6JvwR6nvNsD/hakvaG/Y7R8rq8eeQvX2EioU4W8RZs/Z7QbQyQU6emdsuqVXpCP0sRNrLdlev6atUBUUC0nEoLYm7xPDiBBl/Pz00XhFzDDbhJCj+1mKW3lQVfFp7spmfVDJx7DioDSUJTzYoQFvUhi3M6+sDDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z3ZXn51A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E38C116C6;
	Mon,  9 Feb 2026 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647913;
	bh=w/xEqQP1hgnMQWdS5LQ/qII59G4Z+9y9o+chlmtSnJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3ZXn51ATqwh7ppxEbo2Wh6fBPWTXFJU4Imoy5GuRzOX1yqGAbV9SHlzXcH8imKPd
	 g0f1LxH2jIAp3/OJ61+DnUSnBXaHJxPjdTDSR2v8kEPp56pIcxzZ9DJSN3ngXjrVQA
	 LURlU1JIswGRCeAsjqg290SUSRnY27EV6VY1h3hk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Astrand <astrand@lysator.liu.se>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 031/113] wifi: wlcore: ensure skb headroom before skb_push
Date: Mon,  9 Feb 2026 15:23:00 +0100
Message-ID: <20260209142311.328050067@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215172-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,liu.se:email,intel.com:email]
X-Rspamd-Queue-Id: B38EE111242
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Åstrand <astrand@lysator.liu.se>

[ Upstream commit e75665dd096819b1184087ba5718bd93beafff51 ]

This avoids occasional skb_under_panic Oops from wl1271_tx_work. In this case, headroom is
less than needed (typically 110 - 94 = 16 bytes).

Signed-off-by: Peter Astrand <astrand@lysator.liu.se>
Link: https://patch.msgid.link/097bd417-e1d7-acd4-be05-47b199075013@lysator.liu.se
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 464587d16ab20..f251627c24c6e 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -207,6 +207,11 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	total_blocks = wlcore_hw_calc_tx_blocks(wl, total_len, spare_blocks);
 
 	if (total_blocks <= wl->tx_blocks_available) {
+		if (skb_headroom(skb) < (total_len - skb->len) &&
+		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
+			wl1271_free_tx_id(wl, id);
+			return -EAGAIN;
+		}
 		desc = skb_push(skb, total_len - skb->len);
 
 		wlcore_hw_set_tx_desc_blocks(wl, desc, total_blocks,
-- 
2.51.0




