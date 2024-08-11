Return-Path: <stable+bounces-66368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C321894E1CF
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870DE2814A6
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD114A4ED;
	Sun, 11 Aug 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZKHCJp6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68807EAE9
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390064; cv=none; b=iX9tFlxplj9tpuI98PcdKWy1b62D9iGAPwOqeBda4Tt3yq7H8GfReYZy2qjqWwbSc9N45Rg7CjJH8mbCGYqDdsyIf/gWENTr7dgVPUuCoLnCsY/q/eL/TNKXb9iNAzM0lX/idBeW4ylxLZo/4VhU+AIkB1eXQrRz0SzOFICRxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390064; c=relaxed/simple;
	bh=HIMSC2MShyjd+hSPaIzA9RtnLCtALs+Shin0eW/5X34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC4zJBYesCl6Ny/xQTaceORSDdixeD2YGpt17WnGHjpt0w3mM9aH+ZhRmQ1hXnNHQf0PoQVoNlfhgYUo9QdLqDSVoILmvc8bdy8qmiWu30u5Ci94tN0ibSIChjSGFPSJ5cU7qx8RX2qLOmvkSkOVY1sTZuIPruDvo+QtUE5BR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZKHCJp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D08C32786;
	Sun, 11 Aug 2024 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723390063;
	bh=HIMSC2MShyjd+hSPaIzA9RtnLCtALs+Shin0eW/5X34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZKHCJp6jGbhpWK4ooyls2A8Xh6eDNCItbmRkh0EXEwacK7mEVVD9nntAssnMCLXG
	 pl9gXvSn6XphNoPah5ny81YpUXfCGi/DedJOuI8YK0TLuoQ0DZesIYMc8o2fbvdFWr
	 QBbWc1R365Ek1G4WRTsCOrj3jpbNHEOdTiZCp3dg=
Date: Sun, 11 Aug 2024 17:27:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: stable@vger.kernel.org, chen.dylane@gmail.com, t-anchiang@microsoft.com
Subject: Re: bpf tool build failure in latest stable-rc 6.1.103-rc3 due to
 missing backport
Message-ID: <2024081130-backlight-preseason-5a9f@gregkh>
References: <1722571545-7009-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722571545-7009-1-git-send-email-hargar@linux.microsoft.com>

On Thu, Aug 01, 2024 at 09:05:45PM -0700, Hardik Garg wrote:
> bpf tool build fails for the latest stable-rc 6.1.103-rc3
> The error details are as follows:
> prog.c: In function 'load_with_options':
> prog.c:1710:23: warning: implicit declaration of function 'create_and_mount_bpffs_dir' [-Wimplicit-function-declaration]
>  1710 |                 err = create_and_mount_bpffs_dir(pinmaps);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      struct_ops.o
>   CC      tracelog.o
>   CC      xlated_dumper.o
>   CC      jit_disasm.o
>   CC      disasm.o
>   LINK    bpftool
> /usr/bin/ld: prog.o: in function `load_with_options':
> prog.c:(.text+0x346a): undefined reference to `create_and_mount_bpffs_dir'
> 
> The commit causing this failure in 6.1.103-rc3: bc1605fcb33bf7a300cd3ac5c409a16bda1626ba
> 
> It appears that the commit from the 6.10 series is missing in this release candidate:
> 478a535ae54a ("bpftool: Mount bpffs on provided dir instead of parent dir")

That commit does not apply to 6.1.y, sorry.

greg k-h

