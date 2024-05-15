Return-Path: <stable+bounces-45126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311F8C61A5
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79DB1F211C8
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD4433CE;
	Wed, 15 May 2024 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2qbAFRH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515941C6D
	for <stable@vger.kernel.org>; Wed, 15 May 2024 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757828; cv=none; b=m870D3pJNH5dUd3jrNLEawE+w39ylIWLnIM35KwaSufu4X6R2s4ok6bjEsO331e9N0bPgSrKrHjvgN2v5yXvJILUNiXEwTsCqIGwQDJDqplhVhnEfmLMyQg1LO9wbE8Nju2jNqmNyBN7IhLTEKJMx88pvxTGLZgSwXk2Le3+j8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757828; c=relaxed/simple;
	bh=t3odNi6Z57lyiatfCgoi5kGwyg3XEgM52cwjSqhSRtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvIVlW8MQl1GPaPxd6AnGc8P6od98/2Fal/Ddq4gFfO6ImWBoIReN3LdaUavCS4kjL/jFeJG66PJ7OtlMgzEcLZeHv/VNxk/OWKrdAlo7dSJjikRSnD/ch1t39Qbhk8zZhQ9O+EfkG38JDqwKkqpKsL/wFUfUP0zMR5iD2gTfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2qbAFRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1596C116B1;
	Wed, 15 May 2024 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715757828;
	bh=t3odNi6Z57lyiatfCgoi5kGwyg3XEgM52cwjSqhSRtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2qbAFRHKKotvMpTSnOTUxORdRNYBC+4RPBTlZaeblVqVd3JMIaxmi+TS5IHziPfO
	 x2oI4CUpigHtRIBKAU8fpiJlHqjrnUnB8EcwENuOzfR2jxDz77EuVJBf8OmNBWT6/X
	 meU09NnFDxeQ4rv1TU1tprtJfpJFVYpFOaf6CzJM=
Date: Wed, 15 May 2024 09:23:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-ID: <2024051534-extended-nemesis-853c@gregkh>
References: <2024042912-visibly-carpool-70bd@gregkh>
 <20240505070931.2537338-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505070931.2537338-1-linmiaohe@huawei.com>

On Sun, May 05, 2024 at 03:09:31PM +0800, Miaohe Lin wrote:
> When I did memory failure tests recently, below warning occurs:
> 

Both backports now queued up, thanks.

greg k-h

