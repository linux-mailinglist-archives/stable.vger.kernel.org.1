Return-Path: <stable+bounces-269829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CqKHMCjYQmoREgoAu9opvQ
	(envelope-from <stable+bounces-269829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:40:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 722626DEAD9
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SFYTInA5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269829-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269829-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBEDC300F16E
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385303845B0;
	Mon, 29 Jun 2026 20:40:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131E37C92E;
	Mon, 29 Jun 2026 20:39:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765601; cv=none; b=WYz+vd/WkGZ3p3a1Ly6KFa8dyGXex1mq3LWNsGBDlk1BniqduvY+6sNldflkpttjJiCGyFGp4C5hPgfmh0o2+mjfoid/OjMi6BVEu7pzaI4ChSKZ49LMYpC3Qn5pnguCDqKpeGa+upUXFJ5uSxBFPHjmGAZEYHiGhEcVmhkuMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765601; c=relaxed/simple;
	bh=hCDMQT90kxZ8n76pzjZgoBraAMR0vSYi0IqEn/sCVJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYT4m5NY2ug6s2hIJ91+SVTT3TgGvDSkeuRHoJKwcV3HpHIwrEpcRlrkkheEoklYXxwTfRaEy6PH8RxFmSfk0ohxbY3MoISkv5nu/Ns8oFpWEhHdseJUsMQmLpneqsrCvnr0wKR9aWi71jhKAYZ75BDTf7xv1wFmLjBZL9rHvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFYTInA5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9C3551F000E9;
	Mon, 29 Jun 2026 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782765599;
	bh=Vo5KNlprdcpnm+g7OXEniY3/23Gk+9ScMNu5EtPU4g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFYTInA5b+eDbQo63nUEE+OYd1Rza6Fpho3seqR6LQz/Hx4OOUIN4yxU03ONjVlzj
	 wPsGqFk3j12H/TUSvJ4SBpA6Tx+j91+D1uHr5xJrhLOAhCCdESy7SFE6wVqexMyEXK
	 hqB3NBHXTa0UgQYAOoUlVdRu1W1IY6dvTT+Qqysz/2X2zubkoN76edxb8rPOJjpbPV
	 fPz8Zfb9vaJxYTQgbkQtAa8SqMltSu4jmrCqSZmZN0VxwreriqMxWhEboaN/2F8x0/
	 8f4Y/GqQGE96TXqD49p7qVFNpMSu7pZTDlybG94F7j7sboAg3gx/1nvA0pl6IQqU8N
	 sqiQJ3crnG44g==
Date: Mon, 29 Jun 2026 13:39:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfs: zero newly allocated btree root space
Message-ID: <20260629203959.GD6078@frogsfrogsfrogs>
References: <20260628094748.46578-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628094748.46578-1-alhouseenyousef@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269829-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,97f2c05378c5d68dcb8c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 722626DEAD9

On Sun, Jun 28, 2026 at 11:47:48AM +0200, Yousef Alhouseen wrote:
> xfs_broot_realloc() preserves the existing in-inode btree root while
> growing its allocation, but leaves the added bytes uninitialized. The
> inode log formatter copies if_broot_bytes bytes into the journal, so those
> bytes reach the log record and its CRC calculation before every location
> has necessarily been overwritten by btree updates.
> 
> Clear the newly allocated tail immediately after a successful growth to
> keep stale heap contents out of the filesystem log.
> 
> Fixes: 6c1c55ac3c05 ("xfs: refactor the inode fork memory allocation functions")
> Reported-by: syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=97f2c05378c5d68dcb8c
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  fs/xfs/libxfs/xfs_inode_fork.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
> index 606a36526ce2..0d81c78f5afe 100644
> --- a/fs/xfs/libxfs/xfs_inode_fork.c
> +++ b/fs/xfs/libxfs/xfs_inode_fork.c
> @@ -398,6 +398,8 @@ xfs_broot_realloc(
>  	struct xfs_ifork	*ifp,
>  	size_t			new_size)
>  {
> +	size_t			old_size = ifp->if_broot_bytes;
> +
>  	/* No size change?  No action needed. */
>  	if (new_size == ifp->if_broot_bytes)
>  		return ifp->if_broot;
> @@ -430,6 +432,7 @@ xfs_broot_realloc(
>  	 */
>  	ifp->if_broot = krealloc(ifp->if_broot, new_size,
>  			GFP_KERNEL | __GFP_NOFAIL);
> +	memset((char *)ifp->if_broot + old_size, 0, new_size - old_size);

Why doesn't GFP_ZERO work to clear the new memory?

--D

>  	ifp->if_broot_bytes = new_size;
>  	return ifp->if_broot;
>  }
> -- 
> 2.54.0
> 
> 

