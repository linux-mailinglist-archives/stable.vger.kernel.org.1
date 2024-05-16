Return-Path: <stable+bounces-45248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0DE8C71BB
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11D81C20E08
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C02562E;
	Thu, 16 May 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5YKHey3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9162C848
	for <stable@vger.kernel.org>; Thu, 16 May 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715842474; cv=none; b=kdST1IjGLEhuV9eHDJGqk85Z660zhM1xsUxtRvKZQPh0RhIl6L0J833ME81NKS6NHrOAtCs2PsssVwSVmmxUChxmszvnavGF7fbXLnAy5lAn2gCS7jnLypOcMeoKuPJmF5kXzK3GcEiM54hRQjWQsBldn8Rm7F2EsqUtMQ0iHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715842474; c=relaxed/simple;
	bh=eevpH/zOJcYpssNyQa2qnS74gs5CzKSGjnzwZZrS6us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbgSFprDcbnPXD32AFCbG9lsdSznkKkMFS29i+pLIkAEWoOGaPg80dRF3MdnaSBy3PD9nuNqMv4COJ3T/fsmi6W6ZYMl7vcHTVpp1KwvOMpaEUtBTdaeBv8jg0vm8haX38PzBX2Ml1wZPbLHP3CqRROwrInJFIAn03SR0bq44cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5YKHey3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF2EC113CC;
	Thu, 16 May 2024 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715842474;
	bh=eevpH/zOJcYpssNyQa2qnS74gs5CzKSGjnzwZZrS6us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5YKHey3BEPtbuXiZaWYFLW+esChLni5UbzSK9YNaaYCynIfRCZIBdiYEcxPaxqtu
	 dLL/iJGYa5koUnsaEp+tGnc6EJZxvspEHuYbwdTm/3CRgX5wAlbfIMYidBaMBVT/J2
	 TdqNM0k+ZFNDP1DC6OT0i1mqKK04MBzQq2jbBpCM=
Date: Thu, 16 May 2024 08:54:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Bongio <jbongio@google.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
Message-ID: <2024051632-qualifier-delta-f626@gregkh>
References: <20240513233058.885052-1-jbongio@google.com>
 <2024051523-precision-rosy-eac3@gregkh>
 <CAOvQCn5LEhFw8njxO7oa9Q_Ku3b7UEEmJUAqPw9aTO3Gu90kRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvQCn5LEhFw8njxO7oa9Q_Ku3b7UEEmJUAqPw9aTO3Gu90kRg@mail.gmail.com>


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, May 15, 2024 at 09:31:07AM -0700, Jeremy Bongio wrote:
> 5.4 doesn't have "mddev_destroy_serial_pool" ... More work would be
> needed to figure out if the vulnerability exists and how to fix it.

Can you do that please?  I know Google still cares about 5.4 kernel
trees :)

> The patch also applies to 5.15, but I haven't tested it.

I took it there as we can't take a patch for an older kernel and not a
newer one, as that would cause a regression when people upgrade.

thanks,

greg k-h

