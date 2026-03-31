Return-Path: <stable+bounces-231563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIIwLnn+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001436DC4D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAD630B88E8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D79413240;
	Tue, 31 Mar 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F98a/ijt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89D3E3174;
	Tue, 31 Mar 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974493; cv=none; b=s3C7n+4zN3VAGxmsdcpbgtGhUr+pXvkd8EwajD2PlJ0m9jr/oG20UMp0ogCGHLvaR206aW/VFz2+SVL3EvhFt+cnvkvVcDsbKPR5HOBPRp9S0ajzTsW/7HFB3/PRP4UewIiPQJoJZ3d+3dA88J2D1PV+f/saKL+aM/GdaA0cOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974493; c=relaxed/simple;
	bh=T+lET38Q28cpG5PTvgQIsl31kCER/lt5Ea3QOtcJA3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwDSeSr6qSPPaXHLiMoxkGwWXigp6w6m4iRZdp2+Pd7/y4rOyUbAAsUByQJIJZ8i01DH2kzP3zCuICRdGlsLFcwI5mm+9NHwioxMQWVs4XsjAk0fHv9jME7PLZPEpNDJkyTOhAZUIU2IiwaTXve4KrYwkuz8zCiMHybCFDKKe6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F98a/ijt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA43FC2BCB2;
	Tue, 31 Mar 2026 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974493;
	bh=T+lET38Q28cpG5PTvgQIsl31kCER/lt5Ea3QOtcJA3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F98a/ijtqoNiqSfS3Mj7ymqO+MpRRqIzYRgqwnbzLRUP7GEivSDMtqNnghmV54SNz
	 /lpZEqZWGO4k8YjkOO8gs3/sltA1xn6xB+lkb+qa6G3xXCXgFO4ipM4in89XniCACu
	 WykJOC7Z+LhJwiEyPBycm2ST5Nyk0vcwinEPRSCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ali Norouzi <ali.norouzi@keysight.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6 105/175] can: gw: fix OOB heap access in cgw_csum_crc8_rel()
Date: Tue, 31 Mar 2026 18:21:29 +0200
Message-ID: <20260331161733.639147309@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231563-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email,keysight.com:email,pengutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2001436DC4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ali Norouzi <ali.norouzi@keysight.com>

commit b9c310d72783cc2f30d103eed83920a5a29c671a upstream.

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
Link: https://patch.msgid.link/20260319-fix-can-gw-and-can-isotp-v2-1-c45d52c6d2d8@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/gw.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -374,10 +374,10 @@ static void cgw_csum_crc8_rel(struct can
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
 
@@ -396,7 +396,7 @@ static void cgw_csum_crc8_rel(struct can
 		break;
 	}
 
-	cf->data[crc8->result_idx] = crc ^ crc8->final_xor_val;
+	cf->data[res] = crc ^ crc8->final_xor_val;
 }
 
 static void cgw_csum_crc8_pos(struct canfd_frame *cf,



