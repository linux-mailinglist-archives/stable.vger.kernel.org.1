Return-Path: <stable+bounces-236771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPhPM9sh3WndaAkAu9opvQ
	(envelope-from <stable+bounces-236771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:03:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD43F098A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72804321499B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532130C371;
	Mon, 13 Apr 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7XC29mi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6830DEDC;
	Mon, 13 Apr 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097751; cv=none; b=Obt6O/hvLiA2UJI6iEi3LWVOKsHysBaz7d/KPOLkVyNFUxH1KHgPAtXY0dkfR1nTc/yGj1+9EKMw7bM1cdQ+lQfswgYsDsytPZR+ebh3R3rsvgHwZOV4oe1+6D7XRJWApoqc/L3dw3J6u9ezfbLhdD0mo8mU/MlGe/DXkvnuFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097751; c=relaxed/simple;
	bh=Cf2pTM+T3YMNwQwYllCZLap0uMhXQ6yAAFA6uJ6WllU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhw9gRItsLZBJdflUoFU9yGB+bv9sdyI6HLjPV4oUnw45MJz0qn7uuxiG7ZqhZnSD/uu6V3kkyTa0DGyklZjb352bxREbxxN3R68Vm7i76w2sDTuBUliJoo6FOyWSM/D/VueivmtbgZD+GkfAn6VrNNlizfQ0EUCNvrwJBGX60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7XC29mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F898C2BCAF;
	Mon, 13 Apr 2026 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097751;
	bh=Cf2pTM+T3YMNwQwYllCZLap0uMhXQ6yAAFA6uJ6WllU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7XC29mip3TumfPYXFSIDpL3fvrDo275SVQnfh3EYrcVJCFLDTsk6ClxjRoQ5Hrlh
	 Liw2aKmH+UGvGhPnpgqNCr66L3mlh+IUJtWJOEcU6TfL+p//0SXN/fcqABV2TJcWH9
	 MbqBXBeMdPEsmTZDGBrOAbUqcDaEwKEWDGp1EBAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Klaudia Kloc <klaudia@vidocsecurity.com>,
	=?UTF-8?q?Dawid=20Moczad=C5=82o?= <dawid@vidocsecurity.com>,
	Jenny Guanni Qu <qguanni@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 257/570] netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
Date: Mon, 13 Apr 2026 17:56:28 +0200
Message-ID: <20260413155840.100171721@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vidocsecurity.com,gmail.com,strlen.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236771-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vidocsecurity.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 44AD43F098A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jenny Guanni Qu <qguanni@gmail.com>

[ Upstream commit 1e3a3593162c96e8a8de48b1e14f60c3b57fca8a ]

In decode_int(), the CONS case calls get_bits(bs, 2) to read a length
value, then calls get_uint(bs, len) without checking that len bytes
remain in the buffer. The existing boundary check only validates the
2 bits for get_bits(), not the subsequent 1-4 bytes that get_uint()
reads. This allows a malformed H.323/RAS packet to cause a 1-4 byte
slab-out-of-bounds read.

Add a boundary check for len bytes after get_bits() and before
get_uint().

Fixes: 5e35941d9901 ("[NETFILTER]: Add H.323 conntrack/NAT helper")
Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczadło <dawid@vidocsecurity.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 62aa22a078769..c972e9488e16f 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -331,6 +331,8 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
 		if (nf_h323_error_boundary(bs, 0, 2))
 			return H323_ERROR_BOUND;
 		len = get_bits(bs, 2) + 1;
+		if (nf_h323_error_boundary(bs, len, 0))
+			return H323_ERROR_BOUND;
 		BYTE_ALIGN(bs);
 		if (base && (f->attr & DECODE)) {	/* timeToLive */
 			unsigned int v = get_uint(bs, len) + f->lb;
-- 
2.51.0




