Return-Path: <stable+bounces-263085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ywWmMfz0Lmoe6gQAu9opvQ
	(envelope-from <stable+bounces-263085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 20:37:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B62681E62
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 20:37:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=BIIGEw1p;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263085-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263085-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62178300916B
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEE72F7EED;
	Sun, 14 Jun 2026 18:37:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AFE27456;
	Sun, 14 Jun 2026 18:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462260; cv=none; b=Zi7nqYsh4ztxBWM09GrUq2ZKJjyBjoOv54/L+VQiRwia+XSInx2j9qvbqO9V+gHdWv7W0FztVcIjZec5a2uWJEFqPCGP7GHiUFhIdVe13KXteNpZsrGkTslB6bDbwoUoODp1+R3rCN/xPuA+dJgWWjE6hrPRSz8N9mwS4skH28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462260; c=relaxed/simple;
	bh=Z7HDfVJg2jcODeiTiqOrlDAJJhrLYUUdqKCMicF5dg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFKF/roJJMKbxkyHqc/fIvSedloJUBUzyFKmDEwSaUC+V3s1XaCo832iFZxU1ZN6bB02/k4BT+jUQ1/Z0B73MmFXv4IvTCGQ5COh/9W3Qpvo+HeUa2vkRTxV7POkXmQB3c/NJwmV6gUtJ5QLjVKlgTimq0oMIS8YQdgZksH9kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BIIGEw1p; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hugQHs4sKsTK6Ai2NwmbPrwwXHDZ4UgWd7vqKRkJQ84=; b=BIIGEw1pe0onp6jNBRHRzN7ucu
	eSDC8PAcam0j14+iCbKI6yR7kbWP25vga4NMV5eQXGou6G3S6RINnXN6x+CN+uXL2vBF8lB9qr0nN
	CdkgHCBA/DCUDV7Qr03pmiWx1JECyFilFnalj5vJgJxv7zinJlHcncFKUwQf7RUEdFxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wYphZ-007gaR-OT; Sun, 14 Jun 2026 20:36:57 +0200
Date: Sun, 14 Jun 2026 20:36:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] atm: br2684: validate IP header length before
 filtering
Message-ID: <e85fe7cc-05d1-4fb1-a919-baa170d08307@lunn.ch>
References: <20260614084027.1179-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614084027.1179-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263085-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:3chas3@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lists.sourceforge.net,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:email,tsinghua.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53B62681E62

On Sun, Jun 14, 2026 at 04:40:26PM +0800, Yizhou Zhao wrote:
> When CONFIG_ATM_BR2684_IPFILTER is enabled, packet_fails_filter()
> treats skb->data as an IPv4 header whenever the packet protocol is
> ETH_P_IP and then reads iph->daddr.  That read is not protected by a
> check that the pulled skb still contains a full IPv4 header.
> 
> This is reachable through the receive path.  An LLC-routed IPv4 PDU can
> contain only the 8-byte LLC/SNAP header; br2684_push() accepts it,
> sets skb->protocol to ETH_P_IP, pulls the LLC header, and leaves
> skb->len as 0 before the filter runs.  The VC-routed path also reads
> iph->version before checking that the skb contains an IPv4 header, so a
> 2-byte PDU starting with an IPv4 version nibble can reach the same
> filter decision.
> 
> In both cases the filter can make its pass/drop decision from bytes
> outside the packet data.  A reproducer using a dummy ATM receive device
> filled the skb tailroom with 0xa5 and showed that an 8-byte LLC-routed
> PDU and a 2-byte VC-routed PDU were forwarded when the filter prefix was
> 0xa5a5a5a5, even though neither packet contained an IPv4 destination
> address.
> 
> Drop IPv4 packets that are shorter than struct iphdr in
> packet_fails_filter(), before reading iph->daddr.  Also reject
> VC-routed packets shorter than struct iphdr before br2684_push() reads
> iph->version.  Such packets cannot contain a valid IPv4 header, while
> normal minimum-sized IPv4 packets continue through the existing filter
> logic.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>

So did all these people find the problem at the same time in parallel?
Can you point to their reports?

It is a long time since i worked with ATM. From what i remember, ATM
cells are 48 bytes in size. So can the packet actually be smaller than
48? Would a 48 byte packet trigger this? Or is AAL5 involved here? Can
AAL5 carry a frame smaller than 48 bytes?

What hardware was used when finding this problem? I know DSL often
used ATM underneath, so was it a DSL modem?

	Andrew

