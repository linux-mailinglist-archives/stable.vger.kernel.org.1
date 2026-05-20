Return-Path: <stable+bounces-252631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGD5BG8mDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:23:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7B59ACA2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E758C3865D51
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CB3F9287;
	Wed, 20 May 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ueUuGTgT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6E3E5ECF;
	Wed, 20 May 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301182; cv=none; b=ajUCqXjbQKclo1bHOI7mrCm5TRODLdwI/02/u/yoDSvJiq65kdQebA4SyF3cAHWBL3BmBcbS2EO4yARsXtFu/wP6Ps0ZIv6/PzGBodfTtksPAVSV3ipokH3mr/So7nXYCwww0g4/v2YBwc1jyqjHQxruR5Cu18cFJ3Up2CO8epY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301182; c=relaxed/simple;
	bh=3rjOV/xZe0B5uwYdsnm8cJL7MJMOUSYDIX6hV8nfJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqf7PYJl3AApLDa76T1a320gLpGZ3uaoUVXJoeShz7eSlcj8qp4kBI5SxOR0g8qN0CCGxaZbgA3TSAv+XXWre78hqiSxObkx/Ohh+IKQXMkoKGhfpcDomQ4s0sexSCD8PPS9GE5A8Q6IalfUOkWfsStm/Iz2BZpvoRcnc0+9Rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ueUuGTgT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480071F000E9;
	Wed, 20 May 2026 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301180;
	bh=q3JNt0WilEoqTJeEVbUzE4vUGQ0aV9niycPepPopz94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ueUuGTgT+I3W4nzZh3lN4wHhJF9SUYMQLZ+RCWQjnVJCZxdpo50Xh69w88MsbIA+H
	 o6NRH9BtZqJb/8L6W6tw4NFwQjq/b8PIBN+RsoBxDSdXOBFd1WdzkMSgP5Wv7aN1wo
	 t26ConwZFG4nDktDqKVS2MbGFnsGgYl8TSXDBDWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Mikityanska <alice@isovalent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 457/666] ice: Remove jumbo_remove step from TX path
Date: Wed, 20 May 2026 18:21:08 +0200
Message-ID: <20260520162121.174781778@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252631-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,isovalent.com:email]
X-Rspamd-Queue-Id: 6BD7B59ACA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Mikityanska <alice@isovalent.com>

[ Upstream commit 8b76102c5e00d1f090e0c31d17b060c76d8fa859 ]

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260205133925.526371-8-alice.kernel@fastmail.im
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 1a303baa715e ("ice: fix double-free of tx_buf skb")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 431a6ed498a4e..08d1757f40888 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2346,9 +2346,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto out_drop;
-
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
-- 
2.53.0




