Return-Path: <stable+bounces-110993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E8A20F75
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9166B7A1CC6
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5E1B4159;
	Tue, 28 Jan 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZeZ3YUkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9A27452
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084314; cv=none; b=MN65+96VyCLwLQoeOlc4MDDtN7EEzSDDNuic2lcwiNXs0GaOIJB1z0tp7gqXaZhrVm9P4SDna/ndZE1+MbXxX3TfZ4Yb38XRxOE0IIz9u4eS/ifCMbrhqMH3KgQw7oNAtwxMnfSwMdVyPCeQLySVyV3SFHteHTRUxD8QWB/Mj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084314; c=relaxed/simple;
	bh=mqQuUZ4ZGGVY9hiG09vTynAl8M+lQ4QKCvr1GvRvb+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfI/pAlDBIhzxw2gFltj0OMT7rhLgWeeURVZWJCXz5koWepOJPj1hAdUKXhs2cOWNGhOTdEMpH3WMB4mMUfxd2oEzxklvfnazT6xDKBvjg/E59L0nAES7M+vNoWq/7rdBRj1sCJNwyAjx/MPpAJYdyO/dU4/paLs56kVi8WXDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZeZ3YUkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99269C4CED3;
	Tue, 28 Jan 2025 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738084313;
	bh=mqQuUZ4ZGGVY9hiG09vTynAl8M+lQ4QKCvr1GvRvb+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeZ3YUkMyTzmfx7RY5jEiFY0EY9WjSl4/+f6ApoTfRoNVFNJw1DSdDoU5e1YTaNkt
	 NfsFV0tja3vv1M0v4RmpMH2ub5mg3nQkxQx8ijExcFGmROEFrjCUDmtAXpE1KSpH1B
	 uAnKRaoBqK+W+SIU04NpcG0ByUQE1FmH2Pz1+tLo=
Date: Tue, 28 Jan 2025 18:11:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: ciprietti@google.com
Cc: stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <2025012819-goal-elastic-e89f@gregkh>
References: <20250128150322.2242111-1-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128150322.2242111-1-ciprietti@google.com>

On Tue, Jan 28, 2025 at 03:03:22PM +0000, ciprietti@google.com wrote:
> From: yangerkun <yangerkun@huawei.com>
> 
> [ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]
> 
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> 1. create 5000 files(1 2 3...) under one dir
> 2. call readdir(man 3 readdir) once, and get one entry
> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> 4. loop 2~3, until readdir return nothing or we loop too many
>    times(tmpfs break test with the second condition)
> 
> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> directory reads") to fix it, record the last_index when we open dir, and
> do not emit the entry which index >= last_index. The file->private_data
> now used in offset dir can use directly to do this, and we also update
> the last_index when we llseek the dir file.
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> [brauner: only update last_index after seek when offset is zero like Jan suggested]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrea Ciprietti <ciprietti@google.com>

You forgot to mention what you changed.

> ---
>  fs/libfs.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index dc0f7519045f..916c39e758b1 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -371,6 +371,15 @@ void simple_offset_destroy(struct offset_ctx *octx)
>  	xa_destroy(&octx->xa);
>  }
>  
> +static int offset_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +	unsigned long next_offset = (unsigned long)ctx->next_offset;
> +
> +	file->private_data = (void *)next_offset;

Why do you need 2 casts here when the original did not?

thanks,

greg k-h

