Return-Path: <stable+bounces-93083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769059CD68D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9CF1F22E0D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839128EF;
	Fri, 15 Nov 2024 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FO25gPla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA54156C4D
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648107; cv=none; b=uBwQxM5Xqb6/SMOTwK2l+MFLPfB1rqSgA+laIUxmj1t27nek0RmHVUmKXzUcjvEJD1yvKviv4J5vVpkHx52qvuhGOYng4O23JXYVW1qGifUX2gVe7EgZUyxoa89DcGcftyhQT3+6d9XqZWG2ZIBP4ceRV3xWwu+5M23J9O9fZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648107; c=relaxed/simple;
	bh=nWfKYXIkRyNz6I4dQuQMY+zWf5w9ofOardnmZW3wO20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5YfbKuG0x6eLhGSQgZsHN11zMEF2aT1tWCCRPZyTBL8hAjm0aDz2JWXLAfmydy/3Tr0BUKbWlQ2X2j/M1wa7ksMnhVfLQ0sOzDBUM5T64WT39pMgIR3Adj2wkcxZIptrri3b3BMZt31FLyZZurmCv1Gyrzcu/IExv5spI2SiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FO25gPla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27169C4CECF;
	Fri, 15 Nov 2024 05:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731648107;
	bh=nWfKYXIkRyNz6I4dQuQMY+zWf5w9ofOardnmZW3wO20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FO25gPlaZKb39fQqcVEJyvEOgGRLl6oitHWDOzHkZCBFy+6csHr40UUFwW6eO071X
	 A//7uA4ZZQ/QY/FdHBBjVswNIAQz8nK6GkdkaYMcD/1o3+M9Okil+Ang61Bt7TJ0j/
	 A42E4j33grZVDw8alJaO1DEPlYVU7CMOG6qva/0s=
Date: Fri, 15 Nov 2024 06:21:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org, jack@suse.com
Subject: Re: [PATCH stable 5.15 0/2] backport: udf: Allocate name buffer in
 directory iterator on heap
Message-ID: <2024111539-mandolin-astonish-8414@gregkh>
References: <20241114212657.306989-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114212657.306989-1-hauke@hauke-m.de>

On Thu, Nov 14, 2024 at 10:26:55PM +0100, Hauke Mehrtens wrote:
> I am running into this compile error with Linux kernel 5.15.171 in OpenWrt on 32 bit systems.
> ```
> fs/udf/namei.c: In function 'udf_rename':
> fs/udf/namei.c:878:1: error: the frame size of 1144 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>   878 | }
>       | ^
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:289: fs/udf/namei.o] Error 1
> make[1]: *** [scripts/Makefile.build:552: fs/udf] Error 2
> ``` 
> 
> This problem was introduced with kernel 5.15.169.
> The first patch needs an extra linux/slab.h include on x86, which is the only modification I did to it compared to the upstream version.
> 
> These patches should go into 5.15. They were already backported to kernel 6.1.
> 
> Jan Kara (2):
>   udf: Allocate name buffer in directory iterator on heap
>   udf: Avoid directory type conversion failure due to ENOMEM
> 
>  fs/udf/directory.c | 27 +++++++++++++++++++--------
>  fs/udf/udfdecl.h   |  2 +-
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> -- 
> 2.47.0
> 
> 

Now queued up, thanks.
greg k-h

