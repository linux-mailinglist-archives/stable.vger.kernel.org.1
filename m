Return-Path: <stable+bounces-270886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GN4JE5ChRmpVagsAu9opvQ
	(envelope-from <stable+bounces-270886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:36:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758F6FB79D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:36:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="x1/r5ujH";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270886-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270886-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 384213164FD1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE9D318BA7;
	Thu,  2 Jul 2026 16:35:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F2330B01;
	Thu,  2 Jul 2026 16:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010107; cv=none; b=bPuE7CmsPbvEKaYrlfRuDQEI2u/aiO9hQTCJIbvQP0efvSEyeTBHDnlq5DRKwCkrB6RqOi/zYauASc7UA4BofSfUsLcGUNmpWMgQB7suV5NqIGiyEO+YtGeiZ1xtjwgZT+l2IB0ZK7774KAs1GLtsjdyhvQ7zV9nngPVvH/uQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010107; c=relaxed/simple;
	bh=GUwf0H6K0Uzht15IZ+w3GP1XCc2uRgLFTPGMHfDDu24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NctisKIuj/9OiU2UUKMmOqEFjX48r/jZZ5zJR+pVQr69MY2/itdXz4pSBQxWfOSwPaHGumnVP8OFUnroqLu4RELqR7Iqr6e0tKhRXJ7IGs/tjlyawOdzUO2nKHBbOUszrgiX1DPJRk2BjJQ97sg40RMChiESTDKx4HXGF7fOhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1/r5ujH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1048D1F000E9;
	Thu,  2 Jul 2026 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010106;
	bh=yPnbRnjS6qJRicLlGu3fcmsZU1KwVjwrWWpKXM0QyDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x1/r5ujHYWWOvurTSDt4CeVxEfGkRWKtFu0Lr9fSNUFapKW9eHI7Dt6+22X6Xsf/a
	 9ifp5S2k9hSwXo2VPJ7IxzslZbd7aV/A72Az3tsINIm+XltQ/NuA23BCPcrGVozdMv
	 WvyOePrzss619UhO9GWxewtUOIOOExF7zQh+GQCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guannan Wang <wgnbuaa@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 106/129] NFSD: Fix SECINFO_NO_NAME decode error cleanup
Date: Thu,  2 Jul 2026 18:20:25 +0200
Message-ID: <20260702155114.337496343@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270886-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:wgnbuaa@gmail.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4758F6FB79D

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guannan Wang <wgnbuaa@gmail.com>

commit 9e18e83b8846a5c3fe13fc8a464b4865d33996c6 upstream.

nfsd4_decode_secinfo_no_name() currently initializes sin_exp after
decoding sin_style. If the XDR stream is truncated, the decoder returns
nfserr_bad_xdr before sin_exp is initialized.

Since commit 3fdc54646234 ("NFSD: Reduce amount of struct
nfsd4_compoundargs that needs clearing"), the inline iops array is not
cleared between RPC calls. A failed SECINFO_NO_NAME decode can therefore
leave sin_exp holding stale union contents from a previous operation.

The error response path still invokes nfsd4_secinfo_no_name_release(),
which calls exp_put() on a non-NULL sin_exp.

Initialize sin_exp before the first failable decode step, matching
nfsd4_decode_secinfo().

Fixes: 3fdc54646234 ("NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing")
Cc: stable@vger.kernel.org
Signed-off-by: Guannan Wang <wgnbuaa@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4xdr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1821,10 +1821,11 @@ static __be32 nfsd4_decode_secinfo_no_na
 					   union nfsd4_op_u *u)
 {
 	struct nfsd4_secinfo_no_name *sin = &u->secinfo_no_name;
+
+	sin->sin_exp = NULL;
 	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
 		return nfserr_bad_xdr;
 
-	sin->sin_exp = NULL;
 	return nfs_ok;
 }
 



