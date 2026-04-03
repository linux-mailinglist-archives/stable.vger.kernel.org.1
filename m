Return-Path: <stable+bounces-233222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNLUI7X3z2lT2AYAu9opvQ
	(envelope-from <stable+bounces-233222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:24:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8D396F67
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F7AA300A24D
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51C3C6A43;
	Fri,  3 Apr 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X1EgGrJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655120D4FF;
	Fri,  3 Apr 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237037; cv=none; b=GRS7Q045I010OQ36Z9ORdddpl0bcfujb1mdXTgjABd8M6GQHX5nlBVJIusWdVqxVdOG8gcXRWDlOKoh/N4i+baiY5KvTZ283AckYQ1mwc2MW36xnOyRjHl7TMVE4G5mBdk586kBoVHsys5s5JzojTii0vR8l6MT6LA5IOCAoaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237037; c=relaxed/simple;
	bh=i0k6scjtDXpcSb7+aoPkR9B9XsU3fxvXvmnpM2MepR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrVKV8d1VzFcpXOkRKOM+BO7BaP6B2c19c/ONl0avx4YU3fylP1s1k8hCRkNTCLztQKxSuBQTa6RScC2Img5xsG7V7Oogoi54KKSSZgjwWp6gbhpL/WBH1U4sOs0QBDsxgmE4OLWJVn/hykhenvmZO1CQxVBS4atIpU3wkx00VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X1EgGrJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72D0C4CEF7;
	Fri,  3 Apr 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775237037;
	bh=i0k6scjtDXpcSb7+aoPkR9B9XsU3fxvXvmnpM2MepR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1EgGrJqqracFSSipsQ71kZq6yJF7Ssn/1KJf8LYxLdG6cIE6/iACMaqmTQul8KeU
	 8d9fpglNjFm6tnyX+ij08ZP/ODwOSlWZZyBtekTfIJYomcWo3R0pu4XK5f3TN1+S/M
	 jLi+xDs/imIrd6kH15h2pEmeunsE46zxWTwJLaVo=
Date: Fri, 3 Apr 2026 19:23:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] driver core: Don't let a device probe until it's
 ready
Message-ID: <2026040322-expert-willow-462d@gregkh>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026040319-seventeen-humorless-5541@gregkh>
 <CAD=FV=XmnWjVzQcr13GmRKX3cvRortA==5C8TH5D-jRBe0VBqw@mail.gmail.com>
 <2026040353-glamour-repacking-0e53@gregkh>
 <CAD=FV=XvqPH7FkRh16u7EE3LAuw-oUYbAdiL1nZxizVft2TqKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XvqPH7FkRh16u7EE3LAuw-oUYbAdiL1nZxizVft2TqKQ@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233222-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 82E8D396F67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 09:26:58AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 3, 2026 at 8:44 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > > If you wish, I can turn this into something like:
> > >
> > > #define DEV_FLAG_READY_TO_PROBE         0
> > > #define DEV_FLAG_CAN_MATCH              1
> > > #define DEV_FLAG_DMA_IOMMU              2
> > > ...
> > >
> > > ...but that seemed worse (to me) than the enum. Please shout if I
> > > misunderstood or you disagree.
> >
> > If you make it a numbered enum, that's fine (I hate unnumbered ones),
> 
> Sounds like a plan.
> 
> 
> > and a comment somewhere saying we will "max out" at 63, or have a
> > DEV_FLAG_MAX_BIT entry in there.
> 
> Sure. To be compatible across all architectures, it should probably
> max at 31, right? Atomic bitops works with an "unsigned long" which
> might be only 32-bits. Oh, actually I should just add "DEV_FLAG_COUNT"
> at the end of the enum and declare flags with DECLARE_BITMAP(). Then
> there is no max.
> 
> In total, I've now got this:
> 
> enum struct_device_flags {
>         DEV_FLAG_READY_TO_PROBE = 0,
>         DEV_FLAG_CAN_MATCH = 1,
>         DEV_FLAG_DMA_IOMMU = 2,
>         DEV_FLAG_DMA_SKIP_SYNC = 3,
>         DEV_FLAG_DMA_OPS_BYPASS = 4,
>         DEV_FLAG_STATE_SYNCED = 5,
>         DEV_FLAG_DMA_COHERENT = 6,
>         DEV_FLAG_OF_NODE_REUSED = 7,
>         DEV_FLAG_OFFLINE_DISABLED = 8,
>         DEV_FLAG_OFFLINE = 9,
> 
>         DEV_FLAG_COUNT
> };
> 
> ...and "flags" is now:
> 
> DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
> 
> Yell if you want anything changed. I'll restart my allmodconfig
> compile tests now.

That looks much better, thanks!

greg k-h

