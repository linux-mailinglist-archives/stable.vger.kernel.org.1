Return-Path: <stable+bounces-215422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FlBCqH4iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:09:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30D1119F7
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF433306642C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3E28725B;
	Mon,  9 Feb 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dumw/hs6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD237997A;
	Mon,  9 Feb 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648739; cv=none; b=p/psDtneL6Mj/ujUWks1Rc6cH1oI+MK4ppiXGf4ZUiGHdsJJ6AKiZYeuCImfV+xo6/rpBkHHmuNQSSfpDT09LreglVZzJYTIc3XuLurE5c0Th57W0wLNZ8lEK99L57RUPGKvm4aEXWclFMCivm/5soS+JKo3jCJLrqThVhP9Jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648739; c=relaxed/simple;
	bh=ChpAUU99oreo/xuRmWfDlRqUKO/hLysu9osVy7WI3ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gsm7mq3Ad4i9Wb5CAE5dqN6qMkqBb35ZXGDngzEP2yOuVA1x7fRk89kKnMf1BkW0MSbd++i0kO6toRVyMoWAusQXdN4UkqZp9extv1jYRlZXVRbEv528Q6ktmhRBMuoKDqfYx/hZrv0qcMynwsT8DhH1MlkWBysM7Kr0QHPhCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dumw/hs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8449DC116C6;
	Mon,  9 Feb 2026 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648739;
	bh=ChpAUU99oreo/xuRmWfDlRqUKO/hLysu9osVy7WI3ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dumw/hs6M+MwqI8jcEol4zq2bPfxRGkvHxQz4GUmMGdvAQ8/hHN7kwfHRm1C6iIcZ
	 YjNF+p0sl3U5u3MTG8lQOsm+K5OMCApztkWdrTkSZ1vyjJb4/IYsPN0uokfybzW6Hb
	 jBiILJNmNgN5DLM49DXc3B5RoXwXHA4GPK34h19Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Hodges <hodgesd@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 29/41] tipc: use kfree_sensitive() for session key material
Date: Mon,  9 Feb 2026 15:24:50 +0100
Message-ID: <20260209142257.864186658@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215422-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,meta.com:email,msgid.link:url]
X-Rspamd-Queue-Id: AA30D1119F7
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Hodges <hodgesd@meta.com>

[ Upstream commit 74d9391e8849e70ded5309222d09b0ed0edbd039 ]

The rx->skey field contains a struct tipc_aead_key with GCM-AES
encryption keys used for TIPC cluster communication. Using plain
kfree() leaves this sensitive key material in freed memory pages
where it could potentially be recovered.

Switch to kfree_sensitive() to ensure the key material is zeroed
before the memory is freed.

Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
Link: https://patch.msgid.link/20260131180114.2121438-1-hodgesd@meta.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index cc409d55e1576..42e7d2bc78302 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1223,7 +1223,7 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
 		rx = c;
 		tx = tipc_net(rx->net)->crypto_tx;
 		if (cancel_delayed_work(&rx->work)) {
-			kfree(rx->skey);
+			kfree_sensitive(rx->skey);
 			rx->skey = NULL;
 			atomic_xchg(&rx->key_distr, 0);
 			tipc_node_put(rx->node);
@@ -2398,7 +2398,7 @@ static void tipc_crypto_work_rx(struct work_struct *work)
 			break;
 		default:
 			synchronize_rcu();
-			kfree(rx->skey);
+			kfree_sensitive(rx->skey);
 			rx->skey = NULL;
 			break;
 		}
-- 
2.51.0




