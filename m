Return-Path: <stable+bounces-215749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI/kJdoTjGl1gAAAu9opvQ
	(envelope-from <stable+bounces-215749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 06:30:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C8121599
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 06:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62BA303C297
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657D3446AF;
	Wed, 11 Feb 2026 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Myxfk5HE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E401A3157
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770787800; cv=none; b=aDnajnthhzMBrgDUtwWnsp1gQMCQx7CM4+FZ4ly5TGqcKXeh8bDFXyrXGeidN99RmrUDFBd+ryTsdp/SL74Vq9vmLqcDyqfUMxfL/aiaQzyQtf05IDxnbHJlGfVuTYeB66IP+0FwjvNqIAknrQBWNg/4iiqHinonoQa2GUrnwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770787800; c=relaxed/simple;
	bh=Uz+x9y99muTa8NCgYEpHnw/WPnftl6PnQ+zs1LSTcXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzaTTJTqoLFQyES4aV2z4NUJTSAocoRy+jVMp6BbLxXtm6B0x4ZEc8fPQkCcnK4OTiQWcXiCn069LjymFiQ3i4Y8F0fQ70HNnWxvCwYNMto6kAsQjcc9TiuwIUzxzm12XwVW7XcC9R9FH7KZG6jRde0J7AhRT0LPn+4/qy6tu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Myxfk5HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1793C4CEF7;
	Wed, 11 Feb 2026 05:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770787799;
	bh=Uz+x9y99muTa8NCgYEpHnw/WPnftl6PnQ+zs1LSTcXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Myxfk5HEkvebWZ+SL2FyaSK72iDneav+ebjjmH6s5aQJ+9yERQShgwBbAjG/nNKUB
	 ujHlDIZWRujTcEP0angQL1QjDx1aUw6sYGncX2a8CoBN8zL9tWu0ZqQ+9Q7J1zyHgn
	 rPaX8MDCLu8XgOiAVnRGZjRPgQGWTeCpIT/uBN/k=
Date: Wed, 11 Feb 2026 06:29:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tj <tj.iam.tj@proton.me>
Cc: 1127597@bugs.debian.org, Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org, Bastien Durel <bastien@durel.org>
Subject: Re: Regression: v6.12.67 ip6_tunnel: ip6gre decapsulation fails
Message-ID: <2026021138-gleaming-overarch-7e6f@gregkh>
References: <177076023892.578113.8206759777477389796.reportbug@sunny>
 <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
 <4157ffbe-3974-46f8-a39f-01671d86e224@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4157ffbe-3974-46f8-a39f-01671d86e224@proton.me>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215749-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E78C8121599
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 05:04:04AM +0000, Tj wrote:
> ip6gre tunnels fail to be decapsulated in v6.12.67 so never appears on 
> the GRE interface.
> 
> Reverting the following commit fixes it:
> 
> commit df5ffde9669314500809bc498ae73d6d3d9519ac
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Wed Jan 7 16:31:09 2026 +0000
> 
>      ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
> 
>      [ Upstream commit 81c734dae203757fb3c9eee6f9896386940776bd ]
> 
> v6.19 works but I've not been able to identify a subsequent commit that 
> should also be backported to the stable tree.

Please see this thread:
	https://lore.kernel.org/r/CANn89iL5ksZZCJr7SK9=4Sw6EejdOzr5_m6pBMM8RVtbLy_ACA@mail.gmail.com

I think that should fix this, right?

thanks,

greg k-h

