Return-Path: <stable+bounces-46122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F18CEE5B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 11:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072CA1F216F8
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366319BDC;
	Sat, 25 May 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMAdpl81"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34D23748;
	Sat, 25 May 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716630159; cv=none; b=PshV3MAgOhJByqbs6laMAnBymC7xAFGabyobXsCCChUntyZBmIKHCsovThreMRBatbJdaPXYNbJSKO7e4HHqj0OOvjbiUfbd0OO/m/zOQMKnRCPnPaQ24X1vJ+sK0dzUbU2y4ID0avqkUe2T4oJ3DLuBZf4VZjJYIrUpeuZSHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716630159; c=relaxed/simple;
	bh=RiSBNerJeUUysE1tNmEwQ7JhpvQEcx5D1JY07vm8CDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0IGa6JaEkL2hC23v/MCdowFz4d7rVZAoKlvEeUl9Ulch49FUCtTPsQi83Xw3/q7VYTle/5Qdl7v8KaqPspkn8UdzOzgsoGqJ3gkzN+3G7t7do3Wp+L9qwp0rRQ/g55qAvIGO/OOjekj/nFliMmKoLFwwKbtOj6zN0nSKNC+V7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMAdpl81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B53C2BD11;
	Sat, 25 May 2024 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716630158;
	bh=RiSBNerJeUUysE1tNmEwQ7JhpvQEcx5D1JY07vm8CDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yMAdpl81sfNgGy7j+B0YCqpyYdzYRX4+s42aHXoFFYdBwh9fTsRq1DqKyKgVhgL7r
	 AcTJTF5SXYmx8JnVz6q8RYOfiedQQkUPPxomKqF7i0udoHJfoe3yVIphKqSYWgXJiJ
	 8kGhjIOoPpROt8jhL7B6UB9hfEqNIsKEakGA9icg=
Date: Sat, 25 May 2024 11:42:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.15 0/2] Revert the patchset for fix
 CVE-2024-26865
Message-ID: <2024052511-aflutter-outsider-4917@gregkh>
References: <20240506030554.3168143-1-shaozhengchao@huawei.com>
 <2024052355-doze-implicate-236d@gregkh>
 <92bc4c96-9aaa-056c-e59a-4396d19a9f58@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bc4c96-9aaa-056c-e59a-4396d19a9f58@huawei.com>

On Sat, May 25, 2024 at 05:33:00PM +0800, shaozhengchao wrote:
> 
> 
> On 2024/5/23 19:34, Greg KH wrote:
> > On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
> > > There's no "pernet" variable in the struct hashinfo. The "pernet" variable
> > > is introduced from v6.1-rc1. Revert pre-patch and post-patch.
> > 
> > I do not understand, why are these reverts needed?
> > 
> > How does the code currently build if there is no variable here?
> > 
> > confused,
> > 
> > greg k-h
> Hi greg:
>   If only the first patch is merged, compilation will fail.
> There's no "pernet" variable in the struct hashinfo.

But both patches are merged together here.  Does the released kernel
versions fail to build somehow?

thanks,

greg k-h

