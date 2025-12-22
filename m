Return-Path: <stable+bounces-203212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9714CD5E28
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81278305B93B
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30226312814;
	Mon, 22 Dec 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e13DDMaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1B1AAE13;
	Mon, 22 Dec 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404467; cv=none; b=PTp4W2GquzJTsxNcv47x1Of0Nb5ckD0mUg9NUot0+eUkTgUWfZnJfD8EwcjV8gzNEhUONsUR/1iTayb83luENt+baujwA03gj0uxLv3qWm2B6Pu/4Nhx/CwL3vpdMrK468jYKEXOTqkEwyjd22hzAHVtuWmWPs8B16jPhOehcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404467; c=relaxed/simple;
	bh=a1OYB19ECEXChDroUupBf2Ouf4nQd7/6B98eFdrDRa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVoO2//yNSUS5iHYc6GpHTdPSOYNwlVuVYp+ZlbHlipIPTXTtkG/ljCsgBj2tMXEWzUJQ1LGVwfnVrg4jj2dHw/sPAfh0oqzhgpqMtTSAFgsOwEN9asVKtRj2v2AJqgvwVFxd53b1RV6U2gKn1QGlXEeGS9pi+C7RPnVadbFfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e13DDMaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55226C4CEF1;
	Mon, 22 Dec 2025 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766404466;
	bh=a1OYB19ECEXChDroUupBf2Ouf4nQd7/6B98eFdrDRa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e13DDMaK+ppcAYaY9fitcHCvuWtE5EQr12Ck3pr+V72KB1gU+FovX86WwP0WslFAp
	 hMX6Jw1/fxVuZyj021pj16DPlmXEAXLiMI/6B1C0ExvMKsvQ5vUBex6KoBnW2luCI0
	 7/xAv0ntcAlpCnrCWA8Uye6SRFzx0SJv7Hm6Dflc=
Date: Mon, 22 Dec 2025 12:54:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yangshiguang1011@163.com
Cc: rafael@kernel.org, dakr@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, yangshiguang@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix NULL pointer dereference at
 debugfs_read_file_str
Message-ID: <2025122234-crazy-remix-3098@gregkh>
References: <20251222093615.663252-2-yangshiguang1011@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222093615.663252-2-yangshiguang1011@163.com>

On Mon, Dec 22, 2025 at 05:36:16PM +0800, yangshiguang1011@163.com wrote:
> From: yangshiguang <yangshiguang@xiaomi.com>
> 
> Check in debugfs_read_file_str() if the string pointer is NULL.
> 
> When creating a node using debugfs_create_str(), the string parameter
> value can be NULL to indicate empty/unused/ignored.

Why would you create an empty debugfs string file?  That is not ok, we
should change that to not allow this.

> However, reading this node using debugfs_read_file_str() will cause a
> kernel panic.
> This should not be fatal, so return an invalid error.
> 
> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
> Fixes: 9af0440ec86e ("debugfs: Implement debugfs_create_str()")
> Cc: stable@vger.kernel.org
> ---
>  fs/debugfs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 3ec3324c2060..a22ff0ceb230 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1026,6 +1026,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  		return ret;
>  
>  	str = *(char **)file->private_data;
> +	if (!str)
> +		return -EINVAL;

What in kernel user causes this to happen?  Let's fix that up instead
please.

thanks,

greg k-h

