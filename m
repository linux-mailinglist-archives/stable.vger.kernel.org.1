Return-Path: <stable+bounces-269204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2xbqFoGpPmqQJwkAu9opvQ
	(envelope-from <stable+bounces-269204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:32:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1276CF1B1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:32:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=P82+aJKm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269204-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269204-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 947A831269E0
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2DE403AF8;
	Fri, 26 Jun 2026 16:12:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F23F99E6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490370; cv=none; b=mfsLqlemx54bsL3RAe9YCZ35Xk9/k5RNXkAWmX2dytSAVR22X10WRYLjvPES16qp2IOyb802dgiVZwZ5lUbD5RWqbWSSvQlm4bLcpwLesYGEh9xor4zx1EDcUAVJKz3Q70mMQ8EHxcO4riotYVlHKWtoTmiaTD91F/hGI4+0gfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490370; c=relaxed/simple;
	bh=PXTFLasdbor8sCU1RD8RI4t04idnaIPVCj4SCtEOxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKK5qEMKT1ezq7CilfiBzZu6ENEQXAoTt/F6c2B6xNBr4STiQzmDARgIy8sgQnVBsb4BOhZ6h7+j14LcDelygoi+jXh83qk6QF3Og704sbd+EOu4bsXpdxqkTcsGvo/aqmto0NDxXB9UkKEqd1fFeRzjrn0T0zoILZhUd8bghss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=P82+aJKm; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 0EAFE2045E;
	Fri, 26 Jun 2026 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OSopJtj7ppYSjnEhqIsscCBXht2wUAZgGyIq+VEtIk=;
	b=P82+aJKmMndjlG5RR61Pi4K5s6tTYgwy9oLtWm+Slu7ZoKOdvzEPICb7YctQJPGA7ypZkX
	2F8nTT8AWA6Bdr0RLQp5HirMuWKDNYZjKFqHZL0+ujLhSXgtejxGMuRcaOWG5kXldVJo10
	cFFFK3KfUUWxxuSqfu6uYNKFZ4Ffb2k=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 06/26] batman-adv: tp_meter: fix fast recovery precondition
Date: Fri, 26 Jun 2026 18:12:21 +0200
Message-ID: <20260626161241.124988-7-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269204-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB1276CF1B1

commit 2b0d08f08ed3b2174f05c43089ec65f3543a025b upstream.

The fast recovery precondition checks if the recover (initialized to
BATADV_TP_FIRST_SEQ) is bigger than the received ack. But since recover is
only updated when this check is successful, it will never enter the fast
recovery mode.

According to RFC6582 Section 3.2 step 2, the check should actually be
different:

> When the third duplicate ACK is received, the TCP sender first
> checks the value of recover to see if the Cumulative
> Acknowledgment field covers more than recover

The precondition must therefore check if recover is smaller than the
received ack - basically swapping the operands of the current check.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e4f76c141af3e..77bc69573a562 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (tp_vars->recover >= recv_ack)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3


