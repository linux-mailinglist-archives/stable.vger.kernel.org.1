Return-Path: <stable+bounces-272670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CYAYBqZrTmp3MQIAu9opvQ
	(envelope-from <stable+bounces-272670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 17:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4741727F52
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 17:24:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oeQEqO7C;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272670-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272670-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06B7330CBBF6
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A50337FF43;
	Wed,  8 Jul 2026 15:16:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D92FD1B5;
	Wed,  8 Jul 2026 15:16:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523812; cv=none; b=d7lwBSoXueTWJ3CV8kqsXnEKijDxGI6CkOsQzsrwkfFvL1zsenIBDrwWK1BL945RLZKHRAJVDwNLCFKyPkP27fTfsRj/71BoqYnoqf0I9G7SX5+j7L1rzeTvkiYCWL1NPNQH5Q6hEkXc22H2zAWjJrJWf2ZnZV7FZAvZIuuDHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523812; c=relaxed/simple;
	bh=F7dZV6zxAEtQJJPEoGTdLT8P9EwBPjKmdGYsx4Tzb6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXBWTwQTlXwj+pu+JaItT+LXjBP2Qv3MSYapNR0FVy5DFt2iH+1CxUEwRI5lguQQewanaw3Xp8hSx113EnSuxl4dna/bTVz4o+Awmi1/2tx8DwwqwP0AoVi7nimh6yiUe113m3DNTUFFyvRjNec0HAA8pMeU3yY9zGZgpN//NmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeQEqO7C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1001F00A3A;
	Wed,  8 Jul 2026 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783523811;
	bh=oqR2FYIL9gd+uxjCSRYuIsKpSmXVw+IaB8YVYE2KeRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oeQEqO7CcYue/6QKlCyST/ss4/NgQEIT//nvZKj6o674K6bD/fARvtj5mw8+2cLL5
	 m2+zss8NOJD970v/dZYa3hvmXn4JGrzaZdoLGYSEmvoX7V2Hr1TRL8a6/vhRjQI8bJ
	 y1qXK6ph8Epfid4iKP3N7ZeoDv9Y67CghlCkt5aRxsY0pyPpB230FR7C1O6+9aaa39
	 w01c6/Ed7RXPvuD4XHmHKKHZOQBixkVVTITVA29XPupY3rLv1u0ueRYOu6c0hBuE+B
	 fkTUuUUk6T4jiUCLNfs5czRmcQWGpF/60EVht2IW7WLphe5j71HcIULN0kP6YWfd94
	 cxXTasUwMByuQ==
Date: Wed, 8 Jul 2026 17:16:44 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, 
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfs: bound da-node entry count against the correct
 geometry
Message-ID: <ak5pVqB9fyo7MK-U@andromeda.toxiclabs.cc>
References: <20260707135930.3214701-1-qwe.aldo@gmail.com>
 <20260707190245.3813498-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190245.3813498-1-qwe.aldo@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:qwe.aldo@gmail.com,m:linux-xfs@vger.kernel.org,m:djwong@kernel.org,m:dchinner@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:qwealdo@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272670-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4741727F52

On Tue, Jul 07, 2026 at 04:02:45PM -0300, Aldo Ariel Panzardo wrote:
> xfs_da3_node_verify() bounds the node entry count against the larger of
> the directory and attribute geometries because, as a buffer verifier, it
> cannot tell whether the block belongs to the directory or the attribute
> tree. When the directory block size exceeds the fs block size (e.g.
> mkfs.xfs -n size=64k -b size=4k), an attribute node buffer is a single fs
> block that holds only m_attr_geo->node_ents entries, yet a crafted attr
> node may claim a count up to m_dir_geo->node_ents and still pass the
> verifier.

For all the patches, Vx shouldn't be in-reply-to to the initial
versions. While this is 'acceptable' it really makes it hard to me to
track down what I have yet to process because the threading. You don't
have to re-send the by now, but once you get RwBs (or need to send a V3)
please resubmit them with the tags (or the newer versions) without
replying to the original.

> 
> xfs_da3_node_lookup_int() then indexes btree[] up to that count during
> its binary search -- an out-of-bounds read via getxattr/listxattr on a
> mounted crafted image.
> 
> The buffer verifier is the wrong place to tighten this: it has no fork
> context, and the transaction-less read path used by getxattr does not run
> xfs_da3_node_set_type() either. xfs_da3_node_lookup_int(), on the other
> hand, always runs on that path and holds args->geo, the geometry of the
> fork actually being searched. Bound the entry count against
> args->geo->node_ents there, before walking the entries.
> 
> Fixes: 7ab610f9e0f1 ("xfs: move node entry counts to xfs_da_geometry")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> v2: reworked per Darrick's review.  Do not infer dir-vs-attr from the
>     buffer size in the verifier; instead bound the entry count in
>     xfs_da3_node_lookup_int() against args->geo->node_ents, the
>     geometry of the fork being searched.  cc stable.
> 
>  fs/xfs/libxfs/xfs_da_btree.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> index 9debb95d86fa..95ea3737eb33 100644
> --- a/fs/xfs/libxfs/xfs_da_btree.c
> +++ b/fs/xfs/libxfs/xfs_da_btree.c
> @@ -1787,6 +1787,20 @@ xfs_da3_node_lookup_int(
>  		} else
>  			expected_level--;
>  
> +		/*
> +		 * The node verifier cannot tell whether this block belongs to
> +		 * the directory or the attribute tree, so it only bounds the
> +		 * entry count against the larger of the two geometries.  Here
> +		 * args->geo is the geometry of the fork we are actually
> +		 * searching, so reject a count that would walk btree[] off the
> +		 * end of this node buffer.
> +		 */
> +		if (nodehdr.count > args->geo->node_ents) {
> +			xfs_buf_mark_corrupt(blk->bp);
> +			xfs_da_mark_sick(args);
> +			return -EFSCORRUPTED;
> +		}
> +
>  		max = nodehdr.count;
>  		blk->hashval = be32_to_cpu(btree[max - 1].hashval);
>  
> -- 
> 2.53.0
> 
> 

