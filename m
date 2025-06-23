Return-Path: <stable+bounces-155296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DFDAE35B9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DFC1891825
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85117A2E6;
	Mon, 23 Jun 2025 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EF45KbtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5F2AE8E;
	Mon, 23 Jun 2025 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660239; cv=none; b=EnTvMl1iy7DLMj3DfO6Ww1SIIv357F1bBZrvT8d0o7qrFCOvgtM+acTsrmLPGXbEAMm+8TV+E5CF6NWbTHNwAgg63iRyrtabA5FXYtohbzCHkLGS1gpAA/P3RgEhLwwP7wWy2Ip/VBF5vzxjWVxkPBLC1k9nZdiLpuXrjxCoIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660239; c=relaxed/simple;
	bh=A5iAUiBwdryeGxjk6M1qBPxFtLwwMQblh3v/teSSJcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIdWJElqsoOa4ttntrIRiK5oJ140zurxUmcG5vh3GQXmXK8VP0pNdd5fsep+5/FNzqGG2YBk2QXpdpvVOEA8EsyNMsNxb2tMzhQhhiCyCDamzfJHPor/91xyRf5vbHhIZSRfyqRQFKsVtyi+I1rFL1Nm3kBGUm7w9dwT9RN796Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EF45KbtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB3C4CEED;
	Mon, 23 Jun 2025 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750660236;
	bh=A5iAUiBwdryeGxjk6M1qBPxFtLwwMQblh3v/teSSJcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EF45KbtYYt+IvmhslfGLh5cOtftlL8KaIAD+htW5MuV0s2h55atKVf5QJvLIOuBEk
	 VuSLQK3vAf+9I0shTUQlhSeOSoF34KS47Malmw3glQXlPFuysZeZqrjwnjsEDZnJjx
	 YwT9SHEMXy1DjLBFYkvWT7d4AtQTeIaUaS5xsSOw=
Date: Mon, 23 Jun 2025 08:30:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	yebin10@huawei.com, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Patch "arm64/cpuinfo: only show one cpu's info in c_show()" has
 been added to the 6.15-stable tree
Message-ID: <2025062323-fresh-plutonium-74a2@gregkh>
References: <20250620022800.2601874-1-sashal@kernel.org>
 <20250620101956.GB22514@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620101956.GB22514@willie-the-truck>

On Fri, Jun 20, 2025 at 11:19:56AM +0100, Will Deacon wrote:
> On Thu, Jun 19, 2025 at 10:28:00PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     arm64/cpuinfo: only show one cpu's info in c_show()
> > 
> > to the 6.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      arm64-cpuinfo-only-show-one-cpu-s-info-in-c_show.patch
> > and it can be found in the queue-6.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> I don't think this one needs to be backported.
> 

Now dropped from all queues, thanks.

greg k-h

