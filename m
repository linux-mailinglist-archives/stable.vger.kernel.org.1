Return-Path: <stable+bounces-239266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFRRM7VR5mlduwEAu9opvQ
	(envelope-from <stable+bounces-239266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:17:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3942F461
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AACD31B18E1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C8366570;
	Mon, 20 Apr 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7KdHnbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838C35B14B;
	Mon, 20 Apr 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697777; cv=none; b=HDgYs7USlA0LMsremzk8o8Vx4EBrS8NCm8EKe/XjtG9Xxq7dM4X4XjZ/mjEdczCgyp0bS+gpNqLR296fXGRxAJUSqLRshm2sw5ALRhQVmcrXTmrokTDOog5Ibp714AhkD5Ae96ik4hxhtJE3gm1S6jQ5VTBuihg1fllrvIGCEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697777; c=relaxed/simple;
	bh=4IbzJI6K9IX8/ArQUQEVhy70gC0jpAGzopV+wDK/xoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYgxPAT5dsvgJ2PgnrjL5FQYG0TjfrDilA8hWtRHGbqdeVnHEjXPINc7mPq8cCrRSjcG8fSRGMPou3vrIFDW5c/GsFsPgXXVxFX66mJWrMmVhbkqzo6+gpCGYBJUwMPUQ/w/cqDiTrmAdx8G9qQGbcyXgRlb+Yszvh07Eox0Aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7KdHnbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085A9C19425;
	Mon, 20 Apr 2026 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697777;
	bh=4IbzJI6K9IX8/ArQUQEVhy70gC0jpAGzopV+wDK/xoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7KdHnbALu/BDgXLIh3c8UFddIZDOgklMP0zfy60Ipv9Lv8gtjtaUOh8CJ0PH/IQu
	 zOriUGHPHSQw5RHHtB1rEx+eE7FA4XxKJijgiKQztsjF3KPVspcUOOvQtVVDDmIAe1
	 7KoxAgSJ5f5elRGEIe4jHrSrJYnw8f1IdTWFtBpkZAN1gwE3AFDfDr7qVlWhSt29Nb
	 wGiMwovIZkuCAJCcIZczB5p03B0Ci4i2P/fxO6aIIJzOY33dFjBsxNuxOzpd2W+srG
	 aINPdatxVVXQHbagAnOYhgF+1QScP4VPJT4ywtR8MpsDPYZv7jsnvPdPpBMOLd/0bS
	 5TNMDqU7if41Q==
Date: Mon, 20 Apr 2026 08:09:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Sergio Lopez <slp@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>,
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.15] fuse: mark DAX inode releases as
 blocking
Message-ID: <20260420150936.GE7765@frogsfrogsfrogs>
References: <20260420132314.1023554-1-sashal@kernel.org>
 <20260420132314.1023554-286-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420132314.1023554-286-sashal@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239266-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61E3942F461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:21:20AM -0400, Sasha Levin wrote:
> From: Sergio Lopez <slp@redhat.com>
> 
> [ Upstream commit 42fbb31310b2c145308d3cdcb32d8f05998cfd6c ]

<snip>

> - UNVERIFIED: Could not access lore.kernel.org discussion thread due to
>   Anubis protection

HAHAHA LOL

> **YES**

Yes, I thin this patch is appropriate for 6.1.

--D

>  fs/fuse/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 676fd9856bfbf..14740134faff7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -117,6 +117,12 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
>  			fuse_simple_request(ff->fm, args);
>  			fuse_release_end(ff->fm, args, 0);
>  		} else {
> +			/*
> +			 * DAX inodes may need to issue a number of synchronous
> +			 * request for clearing the mappings.
> +			 */
> +			if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
> +				args->may_block = true;
>  			args->end = fuse_release_end;
>  			if (fuse_simple_background(ff->fm, args,
>  						   GFP_KERNEL | __GFP_NOFAIL))
> -- 
> 2.53.0
> 

