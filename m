Return-Path: <stable+bounces-257428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMQDAUcaG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D8860F134
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92BEB306A409
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435A3AB26B;
	Sat, 30 May 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sPc/epp5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50977314A8E;
	Sat, 30 May 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160963; cv=none; b=gc018WzfTHN2Z7n3YJibw9tgxPPwUFkxS3J1YMyvhrM9L/9C+UPTnz+Na7GcSx6iBbYuQZOdOT7bpGxQ8HlnoGoh/LZFAog4wPLpQpM9OFsPYvNbL7gZt7TteleQ3fW5ot6skzkw8+/qpIE7QmExGC7XqzkDOn73e5iF4JrSIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160963; c=relaxed/simple;
	bh=oQuQr+cMBsGqCgtkuLPT2zvnMBmrs0wgeKq0ePDrvqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7EfYPCZOP1IO+lCdCbrVkW+50r95Xctzbke2AygaXTdGBuIg5e9mYpI13meyi/fqkPXXnkUvwmAQh+hdXcw7CNRMUIQeImGLuLRKUhmVfSOs/sUqFvZMQw89sGHXgXKLtgvg0L+9HI5xVTDMrHKlP1gs2TCLppHkgcArHXBPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sPc/epp5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6CC1F00893;
	Sat, 30 May 2026 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160962;
	bh=Zy1yVZI11rYhjIAoAs7ugwbplatncRgy5Xr2ghb+Ug0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sPc/epp5ACrzsnFS1ZprLeoWFR1I1wNkNUMALS6wkewVVooZp+calw35UaMpqEwra
	 CGaTpMt4o4HghJV5dQNAuJyWE1CxVfSVza9Fo0aMqDj03WoziiMr3cPox3ZZNJqMDr
	 WTKhQ2PLWPgLvtbroQarLUs7Yw8rQW81Fhaz+PvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justin.chen@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 468/969] net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
Date: Sat, 30 May 2026 17:59:52 +0200
Message-ID: <20260530160313.209893001@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257428-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8D8860F134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

[ Upstream commit 57f3f53d2c9c5a9e133596e2f7bc1c50688a6d38 ]

The write_ptr points to the next open tx_cb. We want to return the
tx_cb that gets rewinded, so we must rewind the pointer first then
return the tx_cb that it points to. That way the txcb can be correctly
cleaned up.

Fixes: 876dbadd53a7 ("net: bcmgenet: Fix unmapping of fragments in bcmgenet_xmit()")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20260406175756.134567-2-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f087a97164094..650f51471a0e1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1744,15 +1744,15 @@ static struct enet_cb *bcmgenet_put_txcb(struct bcmgenet_priv *priv,
 {
 	struct enet_cb *tx_cb_ptr;
 
-	tx_cb_ptr = ring->cbs;
-	tx_cb_ptr += ring->write_ptr - ring->cb_ptr;
-
 	/* Rewinding local write pointer */
 	if (ring->write_ptr == ring->cb_ptr)
 		ring->write_ptr = ring->end_ptr;
 	else
 		ring->write_ptr--;
 
+	tx_cb_ptr = ring->cbs;
+	tx_cb_ptr += ring->write_ptr - ring->cb_ptr;
+
 	return tx_cb_ptr;
 }
 
-- 
2.53.0




