Return-Path: <stable+bounces-269558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9hg4KKpOQWqxnQkAu9opvQ
	(envelope-from <stable+bounces-269558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:41:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC46D469F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:41:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=OrimP6fT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269558-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269558-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B85C300D335
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942202D876A;
	Sun, 28 Jun 2026 16:41:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAF2D592D;
	Sun, 28 Jun 2026 16:41:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664865; cv=none; b=mvR2MYrQm1oc3jV5MIq2qnpxdyux1JC36a9oRxgghrDyFoCrHeqk3eUXkAUeBFkMZCndMqCYV9wWyuVKYAiiuZ3B62jOk1YfkJcgYMZLfY+VB15pepONVOO/IG60ynzQm+QVu77V64wMHphGdNwSja+huzX4LzmtBT07dYsWmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664865; c=relaxed/simple;
	bh=LSCUwICUqCuV2GVZLI+GD5iR/lyWdJWr3Z3gQRwcJQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMwrPNleX60uWYbQQg2qerOFbalLrDOnR6BzHTqVvOwyYVOkkC0LvuWeeMB4oL8E+vs7CocKZsGFL3CblJKMscwMA9ATOhziDyseuRdkaeON5bn+KzBKdut9DhGAPg3d9v4P8AoO+h8YQ0qpxTIG4cYDQT090DtUfWc3fRFEN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OrimP6fT; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m/ThfnCA53xsojiK3CDkKqyB+7t20zZEYIXw4BzuvDA=; b=OrimP6fTdz343iL+WTwQ1+rjCS
	8uCXcEObsyaEJ4tFo7UPjtXRtkVAYWq1eDAKvM8AF8AIJmJSpt4TkO+0RA2DuU9/UPsi3xqtDFmIS
	3LdR6BjtQnk4UeM5HvJLK+tzAQzoBF1tsUg6jeFMwsPxo283gnklZmrBGmmIqv1kDWaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdsYo-009cMG-T7; Sun, 28 Jun 2026 18:40:46 +0200
Date: Sun, 28 Jun 2026 18:40:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] net: usb: rtl8150: handle link status read failures
Message-ID: <31402931-dd4f-4dda-9637-2880350101d7@lunn.ch>
References: <20260628151835.GC14404@carbon.k.g>
 <20260628162528.8273-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628162528.8273-1-alhouseenyousef@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269558-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[stable,netdev,9db6c624635564ad813c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0BC46D469F

On Sun, Jun 28, 2026 at 06:25:28PM +0200, Yousef Alhouseen wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> Cc: stable@vger.kernel.org

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Does this issue bother people?

I think it would be better to submit to net-next:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please don't thread patch versions together.

Also, a Suggested-by: might be appropriate here.

    Andrew

---
pw-bot: cr

