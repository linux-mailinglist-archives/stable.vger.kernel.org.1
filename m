Return-Path: <stable+bounces-108212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5854A098AE
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A503A2C61
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FC214232;
	Fri, 10 Jan 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyPnzk7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345B212B17;
	Fri, 10 Jan 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530710; cv=none; b=PMVY51L9tpePgSstiuBYFgI3cERcuULrqLj1VgAVAsYJH5+KaIGSEa1jcPMDWmbwrC9kcvlhnBki/XHdrTl5P+5lWDYqJMEJ/H02v6fOsxsrc2MGMIHYJGPZt2Vn6KYV+FI6BWW4AYcPl5UpLJjvlj5fAEA6WXpyeoA+w92/kaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530710; c=relaxed/simple;
	bh=Sh83PnEWnHDXBwVSqxmjLspOETkOihQ+AZ7/lgmMC2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg88mkL484smPi/GOPojD6YPxvngSg3raUi9cU7UNF1+kk11cwzJe+auXXOt5XiZBiPHNqW/8Oxqz/1IwO/b8L+cq1LnAa7ciGuunj6CVOoi4Hcur0VCVpKURz5CzoH2r7LUnV/VuLh0ovtTjhJXZ1EODJM1JAkh/21KGuRRRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyPnzk7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C7CC4CED6;
	Fri, 10 Jan 2025 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530709;
	bh=Sh83PnEWnHDXBwVSqxmjLspOETkOihQ+AZ7/lgmMC2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyPnzk7w4AicheOsXux1iyMjkYXV5FIm5Wm2KaCthQ/p3mATVgtykZ8opf0G7Sdna
	 PUaQOZ1dMPInjPS2P6KVDu8HatoT+njo77pZpUtN+8CdEpQTIJ/1ZY6odaoXjbQtNT
	 dpDCpcKCZJ4EgIMxZGsMxKMDVN8f0EFbnjMHKqrk3PUtqZxknCNCw3Vu49FlRal0YJ
	 os5KHe3jKYeHuThvBgSIE1Rr76ooEHiWmDXQUSjyA9SpZhk5DJxHq3l7JrGpXpiFUl
	 0y5t6cMRNFr5q8thgm+LbsYFS/jOv4DgAkcQLdjWaKWXCkjP5pa4BiAyZkTWgRcvbV
	 R1imBOKzuGf9g==
Date: Fri, 10 Jan 2025 11:38:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Maxime Ripard <mripard@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Saravana Kannan <saravanak@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Herrmann <andreas.herrmann@calxeda.com>,
	stable@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/14] of: Correct child specifier used as input of
 the 2nd nexus node
Message-ID: <173653070694.3215354.8498734202934097478.robh@kernel.org>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-1-db8a72415b8c@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-of_core_fix-v4-1-db8a72415b8c@quicinc.com>


On Thu, 09 Jan 2025 21:26:52 +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> API of_parse_phandle_with_args_map() will use wrong input for nexus node
> Nexus_2 as shown below:
> 
>     Node_1		Nexus_1                              Nexus_2
> &Nexus_1,arg_1 -> arg_1,&Nexus_2,arg_2' -> &Nexus_2,arg_2 -> arg_2,...
> 		  map-pass-thru=<...>
> 
> Nexus_1's output arg_2 should be used as input of Nexus_2, but the API
> wrongly uses arg_2' instead which != arg_2 due to Nexus_1's map-pass-thru.
> 
> Fix by always making @match_array point to @initial_match_array into
> which to store nexus output.
> 
> Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


