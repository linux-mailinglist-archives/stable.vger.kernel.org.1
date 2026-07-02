Return-Path: <stable+bounces-270540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i1j7Fvd3RmrDWQsAu9opvQ
	(envelope-from <stable+bounces-270540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:38:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46F6F8F3C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kUUY9zX1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270540-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270540-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288EC303CD2C
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AE4DD6FE;
	Thu,  2 Jul 2026 14:33:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20447279F;
	Thu,  2 Jul 2026 14:33:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002808; cv=none; b=Ct1ZywmAHEFiWYpkx4y2ll6Jry742lOxzCIAUjGO82dFT8MRaOHaV5QTbLkx3Asy98aVHIxmT8xyf7PxNc1VFYhnIkPbEFScFRcrR+jR4bhjpdoxc0nTkjodtDItRZrntFPkY9/IBQm02R1GOwGnTpYAdzACJ/SMXfhgr91qkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002808; c=relaxed/simple;
	bh=t5Vi6OsDk2eWxe7TGJ1s96KWVcA8DipRhR+B42GcteM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbB8o5W0uYWIBOTM3htkwX7a1L+Y45c7GcbXrC+egfqN76Ev+Z3HONYY+0i7vy1ba8uyvBoTcD0fOjl4TtXmDwyOnLjjjJiVpupfrtlBJqCYj+P6oTXUkKm4Yz5US6fzvvQ0owC94iR8osVIvIYy4KvBIUTIl3zH8WBwM/UTfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUUY9zX1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969161F000E9;
	Thu,  2 Jul 2026 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783002804;
	bh=ObPSPm/RAbPRAiqiaBm+TmK1R0zPbfnWG/8sRU3cr3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kUUY9zX1jWEG2F7JuRo7tWuSOwrGZPRAJbOgbN5R1OKkqnVBt5P3tMFaxdqhtaMbo
	 dYIJCFuRh8T6KwoK8BqilA6PiGXalD3x92ud3EZHUY2O49k8Aq3malWEDD6aBkSZtt
	 zIn8CL/z9s/C1MiWGohGOQAENuS0BWs56QZ+Hd8c=
Date: Thu, 2 Jul 2026 16:33:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
Cc: stable@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v3 5.10/5.15 0/2] Backport RDMA/rxe task and timer
 cleanup fixes
Message-ID: <2026070218-playhouse-quicksand-7f7d@gregkh>
References: <20260605171449.1760-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605171449.1760-1-vlad102nikolaev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270540-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,nvidia.com,linuxtesting.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B46F6F8F3C

On Fri, Jun 05, 2026 at 08:14:41PM +0300, Vladislav Nikolaev wrote:
> This series backports two upstream RDMA/rxe fixes to linux-5.10.y and
> linux-5.15.y.
> 
> The first patch fixes cleanup of RXE tasks that may not have been
> initialized on the rxe_create_qp() error path. The second patch fixes
> the same class of lockdep issue for RC timers by checking that both
> timers were initialized before deleting them.
> 
> In linux-5.10.y and linux-5.15.y the relevant task and timer cleanup
> still lives in rxe_qp_destroy(), so the 1c7eec4d5f3b backport applies
> the timer guard there and keeps del_timer_sync().
> 
> Zhu Yanjun (2):
>   RDMA/rxe: Fix the error "trying to register non-static key in
>     rxe_cleanup_task"
>   RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup"
>     bug
> 
>  drivers/infiniband/sw/rxe/rxe_qp.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.5

Would need this for newer kernels first.  Please submit that series
first, then resend these.

thanks,

greg k-h

