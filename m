Return-Path: <stable+bounces-109643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494CA182A0
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C898D16366C
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A11F4E44;
	Tue, 21 Jan 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWiMBpYg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078271F4E40
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479498; cv=none; b=gkQW0QxkybijuSyiLUPUS5u+qT2FRAsZkGF5lynB3AggIPCju8gRxf3DMy4CZ26mbC6VfKvPCug0OPa9lWmn0KVTEjOugRfVLhIM+5lOmB5lNjXWRvyDxM9EdEH0H8QAHfjjyLX6O8g6WKsvLcAce4vFbAP2knG9bSN7INQW+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479498; c=relaxed/simple;
	bh=mrBJJ2J8A+ei0DGpxzlrR+QYR/Jobw8UM4ywPtc/wp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywf6LC6OrAZfyVZt7ua+y4lfknm3DYpWf5dHHAI3A9pyp3SuxgnPXmrPYKNUUbCkQpxZYSbQbj2yoJ6Wr2XbA8wgamTczu2eAEclP8XBjuOjHpWT/6LbZBWd0KsnNFkm8AMRoifSs3sSzks39QIxY0PhNrFvpNgOrhR89SgbdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWiMBpYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DFDC4CEE1;
	Tue, 21 Jan 2025 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737479497;
	bh=mrBJJ2J8A+ei0DGpxzlrR+QYR/Jobw8UM4ywPtc/wp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zWiMBpYg1qY+88/Y24m5CYP2vpvaaKAHcGcCcNNrsBEqhvQFkLPspRrnnK2pelEjk
	 t95PfNzepK8vGfeN+iLLGbQnB+xDOXKU/i5pO0GyEMIUqX6P6oeJ6J8uTzv1kUB5mW
	 LD5bdt8sYgnypKnImummFjHOM4/gyP1aMQ1FJhR8=
Date: Tue, 21 Jan 2025 18:11:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: stable-rc: queues: v5.10.233: drivers/of/address.c:272:23:
 error: implicit declaration of function 'pci_register_io_range'
Message-ID: <2025012124-librarian-awry-51c2@gregkh>
References: <CA+G9fYvsRbxV7u5xX=5mThTmrd-1pfOYjJZxp1yUUqJfCdom+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvsRbxV7u5xX=5mThTmrd-1pfOYjJZxp1yUUqJfCdom+g@mail.gmail.com>

On Tue, Jan 21, 2025 at 09:05:25PM +0530, Naresh Kamboju wrote:
> The following build warnings / errors noticed with tinyconfig builds
> on stable-rc queues 5.10.
> 
> Build error:
> ---------
> kernel/sched/fair.c:8653:13: warning: 'update_nohz_stats' defined but
> not used [-Wunused-function]
>  8653 | static bool update_nohz_stats(struct rq *rq)
>       |             ^~~~~~~~~~~~~~~~~
> drivers/of/address.c: In function 'of_pci_range_to_resource':
>   272 |                 err = pci_register_io_range(&np->fwnode,
> range->cpu_addr,drivers/of/address.c:272:23: error: implicit
> declaration of function 'pci_register_io_range'; did you mean
> 'pci_register_driver'? [-Werror=implicit-function-declaration]
>       |                       ^~~~~~~~~~~~~~~~~~~~~
>       |                       pci_register_driver
> cc1: some warnings being treated as errors
> 
> Anders bisected this and found,
> # first bad commit:
>   [00ec41adffcf855c3812cec7b265f43c60752f63]
>   of: address: Use IS_ENABLED() for !CONFIG_PCI

Thanks, I think I've fixed this up now.

greg k-h

