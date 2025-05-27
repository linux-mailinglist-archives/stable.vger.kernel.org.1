Return-Path: <stable+bounces-146452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64EBAC5187
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785AE189DD43
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2E279798;
	Tue, 27 May 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xeiUWq0o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE1126C02;
	Tue, 27 May 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358243; cv=none; b=U++191o5IESlCGyuZ/1DoTbOW8GwNq56zcZfPQE2+Kv6ja7jsmIGGckkYaaG2V3Pt5K7r4//5TMVg69DscPuaZiuaNA0hQ2A4ITeK85KUCimJQlKL6nPT5NJ/mLjT24/cCAyPyl8XIxoZPWMdVSOJXKS3ed+UsCxmZBc+kY4jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358243; c=relaxed/simple;
	bh=aw3PU0r/ne5shVw+oqWV32Eq2M+t7QqvzxmjVoePFaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNIH3zjjzGt0aTyOwClKvd/+YTL3fNZ2nCNFqDzYk1YB2w3kUL1iwwjdF1u0J3SrRRZLZxCrQtNG45r2OdnvMmsr2gg2JoK1sIQr8STuT9pLEy77IL+RoMjWrHbo+WQnGxuKT/1Ax54Z0C/BKqB1ISAPKGo/T3INiwcAj5aT+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xeiUWq0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30781C4CEEF;
	Tue, 27 May 2025 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748358242;
	bh=aw3PU0r/ne5shVw+oqWV32Eq2M+t7QqvzxmjVoePFaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xeiUWq0oN5+P0CrxaatEjqm8V2Z+o5InWcnEOla4gijKlm1hN9165Jbq4OK/n5qbD
	 tKUZVqyf+hIzKCI20AtbKbVwMv46E8lOWz7ouldCAHPLf4hacGRZ80KuVpHHvG4k8k
	 JIUuEjPsPAxXr0LdMI4Brr4Y7LwRKG9pTnXjqrro=
Date: Tue, 27 May 2025 17:03:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Qu Wenruo <wqu@suse.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: properly limit inline data extent according to
 block size" has been added to the 6.12-stable tree
Message-ID: <2025052752-untwist-overuse-2db4@gregkh>
References: <20250522220136.3171868-1-sashal@kernel.org>
 <872d4847-9092-4b9e-a7d6-5c2bae8e1cbf@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <872d4847-9092-4b9e-a7d6-5c2bae8e1cbf@suse.com>

On Fri, May 23, 2025 at 08:17:45AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/23 07:31, Sasha Levin 写道:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      btrfs: properly limit inline data extent according to block size
> > 
> > to the 6.12-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       btrfs-properly-limit-inline-data-extent-according-to.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this patch from all stable trees.
> 
> This is only for a debug feature, 2K block size, and it will never be
> exposed to end users (only to allow people without a 64K page sized system
> to test subpage routine on x86_64).

Now dropped, thanks.

greg k-h

