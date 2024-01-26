Return-Path: <stable+bounces-15839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEEF83D0DE
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 00:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0A61F2520A
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BF134A3;
	Thu, 25 Jan 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UN7Ij3xg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641310A39;
	Thu, 25 Jan 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706226265; cv=none; b=f5ujMM9EsHM4AMdDE0px+freL99vUn0Oy0i/YoT16ljiVc4LyXcgt2+hWkaEbPr333w6tJWfUFdnrQupUrpG7T+tvr6r0N1ajbg9kmqphm9PJmcTe7bq4F6e/EOHCh0VlaBTj8miu7DZ6M7AH1VCOr+tjhg2t+IsxyL/ruRybJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706226265; c=relaxed/simple;
	bh=qsZkhb1TJbQKFSsLAdZeTRpwTwKFmaB8eyBNamGPsok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqFwYh1g7bfKBuMMLyM5X1rkjyt8CqeAq4K0x3q8SlZYisrsKbsRvPVEftj1mXh5E7s7gVzns4TMbYcuUu8mtSPO/oRW1Oyel7WmSkMvJF3JAFWqSwrdZhuOPnCAbtJd6Z1FC8J7T/rmczaY73S139reY72ZPNJmvElQkDaDOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UN7Ij3xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E717DC433C7;
	Thu, 25 Jan 2024 23:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706226265;
	bh=qsZkhb1TJbQKFSsLAdZeTRpwTwKFmaB8eyBNamGPsok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UN7Ij3xgo35VMftSHf3Ry3w8cqk4N+ncSaUJ3oVBLG5si2XPapzGk56RyfP6sPRvj
	 j5jYT38ZOVPQr5vcPnLep8x1HdxZe8Lx/IR79rbLwQLchsssEzOb+MNRkfekwYALs6
	 qIYaNnVrAu+ZA7mOvORTwxuBdu1RBbChZbavgX1M=
Date: Thu, 25 Jan 2024 15:44:24 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/641] 6.7.2-rc1 review
Message-ID: <2024012503-issuing-getup-15d5@gregkh>
References: <20240122235818.091081209@linuxfoundation.org>
 <39467773-641e-4d14-90bb-d508b6c625e6@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39467773-641e-4d14-90bb-d508b6c625e6@hardfalcon.net>

On Tue, Jan 23, 2024 at 05:31:39PM +0100, Pascal Ernster wrote:
> It might be worth a thought to consider taking in the following patch for
> ath11k as well:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/
> 
> According to various reports, this seems to fix crashes related to ath11k
> that started with kernel 6.7:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218364
> 
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/18
> 
> I don't have any ath11k hardware to test/reproduce this, though.

When it is in Linus's tree, feel free to submit it for inclusion.

thanks,

greg k-h

