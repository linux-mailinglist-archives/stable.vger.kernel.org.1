Return-Path: <stable+bounces-58991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C392D008
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF6B287F7
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CDF18FC74;
	Wed, 10 Jul 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vs7EktCw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A318FC68;
	Wed, 10 Jul 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609196; cv=none; b=QsklPa5oAu1r9xDKmkRDdjmseQq0rV7Ij5aFUIb7/P+Hcn7AwbUdxie2ZWNsSXLdpqhmFvqcDPHU0vUE0IWa+OZCPOx2bjcdr0Mp+51QkWU6+G00a/pgHjskfUYfqR8jVp0IVeSqk/7F/RnCMFHgX7tQpgDVKRLHB5XLcOrGXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609196; c=relaxed/simple;
	bh=tMlH2OXPei8W8GzXahYFQG62CK2hv/8deu1RpFRVkQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGUZlRItUIzIQ6PEZ2W6VgNN1zDQ1EnWRhKSI2/KA50Q3KO2YEdhKZLDof+TOSto2Xs24z1QH9G8n3ZoSU+EXoX3yCFhMe6IhMsCNB95UQToQ/bpQGkLcSIjIj3F0QB3cvtFaXCJJBVH+bo8xltHkV3X8b0vgoT9pSHSY2QugPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vs7EktCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2B7C32781;
	Wed, 10 Jul 2024 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720609195;
	bh=tMlH2OXPei8W8GzXahYFQG62CK2hv/8deu1RpFRVkQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vs7EktCw5xixb1VI8uPyOFQ5RZ5h9SwZLocBQYn4biVvtXivY7g9JLO47g2yilUR7
	 uPkjdKXUJOWoDjQUSi5JHf2z3662Hgaeutmb89CXo5Cs/iTYjHymDz1e5RFeJIQ2jN
	 FgG0BoZegT2J09e2QEQfoTtJQA/w/BjFUvzeEt2s=
Date: Wed, 10 Jul 2024 12:59:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
	clombard@linux.vnet.ibm.com, imunsie@au1.ibm.com,
	mpe@ellerman.id.au, manoj@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <2024071052-squad-glorify-0830@gregkh>
References: <20240710103352.1890726-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710103352.1890726-1-make24@iscas.ac.cn>

On Wed, Jul 10, 2024 at 06:33:52PM +0800, Ma Ke wrote:
> In read_handle(), of_get_address() may return NULL which is later
> dereferenced. Fix this by adding NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - The potential vulnerability was discovered as follows: based on our 
> customized static analysis tool, extract vulnerability features[1], and 
> then match similar vulnerability features in this function.

You need to follow the rules outlined in
Documentation/process/researcher-guidelines.rst when doing stuff like
this.  Otherwise all of your patches will have to be rejected.

Please fix up the changelog text of all of the patches you have
submitted recently to follow those rules.

thanks,

greg k-h

