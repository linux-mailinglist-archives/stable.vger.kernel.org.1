Return-Path: <stable+bounces-163495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E49B0BC0A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 07:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954EA3ACA98
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 05:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB20E1ACEDE;
	Mon, 21 Jul 2025 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G3YXxnBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12219CD13
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076236; cv=none; b=usghCAt1Q/8pYUb2uOE2igvCytzIgh+d1HXbbsJ0tdH11v4kZTeNotsG+FGrSJAQtMnWeeBmRjUD1DHusjFHFDPx8p0TE90hjsoSWfztbe4M+c1P1zZVLQnVVVYrbR/3/pFXS7JGEZVbJBqikxRwTyGSfNOYicxCfQWkGB0K6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076236; c=relaxed/simple;
	bh=tk90Dhhnk68eq0yeTTPmpEa/JZ4j8McorbDAvuf6d3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wnwo6qZlA4Srml+GHiLavoMjBDRkijwtLAa55d8EuS6xJnxNbw4DSJ8nZrQaew4KtMFt0h3jZJt9LQIymo8Zu8fgPIn8rgd3dBhANO6PFYkSGtuxAY90clMWvvfN7rz5TOyA5MASSdR5E2i4HJFlLxMDW08pK6kELpyyVQtrzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G3YXxnBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24170C4CEF1;
	Mon, 21 Jul 2025 05:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753076235;
	bh=tk90Dhhnk68eq0yeTTPmpEa/JZ4j8McorbDAvuf6d3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3YXxnBovTDraNyy5PRhex81HIX00L7gEKfFskL1+CkZPAJFraVvFGJ3Cw61hMuy2
	 /y2GCIYzpI5CQZ27Dxy3r8Txq6zlE5YcinX7iu4PsZrkZE/+yB4ahx5G2mm/+On1Uq
	 Dw38C9F4A7xHFMbGyfgYE42c5lPqc052yafXj0SI=
Date: Mon, 21 Jul 2025 07:37:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: Steve French <stfrench@microsoft.com>, stable@vger.kernel.org,
	Ralph Boehme <slow@samba.org>, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH] Fix SMB311 posix special file creation to servers which
 do not advertise reparse support
Message-ID: <2025072104-rebound-aftermath-f257@gregkh>
References: <20250720203248.5702-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720203248.5702-1-eraykrdg1@gmail.com>

On Sun, Jul 20, 2025 at 11:32:48PM +0300, Ahmet Eray Karadag wrote:
> From: Steve French <stfrench@microsoft.com>
> 
> Some servers (including Samba), support the SMB3.1.1 POSIX Extensions (which use reparse
> points for handling special files) but do not properly advertise file system attribute
> FILE_SUPPORTS_REPARSE_POINTS.  Although we don't check for this attribute flag when
> querying special file information, we do check it when creating special files which
> causes them to fail unnecessarily.   If we have negotiated SMB3.1.1 POSIX Extensions
> with the server we can expect the server to support creating special files via
> reparse points, and even if the server fails the operation due to really forbidding
> creating special files, then it should be no problem and is more likely to return a
> more accurate rc in any case (e.g. EACCES instead of EOPNOTSUPP).
> 
> Allow creating special files as long as the server supports either reparse points
> or the SMB3.1.1 POSIX Extensions (note that if the "sfu" mount option is specified
> it uses a different way of storing special files that does not rely on reparse points).
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 6c06be908ca19 ("cifs: Check if server supports reparse points before using them")
> Acked-by: Ralph Boehme <slow@samba.org>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
>  fs/smb/client/smb2inode.c | 3 ++-
>  fs/smb/client/smb2ops.c   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 2a3e46b8e15a..a11a2a693c51 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -1346,7 +1346,8 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
>  	 * empty object on the server.
>  	 */
>  	if (!(le32_to_cpu(tcon->fsAttrInfo.Attributes) & FILE_SUPPORTS_REPARSE_POINTS))
> -		return ERR_PTR(-EOPNOTSUPP);
> +		if (!tcon->posix_extensions)
> +			return ERR_PTR(-EOPNOTSUPP);
>  
>  	oparms = CIFS_OPARMS(cifs_sb, tcon, full_path,
>  			     SYNCHRONIZE | DELETE |
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index cb659256d219..938a8a7c5d21 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -5260,7 +5260,8 @@ static int smb2_make_node(unsigned int xid, struct inode *inode,
>  	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL) {
>  		rc = cifs_sfu_make_node(xid, inode, dentry, tcon,
>  					full_path, mode, dev);
> -	} else if (le32_to_cpu(tcon->fsAttrInfo.Attributes) & FILE_SUPPORTS_REPARSE_POINTS) {
> +	} else if ((le32_to_cpu(tcon->fsAttrInfo.Attributes) & FILE_SUPPORTS_REPARSE_POINTS)
> +		|| (tcon->posix_extensions)) {
>  		rc = smb2_mknod_reparse(xid, inode, dentry, tcon,
>  					full_path, mode, dev);
>  	}
> -- 
> 2.34.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

