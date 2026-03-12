Return-Path: <stable+bounces-224870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDZ/DlLOsmmPPwAAu9opvQ
	(envelope-from <stable+bounces-224870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:31:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E15DB273649
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9E603017054
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956D3537EA;
	Thu, 12 Mar 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+v8ijL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2F2820C6;
	Thu, 12 Mar 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325562; cv=none; b=t9e5R3YsPGISnEXbBa25GxfIkqqfinLliK8BACsjBnx70yon6Uf6LtHC88sJ3GyhvHYXoLf+XIe6a8LcllLMox7rA0VzIhLn9qO9qQABjwnlYoscc+9pJUer0ngrGzjhiQNFwMGs8DYekDvE9VBklPc9yOQXdwHCQumlP9f/614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325562; c=relaxed/simple;
	bh=k848j60HvtH7MWbaLc7OPs4xO69RUnxKM8wgJQuKl9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3CydElANcGPZS7HVXYT/KKxnUwhddXMysO6jTlFqYxeNtxjNzRYPcayaCB5TuACvNjVvG4++Lof37Y1wEb7jfE6yKiyXgSVkiXA10Jyr1FWNroxPR/51UB1zd2xgvpjNUxotVNhDerkIFZ04b6sLznW2f79CYFACr+12tWhBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+v8ijL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB3EC4CEF7;
	Thu, 12 Mar 2026 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325562;
	bh=k848j60HvtH7MWbaLc7OPs4xO69RUnxKM8wgJQuKl9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+v8ijL5aHDzAUcL+zxOuQLK424XDV2CDX6NRNBw6lBL1oMOVjm7sKhlrxOGGTCZz
	 721Hk7bOmLNGi9f7TPxeL31EteUoXyLL4p8mMb2TLOEUfxuM29qPHJFsdtIn4Kwgzk
	 3KTArbMGwgL/iAyD/ahnVvxepbdSvqSB9CdQOJCnOO2X7/jnhyuwVISnktBcpOjBxv
	 8eyTu1tPwc3dXA72s7p4RuB+a94p4bIYdSlWSOXNOjcBInPNsFwvxAjra+mxSSS9y5
	 UBydC7c+TbKsjwYoKPHC7hmoVDlNQlwodsGg3Mpdk+vfrQ4DVkDsyM/iz3qELXfzG6
	 ZQMtpWn4Hr+pQ==
Date: Thu, 12 Mar 2026 07:26:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: cem@kernel.org, zhanjun@uniontech.com, hch@lst.de, dchinner@redhat.com,
	stable@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+d78ace33ad4ee69329d5@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfs: use GFP_NOFS in __xfs_trans_alloc
Message-ID: <20260312142601.GI1770774@frogsfrogsfrogs>
References: <24B50BB66059E3C8+20260312072214.475115-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24B50BB66059E3C8+20260312072214.475115-1-zhangdandan@uniontech.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224870-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d78ace33ad4ee69329d5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: E15DB273649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 03:22:14PM +0800, Morduan Zang wrote:
> __xfs_trans_alloc() allocates the transaction structure before
> xfs_trans_set_context() establishes the nofs context. If memory reclaim
> enters XFS through xfs_vn_sync_lazytime(), this GFP_KERNEL allocation can
> trigger a warning from the reclaim path.
> 
> Use GFP_NOFS for the transaction allocation to avoid filesystem reclaim
> recursion before the nofs context is set.

Why doesn't filesystem reclaim itself set PF_MEMALLOC_NOFS for us?

 xfs_vn_sync_lazytime+0xaf/0x150 fs/xfs/xfs_iops.c:1238
 sync_lazytime+0x12d/0x2d0 fs/fs-writeback.c:1721
 iput+0x230/0xe80 fs/inode.c:1997
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1147
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1174
 prune_dcache_sb+0x119/0x180 fs/dcache.c:1256
 super_cache_scan+0x369/0x4b0 fs/super.c:223
 do_shrink_slab+0x6df/0x1170 mm/shrinker.c:437`

--D

> Link: https://syzkaller.appspot.com/bug?extid=d78ace33ad4ee69329d5
> Fixes: 83a80e95e797 ("xfs: decouple xfs_trans_alloc_empty from xfs_trans_alloc")
> Reported-by: syzbot+d78ace33ad4ee69329d5@syzkaller.appspotmail.com
> 
> Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> ---
>  fs/xfs/xfs_trans.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index bcc470f56e46..0d347cff7317 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -217,7 +217,7 @@ __xfs_trans_alloc(
>  
>  	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) || xfs_has_lazysbcount(mp));
>  
> -	tp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | __GFP_NOFAIL);
> +	tp = kmem_cache_zalloc(xfs_trans_cache, GFP_NOFS | __GFP_NOFAIL);
>  	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
>  		sb_start_intwrite(mp->m_super);
>  	xfs_trans_set_context(tp);
> -- 
> 2.50.1
> 
> 

