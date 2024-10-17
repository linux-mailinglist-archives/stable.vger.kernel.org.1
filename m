Return-Path: <stable+bounces-86629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC659A2418
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA78A1F22530
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998F1DE2C9;
	Thu, 17 Oct 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulqQLaXI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD01C07C7;
	Thu, 17 Oct 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172349; cv=none; b=PKl8CTGROlMJPk2/MJOVOJyaNu9aKTlUNwpi/49oCQWoJ1wSwba430kq/A0x8BWDVk6zfyYQItfRF7K56T23lXy16/DQVnyXl+hhXroM/4mA3qAD8E4hRDXxiaoOR8vr/bMnXTa3cAaI8AYNKPZ6sKh6JFr4JZFYXN23IpyGZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172349; c=relaxed/simple;
	bh=ZzzYnZcVVmf5k7zsxQyVHK7Uv4btO9xlyLEJg5slnso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOtpqGyFWcn9eAeZ9VMNNaR3cNuPkNxkM2ySa3k4KOTLhMQwBKsfF7rNQ67EOS/JLbDDKCbh0GB3NRdRldehiC7X5dFbZWmvy9RoOBiLDqBQWqNuRe5m9XgBOufs1aYu4Zu6OZJFCpV97ImGaTiJND470dHaWwED4FvnYySg7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulqQLaXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4758C4CEC3;
	Thu, 17 Oct 2024 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729172349;
	bh=ZzzYnZcVVmf5k7zsxQyVHK7Uv4btO9xlyLEJg5slnso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulqQLaXIYO1xXVJlwmP9DV11ThvuEe7T3Ur9g/CblBHix8B1N+IVHiOiO0IzgpY8L
	 OFZ+PLvGI9bIFhhyNJPtT7um88z1n9Yth103U+bvzaQsn7zHa69y6Y+M3HuAjFQ2bD
	 m51WZ5Tv4K1VwMR1LwJoeMDiZYEYUyVzaqT9y0cs=
Date: Thu, 17 Oct 2024 15:39:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org, vimal.agrawal@sophos.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] misc: misc_minor_alloc to use ida for all
 dynamic/misc dynamic minors
Message-ID: <2024101715-flounder-delusion-8edb@gregkh>
References: <2024101722-uncharted-wages-5759@gregkh>
 <20241017133532.94509-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133532.94509-1-vimal.agrawal@sophos.com>

On Thu, Oct 17, 2024 at 01:35:32PM +0000, Vimal Agrawal wrote:
> misc_minor_alloc was allocating id using ida for minor only in case of
> MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> using ida_free causing a mismatch and following warn:
> > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > ida_free called for id=127 which is not allocated.
> > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> ...
> > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > [<605acb82>] misc_deregister+0x171/0x1b3
> 
> misc_minor_alloc is changed to allocate id from ida for all minors
> falling in the range of dynamic/ misc dynamic minors
> 
> Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
> Signed-off-by: Vimal Agrawal <avimalin@gmail.com>

Sorry, but no, do not hide behind a gmail.com address.  Either fix your
corporate email system to be able to send patches out, or use the other
method of sending from a different address as documented in the kernel
documentation.

As it is, I can't take this, sorry.

greg k-h

