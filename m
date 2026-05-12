Return-Path: <stable+bounces-245871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDZPMrNmA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:43:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28D525FAF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B14DA30167D3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB13DC86D;
	Tue, 12 May 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6pcS3rl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7603B1EE2;
	Tue, 12 May 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607769; cv=none; b=VC/mTYy3qGtFakb72ZJtkqM4eSLy16uXs12nu4kJ7CiIFDJ9uGNhUILiw14JCKGiLJYnBlQf06PgcmKRWHEj420lIEfx+Kq+/9Tb0uzeB+PjAGYtzkvZFTfGxQ21Qggf62F8yCdknqGlh0E8ALBUJDG/x3y4llIGGoGwP39YtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607769; c=relaxed/simple;
	bh=eqde1BqleyJBwsjLyp76d2gxXXPVZUjFygGj8amklzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeJVS2fiD4gnK1IjF3CrEEB7+SIGR51UKdvft3loNQqPAquwrLbi/LNvj0lc8LASF/uOTr21pA8Q4qnD22v8U5snXJ4O0aRLdUBED4JqUffwo5ki1gIxHD8eJxicePG+Uthd6pMkz10guU0GA2OYv9N90s+QNRZxucSETsrle3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6pcS3rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E439EC2BCB0;
	Tue, 12 May 2026 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607769;
	bh=eqde1BqleyJBwsjLyp76d2gxXXPVZUjFygGj8amklzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6pcS3rlwACLznltxcUU7Yy3/TARcdocOxIJGBv/6bkvSo9al7tQ81PUOUCNSBHys
	 re3URINNBTe5W0EHvdw80duI9mmduXWu8+UFFMIrQLDDsU1tq6YWYHm8wGYzgduZ9Z
	 Xi+lEsj64Yol0BV2DPDfEShFZSIbTHJzeE6n/Wa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quan Zhou <quan.zhou@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12 029/206] wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
Date: Tue, 12 May 2026 19:38:01 +0200
Message-ID: <20260512173933.446317168@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BE28D525FAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245871-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:email,nbd.name:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quan Zhou <quan.zhou@mediatek.com>

commit bb8e38fcdbf7290d7f0cd572d2d8fdb2b641b492 upstream.

Previously, the AMPDU state bit for a given TID was set before attempting
to start a BA session, which could result in the AMPDU state being marked
active even if ieee80211_start_tx_ba_session() failed. This patch changes
the logic to only set the AMPDU state bit after successfully starting a BA
session, ensuring proper synchronization between AMPDU state and BA session
status.

This fixes potential issues with aggregation state tracking and improves
compatibility with mac80211 BA session management.

Fixes: 44eb173bdd4f ("wifi: mt76: mt7925: add link handling in mt7925_txwi_free")
Cc: stable@vger.kernel.org

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/d5960fbced0beaf33c30203f7f8fb91d0899c87b.1764228973.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -885,8 +885,10 @@ static void mt7925_tx_check_aggr(struct
 	else
 		mlink = &msta->deflink;
 
-	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
+	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state)) {
+		if (ieee80211_start_tx_ba_session(sta, tid, 0))
+			clear_bit(tid, &mlink->wcid.ampdu_state);
+	}
 }
 
 static bool



