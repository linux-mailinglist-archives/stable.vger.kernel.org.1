Return-Path: <stable+bounces-73162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8E96D36A
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F9C1F2A339
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044319415D;
	Thu,  5 Sep 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1M5mQR/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C515574C;
	Thu,  5 Sep 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528829; cv=none; b=CxAHia0IpY5yRl+Uj4Y4m9O45AOnZfYDQxZRZbNTqmwI+/NNOmwdaaETAi9lDqJSbVnpvJfSVieDYDnF0EiSQpH3HksPrp4kHh/GDNTVIgxM21nA1c0TgYdHAGTkxRu0JlYFDxTduvYarkgRnBfS7iWQR4fymfME22RyM4B7MsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528829; c=relaxed/simple;
	bh=0zbUrqxcFwgYV4pY95B5ZDbHuiUncD2IKxLKl2pUCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=artLisc8F6D+jEJ74g90dDxTOff8kRDCy07dP8v3c+i0ZHquOqTm7D9yUF8qQ9iqHNI/LBuUB+ZBkF/M64rOu8+utfojW0RhnuH04CnBGfT/7/GZO6tZDd+H/suAT7Y/8znwFpPb7nf0bDFQ1hcZjTJW/DyJn/s46zhB/6QmHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1M5mQR/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BD7C4CEC3;
	Thu,  5 Sep 2024 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725528829;
	bh=0zbUrqxcFwgYV4pY95B5ZDbHuiUncD2IKxLKl2pUCzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1M5mQR/anaMYaFZVSpSKSj02w8VnC+kaEWkFrT4wmONtIKdAUTxBCisiGB/qWRFyh
	 BzmrLQMJRAl8eXcqIguYL3AVm69NLajZO7sGJqgqaqN7RUKp9Iw2+NatKvCrb5jvPb
	 QSHgvNtYgWKvKHgQc/R13aYKsxc0FEfICq3uRa2I=
Date: Thu, 5 Sep 2024 11:33:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: validate event numbers
Message-ID: <2024090556-skewed-factoid-250c@gregkh>
References: <2024083026-attire-hassle-e670@gregkh>
 <20240904111338.4095848-2-matttbe@kernel.org>
 <2024090420-passivism-garage-f753@gregkh>
 <fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org>

On Wed, Sep 04, 2024 at 05:20:59PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 04/09/2024 16:38, Greg KH wrote:
> > On Wed, Sep 04, 2024 at 01:13:39PM +0200, Matthieu Baerts (NGI0) wrote:
> >> commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.
> >>
> > 
> > This did not apply either.
> > 
> > I think I've gone through all of the 6.1 patches now.  If I've missed
> > anything, please let me know.
> It looks like there are some conflicts with the patches Sasha recently
> added:
> 
> queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
> queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
> queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
> 
> >From commit 0d8d8d5bcef1 ("Fixes for 6.1") from the stable-queue tree:
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0d8d8d5bcef1
> 
> I have also added these patches -- we can see patches with almost the
> same name -- but I adapted them to the v6.1 kernel: it was possible to
> apply them without conflicts, but they were causing issues because they
> were calling functions that are not available in v6.1, or taking
> different parameters.
> 
> Do you mind removing the ones from Sasha please? I hope that will not
> cause any issues. After that, the two patches you had errors with should
> apply without conflicts:

Ok, I've now dropped them, that actually fixes an error I was seeing
where we had duplicated patches in the tree.

>  - selftests: mptcp: join: validate event numbers
>  - selftests: mptcp: join: check re-re-adding ID 0 signal

I'll go add these now, thanks!

And thanks for all the backports, much appreciated.

greg k-h

