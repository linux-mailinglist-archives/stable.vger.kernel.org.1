Return-Path: <stable+bounces-223910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOv4JLz9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47A24A4CC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25DE930BBFBD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C94387577;
	Tue, 10 Mar 2026 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4ny3gRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22469387569
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141001; cv=none; b=f1ft0VTundJaC8iCVqlmFiKM07flGf5VwfrKTUCjMQSYhqsKc/gDrWh1Zsaep2HsBU5UTa994OWpXsS86Si3rWbwoWiMPO4o4ttKil4xeKVYBaycS07NSgmw/y0hVXcpvusD1PSrDUykz85C3qiPG2vD94jCtV2UOmak7xrPs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141001; c=relaxed/simple;
	bh=pTqsKzPZ4GxRZrm3fvozd35UWVUKhfzyl2f/S8JzPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u42OhFODurI13OtZL0s+F3RR2TkJjvIb1nYzEKCsoHzGxlNWyKfYbgMTHIVbfE5e/qpmUcIQVwboHqPnDKTHSSXfA4XdOmGC9nuZG/FM8w6pU4bm+iRBLRb+kmWBMcwwqxY2ICuaZw/x75lWP22KCgKgwnwLh2clbqASXUrxcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4ny3gRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D79C2BC9E;
	Tue, 10 Mar 2026 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773141000;
	bh=pTqsKzPZ4GxRZrm3fvozd35UWVUKhfzyl2f/S8JzPbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4ny3gRVAE0E8N6NZJI1kMSaRf00JCJs+3Bfx0nsEUSdU0mR/p/3GVP82bCX6fnw3
	 iA7TDXgz8ujlkfQLH5lfznazXcagTnJgfWjbv/Kh3+biCsAWYfwOrT46EZahkaHX3i
	 bbN92J6woNV4Ghkapp0OA4bfARrbXHMY+GbLRPPo=
Date: Tue, 10 Mar 2026 12:09:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
Message-ID: <2026031024-protegee-kinfolk-d9f3@gregkh>
References: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
 <2026030930-iphone-pony-e8ef@gregkh>
 <037126c3-d398-42aa-9883-e9eb74a0ad20@pobox.com>
 <2026031014-dimly-unbaked-4f9c@gregkh>
 <aa_hrFevcnH1nHm-@monoceros>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa_hrFevcnH1nHm-@monoceros>
X-Rspamd-Queue-Id: 3F47A24A4CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223910-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:22:14AM +0100, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Tue, Mar 10, 2026 at 08:07:33AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 09, 2026 at 06:34:47PM -0700, Barry K. Nathan wrote:
> > > On 3/9/26 07:43, Greg Kroah-Hartman wrote:
> > > > On Mon, Mar 09, 2026 at 07:03:33AM -0700, Barry K. Nathan wrote:
> > > > > To be very clear, I want to emphasize up front that this is regarding
> > > > > the *current 5.10.y queue*, and not any 5.10.y release. This does not
> > > > > affect any currently released 5.10.y kernel.
> > > > > 
> > > > > When I apply the current 5.10.y queue on top of 5.10.252, the result
> > > > > is a kernel that consistently freezes on shutdown, both when running
> > > > > directly on my Lenovo ThinkPad T14 Gen 1 (Debian 12 bookworm running on
> > > > > an Intel Core i5-10310U) and when running in a virt-manager VM (I didn't
> > > > > put much thought into it and just happened to pick a Debian 13 trixie VM
> > > > > for my testing).
> > > > > 
> > > > > (Just once in my testing, there was a visible kernel panic, but there
> > > > > was also screen corruption, and it looks to me like it might've frozen
> > > > > up partway through the panic being printed on the screen, so I'm not
> > > > > sure how useful it would be. I did take a photo so I guess I could
> > > > > post it up somewhere if it might be useful, or maybe I'll try to type
> > > > > it in from the photo later today or tomorrow.)
> > > > > 
> > > > > I bisected manually, and it turned out to be this patch:
> > > > > "driver core: platform: use bus_type functions"
> > > > > (driver-core-platform-use-bus_type-functions.patch)
> > > > 
> > > > That patch has been dropped from the queue earlier this morning, so all
> > > > should be fine.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > $ git pull
> > > Already up to date.
> > > $ fgrep bus_type queue-5.10/series
> > > driver-core-platform-use-bus_type-functions.patch
> > > 
> > > It doesn't look like the patch has been dropped yet from the
> > > 5.10.y queue in the stable-queue git repo on kernel.org.
> > > 
> > > (At least as of this writing, around 6:30 PM PDT, you can go to
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10
> > > and see that the patch is still there.)
> > > 
> > > 
> > > By the way, if dropping this patch turns out not to be the correct course
> > > of action, I think backporting one additional patch will fix it.
> > > 
> > > I applied the following patch directly from mainline to test it; it
> > > applied with an offset but no fuzz. I did some brief testing and it
> > > seems to fix the problem (no more freezing on shutdown).
> > > 
> > > mainline commit 46e85af0cc53f35584e00bb5db7db6893d0e16e5
> > > driver core: platform: don't oops in platform_shutdown() on unbound devices
> > 
> > Ugh, my fault, I was confusing this with a different patch.  I'll go
> > drop all of these now, thanks for confirming.
> 
> I'm unsure why you wrote to "drop all of these" now that the reason for
> the breakage is explained and the solution is to pick another patch from
> mainline. If you don't really need
> driver-core-platform-use-bus_type-functions.patch that's fine, but
> otherwise just add 46e85af0cc53f35584e00bb5db7db6893d0e16e5?
> 
> I somehow expected that the patch selection procedure for stable notices
> if you pick 9c30921fe799 ("driver core: platform: use bus_type
> functions") that there are later changes declaring to fix this commit?!

Yes, we had not run the "find the fixes for the fixes" script, but in
the end, it was just not going to be worth it so I dropped these
changes.

thanks,

greg k-h

