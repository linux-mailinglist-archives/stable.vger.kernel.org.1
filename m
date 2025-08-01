Return-Path: <stable+bounces-165715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C440B17DC1
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CAC18840AA
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0A70805;
	Fri,  1 Aug 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qySnn6W8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183735280
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034085; cv=none; b=iwCGcbI0EQAK3W8SlAh7T7+BhaRnFKtCrUoA0aFMFADDvOq5s+MTkhj9/kW3TIg4y2lBw8Cq7+gXjf7762rZp8De5nNeekifLRHvEs5YBPY0DtsIjjPybN0gXF5L1gEBEyWPoABx8qpivF/iX8CH0AIjJm8VZEnqye51/0cxdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034085; c=relaxed/simple;
	bh=lbqAt85uQA1Br76zvT+Pz1Ztyr6cwykPB42rZnZ5hRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irnwlNgL7ublP6b/GVJqM9yzwqIglMu8CRU7N98Qo5fmFa58W/IZogNJEd03Th9f/P/drAu5EzgCxQqN0P2WL9lAK3M7YHq/zTYqzIMpJgb22bLaMmntbZJeZhZtIDRqt0cIL8phuSfJwyeNeCP5VbmXQg2oCmilhXoxbeZgREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qySnn6W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7BCC4CEE7;
	Fri,  1 Aug 2025 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754034084;
	bh=lbqAt85uQA1Br76zvT+Pz1Ztyr6cwykPB42rZnZ5hRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qySnn6W8o1GUqoopAb4M+kI47i9isitxyVan1XFOciJXocuXdOLnsnfNcnNZTC1oE
	 mL6plIolzsg0kKexkmRTGBXdlcQ8FLZBFoGzFOq48bz9ds1Vp9WgvuALcxFFtE88G0
	 7PnVTcXm5/ZvlpMrrozPCWFfIHBDAFRsUpi/wM4g=
Date: Fri, 1 Aug 2025 09:41:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Qingfeng Hao <qingfeng.hao@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org, zhe.he@windriver.com
Subject: Re: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
Message-ID: <2025080132-landlady-stilt-e9f2@gregkh>
References: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801040635.4190980-1-qingfeng.hao@windriver.com>

On Fri, Aug 01, 2025 at 12:06:34PM +0800, Qingfeng Hao wrote:
> There is a fix 17ba9cde11c2bfebbd70867b0a2ac4a22e573379
> introduced in v6.8 to fix the problem introduced by
> the original fix 66951d98d9bf45ba25acf37fe0747253fafdf298,
> and they together fix the CVE-2024-26661.

Those are two different things, shouldn't they get different CVE ids?

> Since this is the first time I submit the changes on vulns project,
> not sure if the changes in my patch are exact, @Greg, please point 
> out the problems if there are and I will fix them.

There's never a need to modify the .dyad or .json files (hint, you also
did not touch the .mbox file.)  they are all auto-generated from the
.sha1 file.

But again, I don't think this is correct, either this specific CVE is
not a CVE (i.e. it doesn't actually fix an issue), or we need to assign
another one, right?

thanks,

greg k-h

