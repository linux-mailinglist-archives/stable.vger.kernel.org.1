Return-Path: <stable+bounces-25880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212186FF34
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6682B20DC2
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB536B02;
	Mon,  4 Mar 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PnmXNlM/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA91A29F;
	Mon,  4 Mar 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548759; cv=none; b=sAO5K/hajpKhxA2lzZVTXmSzAJSEKthmQCAjiQUKTX3j9pxuqj+wA3IduzRR2jBGO4LLIaBUorL+Gzao5AFwrIJqMutzIXzrqBHcvxk5/hVZYYeflOt5MRFqcBo0qSTokWo4HF4uy8gVAnE7l4UTWC/I5psG7fHZLMV5vVmUBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548759; c=relaxed/simple;
	bh=2VQrMI0lSi4o9IMgm0AsR/HEu9Plic859VxMRBDJ3EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzGS/6hvSrcBCWiF6aDKC4dxFWt4OiNrxuWkpVSH85Km9jUPE5fpp2zARqpamOc287zvbbfv/YcxPjzAkLKN+U0TF5YHCag2auWHOODdV0CoRWmTFp3AjKbl6MSZfTmMBLdfKLTC5tLl7OR0b+7J7MWGeurMV1cXAaYKemSGacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PnmXNlM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6DEC433C7;
	Mon,  4 Mar 2024 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709548758;
	bh=2VQrMI0lSi4o9IMgm0AsR/HEu9Plic859VxMRBDJ3EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnmXNlM/N99o6O2N5WRK8Dj5F/rRKEyEaCiAZAHeGVPsasxCydxdOEIOc32Y0gt1Y
	 NIm9cE7XsKcsVuC/oGQq8bs/SgPh93hWGRYG/na4owTygCaWXx4yG5+VpY6CslXBus
	 r0x7346A0SMElrS3A9/R1tnFj9WShizIezFDfrHI=
Date: Mon, 4 Mar 2024 11:39:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, patches@lists.linux.dev,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	David Howells <dhowells@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 4.19/5.4/5.10/5.15] cachefiles: fix memory leak in
 cachefiles_add_cache()
Message-ID: <2024030457-subsidy-brewery-0370@gregkh>
References: <20240227141606.1047435-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227141606.1047435-1-libaokun1@huawei.com>

On Tue, Feb 27, 2024 at 10:16:06PM +0800, Baokun Li wrote:
> commit e21a2f17566cbd64926fb8f16323972f7a064444 upstream.
> 

Now queued up, thanks.

greg k-h

