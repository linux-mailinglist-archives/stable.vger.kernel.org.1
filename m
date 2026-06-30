Return-Path: <stable+bounces-270008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QVrQJ6XsQ2qKlgoAu9opvQ
	(envelope-from <stable+bounces-270008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:19:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BE6E65E9
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MkcNtWpH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270008-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270008-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E140130F6DFE
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295347279F;
	Tue, 30 Jun 2026 16:11:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF047278C;
	Tue, 30 Jun 2026 16:11:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835875; cv=none; b=OuAPwDKSgfMiuHIpnV+WMKNUJtbzyirqjqqjARDoHIIPImsUfDzkiOmHZb+bwRzjKP3E0TU9cV3HGJVGWZavLmvBDGmK/5AJCwpDjN7rXkY6Ez1DTQOYi86l3s8aigJ2FaIK3yZlSoeYIgHVuxb5lrqxUEkkQ16/gB4ll6/gQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835875; c=relaxed/simple;
	bh=6HJguPcwaTGzO9viK21l1rsMKhFIl0tLTXgu8y8wIWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlabrvbAlYn1WIIZRbSAVeZCNIJn/+Vg8w2Gcri/WHqrwdrle0Zm2SmrG2trzremRKXomF32UrzcHQ+NNPmHvEOr9aGLugtt7A41WMHAbrCFPF/qwKQ0XIghny2QJhpw0cgEK3W1z/p4l62+KEiLtOHCQv9F8igml629AGgR9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkcNtWpH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BB4F81F000E9;
	Tue, 30 Jun 2026 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782835873;
	bh=duLwucBstRQtdnR7cqd58bPGJsHK8EN8NC60p9eEjNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MkcNtWpH1uzZ7EsKXGrdzoj4n1dVOr/WFZSMmtfoZsfM2aR1XMwCWUKEmpQQATVha
	 t0A+y+KmvNE+2XlufllX6toNoAc8bnMwNdqa4hedXo3gE//nA/wkUlEt2U5lIOZjvE
	 Bbk7qNku+d7FcFogYRj/yTebHe//1SXo0Bg5NcXPHTq6jYRK2dq3EOCoVTPv1VdPj0
	 0YBaa1kmIDRk7TdLpeB2aANYC+edG11zGTsi97Na2uRi5h0LbNXIzXq9uTw0AS/41s
	 Noa3/sjxwBA4P+v94kYpGUaECM+dvC0xyXXJbmLZe7BUbdt7bN8FDKqJiJtyC7gRrR
	 oxhJ+u5WmZNpQ==
Date: Tue, 30 Jun 2026 09:11:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] xfs: zero newly allocated btree root space
Message-ID: <20260630161113.GB6526@frogsfrogsfrogs>
References: <20260630100621.7173-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630100621.7173-1-alhouseenyousef@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270008-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,97f2c05378c5d68dcb8c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F27BE6E65E9

On Tue, Jun 30, 2026 at 12:06:21PM +0200, Yousef Alhouseen wrote:
> xfs_broot_realloc() preserves the existing in-inode btree root while
> growing its allocation, but leaves the added bytes uninitialized.  The
> inode log formatter copies if_broot_bytes bytes into the journal, so those
> bytes reach the log record and its CRC calculation before every location
> has necessarily been overwritten by btree updates.
> 
> Request __GFP_ZERO for the initial allocation and every subsequent
> allocation or reallocation, as required by krealloc() semantics.  This
> keeps stale heap contents out of the filesystem log without a separate
> memset after each growth.
> 
> Fixes: 6c1c55ac3c05 ("xfs: refactor the inode fork memory allocation functions")
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Reported-by: syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=97f2c05378c5d68dcb8c

I wonder, did you figure out exactly *which* code path was leaving
if_broot partially uninitialized?  Somewhere out there, someone will get
cranky at the reduced performance that comes from zeroing (especially on
krealloc) when most of the codepaths will immediately zero/set the
buffer anyway.

> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

In the long run I'm willing to take a small performance hit of having
many layered protections as is reasonably performant to avoid spilling
kernel memory contents to disk, though, so

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

(others may disagree)

--D

> ---
> Changes in v2:
> - Use __GFP_ZERO instead of an explicit memset after krealloc().
> - Apply __GFP_ZERO consistently across the allocation lifetime.
> 
>  fs/xfs/libxfs/xfs_inode_fork.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
> index 606a36526ce2..dc05540fa85b 100644
> --- a/fs/xfs/libxfs/xfs_inode_fork.c
> +++ b/fs/xfs/libxfs/xfs_inode_fork.c
> @@ -384,7 +384,8 @@ xfs_broot_alloc(
>  	ASSERT(ifp->if_broot == NULL);
>  
>  	ifp->if_broot = kmalloc(new_size,
> -				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
> +				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL |
> +				__GFP_ZERO);
>  	ifp->if_broot_bytes = new_size;
>  	return ifp->if_broot;
>  }
> @@ -417,7 +418,8 @@ xfs_broot_realloc(
>  	if (ifp->if_broot_bytes > 0 && ifp->if_broot_bytes > new_size) {
>  		struct xfs_btree_block	*old_broot = ifp->if_broot;
>  
> -		ifp->if_broot = kmalloc(new_size, GFP_KERNEL | __GFP_NOFAIL);
> +		ifp->if_broot = kmalloc(new_size,
> +					GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
>  		ifp->if_broot_bytes = new_size;
>  		memcpy(ifp->if_broot, old_broot, new_size);
>  		kfree(old_broot);
> @@ -429,7 +431,7 @@ xfs_broot_realloc(
>  	 * object.
>  	 */
>  	ifp->if_broot = krealloc(ifp->if_broot, new_size,
> -			GFP_KERNEL | __GFP_NOFAIL);
> +			GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
>  	ifp->if_broot_bytes = new_size;
>  	return ifp->if_broot;
>  }
> -- 
> 2.54.0
> 

