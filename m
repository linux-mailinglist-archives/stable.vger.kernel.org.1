Return-Path: <stable+bounces-151582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FAACFC57
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 08:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D41B3AFE25
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 06:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF41DE889;
	Fri,  6 Jun 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyaRHrqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE836D;
	Fri,  6 Jun 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189871; cv=none; b=l9srd6x4l0kMPOqPKFL1JfAT0rHUwQABXC5hmbU6p5vVh6gl3SxatkOKU9L/rRNBc8U4ZeG0b4ypyXC2EfuStXMM0rX3wG41XcMKcZsPsDOy/NId3Wy2y01o6M6tV3JPB2vSUJpEtruL3vSIp++HiRXieBtnV1FYMFnnL3ieKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189871; c=relaxed/simple;
	bh=pjeKZkJ883qYbol/QOdBTpC5HUIdAmNCeHTYYgEIJcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9gW6cc3DKd9S55ahO04tauCuIH+T+zqIAQcgLgjzlvmRhUj2GoSVbUNd1VL28QknPRWDY7Ky8AW313pZhkgIsc3VPL2JQDIF2/WulCqgEBQ+Y3MZZLqPyNnqrtkvvcoGw0XbBN4ziaOYXP+EPpOZPHHe7EKlh7B6F4BaJYAePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyaRHrqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E30C4CEEF;
	Fri,  6 Jun 2025 06:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749189869;
	bh=pjeKZkJ883qYbol/QOdBTpC5HUIdAmNCeHTYYgEIJcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyaRHrqAG26KiDXNl2swrMn/dZgB7lKOu29sM3/1xOQf6Xpu6Zus+8V9sT3hFBpbG
	 w/Mdk+roYnXfOpoyruY7y0HjIBtFlbSvHsH5koRTlzcrG1tRi5ZkgZCltGoeF4vZKN
	 9IGZ3KSPY4uKzpOn79GoFFFDvVlzdZlUJl/6v5A4=
Date: Fri, 6 Jun 2025 08:04:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brahmajit Das <listout@listout.xyz>
Cc: stable@kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, mpatocka@redhat.com,
	stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/1] dm-verity: fix a memory leak if some arguments are
 specified multiple times
Message-ID: <2025060654-semisoft-prevent-351a@gregkh>
References: <20250605201116.24492-1-listout@listout.xyz>
 <65ci7zvx3kr5qfq2ioadzzd4ghrtrtrc3pxefosexxpbup63kb@4jkc6e6usols>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ci7zvx3kr5qfq2ioadzzd4ghrtrtrc3pxefosexxpbup63kb@4jkc6e6usols>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Jun 06, 2025 at 02:00:52AM +0530, Brahmajit Das wrote:
> Greg, Shuah, Mikulas,
> This is my first attempt at backporting an upstream patch (Part of Linux
> kernel Bug Fixing Summer 2025). Please feel free to correct me, I'm open
> to feedback.
> I see I've added two From section, if that requires me to
> resend a v2 of the patch, please let me know.

Yes it does.

But you provide no information as to why this needs to be merged _now_
and not through the normal stable backport process that happens.  What
is different here that required you to send it to us?

And you forgot to mention what kernel branch this is for.

There is a stable kernel rules file that explains most of this.

thanks,

greg k-h

