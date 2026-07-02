Return-Path: <stable+bounces-270904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hb1bAkeVRmp8ZAsAu9opvQ
	(envelope-from <stable+bounces-270904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93016FA748
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VSiJjSZK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270904-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270904-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3CA8301C432
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BE330B01;
	Thu,  2 Jul 2026 16:35:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA383403E7;
	Thu,  2 Jul 2026 16:35:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010155; cv=none; b=AV3nJFPLSZAzeoGtp3yUiWwHM+HyNB4ccrYScySDTSqeZTtDaytQjhUEzLLSMC+4IOpkyvUPIoxqv6XeVJfy/S03KKGbcCc81Hujv4R5Csw3y6oP4klb4ftyEaQYcMClSeQd9XfjgMWzFiH/1gjDbPiKSaEaiX1ySvApGM3Ek/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010155; c=relaxed/simple;
	bh=luY1wPs68fUfVQMRut8gxvDKl8O0DIXusbQnOWqOn9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC/J+8L8O+vK7vc5GJpmMBXY5LlPykjuj6dZH2zovqQmly8M8jDpJscFuQJB7Gcj4X/RpNExdJfHAiiP7Hk7dDBF8naLoFNiI33W+8oMzRafJoNyjNfMm/XQ07Xzi7Z9pI3lUll+RK/iWc1334pHSLhaCkenpLeSF0FRk8zCaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSiJjSZK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA01F000E9;
	Thu,  2 Jul 2026 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010153;
	bh=SZ6iM+2l7lB8FlilVodCNK5p+W0BdjsYvjQQyZZS2J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VSiJjSZKLVTD1t9d0c0Lza8wlP9xTYnc6Svm4B5EtB9PBprjEZDnmmYrLxNgkZTXP
	 /2AsFozDcep30MtGjomM7/D21GwizsYhekSkKJUvObY1HZbrEN8OVsX13yhTXvGvyY
	 En8oXE1oEC8F38scOwumO9BQol0/Zfql/s0rFlhY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>
Subject: [PATCH 6.1 109/129] NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr
Date: Thu,  2 Jul 2026 18:20:28 +0200
Message-ID: <20260702155114.399603237@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270904-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:anna.schumaker@hammerspace.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,hammerspace.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,hammerspace.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B93016FA748

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 41fe0f7b84f0cb822ae10ab08592996a592b2a25 upstream.

nfs4_decode_mp_ds_addr() decodes the r_netid and r_addr opaques of a
netaddr4 from a GETDEVICEINFO multipath-DS body, then immediately
calls strrchr(buf, '.') to locate the port separator. Both decodes
use xdr_stream_decode_string_dup(), and the current code checks only
"nlen < 0" / "rlen < 0" before dereferencing the returned string.

When the on-wire opaque has length zero, xdr_stream_decode_opaque_inline()
returns 0 and xdr_stream_decode_string_dup() falls through to its
"*str = NULL; return ret" tail, leaving buf NULL with a return value
of 0. The "< 0" check does not catch this, and the next line is
strrchr(NULL, '.'), a kernel NULL pointer dereference reachable from
any pNFS-flexfile client mounted against a malicious or compromised
metadata server.

Reject the zero-length cases explicitly so the decoder fails with
-EBADMSG (treated as a malformed GETDEVICEINFO body) instead of
panicking the client.

Cc: stable@vger.kernel.org
Fixes: 6b7f3cf96364 ("nfs41: pull decode_ds_addr from file layout to generic pnfs")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs_nfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1057,14 +1057,14 @@ nfs4_decode_mp_ds_addr(struct net *net,
 	/* r_netid */
 	nlen = xdr_stream_decode_string_dup(xdr, &netid, XDR_MAX_NETOBJ,
 					    gfp_flags);
-	if (unlikely(nlen < 0))
+	if (unlikely(nlen <= 0))
 		goto out_err;
 
 	/* r_addr: ip/ip6addr with port in dec octets - see RFC 5665 */
 	/* port is ".ABC.DEF", 8 chars max */
 	rlen = xdr_stream_decode_string_dup(xdr, &buf, INET6_ADDRSTRLEN +
 					    IPV6_SCOPE_ID_LEN + 8, gfp_flags);
-	if (unlikely(rlen < 0))
+	if (unlikely(rlen <= 0))
 		goto out_free_netid;
 
 	/* replace port '.' with '-' */



