Return-Path: <stable+bounces-45620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040B8CCC4B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934F31F220F4
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBF13C3EB;
	Thu, 23 May 2024 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6xqYaw9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E201869
	for <stable@vger.kernel.org>; Thu, 23 May 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445976; cv=none; b=dRv86hj1GO9Nk/3eMLGufoV/dY/7XIz7nsnZcAy5zqaEZQB+cUJ6nmBkk6JRDxPQ9SkkV1xXsoI4gaOxLjwMjbozieNRGOz8bWZ1tUiVL8007KAuPPQfvX3iqonTfvPudWQuVwKP0noHvyvEg38pqDzolPn/aFfKNC2u14gfOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445976; c=relaxed/simple;
	bh=qID+yho+5GVt3FToKJhSXLl9BThzLJ4jY9PF85hqDKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkacVCfMAtwTp8pzCWGR2aaG2oKb/Gh9wuZapTMoU60XAV7M0J7lUNNOgLN5LFhfAQCNUyT2QGlCVLyN1mcqhxkalTOVwjavETpl74Kt+6vbdL7nHdYaLfhegA3gz9pYhY/Fn+318K/z0ImBY7HbC16MntsAMa0mfF9aX2jUoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6xqYaw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564BFC2BD10;
	Thu, 23 May 2024 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716445975;
	bh=qID+yho+5GVt3FToKJhSXLl9BThzLJ4jY9PF85hqDKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6xqYaw9Hm6RDkumSu7dHLcNXoo8ETkejD2JCEEQztpu5WvrhXhPS/tXkWuoxCD1m
	 sKyJnQYveBXux3RjqPsHxak3VWhZ/0FNny81lVmrLL8dZEIe3Pv1Q9i9BIDLm/M25j
	 tB1xL58DrmSWpFrQWdiHdosrgXCv+ZcOiMkrqR+Y=
Date: Thu, 23 May 2024 08:32:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: backport a patch for Linux kernel-5.15 kernel-6.1 kenrel-6.6
 stable tree
Message-ID: <2024052333-parasitic-impure-6d69@gregkh>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Thu, May 23, 2024 at 02:39:14AM +0000, Lin Gui (桂林) wrote:
> Hi reviewers,
> 
> Please help to backport this patch into kenrel-5.15 , kernel-6.1 , kernel-6.6 stable tree
> Thank you
> 
> 
> 
> https://patchwork.kernel.org/project/linux-mmc/patch/20231225093839.22931-2-mengqi.zhang@mediatek.com/
> 
> [v3,1/1] mmc: core: Add HS400 tuning in HS400es initialization
> Message ID	20231225093839.22931-2-mengqi.zhang@mediatek.com (mailing list archive)
> State	New
> Headers	show
> Series	mmc: core: Add HS400 tuning in HS400es initialization | expand
> Commit Message
> Mengqi ZhangDec. 25, 2023, 9:38 a.m. UTC
> During the initialization to HS400es stage, add hs400 tuning flow as an
> optional process. For Mediatek IP, HS00es mode requires a specific
> tuning to ensure the correct HS400 timing setting.
> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

What is the git id of it in Linus's tree?

thanks,

greg k-h

