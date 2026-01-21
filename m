Return-Path: <stable+bounces-210767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDcJM3vkcGk+awAAu9opvQ
	(envelope-from <stable+bounces-210767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:36:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A158833
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0080704AC4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905C481FD8;
	Wed, 21 Jan 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKRjBsMl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86D31326B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004494; cv=none; b=Wk1fqSyZDA/P3LhbnD0fCqQXJlDxz/2j4zU4HeviGVgzU1fmejSnLAFoIkj6lOGDL3n9dyg8E/w+hqlir76vpN3Xz5/NxaoF4DQflFV+StnnD/l999dYJ88d/oCbvelPDnOG6rQqxbyBw0yEyC2Kepsvi0MLvxfbYjuyQwQqRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004494; c=relaxed/simple;
	bh=aMhUYVMZJIAYlAbN+hemEdXD6+ZbW8noRwSYa7B2flE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTWl2hUbGm0ZvzGUKna583xaQeWJP0Y4jNMwYTSp92WL5UYrwnQGZwcUZQaNkE0nbpn7byUxVda9eg1Osd9DSo8E7LjBAc/HJHlYywfD1xZFw9Qphiz4sdDaHOOztbIGevVaXY90LWVte9IR56uNji+SWAwy2L5SAw43cgIoOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKRjBsMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769004491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZGcysZY0NniwPs9xjhTFfzQAdsQLMoUJu7pGmR5sNA=;
	b=YKRjBsMlOt3RQdndolOLi+nh+GpJloTJPeIsh3a79O/inoOEMsK052M/JQWfkMWVybU+Hp
	L2w/mAbCqAsKXlf95835oHwuVRl99AjGDMf5fCwg3cwZBMU1Na5iIt+GliL4Te1O43YDS/
	sZpZPRiSKWaNtWobl6V2NdhHm6UsXzA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-D-SkUFBpNoCJ6tmjUGhBVA-1; Wed,
 21 Jan 2026 09:08:06 -0500
X-MC-Unique: D-SkUFBpNoCJ6tmjUGhBVA-1
X-Mimecast-MFC-AGG-ID: D-SkUFBpNoCJ6tmjUGhBVA_1769004485
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78BB9195422D;
	Wed, 21 Jan 2026 14:08:05 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEB4919560AB;
	Wed, 21 Jan 2026 14:08:04 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:08:02 -0500
From: Brian Foster <bfoster@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.6.y] xfs: set max_agbno to allow sparse alloc of last
 full inode chunk
Message-ID: <aXDdwtuJYYLmIex1@bfoster>
References: <2026012007-legal-directly-ad82@gregkh>
 <20260121021329.1126671-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121021329.1126671-1-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210767-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 726A158833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:13:29PM -0500, Sasha Levin wrote:
> From: Brian Foster <bfoster@redhat.com>
> 
> [ Upstream commit c360004c0160dbe345870f59f24595519008926f ]
> 
> Sparse inode cluster allocation sets min/max agbno values to avoid
> allocating an inode cluster that might map to an invalid inode
> chunk. For example, we can't have an inode record mapped to agbno 0
> or that extends past the end of a runt AG of misaligned size.
> 
> The initial calculation of max_agbno is unnecessarily conservative,
> however. This has triggered a corner case allocation failure where a
> small runt AG (i.e. 2063 blocks) is mostly full save for an extent
> to the EOFS boundary: [2050,13]. max_agbno is set to 2048 in this
> case, which happens to be the offset of the last possible valid
> inode chunk in the AG. In practice, we should be able to allocate
> the 4-block cluster at agbno 2052 to map to the parent inode record
> at agbno 2048, but the max_agbno value precludes it.
> 
> Note that this can result in filesystem shutdown via dirty trans
> cancel on stable kernels prior to commit 9eb775968b68 ("xfs: walk
> all AGs if TRYLOCK passed to xfs_alloc_vextent_iterate_ags") because
> the tail AG selection by the allocator sets t_highest_agno on the
> transaction. If the inode allocator spins around and finds an inode
> chunk with free inodes in an earlier AG, the subsequent dir name
> creation path may still fail to allocate due to the AG restriction
> and cancel.
> 
> To avoid this problem, update the max_agbno calculation to the agbno
> prior to the last chunk aligned agbno in the AG. This is not
> necessarily the last valid allocation target for a sparse chunk, but
> since inode chunks (i.e. records) are chunk aligned and sparse
> allocs are cluster sized/aligned, this allows the sb_spino_align
> alignment restriction to take over and round down the max effective
> agbno to within the last valid inode chunk in the AG.
> 
> Note that even though the allocator improvements in the
> aforementioned commit seem to avoid this particular dirty trans
> cancel situation, the max_agbno logic improvement still applies as
> we should be able to allocate from an AG that has been appropriately
> selected. The more important target for this patch however are
> older/stable kernels prior to this allocator rework/improvement.
> 
> Cc: stable@vger.kernel.org # v4.2
> Fixes: 56d1115c9bc7 ("xfs: allocate sparse inode chunks on full chunk allocation failure")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> [ xfs_ag_block_count(args.mp, pag_agno(pag)) => args.mp->m_sb.sb_agblocks ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Hi Sasha,

Thanks for sending out the rest of these. I think there's actually been
a mixup on the stable targeting for this one. It's true that this fixes
the commit tagged in the description above, but it really only matters
in practice for codebases that also include upstream commit
13325333582d4 ("xfs: fix sparse inode limits on runt AG").

The latter is the commit that fixes the calculation to properly bound on
the small runt AG case, where both of the associated problems are
reproduced. This is also the commit that adds the xfs_ag_block_count()
usage that these backports are working around.

I didn't realize this commit wasn't in these repos when the patch was
posted, so that is my mistake, but that is why I only went as far as
resolving the conflict in v6.12. In any event, I think there are three
options here for remaining stable versions:

1. Disregard this subtlety and proceed with these backports as a safety
for future inclusion of commit 13325333582d4. I think this is harmless,
but doesn't effectively fix anything either (JFYI).

2. Also include upstream commit 13325333582d4 as a dependency in these
repos. This effectively fixes both issues (invalid post-eof inode
records and allocation failure shutdowns).

3. Drop this backport for repos that don't already have reason to
include commit 13325333582d4.

Note that I don't mind which direction we go here. I was content to drop
this for pre-v6.12, personally, but I just want to make the context
clear given you've done the work for those older stable releases.
Apologies for any confusion here.

Brian

>  fs/xfs/libxfs/xfs_ialloc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index b83e54c709069..fc6cf445123ea 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -791,14 +791,15 @@ xfs_ialloc_ag_alloc(
>  		 * invalid inode records, such as records that start at agbno 0
>  		 * or extend beyond the AG.
>  		 *
> -		 * Set min agbno to the first aligned, non-zero agbno and max to
> -		 * the last aligned agbno that is at least one full chunk from
> -		 * the end of the AG.
> +		 * Set min agbno to the first chunk aligned, non-zero agbno and
> +		 * max to one less than the last chunk aligned agbno from the
> +		 * end of the AG. We subtract 1 from max so that the cluster
> +		 * allocation alignment takes over and allows allocation within
> +		 * the last full inode chunk in the AG.
>  		 */
>  		args.min_agbno = args.mp->m_sb.sb_inoalignmt;
>  		args.max_agbno = round_down(args.mp->m_sb.sb_agblocks,
> -					    args.mp->m_sb.sb_inoalignmt) -
> -				 igeo->ialloc_blks;
> +					    args.mp->m_sb.sb_inoalignmt) - 1;
>  
>  		error = xfs_alloc_vextent_near_bno(&args,
>  				XFS_AGB_TO_FSB(args.mp, pag->pag_agno,
> -- 
> 2.51.0
> 


