Return-Path: <stable+bounces-191690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48544C1E69F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 06:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51143A6A35
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 05:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA75932C94A;
	Thu, 30 Oct 2025 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQgobIQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732E263C8F
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801987; cv=none; b=m+sBVg9vnFa3/PhXpdYtGAp7WQdEgUehM8Vl8HkL+Pw3IW372eOx/XVb7TztIkatDk5bVeaMNkU4sh6ebo1n516SeMghHIm0xYSt/XB448SB0BfkDPZ1Ch/BHZDYDYJ/wX8P0XTF8pz6A80MKsRN4erIaDKcoA+u1gF4JhKRn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801987; c=relaxed/simple;
	bh=VWkfvpTCJkwSiulr9ZbrMfjFmhvlMfeboi3ECsjUSQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlRNZ0ceBLjJVpOs/yu3QVJjXjFCnQWIGN25+0Nqe+6ra/7apYip9g6VV6yqZ3mMHjRK4jufzQzdctMm+ADahuq8vmFv9nDFh5C79TK0ebM7rN8rASQHh0FIIehs1y86VqyIHHBI8IqqXbRAk+ixjxt1CFbNWD6Dmq+vgCizHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQgobIQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5933C4CEF1;
	Thu, 30 Oct 2025 05:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761801987;
	bh=VWkfvpTCJkwSiulr9ZbrMfjFmhvlMfeboi3ECsjUSQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQgobIQO/kAuTsxpygxJ21oYlI1+soo2GqQTZ9UGECYSn/RfGxyPCXb2tfdAM8nuy
	 6Drr9jEkvezsg/+7kk7NT9GBnGoB4KGqupGLD98GXR1vzjO8dY1yHX7SfjEx+yevj/
	 P8iW7wL3XF50RFawlZ6Me8i8OwCtP+KZSF5YK0oc=
Date: Thu, 30 Oct 2025 06:26:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amelia Crate <acrate@waldn.net>
Cc: stable@vger.kernel.org, dimitri.ledkov@surgut.co.uk
Subject: Re: [PATCH 0/4] Backport CVE fixes to 6.12.y
Message-ID: <2025103043-refinish-preformed-280e@gregkh>
References: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>

On Wed, Oct 29, 2025 at 05:24:59PM -0500, Amelia Crate wrote:
> These patches backport the following upstream commits fixing CVEs to the Linux 6.12.y stable tree.
> 
> CVE-2025-21833 -> 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
> CVE-2025-37803 -> 021ba7f1babd ("udmabuf: fix a buf size overflow issue during udmabuf creation")
> CVE-2024-57995 -> 5a10971c7645 ("wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()")
> CVE-2025-37860 -> 8241ecec1cdc6 ("sfc: fix NULL dereferences in ef100_process_design_param()")
> 
> The following upstream commit applies cleanly to v6.12.y, please pick it up.
> 
> CVE-2024-58097 -> 16c6c35c03ea ("wifi: ath11k: fix RCU stall while reaping monitor destination ring")
> 
> 
> 

All of these seem to be attached (with full git headers?) and the
whitespace is corrupted and can not be applied at all :(

Can you resend these using something like git send-email which will fix
all of that up properly?

thanks,

greg k-h

