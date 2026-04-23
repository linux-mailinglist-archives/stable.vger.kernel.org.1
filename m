Return-Path: <stable+bounces-240532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICfrDkhv6mlBzQIAu9opvQ
	(envelope-from <stable+bounces-240532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:13:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C757845688C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EAA13013BBA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669939937B;
	Thu, 23 Apr 2026 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4sqRX96"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A339902D;
	Thu, 23 Apr 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971531; cv=none; b=SMoaAKimzC/nOgIbxLRayrhdaAG5WC0GH/SxwyEWOxyZh1Cah/8pBWkDMLZy/VuxKR5Vm2CpoMkL9PBdmlWNLe4QzFmssq1fUkp5+254iI6cmWcUU+V8ki/eOi5Rpyk/V7N9V7DbbhqGitCl4S/dUJYMhGudFjHIz48+0L9QoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971531; c=relaxed/simple;
	bh=YwDMmv55teQkZqBfuPu0O/vef+tkUnpUMlh4t6TN/Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF+ap/6bjJFaHt1Z84a1dVxK6xnyddEw5M6mIc3FnWcqQY9eFWKqSarwnppiC7MQVLRkFQBpQLArmHX54c/x5sOmb3ggpxKtGVNiK0ZknQmTupozxzj7O8rbSt2tiOIBubGzB4/J52mpJ2JVhTXisPO0j9Luzdhdqjjs7g+gLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4sqRX96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A6C2BCB6;
	Thu, 23 Apr 2026 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971530;
	bh=YwDMmv55teQkZqBfuPu0O/vef+tkUnpUMlh4t6TN/Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4sqRX96ArngJ7kAfaf4HWZ5gsBPI0TjTbbGhhb1ItVHFcdGQy9V22OtAT9W7f3JP
	 xSdtukNXScG6AdMjWclsq7Cz3QvWINAuJHmua2H2x+F3WtkZygeLkNBCUPMKvuQUjp
	 qSGh2qADDE89Wqyl/v7z6txUoL9Nho6oTsccBAMIkytD9RUfbScmL5UCcsaLvjpq33
	 85VTAARP4nwek92tVlVp+tTzOMY9AULX1yZFiOSFR49AxVZ+H9eIBP9XcFReiKsxbN
	 LOflpIYverJRIdHTUqDWXtqSt4Eqj19ZrkCqtwcFvDSiY9pXzJbV2ZAXikBqIcXNgT
	 NMW0L1WCcvEwA==
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
Subject: Re: [PATCH net 3/6] net/ncsi: validate GMCMA address counts against the payload
Date: Thu, 23 Apr 2026 12:12:09 -0700
Message-ID: <20260423191209.3296515-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-4-michael.bommarito@gmail.com>
References: <20260422160342.1975093-4-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mendozajonas.com,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240532-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C757845688C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/ncsi: validate GMCMA address counts against the payload

This commit adds payload length checks to the NC-SI GMCMA response handler
to ensure the advertised address count does not exceed the packet size.

> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c

[ ... ]

> @@ -1127,9 +1135,21 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
>  	struct sockaddr_storage *saddr = &ndp->pending_mac;
>  	struct net_device *ndev = ndp->ndev.dev;
>  	struct ncsi_rsp_gmcma_pkt *rsp;
> +	unsigned int addr_bytes;
> +	unsigned int payload;
>  	int i;
>  
>  	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
> +	payload = ncsi_rsp_payload(nr->rsp);
> +	if (payload < sizeof(rsp->address_count) + sizeof(rsp->reserved) +
> +		      sizeof(__be32))

The commit message states it validates the fixed GMCMA fields plus checksum.
Does the NC-SI payload length actually include the 4-byte checksum?

Looking at ncsi_validate_rsp_pkt(), the common.length field does not include
the checksum, but it does include the 2-byte code and 2-byte reason fields.

Is it possible the subtraction of sizeof(__be32) here coincidentally works out
to the same 4 bytes as subtracting the code and reason fields, but conceptually
misrepresents the packet layout?

> +		return -EINVAL;
> +
> +	addr_bytes = payload - sizeof(rsp->address_count) -
> +		     sizeof(rsp->reserved) - sizeof(__be32);
> +	if (rsp->address_count > addr_bytes / ETH_ALEN)
> +		return -EINVAL;
> +
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;

This isn't a bug introduced by this patch, but does this read-modify-write
of priv_flags in softirq context race with other modifications?

Since priv_flags is a standard unsigned int, could a concurrent update from
process context holding rtnl_lock (such as modifying IFF_PROMISC) silently
discard this IFF_LIVE_ADDR_CHANGE update or vice versa?

>  
>  	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",

This isn't a bug introduced by this patch, but are the updates to pending_mac
and gma_flag further down in this function safe from data races?

The caller ncsi_rcv_rsp() explicitly drops ndp->lock before invoking the
response handler:

ncsi_rcv_rsp()
    spin_unlock_irqrestore(&ndp->lock, flags);
    ret = nrh->handler(nr);

Since the NC-SI subsystem allows userspace to inject commands concurrently via
Netlink, could multiple Get MC MAC Address responses process simultaneously on
different CPUs and cause a torn write when copying the 6-byte MAC address into
ndp->pending_mac?

