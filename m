Return-Path: <stable+bounces-267926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +F1VBdNwOmpa9AcAu9opvQ
	(envelope-from <stable+bounces-267926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574756B6CC2
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aaTs0w2z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267926-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267926-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 257E3305D982
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49903D3CE5;
	Tue, 23 Jun 2026 11:41:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF2379C23
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:41:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214864; cv=none; b=rEZH98y8wNUd3mvGJ219bpbJeQ4BOiPfW8xG7hcPGoJmcck5qB7NdXJqsqFw2O04epjEyn13hlwnzYUaiZeNCJISofNLa1WlGnJRCLKxDgSTyanhpjYh/Txq0/UNrXuXLHUVlYpd+BQuQkTY8lfGknBiNP6TdFm2hmqjSGhbEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214864; c=relaxed/simple;
	bh=g8jduOyiWy0B8mnnrt/rrd5sTEje8WVrXChbwVgRBQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzM+0SuHFq6LMMrAMif6zP/q6u951laQJYGAPaWWnU1VNLJf9GfZ0RvuSUURbra7xW/9s4dctPOEzmdcAi8wqXY7zwshz0ygH2fxEfaPaDoP/iOaWi54dHgppdxvu2+v/uykWdJhuP9tkibxNG9AIxZXnqlG/zpx2GgynqKB7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaTs0w2z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D561F00A3D;
	Tue, 23 Jun 2026 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782214863;
	bh=dsaYxsMb1EimdZ98sPE2h53JZZwh4ERS19yygJ6FH38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaTs0w2zqzSMl7Rf3DeUMrWURyja1HP88bR3ExxbGB3UVVXr3fU/D6fumNNluxalY
	 RK3/lSzpJ4wUuKWvalug3KVSn9/d7asHq7hHw//1h8fmz3pwZQaC2XlZeCMMxsFayY
	 Yl6jfoei5KrzoSQV/bgJ9fP8wFjjYrhOg0k3GjXM=
Date: Tue, 23 Jun 2026 13:39:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Pratte <slatoncomputers@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] s2io: only arm hardware LSO for GSO skbs
Message-ID: <2026062327-unengaged-apostle-5728@gregkh>
References: <20260623112131.752148-1-slatoncomputers@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623112131.752148-1-slatoncomputers@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267926-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:slatoncomputers@gmail.com,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 574756B6CC2

On Tue, Jun 23, 2026 at 06:21:31AM -0500, Michael Pratte wrote:
> s2io_xmit() enables the Xframe/Xframe-II hardware LSO (TCP segmentation)
> engine whenever the skb's gso_type carries SKB_GSO_TCPV4/TCPV6, and
> programs the segment size from gso_size:
> 
> 	offload_type = s2io_offload_type(skb);
> 	if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> 		txdp->Control_1 |= TXD_TCP_LSO_EN;
> 		txdp->Control_1 |= TXD_TCP_LSO_MSS(s2io_tcp_mss(skb));
> 	}
> 
> Since commit 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
> tcp_transmit_skb() sets skb_shinfo(skb)->gso_type unconditionally on
> every TCP skb, including non-GSO frames where gso_size is 0. The driver
> therefore arms the LSO engine with MSS == 0 for ordinary TCP segments
> such as the connection's SYN. The Xframe-II LSO engine treats an MSS of
> 0 as an illegal descriptor and aborts the transmit (lso_err_reg reports
> LSO6_ABORT), so the frame is dropped before it reaches the MAC. The
> result is that no TCP can be transmitted on these adapters since v4.2;
> UDP and ICMP (which never carry SKB_GSO_TCPV4) are unaffected.
> 
> Only arm the LSO engine when the skb is actually GSO (gso_size > 0),
> restoring the pre-4.2 behaviour. Non-GSO TCP frames take the normal
> transmit path.
> 
> Reproduced and fixed on Linux 6.6.67 with an Xframe-II adapter
> (PCI 17d5:5832); bisected to good v4.1.6 / bad v4.2.2.
> 
> Fixes: 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
> Signed-off-by: Michael Pratte <slatoncomputers@gmail.com>
> ---
> [ Not upstream and cannot be: the s2io driver was removed from mainline in
>   commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
>   driver"). It still ships in the 6.6.y and 6.12.y stable trees, where this
>   bug is present and the patch applies cleanly. Please apply there. ]

Why not just remove the driver in older kernels as well if it is not
being used?

And if it's not being used, why is this patch needed at all?

thanks,

greg k-h

