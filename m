Return-Path: <stable+bounces-76178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADF979BC6
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116BE1F20FB1
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D31332A1;
	Mon, 16 Sep 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvUF430c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5A131BAF
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470171; cv=none; b=e7u2LZinUF8vV34KmawW4pScZFyCRrMoBQ+8DLEAHGYgQ1koi1vuLW4OemasjGVXsFiM8ZIxtVgRaLguqs6LNejhjTCnNj5uzucV1o3zOjspyPx7V73WekMEjh1i6wWQqOaiHubX/dDylfmxUPCbARwkZLDLWD2OWrVQB3Wph8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470171; c=relaxed/simple;
	bh=2xeH0G3E/fYTv4QIfZNlBOpPe+nhmbn1RmNdIb5dy7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmdS1KKVtuxiTTvD/HeuAkn8JvJtn42a+6fE1Tm0+5CKm/K9feDnDlSw5sVCMccsYmqwnK2yGpc/TzECcm4BvKQf090FT3P4urA5wU3CuCkrFbcGq1HXCEu+frcqZQPcZR7GRk50dEpRETYm8n67uePbonJP6VmLfqMmZfylaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvUF430c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF10C4CECD;
	Mon, 16 Sep 2024 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726470170;
	bh=2xeH0G3E/fYTv4QIfZNlBOpPe+nhmbn1RmNdIb5dy7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvUF430c7yJvJxrhIhC8CuH9OxS0Dl9pgvmNkvbuyiYp4Xkbwg8wt318NrVMTqKHp
	 6Ziq5nUdXgCUaGMAkjB0vW0YHpceO3dgnauwPxXIl4zQPONxG1aPivcYogvhM+bHQH
	 atanlPfMpHpxW9tMYvGJ230D47A/3mFhO7Rvy944=
Date: Mon, 16 Sep 2024 09:02:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: stable@vger.kernel.org, Xingyu Jin <xingyuj@google.com>,
	John Stultz <jstultz@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 5.10.y] dma-buf: heaps: Fix off-by-one in CMA heap fault
 handler
Message-ID: <2024091643-proved-financial-0bb5@gregkh>
References: <20240916043441.323792-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916043441.323792-1-tjmercier@google.com>

On Mon, Sep 16, 2024 at 04:34:41AM +0000, T.J. Mercier wrote:
> commit ea5ff5d351b520524019f7ff7f9ce418de2dad87 upstream.
> 
> Until VM_DONTEXPAND was added in commit 1c1914d6e8c6 ("dma-buf: heaps:
> Don't track CMA dma-buf pages under RssFile") it was possible to obtain
> a mapping larger than the buffer size via mremap and bypass the overflow
> check in dma_buf_mmap_internal. When using such a mapping to attempt to
> fault past the end of the buffer, the CMA heap fault handler also checks
> the fault offset against the buffer size, but gets the boundary wrong by
> 1. Fix the boundary check so that we don't read off the end of the pages
> array and insert an arbitrary page in the mapping.
> 
> Reported-by: Xingyu Jin <xingyuj@google.com>
> Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")

This commit is in 5.11, so why:

> Cc: stable@vger.kernel.org # Applicable >= 5.10. Needs adjustments only for 5.10.

does this say 5.10?

thanks,

greg k-h

