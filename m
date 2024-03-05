Return-Path: <stable+bounces-26875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43C8729EC
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 23:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A54A1C22B0D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4812D1E4;
	Tue,  5 Mar 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r9c/lOqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2112CDA8
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676263; cv=none; b=BBsbCz9COg+SvFjwO0vDomsvPma/XdN2UNUk0jWHYkQlsT6hVNlBH8v4ISlBzFM6xvC2AZAiFI/U4q8RxiMjiPaJjaYDjvh+thPQ2/HxICIWtCk80GOvW6OPlmOiIVpjuSoWKTpJT11LlthrbSibTt7ueuH5piQNhfMnXkzZz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676263; c=relaxed/simple;
	bh=L3SZf4E+sFtB7f5Dc3q1q/9Lmuv1XJiM/41dHY4DL2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1LXehCR3xv2TVOmcqypMs74VrGsiwKip5YkSOjQw68HWp5j25o8FWQZOKVEkl/s/Zec9mdpnAgZYzT6IpFsNy0DzcMFk0oP4AaFl6QvNJ/oc/tObiDjn4sb5E6DBJonvZ5oQ/If5+ZtpNMn+r6QA4ZXaT9t1SOP3baAWIrq7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r9c/lOqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9058C433F1;
	Tue,  5 Mar 2024 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709676263;
	bh=L3SZf4E+sFtB7f5Dc3q1q/9Lmuv1XJiM/41dHY4DL2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9c/lOqEosm+WvgbcB/0+xcT2IxBGo+BXC457mA+kVi7JKVLOuaa4eEKHoSTq6ITn
	 /bJbN+X3mmAaZ+msTKzzoZfPrSPJKu68MQieMrBqv3Y+h/hUQCqpGov6m+0wN36rRr
	 Xn+33pnNVXwL6w2rtTP1nMWNSVpMSlbcxZK7SEqM=
Date: Tue, 5 Mar 2024 22:04:19 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Message-ID: <2024030506-quotable-kerosene-6820@gregkh>
References: <20240305161313.90954-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305161313.90954-1-zi.yan@sent.com>

On Tue, Mar 05, 2024 at 11:13:13AM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> The tail pages in a THP can have swap entry information stored in their
> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h

