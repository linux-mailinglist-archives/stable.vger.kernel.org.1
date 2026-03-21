Return-Path: <stable+bounces-227773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J22M32uvmmEWgMAu9opvQ
	(envelope-from <stable+bounces-227773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:43:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E32E5DCC
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9CE3013785
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592A38B7A1;
	Sat, 21 Mar 2026 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="q+fY9dl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZXd19gB"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124E18E025
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774104108; cv=none; b=Kz54z1Tf/otD3hxLPkWv87riebH0704vLeXDV86dmUZGMjvocp85sWhJyhEj/qAX/prYcIyi9HnAvziZ4L9btZNhnZQFxEnM6wO4ynlwa09uKHp/UJ4DybTPCet/OSbZ4p9lYvWVBxuB7lc6mS3rwF+nW0Yt4vAVUDdnNT0++Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774104108; c=relaxed/simple;
	bh=otlrnFYwqW7SyRjKhiIpkawbb0aXuLiHS6mj87l6HvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLkxocs6K9OYOUEnAON4NNbb9WMjetopYLE4PZk+sqVVT1WwEFybHHIOm8bgcdAhWIn9R2WWCt93FIoK44MJz9573+UyQjBuSAl8g+rGPXxYstj+XnO1v/D9sA6sl0HeRxG7nMA7W12d4MDNhH9X/8JdiAo5xFzcGwXT3O9D838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=q+fY9dl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZXd19gB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DDB381D000C0;
	Sat, 21 Mar 2026 10:41:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 21 Mar 2026 10:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774104105; x=1774190505; bh=B3jo0wppSA
	rFw+urp5dykTcT7QS2boDqPdugo+o7BIM=; b=q+fY9dl50FUoFfBSX4l/SCpnws
	fCUAEVrE7+CSYcG182PWF9C5kupQcrUBzBYiRnEkqyhAvFQgzVicotkgZ3iHJmJz
	BWZrRK0u1b2MyNHFIY0ROlDJ6gEB2s0jMxkIFC3gL93WBKqvbovxytOvwkS95ezS
	CFQwGSjTGUGvjXx0MF4ZuJ5uIcde0DPh8R1+t5qVxN1w2Cp7WeeBTSiuZIJ9+fw0
	EWrg6LJPcAJ/K0F1rjR4jYSaoOiqZ0jYi8OrEjqBkMH+qbjlS6MELsDLOxmJoALc
	gk3HcnkslEfzutMun3MI5JU7+y4CkHrY1SG2UQdFl901o8HMx8ovQNLvxtkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774104105; x=1774190505; bh=B3jo0wppSArFw+urp5dykTcT7QS2boDqPdu
	go+o7BIM=; b=FZXd19gBivqZGl/6MGm2VOJKaUrG2T4HA1GDud7zVjoB/7pQGxv
	OL8MsbbEXCd596SY0IMnWaGI1n03leu5QlzH+FYS0RFY4+yB9EwZ3QPoD34u6Wp8
	+0SO3hY7PksLYSveocmQ1afljWQ5gzARIm+pVqRLXYuTcDMg8d6w7essMZFo/tal
	lr6xUikF//Fd34nC6j1Pnix1wrRDQSfKM2rd2xWA/rvxAsn1oZivzi1+HNjzXYGG
	x1bAGbyCzDsHNopeRFcAF6Tqaz4jth7xvdc6QLYHAmuhzEMwVUmmc7MGmIxGe5kZ
	QludU8h9gEuUBXGI53NqTD7eHKA20ESMFjQ==
X-ME-Sender: <xms:KK6-aaIloVI-bru_RqVs3e9BPOH0thKsrvTqCK8H4uVsWbwBxAFwjg>
    <xme:KK6-aegRpWS_MLjJlt8HLi-TOZGEOtQX9oKJ6OYtXJTR829G1xPkGicqPQn4556uG
    vVB1RPvhxhtd-YuDcWsbFh38hK9zZIlnb_LN-Ah6LI5oTcJOg>
X-ME-Received: <xmr:KK6-afKg-hwT-T7FfzhZUbG7KOekdCZOZmG0LW3IPaGZb6LlMIO_BZt776lIEvLvaTN6ccATNAD6IWgF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihihdriihhrghngheshhhurgif
    vghirdgtohhmpdhrtghpthhtohepohhjrghsfihinheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopehlihgsrghokhhunhdusehhuhgrfigvihdrtghomhdprhgtphhtthho
    pehsthgrsghlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthihthhsohesmhhith
    drvgguuh
X-ME-Proxy: <xmx:KK6-adgHnUWFOsjlMzUAxDkeWSEa9neafbIiQmtaIlDs6h9il58xcQ>
    <xmx:KK6-ad0Gz_C1NLzEzHXmh9tsBRsJB-TuMYDvIltBcE0pVGeGybVAOA>
    <xmx:KK6-aTiec504R-W1uLpsuhDb9XzI7j9hF66LLbHW_AtHqlIpQotF6w>
    <xmx:KK6-ae-yK-pcqvOPyIIdDor4fxfO7vn0hnMfUNu7r_SSmZGLAYruzQ>
    <xmx:Ka6-aYEahhSUSd4d6haeBj2QaHsH3iddoMfk6Umy_J5ml2JhlztuCSx6>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 10:41:44 -0400 (EDT)
Date: Sat, 21 Mar 2026 15:39:24 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>, stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.1.y] ext4: don't set EXT4_GET_BLOCKS_CONVERT when
 splitting before submitting I/O
Message-ID: <2026032119-chevy-unsmooth-a3a4@gregkh>
References: <2026022422-humorous-scam-a54d@gregkh>
 <20260225025732.3839126-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225025732.3839126-1-sashal@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227773-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:dkim,huawei.com:email,huaweicloud.com:email]
X-Rspamd-Queue-Id: 335E32E5DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Feb 24, 2026 at 09:57:32PM -0500, Sasha Levin wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> [ Upstream commit feaf2a80e78f89ee8a3464126077ba8683b62791 ]
> 
> When allocating blocks during within-EOF DIO and writeback with
> dioread_nolock enabled, EXT4_GET_BLOCKS_PRE_IO was set to split an
> existing large unwritten extent. However, EXT4_GET_BLOCKS_CONVERT was
> set when calling ext4_split_convert_extents(), which may potentially
> result in stale data issues.
> 
> Assume we have an unwritten extent, and then DIO writes the second half.
> 
>    [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
>    [UUUUUUUUUUUUUUUU] extent status tree
>             |<-   ->| ----> dio write this range
> 
> First, ext4_iomap_alloc() call ext4_map_blocks() with
> EXT4_GET_BLOCKS_PRE_IO, EXT4_GET_BLOCKS_UNWRIT_EXT and
> EXT4_GET_BLOCKS_CREATE flags set. ext4_map_blocks() find this extent and
> call ext4_split_convert_extents() with EXT4_GET_BLOCKS_CONVERT and the
> above flags set.
> 
> Then, ext4_split_convert_extents() calls ext4_split_extent() with
> EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and EXT4_EXT_DATA_VALID2
> flags set, and it calls ext4_split_extent_at() to split the second half
> with EXT4_EXT_DATA_VALID2, EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT
> and EXT4_EXT_MARK_UNWRIT2 flags set. However, ext4_split_extent_at()
> failed to insert extent since a temporary lack -ENOSPC. It zeroes out
> the first half but convert the entire on-disk extent to written since
> the EXT4_EXT_DATA_VALID2 flag set, but left the second half as unwritten
> in the extent status tree.
> 
>    [0000000000SSSSSS]  data                S: stale data, 0: zeroed
>    [WWWWWWWWWWWWWWWW]  on-disk extent      W: written extent
>    [WWWWWWWWWWUUUUUU]  extent status tree
> 
> Finally, if the DIO failed to write data to the disk, the stale data in
> the second half will be exposed once the cached extent entry is gone.
> 
> Fix this issue by not passing EXT4_GET_BLOCKS_CONVERT when splitting
> an unwritten extent before submitting I/O, and make
> ext4_split_convert_extents() to zero out the entire extent range
> to zero for this case, and also mark the extent in the extent status
> tree for consistency.
> 
> Fixes: b8a8684502a0 ("ext4: Introduce FALLOC_FL_ZERO_RANGE flag for fallocate")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> Cc: stable@kernel.org
> Message-ID: <20251129103247.686136-4-yi.zhang@huaweicloud.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> [ different function signatures ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ext4/extents.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 1aad4ae0e7ae4..dfc365b021094 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3705,11 +3705,15 @@ static int ext4_split_convert_extents(handle_t *handle,
>  	/* Convert to unwritten */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
>  		split_flag |= EXT4_EXT_DATA_VALID1;
> -	/* Convert to initialized */
> -	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
> +	/* Split the existing unwritten extent */
> +	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> +			    EXT4_GET_BLOCKS_CONVERT)) {
>  		split_flag |= ee_block + ee_len <= eof_block ?
>  			      EXT4_EXT_MAY_ZEROOUT : 0;
> -		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
> +		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> +		/* Convert to initialized */
> +		if (flags & EXT4_GET_BLOCKS_CONVERT)
> +			split_flag |= EXT4_EXT_DATA_VALID2;
>  	}
>  	flags |= EXT4_GET_BLOCKS_PRE_IO;
>  	return ext4_split_extent(handle, inode, ppath, map, split_flag, flags);
> @@ -3874,7 +3878,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	/* get_block() before submitting IO, split the extent */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
>  		ret = ext4_split_convert_extents(handle, inode, map, ppath,
> -					 flags | EXT4_GET_BLOCKS_CONVERT);
> +					 flags);
>  		if (ret < 0) {
>  			err = ret;
>  			goto out2;
> -- 
> 2.51.0
> 
> 

Does not apply :(

