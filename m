Return-Path: <stable+bounces-216786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCdWO5VQlGktCQIAu9opvQ
	(envelope-from <stable+bounces-216786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:27:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEA614B57C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FBF3009538
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26B3321DE;
	Tue, 17 Feb 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXG7V5Am"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A05331A61;
	Tue, 17 Feb 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327524; cv=none; b=kUAB88FQV9kEXT+OBoozuwL/yLs2oHEFlc3NzPopgRDTggSDH1dIDm1EVeXLMSMv55KDEFFvpXUZzDbBg1RZ697JvMJy9oTHMyPNX4IP/mD4X6bKTB65w25FFuuhv+WrfP0kEq/qOhOwRn8azp21a/fZmm7+LwcJtx6dvG61XFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327524; c=relaxed/simple;
	bh=CVpf3JWpk2nAbh0v2mx1jJ4G4xwq6GLVRV+qKHXex5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHNOzDXvFESvDVi2w0gTU7Ob8YDTtaYJgPyZTY+PAGo32XRtxaaSVarjtgk+/e3VwyiINU2Su6B67EiUtRyd9iS9oK3z4IwCdPYH9vdu+ygpTYFCKXeUKXOObEojV4jCaas8N/n/AljBlg3JBxm5KpkExpgLvTECmQboGaAJfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXG7V5Am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764DBC4CEF7;
	Tue, 17 Feb 2026 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771327523;
	bh=CVpf3JWpk2nAbh0v2mx1jJ4G4xwq6GLVRV+qKHXex5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXG7V5AmqAuaQgWKmnGPgdu7eKmGp2LmQvwU18jKwEDPYoeHmMLc7m02x3oD84JqL
	 EL5iBQzQb5TM9tgwWu2rfNKGSpArbi9lAAGGXJa0cl/HEI0V8RzrEwGYAMqdo/fUU5
	 IHdalvJ+wPKZSul7l+uXu2AOncdmYxh+Y1WI8SL8=
Date: Tue, 17 Feb 2026 12:25:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org,
	Daniel Dao <dqminh@cloudflare.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH stable v5.15,v6.1] Revert "wireguard: device: enable
 threaded NAPI"
Message-ID: <2026021751-vocalist-enroll-6b2a@gregkh>
References: <c05f3968fa63b630ce22d65aa03e6dcef4bf4e83.1771277247.git.daniel@iogearbox.net>
 <CAHmME9rsvaargjbZO8SkswOToUATuWpkQDVykEUty-kWPyu7gA@mail.gmail.com>
 <2026021715-confetti-endanger-21eb@gregkh>
 <cf804cbc-a8d3-4b11-9a46-679f4d10fd38@iogearbox.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf804cbc-a8d3-4b11-9a46-679f4d10fd38@iogearbox.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5FEA614B57C
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 12:01:15PM +0100, Daniel Borkmann wrote:
> On 2/17/26 11:33 AM, Greg KH wrote:
> > On Mon, Feb 16, 2026 at 10:33:53PM +0100, Jason A. Donenfeld wrote:
> > > On Mon, Feb 16, 2026 at 10:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > > Technically, the backport of commit db9ae3b6b43c ("wireguard: device:
> > > > enable threaded NAPI") to stable should not have happened since it is
> > > > more of an optimization rather than a pure fix and addresses a NAPI
> > > > situation with utilizing many WireGuard tunnel devices in parallel.
> > > 
> > > Indeed.
> > > 
> > > > Revert it from stable given the backport triggers a regression for
> > > > mentioned kernels.
> > > 
> > > Thanks.
> > > 
> > > Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > 
> > > If that helps with Greg queueing this up.
> > 
> > I'll go queue it up now, thanks for the revert.  But it's ok being in
> > the 6.6.y and 6.12.y and newer kernels, right?
> Great question; from a stable kernel PoV that commit to enable threaded
> NAPI for wireguard by default went in natively (aka not via backports) in
> linux-6.18.y branch.
> 
> Given there have been backports around threaded NAPI and then reverts again
> e.g. [0-2] I think it would be best to also queue this revert here for 6.6.y
> and 6.12.y stable kernels. The same applies that it's more of an optimization
> rather than a pure fix.
> 
> I've added CF folks to Cc given they have been testing v6.6 with [2] but
> then it later got reverted again in [1] upon request. Feel free to holler
> if you think otherwise.
> 
> Thanks,
> Daniel
> 
>   [0] https://lore.kernel.org/netdev/CA+wXwBTT74RErDGAnj98PqS=wvdh8eM1pi4q6tTdExtjnokKqA@mail.gmail.com/
>   [1] https://lore.kernel.org/stable/20260204143848.216983148@linuxfoundation.org/
>   [2] https://lore.kernel.org/all/20260120103833.4kssDD1Y@linutronix.de/
> 

Ok, to be "safe", I'll queue this revert up for those other kernel
branches as well, thanks!  Worst case, we get someone who asks for it to
come back :)

thanks,

greg k-h

