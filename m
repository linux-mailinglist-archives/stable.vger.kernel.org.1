Return-Path: <stable+bounces-2880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F87FB660
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 10:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE82826AA
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40E4BAB5;
	Tue, 28 Nov 2023 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1wjBmdoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997C4B5D2;
	Tue, 28 Nov 2023 09:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C879CC433C7;
	Tue, 28 Nov 2023 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701165244;
	bh=n+Ar5X9JSbp0izchwv6/lFQCJOtaNSaVKuhBCyJ0pnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1wjBmdoLl7hA6XpxnkWmlyKxAiYTdui/gybppPOw7NS+DRXo6/xBDKX/6If3IIf0+
	 WGL5S78lFOV5BeHSOlVSI37fD5lory5sZTs8rL1trKebejjW+DFd8RzMrYykR/hl2f
	 hKfMpDdYQyGqZ1Azxcv+rKHq1Jz2Y+OTHbl5XLoE=
Date: Tue, 28 Nov 2023 09:54:01 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
	initramfs@vger.kernel.org, stable@vger.kernel.org,
	Rob Landley <rob@landley.net>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Message-ID: <2023112826-cesspool-cabbie-06c5@gregkh>
References: <20231120011248.396012-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120011248.396012-1-stefanb@linux.ibm.com>

On Sun, Nov 19, 2023 at 08:12:48PM -0500, Stefan Berger wrote:
> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> 
>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>   line.
> 
> This currently does not work when root= is provided since then
> saved_root_name contains a string and rootfstype= is ignored. Therefore,
> ramfs is currently always chosen when root= is provided.
> 
> The current behavior for rootfs's filesystem is:
> 
>    root=       | rootfstype= | chosen rootfs filesystem
>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs
>    unspecified | tmpfs       | tmpfs
>    unspecified | ramfs       | ramfs
>     provided   | ignored     | ramfs
> 
> rootfstype= should be respected regardless whether root= is given,
> as shown below:
> 
>    root=       | rootfstype= | chosen rootfs filesystem
>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs  (as before)
>    unspecified | tmpfs       | tmpfs  (as before)
>    unspecified | ramfs       | ramfs  (as before)
>     provided   | unspecified | ramfs  (compatibility with before)
>     provided   | tmpfs       | tmpfs  (new)
>     provided   | ramfs       | ramfs  (new)
> 
> This table represents the new behavior.
> 
> Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root=  specified")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Rob Landley <rob@landley.net>
> Link: https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Who should take this patch?  Me?  Or someone else?

thanks,

greg k-h

