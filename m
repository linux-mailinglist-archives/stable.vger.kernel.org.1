Return-Path: <stable+bounces-236948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAsZDH0j3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-236948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD23F0E1F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4CF3038162
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FF726B971;
	Mon, 13 Apr 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXwG2yIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B326CE32;
	Mon, 13 Apr 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098202; cv=none; b=d+OZeoNzIITsEMbyuj1igHU/ld+MzxQMBdaj2BVBKzyD5fpC4g9G1Bv1vi0/lViRzD16At81qhTgYmojXkgIfbUZ4by8qU7sVqJ1KOSNWPinLpE3TIq7JrrnOsQJxj9jbJAVIhlaYlPIrmYp554yL37+25BleaarzxSRKVBcyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098202; c=relaxed/simple;
	bh=ziSnnaBw0OE0vLT+69HNofXMjqxKN0DN2AScYYmyxpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR40GhQ++IYZSnoh7sCeCDTUjhRjrUjZKwm/0GEjJZOzUXIl0Ce0ITzIS6I3te6iKplyewgMG+Dx6q8gEKLXhUyD2C2rT9SpYE8dg5CvcEz3hASy7uzgDjngj6gfNvpHYJ4PEKWmzy75Q9gKXhqKWHwe7uK1l7KgsuN/QqmR0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXwG2yIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6F7C2BCAF;
	Mon, 13 Apr 2026 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098202;
	bh=ziSnnaBw0OE0vLT+69HNofXMjqxKN0DN2AScYYmyxpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXwG2yIOYQYHBSpLt7XSrHDDqOi76y8869uyIopSoiow/YswjFpSLOF/44EaK3RSE
	 RSBe1YbDtSMybYNWnUCr3iFO448RJ2exVhMK3M2ETBBkxRZBR34veGhMiTJGOh8EVW
	 FVXGcHxjhaPffjw3Dx+3NCBGiwKofeFnDHW8eFis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Schiller <ms@dev.tdt.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 432/570] net/x25: Fix potential double free of skb
Date: Mon, 13 Apr 2026 17:59:23 +0200
Message-ID: <20260413155846.656298911@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236948-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,tdt.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44CD23F0E1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit d10a26aa4d072320530e6968ef945c8c575edf61 ]

When alloc_skb fails in x25_queue_rx_frame it calls kfree_skb(skb) at
line 48 and returns 1 (error).
This error propagates back through the call chain:

x25_queue_rx_frame returns 1
    |
    v
x25_state3_machine receives the return value 1 and takes the else
branch at line 278, setting queued=0 and returning 0
    |
    v
x25_process_rx_frame returns queued=0
    |
    v
x25_backlog_rcv at line 452 sees queued=0 and calls kfree_skb(skb)
again

This would free the same skb twice. Looking at x25_backlog_rcv:

net/x25/x25_in.c:x25_backlog_rcv() {
    ...
    queued = x25_process_rx_frame(sk, skb);
    ...
    if (!queued)
        kfree_skb(skb);
}

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Link: https://patch.msgid.link/20260331-x25_fraglen-v4-1-3e69f18464b4@dev.tdt.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/x25_in.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index e1c4197af468e..77ad186507f64 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -44,10 +44,9 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 	if (!more && x25->fraglen > 0) {	/* End of fragment */
 		int len = x25->fraglen + skb->len;
 
-		if ((skbn = alloc_skb(len, GFP_ATOMIC)) == NULL){
-			kfree_skb(skb);
+		skbn = alloc_skb(len, GFP_ATOMIC);
+		if (!skbn)
 			return 1;
-		}
 
 		skb_queue_tail(&x25->fragment_queue, skb);
 
-- 
2.53.0




