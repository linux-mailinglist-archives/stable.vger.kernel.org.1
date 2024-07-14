Return-Path: <stable+bounces-59246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B187930A28
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2891C20FE9
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD70131736;
	Sun, 14 Jul 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKn2oM67"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA892BD18;
	Sun, 14 Jul 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964257; cv=none; b=GzuNqc3EUkOq37/9msRKWOro4qjZnyAZ8ptPADaEFoEco/4IOBX1bqbQPajG0JTNoywQnwon4WPRCKPIm1zAJzxnZeIfCRsvAdaoDPcX+YuCpEQSFC/Og2sYSHbWgpE9o7tqjQIdG00sLNjfvMcWlA6psKgr50v4yj8Pp2RqVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964257; c=relaxed/simple;
	bh=z+mWMW1uIm1g/5AeGYEToqR9Xv3/y+6lpKivZwSQdj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYJciJxv2U0PSaCqAfXKDwKasfb5xiZo6a/MGuxAcNXeGikInQ8UDu9YPIBKS+BdpC93VpFl9l/7P8IVIJd5mPNFYfBR0OmgbBv+3ztcB6/6gRyhLsgJgqvrWL6QK0w1X7jkhUdq0TTwh+nX3k93xkZn2q8E3fcHS+zkUskTYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKn2oM67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9F8C116B1;
	Sun, 14 Jul 2024 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720964256;
	bh=z+mWMW1uIm1g/5AeGYEToqR9Xv3/y+6lpKivZwSQdj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKn2oM670TIhRLnD2FOvtL+vyq5nnfCAtRx/qahHtx4yyUhZvL6ZHkvVEn8WPB7nJ
	 cm5zknz2/0A55Q2MhvHIeQT3/WCF2RlGrgs/7mlb+pAZcCw173g+ZThDO09HgiKeH1
	 gGaAIRGsB1s0XFE6B0NBLquugzpBmWihPdw1wh8M=
Date: Sun, 14 Jul 2024 15:37:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
	imunsie@au1.ibm.com, manoj@linux.vnet.ibm.com, mpe@ellerman.id.au,
	clombard@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <2024071459-obscurity-landlord-af08@gregkh>
References: <20240714121404.1385892-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714121404.1385892-1-make24@iscas.ac.cn>

On Sun, Jul 14, 2024 at 08:14:04PM +0800, Ma Ke wrote:
> In read_handle(), of_get_address() may return NULL which is later
> dereferenced. Fix this by adding NULL check.
> 
> Based on our customized static analysis tool, extract vulnerability
> features[1], then match similar vulnerability features in this function.

Please follow the documented rules for researchers submitting patches
based on non-public tools.

thanks,

greg k-h

