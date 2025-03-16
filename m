Return-Path: <stable+bounces-124511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50FA63437
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010247A6688
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 06:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE0186E2F;
	Sun, 16 Mar 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yg/1t/vm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0B183CA6
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742105927; cv=none; b=ipVPMpKbiET1lLSgJy+dAYPQdpOoAcP1+euLIn0uKklPmKAdJv2chhrLgnUd7ZK2xEVTJw4sXZEYYhdltmhwAo2+h0+Sd97/7VV41zXfVCaeKg/H3UGJfWTrGl/WsCejbFiVRqGEYOEXQdoG5j/kIljaiUGyBIM/O/02tAaN5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742105927; c=relaxed/simple;
	bh=Ah10rKYcjyaSSlg1htMaR/wZIK/wGG31pMzC+H6aJpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcjjPamA+z9EYSrETP38DRxm4n39/cCIFYLYp0OOqCFNs5sTKJ6KI3TeHBtQZGDIDoDc7ikQrAnZaT3z4HpsVd0GxU9BrJX43j641PMcjWD1xgn0vr9zURPQSEAD+6H/Q9IKqa4HdaX5PDhZ8mVxRWF1LlxnvbkjD5TXArf68oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yg/1t/vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146D8C4CEDD;
	Sun, 16 Mar 2025 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742105926;
	bh=Ah10rKYcjyaSSlg1htMaR/wZIK/wGG31pMzC+H6aJpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yg/1t/vmbPS0VndaXE+lTwBo4fV8y0EtnGZlAHCoVGqVlSJ74XfWEFzx1n8BtyUfJ
	 zN6xBtbFg45MKh+gXV4Rmy5iQ88D93l3SOnt/jngGHsbKgAUv3u/dUR40RPtklB9WK
	 VxIRZOUHoU7HWqoEm6fZLlBJ5pJKBwfKl4LidMBs=
Date: Sun, 16 Mar 2025 07:18:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdelkareem Abdelsaamad <kareemem@amazon.com>
Cc: stable@vger.kernel.org, Chen Ridong <chenridong@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] memcg: fix soft lockup in the OOM process
Message-ID: <2025031612-ninth-evident-6dcb@gregkh>
References: <20250313180309.41770-1-kareemem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313180309.41770-1-kareemem@amazon.com>

On Thu, Mar 13, 2025 at 06:03:09PM +0000, Abdelkareem Abdelsaamad wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> [ Upstream commit ade81479c7dda1ce3eedb215c78bc615bbd04f06 ]
> 
> A soft lockup issue was found in the product with about 56,000 tasks were
> in the OOM cgroup, it was traversing them when the soft lockup was
> triggered.

Why are you submitting backports for commits already in the requested
stable trees?

confused,

greg k-h

