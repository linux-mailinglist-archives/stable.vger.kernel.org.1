Return-Path: <stable+bounces-40066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B35D8A7CA2
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CEA281F1B
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830B36A00C;
	Wed, 17 Apr 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yXH4L4t6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E39524BC
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337131; cv=none; b=E2eiEZvwoLbkV+MpDtHnTLcn6/Fy6lbBERIkuzaGAAzCrwkuTB40YPywfGJ2lUv7By9YhUSDqe3VXyR4EUVmzyOoaN00vpXurZ3SvOXQCllGno1KJ6//Wl57iLjTAm2/zuT27Ei1jHZ1IgjnWIz3aTzi1vpTs6N106q+w5R5MCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337131; c=relaxed/simple;
	bh=MC1rXYA+mDomXB515BLDqfFnJVbs9j2JoDG4MzHpeRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzY+blmulMccx1hSBflTqAGXGP+ESOTVhkM3G35uUxHiWaAi9ENnjUxL3PUyyCPj1lmBHlxF77t+Q1swxFDQOEeFlpecbM+eWGhNR/qCXjOLGmgAEeoj6toMCujpn+zxcBwqNqE7uZIWDqbjP8TuBNMJa9Rd2JyLNJktESZJLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yXH4L4t6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0171DC072AA;
	Wed, 17 Apr 2024 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713337130;
	bh=MC1rXYA+mDomXB515BLDqfFnJVbs9j2JoDG4MzHpeRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yXH4L4t6B+Fj3VmVc3XVSBvQlLyVSSAQGC043ae714yMTxdBy/pbKYGvrxdsPP8uD
	 GaYiBmR+4Ah8WYjkllepaPMf+i1EPhZW3Xi94qzb1tkoT3rHPbcT4qHdsQ7XLgHe/p
	 ZrDqxzpsV4SzPSMccDR1KaSeBpbsBvjGOD5Cz8M8=
Date: Wed, 17 Apr 2024 08:58:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Chuan Chen =?utf-8?B?KOmZiOW3nSk=?= <chuan.chen@mediatek.com>,
	Yugang Wang =?utf-8?B?KOeOi+eOieWImik=?= <Yugang.Wang@mediatek.com>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Request] backport a mainline patch to Linux kernel-5.10 stable
 tree
Message-ID: <2024041757-evasion-calibrate-f424@gregkh>
References: <SEYPR03MB65312F905CF0A33DC5FB8189940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
 <SEYPR03MB65312AE2FBA8DE870C96A525940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR03MB65312AE2FBA8DE870C96A525940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>

On Wed, Apr 17, 2024 at 06:45:19AM +0000, Bo Ye (叶波) wrote:
> Dear Reviewers,
> 
> we suggest to backport a commit to Linux kernel-5.10 stable tree to fix thermal bug. Thanks a lot
> 
> source patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/thermal/thermal_core.c?h=v6.8&id=4e814173a8c4f432fd068b1c796f0416328c9d99
> thermal: core: Fix thermal zone suspend-resume synchronization
> There are 3 synchronization issues with thermal zone suspend-resume
> during system-wide transitions:

Please provide a working backport of this commit to the 5.10 and newer
kernels and we will be glad to review it for inclusion.  Please note
that we can not take a change for only an older kernel and not a newer
one, otherwise you would have a regression when moving to a new release.

thanks,

greg k-h

