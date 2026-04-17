Return-Path: <stable+bounces-238494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDg4FS054ml73gAAu9opvQ
	(envelope-from <stable+bounces-238494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7993A41BC71
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7F6D30116BE
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D439F18C;
	Fri, 17 Apr 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIvhAJLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561718871F;
	Fri, 17 Apr 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433440; cv=none; b=M9W0lPsL9Eetl0dbyjLD1KRlphKLsIOqYynRQtWTrVfsd2ziutdKyntWkzOp9ff6MniHNTTWSaWJUVzhV443ciLnsKAk355e6SSgc1ypjQmndAkWlXkoGUQ+tdx+TtEvob1LcjpBZJ0tj0COjDHe4PRANIK4ykNyxJRs9bPl0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433440; c=relaxed/simple;
	bh=4lXh4kXUKkj47sLf2DEw+88AaNmaDmKw2CaaikE0xlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFzI4LqVElrzn4iwCAMlcMZ86SnYdSAh4FdSsmtR4DiCDwf4oD8wk1xDOzhK9H8PLQ2fHPP8Rn2+vRGUF1J0ci6qtlrJi5xf0hGugH+hpBSD/lSTSXTlSrv5+6bvL8GtML1BhpKm1wcyTufwPcO/tIKqn1IQpHJIw90ipAJvbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIvhAJLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC87C19425;
	Fri, 17 Apr 2026 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776433439;
	bh=4lXh4kXUKkj47sLf2DEw+88AaNmaDmKw2CaaikE0xlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIvhAJLjbR6ewsxrayhObK/DcB+fg4A/uMhiLt7Pw+Y1sU3z5kDF+NSOIUeFGFT8Q
	 T7qlXcEZHHyYz6Eqz2FEgscAi3i3B1zFV+6jWVtDX+4o9MPRj78kA+JUwv72MiJ1Dn
	 uythP1KldckBtJlXKZilc4INxhSFXNmNkGt6TXRsDSBnwR9aoVJgnt/hLsUOv7RIiv
	 Vmd5xWD9lX/KpMUXPXovFth1j8va7/PDRDveYREoRHCoYfqw2nXx5LC7U9FCbfCZ9j
	 7CkED1pexKQ/OOQF193Pyb3mvBI5VVtQAX0IXXuyyQ/KHxl8PQtFjPSbG8CtmKqytl
	 1ze9c6AV8qsGg==
From: Simon Horman <horms@kernel.org>
To: snowwlake@icloud.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	framemain@outlook.com,
	edumazet@google.com,
	davem@davemloft.net
Subject: Re: [PATCH net v3 3/4] nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
Date: Fri, 17 Apr 2026 14:43:22 +0100
Message-ID: <20260417134321.190842-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414233534.55973-4-snowwlake@icloud.com>
References: <20260414233534.55973-4-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,outlook.com,google.com,davemloft.net];
	FREEMAIL_TO(0.00)[icloud.com];
	TAGGED_FROM(0.00)[bounces-238494-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7993A41BC71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl

This commit fixes multiple out-of-bounds read vulnerabilities in the
nfc_llcp_recv_snl() function when handling Service Name Lookup PDUs from
hostile NFC peers.

> nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
>
> nfc_llcp_recv_snl() has four problems when handling a hostile peer:
>
>  1. nfc_llcp_dsap()/nfc_llcp_ssap() dereference skb->data[0..1] without
>     verifying skb->len; a 0- or 1-byte frame leads to an OOB read.
>     Additionally tlv_len = skb->len - LLCP_HEADER_SIZE wraps when
>     skb->len < 2, causing the following loop to run far past the
>     buffer.
>
>  2. The per-iteration loop guard `offset < tlv_len` only proves one
>     byte is available, but the body reads tlv[0] and tlv[1].
>
>  3. The peer-supplied `length` field is used to advance `tlv` without
>     being checked against the remaining array space.
>
>  4. The SDREQ handler previously only required length >= 1 but reads
>     both tid (tlv[2]) and the first byte of service_name (tlv[3], via
>     the pr_debug("%.16s") print and the service_name_len = length - 1
>     string usage), so length >= 2 is required.
>
> Fix: reject frames smaller than LLCP_HEADER_SIZE up front; add TLV
> header and TLV value guards at the top of each iteration; bump the
> SDREQ minimum length to 2.
>
> Reachable from any NFC peer within ~4 cm once an LLCP link is up.
>
> Fixes: 7a06f0ee2823 ("NFC: llcp: Service Name Lookup implementation")

The Fixes: tag references commit 7a06f0ee2823, but this commit does
not exist in the repository. The vulnerable TLV parsing was actually
introduced in commit 19cfe5843e86 ("NFC: Initial SNL support") from
October 5, 2012, which added nfc_llcp_recv_snl() with the bounds
checking issues.

Should the Fixes: tag be:

    Fixes: 19cfe5843e86 ("NFC: Initial SNL support")

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index db5bc6a878dd..8e7b8d2347d6 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1284,6 +1284,11 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  	size_t sdres_tlvs_len;
>  	HLIST_HEAD(nl_sdres_list);
>
> +	if (skb->len < LLCP_HEADER_SIZE) {
> +		pr_err("Malformed SNL PDU\n");
> +		return;
> +	}
> +
>  	dsap = nfc_llcp_dsap(skb);
>  	ssap = nfc_llcp_ssap(skb);
>
> @@ -1300,11 +1305,17 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  	sdres_tlvs_len = 0;
>
>  	while (offset < tlv_len) {
> +		if (tlv_len - offset < 2)
> +			break;
>  		type = tlv[0];
>  		length = tlv[1];
> +		if (tlv_len - offset - 2 < length)
> +			break;
>
>  		switch (type) {
>  		case LLCP_TLV_SDREQ:
> +			if (length < 2)
> +				break;
>  			tid = tlv[2];
>  			service_name = (char *) &tlv[3];
>  			service_name_len = length - 1;
>
>  			pr_debug("Looking for %.16s\n", service_name);

The new length check ensures length >= 2 to protect tlv[2] and tlv[3]
accesses. However, pr_debug with %.16s can read up to 16 bytes from
service_name (starting at &tlv[3]), not just one byte as stated in the
commit message.

When length==2 (the minimum), only tlv[3] is validated, but pr_debug
may read through tlv[18] while searching for a null terminator. If a
hostile peer sends a SDREQ with length=2 near the end of the buffer,
pr_debug could read beyond the validated region into skb tail room.

This only occurs when DEBUG is enabled (development kernels), so it's
less critical than the production OOB reads being fixed. However, should
the debug code use bounded printing to match the security-focused nature
of this patch?

    pr_debug("Looking for %.*s\n", (int)service_name_len, service_name);

[ ... ]

> @@ -1363,6 +1374,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  		break;
>
>  	case LLCP_TLV_SDRES:

In v2 of this patch, Paolo Abeni noted that SDRES also needs a length
check for accessing tlv[2] and tlv[3]. While v2 included this check,
it was removed in v3 and is missing from the current version.

SDREQ now has the length < 2 protection (added above), but SDRES still
lacks validation. Looking at the SDRES handler later in the function:

net/nfc/llcp_core.c:nfc_llcp_recv_snl() {
    case LLCP_TLV_SDRES:
        dsap = tlv[2];     /* reads tlv[2] without validation */
        ...
        ssap = tlv[3];     /* reads tlv[3] without validation */
}

Should SDRES also have the length >= 2 check before accessing tlv[2]
and tlv[3]?

