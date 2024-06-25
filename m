Return-Path: <stable+bounces-55138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376D915E41
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48381F226FE
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 05:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1219145B0F;
	Tue, 25 Jun 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rh7evAJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MmnmRnDw"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871B2D600;
	Tue, 25 Jun 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294172; cv=none; b=iGozrqlxBR6aQuxmrkv5lUE7guhcNOdR4vxXZUuplC+POhFC80D6Ej/MjwXz9Fxhw32yHJ9IdgI0KdDiXuU9hWfjtIf4GY8SaRiUkfsXlZVeYojQ6BeHPISXGTOGjquQ9an2Mn+WUhKopxgmHwwMITESBU0qGlrS/HZzQjzV++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294172; c=relaxed/simple;
	bh=pMtLjxJAUVQSXjC7H8x3xJNeofOdmXKNPJMn1qX/nC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7YvUy7lY2pqzYprePUVrdlX/+DMEdqlqYqhh/+V/kIFBf9UNLkk+sMhk+kKF2e/Z9AARHzjIIxWumcMTaMgOxOIZQWZ1dDGI7H8QCA0HGHRhjvoIgHwCU4tKFOLrMZeNK0nh2/cqICyKf3jnTbqgvEhi4eeoiMlKefiq3HQhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rh7evAJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MmnmRnDw; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 60293180028E;
	Tue, 25 Jun 2024 01:42:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 Jun 2024 01:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719294168; x=1719380568; bh=tNFJMSSYvl
	qtPJ4Jq6knqUseKigf4JmQ6vFlQUE+I08=; b=rh7evAJwRZUWwzR6qpC0CPW5TH
	BRRPWRfNiMnxj9/Vj+1Wrf0Qs5h5Gc1hAgwf4uRVXE+s9+aoK0dAc2SvPNqOI79D
	V1bOJ5ObCNC/DAuSomeHXnER8oKXUnPqj3NJux/i1NUVTQLiH1dJIYrcimcUHeqk
	jAGmXk/2Wigdewcs4xgdf1JeaDpWFRcFxZr/mkenWDwdvnIip+eBUO7n2QeiWEPs
	xjPcUBG83mb9n6djxpzcRoEEcjorn8gTQgh99stksCRGdpkV+rkKsKAq6tCcKEhX
	C2tDvz3bVvmxJdu7vLzS71Y0R8jOpMc3WAHNXkysjZqHTmF9N795e3WAtYbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719294168; x=1719380568; bh=tNFJMSSYvlqtPJ4Jq6knqUseKigf
	4JmQ6vFlQUE+I08=; b=MmnmRnDwRiEpfHe3IRsXW0BWcZvEt4LGPsisFeos3ljT
	sLGG0PN/hHET2TGWZ4orWi/sB94LVTX/GtnpsSTtKymU7a4L5Umt7EEDjq7rBLYR
	SEWFevQDlJGjgFPLs3UCEPyn0e4zGjQ7wnRuk3GfPkE8cSKYJ95jU3e6R3k8s18w
	gTf+erwjtFRZoGBp+dqklR5qxinIfIleDittTg18wCNHtBh+GCMztuC4AFfg3LMA
	NTI9lCAmpu2p31qGss5WD6HdSSw5U/Mpm17S07zKHJNVYq8JbLbAZhGDluKz7jvb
	16OTSdo5cgfjzDVVW9A44S5lGRDHVVybQD0X+b+w2w==
X-ME-Sender: <xms:1lh6ZrkaUe_qscHtXNLvVXsRMENJ7yZonBUvxsLrjci4BVBkC7qgCA>
    <xme:1lh6Zu2yDByg7TKBMqVDDF9nybK2zFUurexOvfS_GX5eSAMpw2JYDTJmWtxdQqX8E
    jHUmkwLVC7Fdw>
X-ME-Received: <xmr:1lh6Zhp1BcqUz2BTySXyfA48o5CODw-CNoQoQf9eJDe1ZVTGG_uQIfvDd8UWumwb96nhdswtn3oDayB9jiypCj1a-JABVMAp4kelgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:1lh6ZjmkY7As4Z0LM9V1sQD4Q4V5lAZuwBrQL2ztlrVSziovMsacHA>
    <xmx:1lh6Zp3mx650jrxr0Y_0Eqeh-MXxD4icClSR4eO2ey8YBSSgfxX8Uw>
    <xmx:1lh6Zivb8ENMKAqZ8a72qyWVFSEaJHyzw7UJwO0f1_q30fCOfLry4Q>
    <xmx:1lh6ZtWEtxric-RMRqDWroGwfq9AnCN2O3w1sFG_yGLzbINWBjtGqQ>
    <xmx:2Fh6ZoD8GHUR4OOsXS2Ro35d_qnvAiHTou-wubmRQlbR6Dl4ix22b5EW>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 01:42:46 -0400 (EDT)
Date: Tue, 25 Jun 2024 07:42:44 +0200
From: Greg KH <greg@kroah.com>
To: NeilBrown <neilb@suse.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	jlayton@kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "nfsd: fix oops when reading pool_stats before server is
 started" has been added to the 6.9-stable tree
Message-ID: <2024062537-overtone-cupping-3f13@gregkh>
References: <20240624134957.936227-1-sashal@kernel.org>
 <171926974436.14261.14452569082069214699@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171926974436.14261.14452569082069214699@noble.neil.brown.name>

On Tue, Jun 25, 2024 at 08:55:44AM +1000, NeilBrown wrote:
> On Mon, 24 Jun 2024, stable@vger.kernel.org wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     nfsd: fix oops when reading pool_stats before server is started
> > 
> > to the 6.9-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      nfsd-fix-oops-when-reading-pool_stats-before-server-.patch
> > and it can be found in the queue-6.9 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> I feel this should not be added to the stable tree.
> 
> It moves at test on a field protected by a mutex outside of the
> protection of that mutex, and so is obviously racey.
> 
> Depending on how the race goes, si->serv might be NULL when dereferenced
> in svc_pool_stats_start(), or svc_pool_stats_stop() might unlock a mutex
> that hadn't been locked.
> 
> I'll post a revert and a better fix for mainline.

Now dropped, thanks!

greg k-h

