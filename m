Return-Path: <stable+bounces-12323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE758354C4
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 07:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044D41C20BAD
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30126ADF;
	Sun, 21 Jan 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="02jtSHgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD114A92;
	Sun, 21 Jan 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705820246; cv=none; b=l6GWTAGic+RoKAp1lP6g//sXRTArmaPz2Qj+QMTJab+ZS3sCqzjMBQVssMj8/JBV+SXbrdddVM/gEp2M0IB2mh4kEMs50/BvfxMqcp+HiCErfLjiguldEJaoXWiXVhiArr2UW+v1MdhoO1KRxa2BTMKrQd7kr03BpXaB6X2P66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705820246; c=relaxed/simple;
	bh=57xpb1++fJWeW1IgKH6gXgal2Y5y4mdwp/UsvyIUzaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxyKizH32nxdZTIG7LRbkR0MCZm9ibh3hjGTDeGe3vFwtaawmti8ZdUpw+DEvKUE8bJlTSoIG9Z6Ffr4S6rSo7ZZoUW665zncg3L28p/C5wYzb0rlIKAr5xYouSvhTylUcr9chzFa2Wa5Ci1zDImydPTQj5KU0dfZgappZOhvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=02jtSHgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DBC433C7;
	Sun, 21 Jan 2024 06:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705820245;
	bh=57xpb1++fJWeW1IgKH6gXgal2Y5y4mdwp/UsvyIUzaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=02jtSHgpnlIjf9gZRHoADozEFd1gMq100hZQmG5T9FbEs0a2BQOKMv1x7VC3k1Hng
	 QnrNDwZsDPqjumZAsU1v/KEP+czhzXw2VnMO2ktbfcubMgOxmpEJkFNwB+H2AkVbyt
	 uCMvx7T9mHk3RFt73LE1PZJMA39nn4kar6WM3Gdk=
Date: Sun, 21 Jan 2024 07:57:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joe Perches <joe@perches.com>
Cc: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Subject: Re: Patch "rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift" has
 been added to the 5.4-stable tree
Message-ID: <2024012154-manned-food-60c6@gregkh>
References: <20240121014845.662779-1-sashal@kernel.org>
 <b28a42964abc1d67ce7d03d9660e855dc00622b4.camel@perches.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28a42964abc1d67ce7d03d9660e855dc00622b4.camel@perches.com>

On Sat, Jan 20, 2024 at 06:33:46PM -0800, Joe Perches wrote:
> On Sat, 2024-01-20 at 20:48 -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift
> 
> Why?  There's no change in behavior.
> Not a candidate for stable IMO.
> Same for 4.19.

Because of:

> >     Stable-dep-of: bc8263083af6 ("wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior")

It's needed for a later commit.

thanks,

greg k-h

