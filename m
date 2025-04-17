Return-Path: <stable+bounces-133104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81060A91E05
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D97B2E0B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8531150980;
	Thu, 17 Apr 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KTrU5L5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B27248887
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896416; cv=none; b=dkBU5IJ1ddYWuYr+3eCl3oY2j4STUM4E4GUl2qoQ79Vk5LoiVufSc8UdqrcpkpduF9fwwFSCzX5tJUk13ozn6gXXaSLH7MoNv1R+lSUwvz+G74nNIMqhH9W/wrrq5tWE//RQYfZFnJj+VrCCyyOkAIhMdQsN02glV/BMFYlj2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896416; c=relaxed/simple;
	bh=oHhmcBe0ZzwjEbK5epy2tfcRqln48zOlujv1YavE41g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kprc64u4pVv74Y39i+QSKBSlY8jm+oOF31zY2W9wUdXuc9AXWC+jy9GezD3um2xNJCTPlEwbTpLtXRxuzvUtzSbedlkB3hEEZTiHXXlc7RZlAZdLOFuRZ2k85kpsmc8Xo8rHB0eMyZt6/sSeoSyMAJH1eNgTVaHVqANx80kkF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KTrU5L5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8783AC4CEE4;
	Thu, 17 Apr 2025 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896416;
	bh=oHhmcBe0ZzwjEbK5epy2tfcRqln48zOlujv1YavE41g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTrU5L5Sfyl0Sh6uy3Sjc3Vo8pfNU1924K6iBemViMXIhvZU7c9gpdq6EWejpzmrd
	 N0izUI2XpeYqZazVkU6GylnFDMrqwP4p5iQOQLqmfysSv8Ts3aMNob2StS9BFMMKS3
	 fSOpTHtlw7gWahVA8bdSoTr8MZmV6GC390bQTQpc=
Date: Thu, 17 Apr 2025 15:18:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vulns 2/2] CVE-2024-36913: Fix affected versions
Message-ID: <2025041708-multitask-hammock-ba6a@gregkh>
References: <20250417113737.273764-1-zhe.he@windriver.com>
 <20250417113737.273764-2-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417113737.273764-2-zhe.he@windriver.com>

On Thu, Apr 17, 2025 at 07:37:37PM +0800, He Zhe wrote:
> Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  cve/published/2024/CVE-2024-36913.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2024/CVE-2024-36913.vulnerable

Same here, please provide some text.

thanks,

greg k-h

