Return-Path: <stable+bounces-94113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA39D3AB5
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975551F2170A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6719CC05;
	Wed, 20 Nov 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZDWqpiP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09071E481
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106148; cv=none; b=iJytrMI7j4PtB6KacUU7DJC2ZSHyCYw32aohJnHd8WlSmJ/FTUzswGKsAeIBNGJz5bh0UMg45DOVvFX2Ng6epksryFSsBG8YfJtRE6AJAyTksjx1tTvb19tpaB7Jf5Faca3sSj8LZI8zrJUodQCxTqJO9uPuH8oNc/boDF3LAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106148; c=relaxed/simple;
	bh=pAG7w2bh7DTWPIhhW2FUC1zTFdxj0qEiEkb6kt9uDu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAqCcJOZf1ubA++RdV2rs1HgZFuu3uigEhH3VTeFVL8GEPvnv90LOvR3ln1CMCVv0CM5G8jfgowfAShK/tha5pGg4fxzn3r047RDu839J8Xp5ipiW2g0VImIDayWTG4jc3w94ZYAlj3RnBuIxw8/8RFpS+lth+XQH2fxJcnsIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZDWqpiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E4C4CECD;
	Wed, 20 Nov 2024 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732106148;
	bh=pAG7w2bh7DTWPIhhW2FUC1zTFdxj0qEiEkb6kt9uDu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZDWqpiPqRcH31gUTrrL6xMxeknJ9tFjZsRyOmb3oo3kTMHl01SvWue8W4b+3PNVq
	 0VnYm6FHFxkFdeTA3KKX1QMkanzSGusEc98hkGQSj3EuiuT1N2JfSa6H5FxyuldPHI
	 tRcs+dDkNIEZQv3jSSdi41fJZ4rz/4wvkCEWFAI8=
Date: Wed, 20 Nov 2024 13:35:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: yukuai1@huaweicloud.com, christophe.jaillet@wanadoo.fr,
	yukuai3@huawei.com, dlemoal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 6.1.y 0/3] Backport to fix CVE-2024-36478
Message-ID: <2024112011-buffer-pantyhose-9be8@gregkh>
References: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>

On Wed, Nov 20, 2024 at 11:28:38AM +0800, Xiangyu Chen wrote:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
> 
> Backport to fix CVE-2024-36478
> 
> https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/
> 
> The CVE fix is "null_blk: fix null-ptr-dereference while configuring 'power'
> and 'submit_queues'" 
> 
> This required 2 extra commit to make sure the picks are clean:
> null_blk: Remove usage of the deprecated ida_simple_xx() API
> null_blk: Fix return value of nullb_device_power_store()
> 
> Changes:
> V1 -> V2
> Added the extra commit Fix return value of nullb_device_power_store()

Now queued up, thanks.

greg k-h

