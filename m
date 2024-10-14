Return-Path: <stable+bounces-83762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962B99C5D0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC75285885
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC815666B;
	Mon, 14 Oct 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1L8IFVme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0215539F;
	Mon, 14 Oct 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898403; cv=none; b=bDYqoGSUVh0h2WftuX3+n1iFTes5ZtD+PEO2NZxmmQ+fs1VSU1A+q5/YmXpHmc//ufAuoBpeVSmWjwWbyCzs04IbmBYfnzqZ3pQ6CPPyvyedcqE050Ha5avuDviZzplwVF+d27aPp+AQptJKU1HqcJKJEh7Pt3i0IKZ34gZ56tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898403; c=relaxed/simple;
	bh=PevueDWCTWENvgN1GcSZmh97vbxUC5XVUaTwOml/4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7La8FjFcLYdtxhw8uqodceELXoTcGcWeL/4NcZPSoPZwkHE4tD7AiNrOC9fIi7y2z8Pkm9wE8y6cI83zUAErp1kLGj+fP/2CXDXV0fh2c7xJisvrVLZemuA1xwCB94CqoQJC05ySn8Y7nGy9RXpJuEJO6jclcNjZN7q/Wt5HWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1L8IFVme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3841BC4CEC3;
	Mon, 14 Oct 2024 09:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728898402;
	bh=PevueDWCTWENvgN1GcSZmh97vbxUC5XVUaTwOml/4UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1L8IFVmen4CzzhMmq8/BR0ddPGGFwe7lZkue02/0y4KGxjd9RHueND9+vCgWMzoVK
	 GLC4IuU4smnU2g0Yj59xBUbLgBEIVb8rRcj6rKZuZjO1WaQjeRH/mz/YAaGpMIpwCS
	 wE8u7fe+cAYFDFDTeXNnOjuZTxmw6WrY4rQWFlcc=
Date: Mon, 14 Oct 2024 11:33:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Erkun <yangerkun@huawei.com>
Subject: Re: Patch "Revert "mm/filemap: avoid buffered read/write race to
 read inconsistent data"" has been added to the 6.6-stable tree
Message-ID: <2024101411-easing-footprint-d770@gregkh>
References: <20241011001701.1645057-1-sashal@kernel.org>
 <886a1275-814d-4be9-9339-5118c7dc2819@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <886a1275-814d-4be9-9339-5118c7dc2819@huawei.com>

On Fri, Oct 11, 2024 at 09:44:42AM +0800, Baokun Li wrote:
> On 2024/10/11 8:17, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       revert-mm-filemap-avoid-buffered-read-write-race-to-.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> Hi Sasha,
> 
> The current patch is a cleanup after adding
> smp_load_acquire/store_release() to i_size_read/write().
> 
> In my opinion stable versions continue to use smp_rmb just fine,
> no need to backport the current patch to stable.
> 
> In addition, the current patch belongs to a patch set:
> 
>  https://lore.kernel.org/all/20240124142857.4146716-1-libaokun1@huawei.com/
> 
> If the current patch does need to be backported to stable, then the
> entire patch set needs to be backported or problems will be introduced.
> 
> All the patches in the patch set are listed below:
> 
>  d8f899d13d72 ("fs: make the i_size_read/write helpers be
> smp_load_acquire/store_release()")
>  4b944f8ef996 ("Revert "mm/filemap: avoid buffered read/write race to read
> inconsistent data"")
>  ad72872eb3ae ("asm-generic: remove extra type checking in acquire/release
> for non-SMP case")

Ok, now dropped, thanks

greg k-h

