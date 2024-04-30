Return-Path: <stable+bounces-41801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2A8B6B1A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47AD1F226F6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5BE249E4;
	Tue, 30 Apr 2024 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EXjJYhyc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356201C291;
	Tue, 30 Apr 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460729; cv=none; b=JXp6uSVv+MmiG5fKQoXHyB0cp1Nh3ASNDht+TbB+Sq3AbLN8x6ksbo8Ef7ZiZvQbYxP5oaLMqvg0U6e51X3GNcQra770r192PKSZGEHo0hW2dCHixRFIShOjgH+idhQ34k+6qXN61nO5jnczKBd/WHTzhKYJojoN85YilJkPNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460729; c=relaxed/simple;
	bh=yjnSvf8TCvkNWoDg/hmSKYNlbQ8+N9YsBHY77voBzB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9OKNdNpSlUBe3nh14CAPdAGyFNdBRkbRp3Y/CzEVLNvxqptU4SRd+YO7V/Qv3FgvpYXz6tH4yj7gaQ+kK/zP79Dkh7K1X0jt/cZK7wxIXhOykWAziL0k6T1s8Lt6nh79gDHbWZjGXGUCalfDfMFvPXLKRQZ7hbFlqzPqX6FiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EXjJYhyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3A0C2BBFC;
	Tue, 30 Apr 2024 07:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714460728;
	bh=yjnSvf8TCvkNWoDg/hmSKYNlbQ8+N9YsBHY77voBzB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXjJYhyc0gwB/Yk2yYTG8W3Kobro1X86dGuZxdJkiiPJiqjgJYzTyCzRftbtK4nhy
	 vRcgE6RGjhjmynhQpkaaWwz6khgRQeJ+YIvBzU3emQq8l7V2DpoBn5j342rQXubch7
	 syxoUcssxwQSscBUFkgkMR1y7CFB0k8BzSfH0kDM=
Date: Tue, 30 Apr 2024 09:05:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Atishya Jain <atishyajain.it@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel Issue: Wrong EFI Loader Signature followed by Kernel Panic
Message-ID: <2024043037-capture-trench-3611@gregkh>
References: <CAAwq=D4tUP65CNLuYib_YFBYwz2mYNw+wXzAyacf+tJ18Op2eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAwq=D4tUP65CNLuYib_YFBYwz2mYNw+wXzAyacf+tJ18Op2eA@mail.gmail.com>

On Tue, Apr 30, 2024 at 12:16:24PM +0530, Atishya Jain wrote:
> Dear Linux Stable Team,
> 
> I am writing to report an issue encountered while attempting to boot kernel
> version 5.4.274 with an egress XDP patch applied. The issue arises with the
> EFI loader signature, leading to subsequent kernel panic.
> 
> *Problem Description:*
> 
> When attempting to boot kernel version 5.4.274 with the egress XDP patch, I
> encountered the following sequence of events:

What is "the egress XDP patch"?

And why such an old kernel version?  Why not use the latest 6.8 release
instead?

thanks,

greg k-h

