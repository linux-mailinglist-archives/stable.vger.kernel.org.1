Return-Path: <stable+bounces-227122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF67LNrYumkycgIAu9opvQ
	(envelope-from <stable+bounces-227122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:54:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 414732BFB3E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B327B34F08F6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E13A8756;
	Wed, 18 Mar 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aZshw827";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bLNHi3w4"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999C24A05D
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850798; cv=pass; b=ARhkPluVTTkkWMPiYAjRlkpD8aeBlIk2lvVNIwGUd4xqqZghrUZx3xOf8t51HBhpfWBOt6DesA7T5fKg4OozGp/GMLdhXPYq+1xTsGCDFDHJrTOS3xrPcjwJ/6G1Edi7ajVjvNlFeDiio/SyBotz1n1O5Xk4exGykD3LoZQAYDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850798; c=relaxed/simple;
	bh=0r3bjBA1FPGil83IoKH01pkuEYwEpG5LS3m+cfIdzPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bvr1LIG82LA1+K3U7bDQn4ubsI6pOHxW53PDluBweSndvZE62HnEtrn8HnPtY22XE3H7cVLLtoUx+DnTdGiC5ZtrwPFnDuBzovxud9s7cwhnjWzNmYKHYVwz74L44YIcKNTK5QhkEgZ0l7ttE3T94wr3ZQMlZy3EqG+MKLgNlTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aZshw827; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bLNHi3w4; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773850790; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W1bw8tj6JFd5FGiMq4Zb2j5pJDA3sHgMFQz3fda0X02/9KMdVI3DCHQurCUS5WkXn9
    lwEYXJQ5ZIJAF6L4k9mC6Q5ZMg+byeOCMXKL8Sy3yJbWUTcnzYrbGifoUc85Lz+81O6Y
    3q6ZW7Lrb6FvyskJwi0kdgytkL1pD/LvsOdj9T5UWt5E/gzo9OnKUcwdr8OK1PuFZuDX
    o4Nx/rl09IWWaEpCpjjsfdy7otkBJSOnrVLYVsBwRo2NIRCC2v+O9wmM9FeOOVE+Ym8n
    NTdq4bLJgeEGE0DTlRo014eZgL5zVtfR5zTJ21/tyvAPpLfzk8FXPWCDPNcRDFJuyjMK
    ZuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773850790;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uAW4MClx1aJDjN6ESqo+yTHAchyRZHrRKkV3fAuUJ78=;
    b=bL4uUQM/bSi+CGSFJ0QH2or7tg7trEyKPNe4tKXNdOPCzWQZtz0fNXsH0cmQPof6q2
    qJuUzJkbMgTUHjPorSbxNi/A/lHk5o9TpdkuwQX5dtQ3CVDgs9e4k3g/PLNc1uPeL0BY
    FSchW+hl7uNXk4cdN7BjpCNefVGg8z6vzsARVPfuKF7muiS5hvcmWhKTJ5tIV6fS7oVh
    QwQ6dDvE6sX4zkk2rjwF2Bss4uuHXTkSC6y0eXU7qreeHPYp+ggLrTUD5NY5NIaul+nx
    VRMMRY0qG1otkVwMLquhAeGoPSM1Fedl4aUxJ0ap34I0ofYDJWfroOICa8r/ynN/Pcf3
    duyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773850790;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uAW4MClx1aJDjN6ESqo+yTHAchyRZHrRKkV3fAuUJ78=;
    b=aZshw827FfheXzK7BzF43fSjWMDMaCE1zswdRsA5MW8mGBWD/krD0h4dk+KO4Uj1TA
    +mhNJ+6u+aRWoseplbQS7UonyyLDfGF09OzQliKLmMFwXhvYR85gUP9QJLrNz1pVCU99
    XV9eNfnxmljvIq91+2pIEXJfwIKvNrN7v/GTHCMMuh0ukVWUZdG3/Hd8H+7foHpsRvFS
    DPpd1B6rvRMigATkQLBfg+fn3PNBsg2Geedbg/lZz5YfTWHrTxoQip0ndo4fzuMtzyx4
    ZhiBmopHvU0QKl1CBR+yYVqz5l3F10Pu22dbGpSR8BCKhfQ/l275i3ODWBpwWJiORMSr
    3QHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773850790;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=uAW4MClx1aJDjN6ESqo+yTHAchyRZHrRKkV3fAuUJ78=;
    b=bLNHi3w4+yVhJgfpQferrvX0I9s+a5OKDlGWfu+EwjUepqTtzJQM0bjgRdsBhlsU5v
    YgixSPEQQC6j54OO7RDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22IGJoouY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Mar 2026 17:19:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: ali.norouzi@keysight.com,
	security@kernel.org,
	torvalds@linuxfoundation.org
Cc: mkl@pengutronix.de,
	socketcan@hartkopp.net,
	stable@vger.kernel.org
Subject: [PATCH 1/2] can: gw: fix OOB heap access in cgw_csum_crc8_rel()
Date: Wed, 18 Mar 2026 17:19:13 +0100
Message-ID: <20260318161914.15140-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318161914.15140-1-socketcan@hartkopp.net>
References: <20260318161914.15140-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227122-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 414732BFB3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ali Norouzi <ali.norouzi@keysight.com>

cgw_csum_crc8_rel() correctly computes bounds-safe indices via calc_idx():

    int from = calc_idx(crc8->from_idx, cf->len);
    int to   = calc_idx(crc8->to_idx,   cf->len);
    int res  = calc_idx(crc8->result_idx, cf->len);

    if (from < 0 || to < 0 || res < 0)
        return;

However, the loop and the result write then use the raw s8 fields directly
instead of the computed variables:

    for (i = crc8->from_idx; ...)        /* BUG: raw negative index */
    cf->data[crc8->result_idx] = ...;    /* BUG: raw negative index */

With from_idx = to_idx = result_idx = -64 on a 64-byte CAN FD frame,
calc_idx(-64, 64) = 0 so the guard passes, but the loop iterates with
i = -64, reading cf->data[-64], and the write goes to cf->data[-64].
This write might end up to 56 (7.0-rc) or 40 (<= 6.19) bytes before the
start of the canfd_frame on the heap.

The companion function cgw_csum_xor_rel() uses `from`/`to`/`res`
correctly throughout; fix cgw_csum_crc8_rel() to match.

Confirmed with KASAN on linux-7.0-rc2:
  BUG: KASAN: slab-out-of-bounds in cgw_csum_crc8_rel+0x515/0x5b0
  Read of size 1 at addr ffff8880076619c8 by task poc_cgw_oob/62

To configure the can-gw crc8 checksums CAP_NET_ADMIN is needed.

Fixes: 456a8a646b25 ("can: gw: add support for CAN FD frames")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 8ee4d67a07d3..0ec99f68aa45 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -373,14 +373,14 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 
 	if (from < 0 || to < 0 || res < 0)
 		return;
 
 	if (from <= to) {
-		for (i = crc8->from_idx; i <= crc8->to_idx; i++)
+		for (i = from; i <= to; i++)
 			crc = crc8->crctab[crc ^ cf->data[i]];
 	} else {
-		for (i = crc8->from_idx; i >= crc8->to_idx; i--)
+		for (i = from; i >= to; i--)
 			crc = crc8->crctab[crc ^ cf->data[i]];
 	}
 
 	switch (crc8->profile) {
 	case CGW_CRC8PRF_1U8:
@@ -395,11 +395,11 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 		crc = crc8->crctab[crc ^ (cf->can_id & 0xFF) ^
 				   (cf->can_id >> 8 & 0xFF)];
 		break;
 	}
 
-	cf->data[crc8->result_idx] = crc ^ crc8->final_xor_val;
+	cf->data[res] = crc ^ crc8->final_xor_val;
 }
 
 static void cgw_csum_crc8_pos(struct canfd_frame *cf,
 			      struct cgw_csum_crc8 *crc8)
 {
-- 
2.51.0


