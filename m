Return-Path: <stable+bounces-148136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33915AC87B7
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 07:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CB27AC6DF
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79D1459F6;
	Fri, 30 May 2025 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DFr4umC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661961E570B
	for <stable@vger.kernel.org>; Fri, 30 May 2025 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748581853; cv=none; b=UzDtRrpvfPav754ZnQEsm+eQr5JwLMkh6FDlB6HzYp6Ljjjao+25dFGaa5FogNoGR4VO1Rg3C4U2ycyUJGfJsHMrrR5LsyhW1pv1jjfnfxXYu5dHozlLYqg88SiW8cce8NS0LJQ4UaXvcsE3gpBWJdysuCYWAlk5jTbcjGFUqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748581853; c=relaxed/simple;
	bh=H9TSSU9kcBqaV5JLSfS7HbNVU39VFHpJV+jQnfm6P1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTIbggujvN+v5mAqMhNrSFygCU+o7QAvec4Pi9yEHaGUQJhXxy5D6bqKzLcqEH3MprhQQnP29TU+7tndALxAvuep4RdSTlpBgakGHNFLbhuP6FZ6XeGvQBZ3KNYEzwau1PSTd6/FmiLhKd6FL1wsSUeaOVvBUaN1vlb6xnFZlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DFr4umC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B295EC4CEE9;
	Fri, 30 May 2025 05:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748581853;
	bh=H9TSSU9kcBqaV5JLSfS7HbNVU39VFHpJV+jQnfm6P1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFr4umC2bo8F3gF2IyQ2HJQLKs0JqFduRNNmcHeC5ph4RZ5K2K07rYpVv60LLWem7
	 34Jyw6o8NNmvgAXcLFixb9IW8hdrPBeUaTrrW9wNR9rSSvEEbPMFWdWvRoE06kySSt
	 4l2rXD6dTI52g0iY7/EAbbglNFd2hmhjAKO5SUyY=
Date: Fri, 30 May 2025 07:08:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: Are there any internal kernel ABI/API guarantees in -stable
 releases?
Message-ID: <2025053047-manly-dole-d7ad@gregkh>
References: <929a9cbf-1059-4cfc-bed0-88e8fe931560@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929a9cbf-1059-4cfc-bed0-88e8fe931560@windriver.com>

On Thu, May 29, 2025 at 01:48:26PM -0600, Chris Friesen wrote:
> Hi everyone,
> 
> Looking at
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> there are a number of criteria for patches to -stable releases.
> 
> However, there is no mention of preserving the stability of internal kernel
> ABIs and/or APIs.

That is because there is no such guarantee.

Hope this helps,

greg k-h

