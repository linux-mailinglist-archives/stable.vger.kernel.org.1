Return-Path: <stable+bounces-20879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F485C5A3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF61F22010
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60814D45C;
	Tue, 20 Feb 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aclnp/VG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9114C5A9
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460418; cv=none; b=J83++idH3/BsPGIfMPwZTT8SEInnugMOvynZS9r6EBt7JtM8ljlT1SzVOt6U3t72BEwgU+ZO1/geiVCoVXhsc9RYx0mQlApW6pXF80Vh1BFGe//Xr5VoYv3i3C6vSr3Ek3TcPtI0cFCZ3363vvtpCkBXJRnX1zXZWF1wHDjlE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460418; c=relaxed/simple;
	bh=69cEg/xoszDCeEjaQJejQBxzQt5Oy+zhNWaZQdxJSJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YScdl+n0aObX41LyytS5i0UJ5JAxDPmficbAdmZilkDdFDaJVUxKLbFCimTpp0+36AZdrt7HEEpJ/udfD/ae/JqeHYCkOy7XZk+Z9ZK8YBjS99yx/l71HUc1RRHHVu4V+EfdmcfXQWt8iIXUAKK0Y0S2vMfTc1qA16sRZp6BOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aclnp/VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9683C433F1;
	Tue, 20 Feb 2024 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708460417;
	bh=69cEg/xoszDCeEjaQJejQBxzQt5Oy+zhNWaZQdxJSJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aclnp/VGI9Ok8GkxWi6ZJ9RJCLhCVqGU+MN6mR909+Nx4T3DZHJ0uEkBmlZhppsIk
	 kbTOH+eO9gNYNA2YguJM1VGoWfY4578R0k27ucKhj+SQE4WC5dVpoGkifgN6T6hTog
	 f+2zyxdbSTCp9bz9IzB/nkpScDjIKVr2sTQr4HG0=
Date: Tue, 20 Feb 2024 21:20:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org, Wang Kefeng <wangkefeng.wang@huawei.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 1/2] ARM: 9328/1: mm: try VMA lock-based page fault
 handling first
Message-ID: <2024022058-huskiness-previous-c334@gregkh>
References: <2024021921-bleak-sputter-5ecf@gregkh>
 <20240220190351.39815-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220190351.39815-1-surenb@google.com>

On Tue, Feb 20, 2024 at 11:03:50AM -0800, Suren Baghdasaryan wrote:
> From: Wang Kefeng <wangkefeng.wang@huawei.com>
> 
> Attempt VMA lock-based page fault handling first, and fall back to the
> existing mmap_lock-based handling if that fails, the ebizzy benchmark
> shows 25% improvement on qemu with 2 cpus.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/arm/Kconfig    |  1 +
>  arch/arm/mm/fault.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

No git id?

What kernel branch(s) does this go to?

confused,

greg k-h

