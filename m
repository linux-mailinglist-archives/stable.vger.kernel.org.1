Return-Path: <stable+bounces-115143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507CA340D4
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533101689F9
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258224BC1B;
	Thu, 13 Feb 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xODjSaie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4412E7F
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454840; cv=none; b=sjYpUpMwVHlLHR/aFdP3i2jaPo81Ts2Pdp0qOr1zu/ddRFw/1FMTIWzu+J7hoTaaryov0DRsGcRuPRLUT+zexxG211jJcPbZCPqBrGJomUrmCYHHL35rWlQSd5X+iQFskEK3pcvfwojUy+A/gofVfRbaByUs9WLa93BYl2NLCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454840; c=relaxed/simple;
	bh=voxM8iv7cHEo/492BufmSufaR+DXwTCw9cHYwaWu0JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SID55eBdx2mMyuAHYA1BXVGx3IXqJ2oKct/Uf39NsX/OzE4h1Zbz44JZTisVamPCP2G8T2BeLVeXRRMejXdxkMiuyU95raNHU9JZgwW3OmpPYw2JS0t2seC73PXPkQOdOS6Kr4dnqTyUAFZrC8XCsf/w2IJsCK+ix5jEhZAQ0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xODjSaie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF67C4CED1;
	Thu, 13 Feb 2025 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739454839;
	bh=voxM8iv7cHEo/492BufmSufaR+DXwTCw9cHYwaWu0JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xODjSaie9bhpjwZsQm+uIjILcmgK5pPo7JXAmKYSGbwbAzrV07G6o5yBmeJe+xHZp
	 8Ts84j0VEbpblcWX2f3JhGNN+5/ll/cvz4vgtaMNyT8wGfC97qx5yEmpMEtQn29g6O
	 IU1p9MOBk/QYzE17zIhvzC8dzaHwhpribuLbd6vg=
Date: Thu, 13 Feb 2025 14:53:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vgiraud.opensource@witekio.com
Cc: stable@vger.kernel.org, Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>, Bruno VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH 6.6] ext4: filesystems without casefold feature cannot be
 mounted with siphash
Message-ID: <2025021313-aware-yam-ffec@gregkh>
References: <20250207113703.2444446-1-vgiraud.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207113703.2444446-1-vgiraud.opensource@witekio.com>

On Fri, Feb 07, 2025 at 12:37:03PM +0100, vgiraud.opensource@witekio.com wrote:
> From: Lizhi Xu <lizhi.xu@windriver.com>
> 
> commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.
> 
> When mounting the ext4 filesystem, if the default hash version is set to
> DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
> 
> Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
> Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
> ---
>  fs/ext4/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f019ce64eba4..b69d791be846 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3627,6 +3627,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
>  	}
>  #endif
>  
> +	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
> +	    !ext4_has_feature_casefold(sb)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Filesystem without casefold feature cannot be "
> +			 "mounted with siphash");
> +		return 0;
> +	}
> +
>  	if (readonly)
>  		return 1;
>  
> -- 
> 2.34.1
> 
> 

Any specific reason you asked for just this one commit to be backported
and NOT the fix for this commit?

How did you test this?

ugh,

greg k-h

