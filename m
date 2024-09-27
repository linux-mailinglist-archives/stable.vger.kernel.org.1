Return-Path: <stable+bounces-78116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E434D9886BB
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF31F21CFC
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08C74BED;
	Fri, 27 Sep 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDPotEun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5C4D8DA
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446482; cv=none; b=GWapGx6YHIE+jDEgRz23U6VFW7Jgkg1EP/MDkrq+wMMxZzjaH0+mo2mTnKGsnzs2CPLHJPpvuOxVgw1VwZucOC0Dbr/zBCMdBE0g0rW4aC92j3lvTussFZEYsi3vQwlQpv9UM+alC4fD7Sck+DhmKvzJ2TvnUH+BGMfliuz3xVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446482; c=relaxed/simple;
	bh=5BlR4aWwssMWwdjeU3gar3jChwwD7DR4cYmaIk/HF3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PblKNdMhK5WeXi+eIUadOTyC+S8eVsCQHv+Alnlr6jrQZ4T0WAoATBG1/dQtPyOa7rJgD9BCSERD9Isxq8SDlyebMAgVZrPObE6x3HIu+Eni9TBLsk9xn9KyI7VXQoRM30GmuTKR274SHENu2K5oZEQd+nUGDVpi9FwYetzJcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDPotEun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C7DC4CEC4;
	Fri, 27 Sep 2024 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727446481;
	bh=5BlR4aWwssMWwdjeU3gar3jChwwD7DR4cYmaIk/HF3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XDPotEunbP5trkLfHcXGbpvoT8uE4nmXsiNg27Kqy4+6KRxCOi/GwoB/5N/dUgTAa
	 FGkRF51c+S3diKg5Yj/wqn7pWjaToL88NDkIlkahFDZGylgb/YSLfUkFhMYKMtdP3Q
	 Odqcf/2nfSF0NXozyxlS4kWYCfovLzWca9hq1vdrfYwGkfe31E3nFBix69Pp7NOzhw
	 x8Q6GWnOsEGRy4G6I11W1Z6NR83yu2DN2K7613l6Z2z93f6w3BZrgpxpr0ZzFcjCLo
	 udNJW2Vc6ZIqQRbn389guBoQUnAoqpqh7AO9aiSVZHry0P9l3js/tbA8UpqIxzYUlC
	 6zyDjpvzAykyw==
Message-ID: <652c0f61-450c-415f-9520-68cc596fabb0@kernel.org>
Date: Fri, 27 Sep 2024 09:14:40 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fix regression from "drm/amd/display: Fix MST BW calculation
 Regression"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <9c551c15-b23d-4911-99ee-352fad143295@kernel.org>
 <2024092752-taunt-pushing-7654@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2024092752-taunt-pushing-7654@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/2024 02:41, Greg KH wrote:
> On Mon, Sep 23, 2024 at 11:23:57PM -0500, Mario Limonciello wrote:
>> Hello,
>>
>> The commit 338567d17627 ("drm/amd/display: Fix MST BW calculation
>> Regression") caused a regression with some MST displays due to a mistake.
>>
>> For 6.11.y here is the series of commits that fixes it:
>>
>> commit 4599aef0c97b ("drm/amd/display: Fix Synaptics Cascaded Panamera DSC
>> Determination")
> 
> I don't see this commit in Linus's tree :(

Gah; sorry I have a lot of remotes and didn't realize which one I was on 
when regressing this.  Here's the right hashes.

4437936c6b69 ("drm/amd/display: Fix Synaptics Cascaded Panamera DSC 
Determination")

> 
>> commit ecc4038ec1de ("drm/amd/display: Add DSC Debug Log")
>> commit b2b4afb9cf07 ("drm/amdgpu/display: Fix a mistake in revert commit")
> 
> Nor either of these :(

commit 3715112c1b35 ("drm/amd/display: Add DSC Debug Log")
commit 7745a1dee0a6 ("drm/amdgpu/display: Fix a mistake in revert commit")

> 
>> Can you please bring them back to 6.11.y?
> 
> Are you sure you are looking at the right tree?
> 
> thanks,
> 
> greg k-h


