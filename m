Return-Path: <stable+bounces-56332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB83923944
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA276284626
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654D1591EA;
	Tue,  2 Jul 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qLLD9ify"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DB152E13
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911422; cv=none; b=I+RYja4ogbN+4ubS12v6FpaklcMoh1sHOlap2wKUiXbhAKnzLiguhcJTKLqnmrNJ1bEIhOgHv5vHtjOnRyOrPx98RVG8Dni6D8zsB2sH2SgNh/yOpQJN2jVCrgIQHAFTQLjN7Q1sGRivahI+yeGxRMyStAXhlsH9YVc5e8jtkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911422; c=relaxed/simple;
	bh=dPKfDFIfF8WOCfJLDobvzAxFeEC6zXekcNn+FgKXTwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c53umsggGGeLq9CUJXknIDsX57EZEe8OeZdwrFLuhUBYusNq2fkXbdXn8hSBX71GeUsNwbU0Ugsjmk+hUo2KDZNfRLiZvvSzwE4fr0X3ueCmqy34mX9/19tSRZOzDeAyDxv7igWnI6AjHf4M/fVf+LDMm9b8bfxv4cZTiPeBLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qLLD9ify; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D7C4AF0C;
	Tue,  2 Jul 2024 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719911421;
	bh=dPKfDFIfF8WOCfJLDobvzAxFeEC6zXekcNn+FgKXTwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLLD9ifyefeOv4JnXOBjrhbGXj1a8lIclJy8MAkBiouWFoc4uEYz0iKMY/l9viIw/
	 /JpyReEf+TA444VeVgeLuPGNTI9MarilFH0PHkfy6VIvurCwFjVTU+n4hxRLzyJpKz
	 QcNJlUIARFrzDb4rwhQbFhUfE8+pyhQK1KdmDo3I=
Date: Tue, 2 Jul 2024 11:10:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5.4/5.10/5.15] nfs: Leave pages in the pagecache if
 readpage failed
Message-ID: <2024070209-angles-rejoin-afe7@gregkh>
References: <20240626184614.80363-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626184614.80363-1-kuniyu@amazon.com>

On Wed, Jun 26, 2024 at 11:46:14AM -0700, Kuniyuki Iwashima wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> commit 0b768a9610c6de9811c6d33900bebfb665192ee1 upstream
> 
> The pagecache handles readpage failing by itself; it doesn't want
> filesystems to remove pages from under it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> When NFS server returns NFS4ERR_SERVERFAULT, the client returned
> Remote I/O error immediately on 4.14 and 6.1, but on 5.4/5.10/5.15,
> the client retries forever and get stuck until userspace aborts it.
> 
> The patch fixed the issue but did not have Fixes: tag.
> 
> Please backport this to 5.4/5.10/5.15.

Now queued up, thanks.

greg k-h

