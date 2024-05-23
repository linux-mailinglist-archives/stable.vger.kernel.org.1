Return-Path: <stable+bounces-45647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC378CD0CC
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7291F2162C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3553144D12;
	Thu, 23 May 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PI+bj24U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32B144D03
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462112; cv=none; b=Jj5KUE2+9D+V3OZJpJNYrQP82uIPpM6EMOscgy8ST9U7eGs1dGBDN2N0IndHM9zwk2WQGm5a5qkfwi26eBw+mk3und0xlG2yA+3w34UY3PT30wmHul6kVb1D0r3jInxtT4sIMoceEnRRoJFro+KGIepZCLKieui0P77yuwiR61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462112; c=relaxed/simple;
	bh=/xj8Nt4/USIyq3bIDZbElwA4J4ekDtA5u6Q/llraNW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0s8+PU5MyWoZOItMwaL/b1axZRA32dZbj6doWpkuOtVeI7HYbYWr3dxZ/uGO/PlwcrKaPkafivgLE3vxzTrv7+wS/cJw+cPDaqQQKZegEBipcUDd8xVMOOv/22y1FxzPk7UKM+dQcnrOZ9nIqIxfhnH7CT5l7dg2lXI5ZcfyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PI+bj24U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478CEC4AF07;
	Thu, 23 May 2024 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716462111;
	bh=/xj8Nt4/USIyq3bIDZbElwA4J4ekDtA5u6Q/llraNW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PI+bj24UeaMzyR1s/yAIbRwawWzcNXJJHUQDVpJSw8Ra8Fe3C7vPzpvN0V9FiBBkD
	 DW+VWQMoqzU4pG5L+04+4wneN0hLwCHOz2vMzeJTQ09T+9nzCNzwVVEf9GlFIlKjX0
	 KOKAmyOFXSqGr23s3ImyfWgMxuG7qHhiz50T1MH8=
Date: Thu, 23 May 2024 13:01:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IGJhY2tw?= =?utf-8?Q?ort_?=
 =?utf-8?Q?a?= patch for Linux kernel-5.15 kernel-6.1 kenrel-6.6 stable tree
Message-ID: <2024052313-taste-diner-2d78@gregkh>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Thu, May 23, 2024 at 08:21:23AM +0000, Lin Gui (桂林) wrote:
> Dear  @Greg KH<mailto:gregkh@linuxfoundation.org>,
> 
> 
> I don't understand, why does this qualify as a stable patch?  The
> 
> changes says this is "optional", which means the device should work just
> 
> fine without it, right?
> 
> [MTK]
> 
> If without this patch, some emmc devices may cause unstable operation and report CRC errors.
> 
> 
> 
> Is this a regression fix from something that previously used to work
> 
> properly?
> [MTK]
> Yes

Ok, thanks.  But you need to provide a working, and tested, version of
it for 5.15.y as it obviously does not even work there (which means you
did not test that?)

greg k-h

