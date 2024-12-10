Return-Path: <stable+bounces-100427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2759EB1F9
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56432894C9
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFB1A08A0;
	Tue, 10 Dec 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YHS3OaUl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF419DF4B
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837635; cv=none; b=naDnqqG44cGwmT1HhpH12OmoiMLit9rHOxM80oWdB5ANFWvocuftfEpiDCxeFRdvjk1lPYWBCMzdI5x4AUD11BI2ABmQuK07jtFa6WJd67ctaoTGALxDWt4IRCDfLVWxLu+PxZNDiyL1O8Td1UUJFDMyu180xTInll9uHMLK2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837635; c=relaxed/simple;
	bh=SYXhlGse1JSpf3XwBHZlTZpk6+f3NMNeWVe1DMgbWiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbJwaJwFftaVPg6RN+oeAM0s6L+1vJDKXjBWOJRpvIN8tSZwAOobHi8Sk1C8rALQMlqpq0SoVrpkXZVWhkjLgT8aDwqylEc43getgz1Sko6DQDfm7CSlyN4LZNEqjDaXBp2eSghn+zOzhx3AYQ5D0ZwhX2hnF+7ZXRFpBVX+Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YHS3OaUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B60C4CED6;
	Tue, 10 Dec 2024 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733837635;
	bh=SYXhlGse1JSpf3XwBHZlTZpk6+f3NMNeWVe1DMgbWiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHS3OaUlEaFeLbidEOIGl2B4ftaIb6tbjPqEKhqzcQMX6CvsxSgUg8v+9czMODuA2
	 nxGG5J68PiJZPc1Kz2KUAr4O4IuL5qun6WkDKnf4m86bA2OGTfJVFyJzxbkWAf+gtV
	 prvJVTrE2D2nhusVWGLH25Eajbr2Tgf17YInspys=
Date: Tue, 10 Dec 2024 14:33:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bilge Aydin <b.aydin@samsung.com>
Cc: stable@vger.kernel.org
Subject: Re: [APS-24624] Missing patch in K5.15 against kernel panic
Message-ID: <2024121044-coronary-slacker-cf53@gregkh>
References: <CGME20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa@eucas1p2.samsung.com>
 <0bd701db4b06$b7cbdf00$27639d00$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd701db4b06$b7cbdf00$27639d00$@samsung.com>

On Tue, Dec 10, 2024 at 02:23:35PM +0100, Bilge Aydin wrote:
> Dear Linux community,
> 
> I am leading a project at Samsung where we utilized your kernel 5.15 in our system. Recently we faced an important kernel panic issue whose fix must be following patch:
> https://lore.kernel.org/all/1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com/
> 
> The problem for us is that this patch must be available from kernel 6.1 onwards. 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/iommu/iommu.c?h=v6.1.119 
> Clear to us is that it is not integrated into K5.15 yet: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/iommu/iommu.c?h=v5.15.173 
> 
> On the other side we can see that this patch was already applied to Android Common Kernel android13-5.15  https://android-review.googlesource.com/q/I51dbcdc5dc536b0e69c6187b2d7ac6a2031a305b. In particular, we can see the same implementation in the recent ACK release https://android.googlesource.com/kernel/common/+/refs/tags/android13-5.15-2024-11_r2/drivers/iommu/iommu.c  given on https://source.android.com/docs/core/architecture/kernel/gki-android13-5_15-release-builds 
> 
> Do you have any plan to adjust your implementation in drivers/iommu/iommu.c in K5.15 as present in K6.1? If not, since the issue in our project is very critical for us, may I ask you kindly to trigger the sync of K5.15 and K6.1 soon?

If you wish for a commit to be backported to the stable kernels, just
ask us, and better yet, provide a working patch to do so.

The reason we did NOT backport this specific commit is that it is marked
as a fix for a commit that shows up in the 6.1 release, so why would it
be applicable to 5.15.y at all?  So why do you feel it is required in
5.15.y?  (Note, we have no idea why it's in an Android kernel tree,
perhaps they have the offending commit in there as well so the backport
is required?  Have you checked?)

If you need or want it applied to older kernels, please send us a
working patch and we will be glad to take it.

thanks,

greg k-h

