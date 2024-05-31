Return-Path: <stable+bounces-47760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438E8D59D2
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 07:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709731C2108A
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 05:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03B2E633;
	Fri, 31 May 2024 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqkh9VmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94D2595
	for <stable@vger.kernel.org>; Fri, 31 May 2024 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717133006; cv=none; b=czjqwPhXLu9zbcPfDZAIQRN8PCd0AH9rtUrD6jMOGGuAEle2eYkvk7gQ6PTlIznMk1Q3CchGsKzqceFrzPWwi5fahtboQLFSzguLQ+pmaVc2qBxn7gMNG3cVw/Po5Tv8hfwabSBKd6Xt6uIY8dTtpFqWDpW7/0k71y6370nfVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717133006; c=relaxed/simple;
	bh=Z+SrxCSnesevMh52v4v89AOjuUOz9RtWugotU4LF48w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZclsYLFE2b/ZHJuVujMNUkU7IGHQOiCgyFiPkCZOYXBSODyJbJL1FrnCWuRN7lVzlREfp9QRiae48Dx5GemTkGTRUjAYDwXvKmmKOI5MSO5qfP0/TkLV2DbfaBxHw+gQaeBXprAPO0ano/j+qqxNPedzG64WyE4f9Z1PSz7Hwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqkh9VmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EDAC116B1;
	Fri, 31 May 2024 05:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717133006;
	bh=Z+SrxCSnesevMh52v4v89AOjuUOz9RtWugotU4LF48w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqkh9VmZgswRUOOlAJFfduirpuwGhqWSi6tz0X2oZuuIWiPN0VLwTLba3/OMALjnP
	 iZWTPt6PvWGVpziJEBowKvmn7TJ/GUYqZr6IRwk7+im5eIXrBC21N4xhzKv203s4+s
	 SXbuI8v16cMrvnqWkQBiw5UzpMcPsFX+0JDBjNRg=
Date: Fri, 31 May 2024 07:23:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: phil995511 - <phil995511@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Fwd: Kernel 6.8.12
Message-ID: <2024053158-identify-arrest-e061@gregkh>
References: <CAEQj+Ebm09gBePmOYZ3NiH2sMBLqDz=5RS5oODpTTfR1FWspzA@mail.gmail.com>
 <CAEQj+Eb8PByrAxZ9udhQaXXQi19QLg04isuHKL_EG62LsstrKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEQj+Eb8PByrAxZ9udhQaXXQi19QLg04isuHKL_EG62LsstrKQ@mail.gmail.com>

On Thu, May 30, 2024 at 10:20:14PM +0200, phil995511 - wrote:
> Hello,
> 
> Kernel 6.8 which is the default kernel of Ubundu 24.04 and other
> distributions derived from it is at the end of its life for you !?!
> 
> As it provides better support for the Raspberry Pi 5 graphics card, I
> hoped to be able to benefit from it under Raspberry Pi OS which still
> uses the latest LTS kernel available.
> 
> But if you don't make kernel 6.8 an LTS kernel, for Ubuntu and its
> derivatives, I will never be able to benefit from it on my RPi5 ;-(
> In addition, I am afraid that OS derived from Ubuntu 24.04 LTS will
> end up in difficulties due to this situation.

Please work with your distro for any support questions you might have
like this with their kernel choice.  It's nothing we can do, sorry.

greg k-h

