Return-Path: <stable+bounces-93082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C349CD68B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EE02830AE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963E216A943;
	Fri, 15 Nov 2024 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vEGfmWT+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCF55E73
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647987; cv=none; b=FrJ50vnhfkUGu/ep5GGh8xArOzGTBbGZSe2B85FoOqIH7TZDBt+w6seekMUD3PYdtJ+9KhFSZ6ku/CQjuum13iOCg0X1CWA17Eu4Vdsp6bwcb4A1bVxC6j7PrXE5N1brGNBdY2Qz1Ah+Gp79vCiMTtMeL+I3c26TZGzLE0QiwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647987; c=relaxed/simple;
	bh=ut0PdHCie4ZKhNJz9q4UC3dvHxiIpKuDus3bQnhpftM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ+EikLWi7qdVnvzlY2Jw3PhfXmwq6MBIshZTOd/+0iB5FlF8gKTh/1v7uDa35cLP61srqruDcxN/QVES+8cRlgB/BXBHCqynUKp795J6BHAPj2mTF9QnXBQwjpHn1YHU4TRAPn8sqNhj8HG2EXfD1rNojj43jxihW6qMJ66INE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vEGfmWT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69858C4CECF;
	Fri, 15 Nov 2024 05:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731647986;
	bh=ut0PdHCie4ZKhNJz9q4UC3dvHxiIpKuDus3bQnhpftM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEGfmWT+8FbnWyk4P+FLMmY8x1S+D+PSq0GR3u5KdbBkNmcDRJuVWDlSrnFGknjvs
	 XTEVkhp93ifizAxboVmsWEZSVhDpovdZPHsLcoyUSso9caOLNAt/Mq29r/9oVILXtj
	 LGxXFUxUSVCw/vVfS541uvdO+akVRNzitLdeeVpg=
Date: Fri, 15 Nov 2024 06:19:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bin Lan <bin.lan.cn@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] fs/ntfs3: Fix general protection fault in
 run_is_mapped_full
Message-ID: <2024111530-cold-facility-4b7a@gregkh>
References: <20241114093107.1092295-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114093107.1092295-1-bin.lan.cn@windriver.com>

On Thu, Nov 14, 2024 at 05:31:07PM +0800, Bin Lan wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> [ Upstream commit a33fb016e49e37aafab18dc3c8314d6399cb4727 ]
> 
> Fixed deleating of a non-resident attribute in ntfs_create_inode()
> rollback.
> 
> Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> ---
>  fs/ntfs3/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 026ed43c0670..8d1cfa0fc13f 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1646,6 +1646,15 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  			  le16_to_cpu(new_de->key_size), sbi);
>  	/* ni_unlock(dir_ni); will be called later. */
>  out6:
> +	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
> +	if (attr && attr->non_res) {
> +		/* Delete ATTR_EA, if non-resident. */
> +		struct runs_tree run;
> +		run_init(&run);
> +		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
> +		run_close(&run);
> +	}
> +	

You have trailing whitespace here :(


