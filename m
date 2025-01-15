Return-Path: <stable+bounces-109122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C5A121F3
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E5188CEA8
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D51E7C30;
	Wed, 15 Jan 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+s7Rpjh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E228248BAA
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938931; cv=none; b=k4l8gJGrlIAdtLU05FS725zUN9qjxFr7BRbYYLDXXdzFD2EByuB7XIlH3Ipt5Jjphu96xJ5/XKw/jF3wfzQSfTYlTythBTZbLiI0owjqUG5Nll5yVhLuhSkRbfhe+q6Ww0vicwNyyrxH4pnpT9sku0x9qrSN/D5SVnpNpr8wPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938931; c=relaxed/simple;
	bh=bT3RFGqiYeZos8w42ZMCt5FNwvbDOHd2n6lnoGQGoOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSVNZcnMl9RknOo3QkRL5q/DlcAjeqmYpeIFKdIjrby9eCNtGn6EdgNgxdUr50banFSVNDf0Jv1jvNZ8qrY8+IeMQHoH+4r16/U224ZLYzpda5qPgKxhVHzMoZ9HC5vrzlScwwsXb2nsd8rc3NeQwQ9TgLKSuejhGKmBU++Q6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+s7Rpjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244CCC4CEDF;
	Wed, 15 Jan 2025 11:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938930;
	bh=bT3RFGqiYeZos8w42ZMCt5FNwvbDOHd2n6lnoGQGoOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+s7RpjhqFvXNYwdQHQYBvQ+0r6c84x2iMhcIaU96tDJ9A0EyS+ULd1fLFT2KBoAN
	 VkrPGCWbFRFmIrmsIJndbRAE0O7igrxX+S9eLRRaIhKR7iNaSGGb4oecuBb2MNtlSd
	 hy/PwQnba/KihqWgRHQOiYyn0TEk8xJ/yOZgwfcI=
Date: Wed, 15 Jan 2025 11:59:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: INV Git Commit <INV.git-commit@tdk.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Message-ID: <2025011515-perfume-bless-e2bb@gregkh>
References: <2025011346-empty-yoyo-e301@gregkh>
 <20250113124638.252974-1-inv.git-commit@tdk.com>
 <2025011500-unmixable-duplex-9261@gregkh>
 <FR3P281MB175777574467C382B07AAAF3CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR3P281MB175777574467C382B07AAAF3CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>

On Wed, Jan 15, 2025 at 10:50:31AM +0000, Jean-Baptiste Maneyrol wrote:
> Hello Greg,
> 
> beware that I messed up for the 1st versions of this backport, and then I sent v2 patches that are working correctly.
> You need to be careful to use only the v2 patch if there is one.

I don't see a v2 for this one :(


