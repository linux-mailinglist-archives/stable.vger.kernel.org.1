Return-Path: <stable+bounces-73816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99E96FE20
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 00:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70874B23D1D
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CD15ADA6;
	Fri,  6 Sep 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmOMbz1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFA156C5F;
	Fri,  6 Sep 2024 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663169; cv=none; b=IePH6xEfxQugYNre0UbddvFyI8Y3YFrEK18nCvG+xfxU+hc3Dh3z5fwEuxa0Y9ASmDogDWks5Qes/T3YGiUZXW48gVLCxsq68ln/uj/G9pLnk+BGh8nsW3hXAdDaCkBv++yO2ZCH/YlNSpiA+lehNbCdwpCmF6CaVhZJYXodsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663169; c=relaxed/simple;
	bh=NDnhJYHmPd2gD/xHsSON9t0iaghHfHefv1ORSmknexs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8ahdCfhDDBWVHPqn44wAKXcWS25uK7XEtdS3BIro578M6V4sFAKEFbArgMkBinnLClRVw38JDLtv0soalacOJ9rb4ZCxP3LmF6CNOhhv+JOiW6MWajfD+/9K3LusSonMMAAbD9FT32knai0d00YfmpLqLFu+yjTXm0lx/xKayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmOMbz1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45AAC4CEC4;
	Fri,  6 Sep 2024 22:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725663169;
	bh=NDnhJYHmPd2gD/xHsSON9t0iaghHfHefv1ORSmknexs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmOMbz1Yng608S7ZHV8nL7P33mP/I1cgtxwld3tlPtgBimMvyn/i3RrPZeskoiy1E
	 vbP8PjWpEdhJlckEfJgZDQL/5/W5FJ4ya1rKqx2TEJCI9QYLvVBzt9WA0rQ/+xggy0
	 gmtSIPLnVlirDUNqJeQK7gZzwmxwRAfxemJ31J/GThvr7ZrAs9Z8khggJhW9LKLb2d
	 aBXD+tcAHqvCEq7YGzxhE3mftg7/f5GsBiz5qnbOOYRCFUK9v9odrl7Eia4tnqH2mg
	 cSJ4Ubrqyy4D0ztFqQM6HLscdAeduk6jPItefUuZY+6Fh5cyalk6NzK93yuZn/z6eC
	 +w5Zm1Liu+wEA==
Date: Fri, 6 Sep 2024 22:52:47 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Wu Bo <bo.wu@vivo.com>, Wu Bo <wubo.oduw@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned sections
 if EAGAIN happens"
Message-ID: <ZtuHv9ZbCxLmzuZp@google.com>
References: <20240906083117.3648386-1-bo.wu@vivo.com>
 <d5505e7f-19db-44dd-8c3f-5b43cfff6b29@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5505e7f-19db-44dd-8c3f-5b43cfff6b29@kernel.org>

On 09/06, Chao Yu wrote:
> On 2024/9/6 16:31, Wu Bo wrote:
> > On Tue, Feb 20, 2024 at 02:50:11PM +0800, Chao Yu wrote:
> > > On 2024/2/8 16:11, Wu Bo wrote:
> > > > On 2024/2/5 11:54, Chao Yu wrote:
> > > > > How about calling f2fs_balance_fs() to double check and make sure there is
> > > > > enough free space for following allocation.
> > > > > 
> > > > >          if (has_not_enough_free_secs(sbi, 0,
> > > > >              GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
> > > > >              f2fs_down_write(&sbi->gc_lock);
> > > > >              stat_inc_gc_call_count(sbi, FOREGROUND);
> > > > >              err = f2fs_gc(sbi, &gc_control);
> > > > >              if (err == -EAGAIN)
> > > > >                  f2fs_balance_fs(sbi, true);
> > > > >              if (err && err != -ENODATA)
> > > > >                  goto out_err;
> > > > >          }
> > > > > 
> > > > > Thanks,
> > > > 
> > > > f2fs_balance_fs() here will not change procedure branch and may just trigger another GC.
> > > > 
> > > > I'm afraid this is a bit redundant.
> > > 
> > > Okay.
> > > 
> > > I guess maybe Jaegeuk has concern which is the reason to commit
> > > 2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN happens").
> > 
> > Hi Jaegeuk,
> > 
> > We occasionally receive user complaints about OTA failures caused by this issue.
> > Please consider merging this patch.

What about adding a retry logic here, as it's literally EAGAIN?

> 
> I'm fine w/ this patch, but one another quick fix will be triggering
> background GC via f2fs ioctl after fallocate() failure, once
> has_not_enough_free_secs(, ovp_segs) returns false, fallocate() will
> succeed.

> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
> > 
> > Thanks
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

