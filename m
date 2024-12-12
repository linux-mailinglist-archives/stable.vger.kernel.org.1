Return-Path: <stable+bounces-100899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8559EE61C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD0A287B33
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410802116EC;
	Thu, 12 Dec 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/JnbuVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8802054E8
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004769; cv=none; b=P3h47EsEdZ89IOamUR6b12qM9n0GqVsszI6BLXFoYFoaZywVNU7Xv1kuP2A1/ysTD20o3u/DT3nj4QmxcSREHbuiJHuqFFJOA3r04eeRru8JrDBS71X41BnUYTXkXBKAEhtCZ1uFJd9KjcnM9gyWoBpuWHZiJAnRl0n4LxhOxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004769; c=relaxed/simple;
	bh=2paypN9EKZsCIPI8z72B0De3TmgO/Olexdgr8vvDGx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5M70p3ipuadGpXh0q55+PFSm47Ko5jAyymMa7O3B3/b0mcr5v5i9R1GkTDcq08J41+usGhKPBPkIGEnp5fHE9vOxbzhcxPY3PpIoaftIOgM/vapbsngi8WNqByGysS+hjG/t3CF8RbZUBksY0KTYbgQCE7k6cmHJ7UctxyQhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/JnbuVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC3C4CECE;
	Thu, 12 Dec 2024 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734004765;
	bh=2paypN9EKZsCIPI8z72B0De3TmgO/Olexdgr8vvDGx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/JnbuVN/fI355KcThQeyk3eohoC4U/Ggu7Z6Bfr1XAzWZInfWHRSxzq/VSBL2kRy
	 s+qloXDioP4H8VQY+ksBf6bs/dEEKbBPoswjgwpFq8C390uDw2Tu0LbYHSu8ReDRdn
	 TroaMd+DI2kHtYoqjISkWnctj9lGjHTWLUMKjj/Q=
Date: Thu, 12 Dec 2024 12:59:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: juntong.deng@outlook.com, agruenba@redhat.com,
	majortomtosourcecontrol@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Message-ID: <2024121215-earthling-counting-0c9a@gregkh>
References: <20241211083954.3406361-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211083954.3406361-1-guocai.he.cn@windriver.com>

On Wed, Dec 11, 2024 at 04:39:54PM +0800, guocai.he.cn@windriver.com wrote:
> From: Juntong Deng <juntong.deng@outlook.com>
> 
> commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba upstream.

No it is not.

