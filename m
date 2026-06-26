Return-Path: <stable+bounces-268760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5MHB0khPmrXAAkAu9opvQ
	(envelope-from <stable+bounces-268760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:50:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE9A6CAC2A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:50:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=eDAyVICS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268760-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268760-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 096B33028F2A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3793D8104;
	Fri, 26 Jun 2026 06:50:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214813D53C;
	Fri, 26 Jun 2026 06:50:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456618; cv=none; b=uNbnQW2TkcJMHJc51cwK5KNBVBW7f7uPsoX07XDfQ6BKtJscmDktG5hSmkN0tZbVIHGw3lKtQ0IKT0Zfa6+jMaCaNQQ5KHXOnkc6Toxw2yvnLdDtbiT2mlRYlhKw50jgFTXKnCmqqFNxPMT3GuSly8tBlCrw4EIUfdH9KKCMPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456618; c=relaxed/simple;
	bh=LBSc1M6lAKhpzmWvVqpi0wWwTMAQNjfzcAviK9ozj70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIo/IvOyRfz79z409eZdw6ewnPBpnwScU/3Sy8R6FO2ogYE16mGUd6/qX0nNmKYZndK4pUz5L727DpSC5KO6o/tv5EmjEIYTqVHNIwU9DGPBBbeft5VbUnvPlVmiTS3J1DvL3AMvcnaLmS455VnGRoeQzZGyd6XOaIBNFsJEwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDAyVICS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815C31F00A3A;
	Fri, 26 Jun 2026 06:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782456617;
	bh=1GopiY0AHS4sS8HbWiUzsJHkk+10yK7VoiIRb9D8Txs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eDAyVICSWcfi2SDA98ZV/ULFiJSiTnnXmLYpmMfZ5Rhbupa6Jm2+RHae1xxrVoJi6
	 /dS3WzPuzhiI8EG6mvU4jxsLWMgkrpmoQWlY5aUMQwjI+O7Mlqt2qB1mtEulzOzCEA
	 jTwKXjf21cuFYr/Y0NzzfGBKlJmLqmFXeD3bs2YQ=
Date: Fri, 26 Jun 2026 07:49:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Jun <1742789905@qq.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	libaokun1@huawei.com, 25125332@bjtu.edu.cn, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
Message-ID: <2026062643-tamer-limes-a320@gregkh>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:1742789905@qq.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:libaokun1@huawei.com,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	TAGGED_FROM(0.00)[bounces-268760-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,qq.com:email,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EE9A6CAC2A

On Fri, Jun 26, 2026 at 01:17:21PM +0800, Wang Jun wrote:
> [ Upstream commit 6b854d552711aa33f59eda334e6d94a00d8825bb ]
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> After getting rid of ppath in get_ext_path(), its caller may pass an error
> pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path()
> and ext4_ext_drop_refs() to skip the error pointer. No functional changes.
> 
> Without this fix, ext4_ext_insert_extent() returning ERR_PTR(-ENOSPC) in
> ext4_ext_map_blocks() triggers a kernel Oops, observed via SyzKing
> fuzzing on v6.6.142:
> 
>   BUG: unable to handle page fault for address: ffffffffffffffec
>   R15: ffffffffffffffe4  (= ERR_PTR(-ENOSPC))
>   RIP: ext4_ext_drop_refs+0x...->ext4_free_ext_path+0x...->
>        ext4_ext_map_blocks+0x509/0x53a0
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a94798e23..8e23563bb 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4510,7 +4510,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	allocated = map->m_len;
>  	ext4_ext_show_leaf(inode, path);
>  out:
> -	ext4_free_ext_path(path);
> +	if (!IS_ERR(path))
> +		ext4_free_ext_path(path);
>  
>  	trace_ext4_ext_map_blocks_exit(inode, flags, map,
>  				       err ? err : allocated);
> -- 
> 2.43.0
> 
> 

What stable kernel(s) is this for?

