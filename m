Return-Path: <stable+bounces-240530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACbPFFtw6mlBzQIAu9opvQ
	(envelope-from <stable+bounces-240530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:17:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD189456A1B
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C59308BA0B
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5C639182F;
	Thu, 23 Apr 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYKESqXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6A3921CD;
	Thu, 23 Apr 2026 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971527; cv=none; b=R7iAd7BeQb9IxxGqPFPHuFiQjPkdEbbV+c93D4GL/HNgsVK7b7f0B8xOEsTWvGRZNVg0LddpNRGXUw10nTNkYxeBebBQMkGLGwFfXw4TrzxbUvB8UvgAyg2VT2jVf+WvPK7VXGrAVl7G3GprpGLN3v3Nrj9vu1VHJj6h5QSihsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971527; c=relaxed/simple;
	bh=Rg+/kqy7//JrIXigz5eHvVtRaNDdjXzSYhWaYfJ9iL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb1i6m8m1KPhsr7Za+pQGq3ztfkzxJ24e8gUMvSeW2Sqbf4JqdYtKfIEXjt/iE04sOwYt0WbbXLmJPsDckYriEBqjJQj2iAx6T1q7Hn/zYbRoRooCfVlmpJADe6zVd7OM0DRpOxnxRImMsoVApcoUhM4+voM5prYLUASnWNX7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYKESqXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA6C2BCAF;
	Thu, 23 Apr 2026 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971527;
	bh=Rg+/kqy7//JrIXigz5eHvVtRaNDdjXzSYhWaYfJ9iL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYKESqXuYVl5q8+zyHRZyjDKa/Jr2da+EVB8P1IJB1DBf/nxBT1Aosd6Txre9K8q4
	 Khsg8ITCwIOIGyx3ETTLS5OFOiq7HUHGof5h6pU5elwi9IwMTWX1uxS0m99I7cl2bt
	 AhTpLz7OpSwW45dCdD1JIOS5jJEqFiMgA8hQeTbpDDIFy+un+jDn7qjDHZ114lMfb5
	 9KSCzF1xz9zK/gRzoU98XE0kpIjuFBMCIVzuAhRC6ia2HSkOMbdARxdHM/YFnXkkUB
	 o6JF1FvOcomZV56kHUxPMrmZjQeJ177wAXwYdezkwFVdsQ7ejWsscOx5dAACZfkED4
	 vlL/AkW49piGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.bommarito@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam@mendozajonas.com,
	fercerpav@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/6] net/ncsi: validate response packet lengths against the skb
Date: Thu, 23 Apr 2026 12:12:03 -0700
Message-ID: <20260423191203.3296364-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-2-michael.bommarito@gmail.com>
References: <20260422160342.1975093-2-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mendozajonas.com,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240530-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD189456A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/ncsi: validate response packet lengths against the skb

This commit adds packet length validation for NC-SI responses. It pulls the
common header first, then pulls the full response body before validating the
packet to prevent reading past the received packet body.

> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index fbd84bc8026a3..1fe061ede26dd 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -38,11 +38,18 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
>  	struct ncsi_rsp_pkt_hdr *h;
>  	u32 checksum;
>  	__be32 *pchecksum;
> +	unsigned int len;
>  
>  	/* Check NCSI packet header. We don't need validate
>  	 * the packet type, which should have been checked
>  	 * before calling this function.
>  	 */
> +	len = skb_network_offset(nr->rsp) + sizeof(*h) + ALIGN(payload, 4);
> +	if (!pskb_may_pull(nr->rsp, len)) {

Does this pskb_may_pull() call potentially invalidate the hdr pointer cached
earlier in ncsi_rcv_rsp()?

Looking at ncsi_rcv_rsp(), it caches the header pointer before validating:

ncsi_rcv_rsp() {
    ...
    hdr = (struct ncsi_pkt_hdr *)skb_network_header(skb);
    ...
    ret = ncsi_validate_rsp_pkt(nr, payload);

If the SKB is fragmented and pskb_may_pull() needs to pull data into the
linear area, it can reallocate the SKB's data buffer and free the old buffer.

When ncsi_validate_rsp_pkt() returns, the local hdr pointer in ncsi_rcv_rsp()
would still point to the freed memory.

This pointer is then dereferenced in multiple error paths:

    if (ret) {
        netdev_warn(ndp->ndev.dev,
                    "NCSI: 'bad' packet ignored for type 0x%x\n",
                    hdr->type);
...
    ret = nrh->handler(nr);
    if (ret)
        netdev_err(ndp->ndev.dev,
                   "NCSI: Handler for packet type 0x%x returned %d\n",
                   hdr->type, ret);

Could this cause a use-after-free when reading hdr->type?
-- 
pw-bot: cr

