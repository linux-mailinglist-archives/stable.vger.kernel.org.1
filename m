Return-Path: <stable+bounces-118939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2457DA422AF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2956919C11C7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2401474A9;
	Mon, 24 Feb 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugwrNakz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D227CF16;
	Mon, 24 Feb 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406254; cv=none; b=gdJhZQf4RVs1LN4Ee83CAqZK7shVZgI9WtdxW8j9pfykMN5nopDJhId3/U8iEUuZKQ6oUrTwTJ9GeASe013MnyfHK93fM9yth14+BvOQ2Ku3ZLTqa6P2xoDN6OcmK8BLaCausP13v0iWWcu9LM93nLes/KysRSJTFMLZftdRpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406254; c=relaxed/simple;
	bh=GiP5euhQ7Tgb9tgg9gtkD++luXm6ukZAr5cbuUIaBl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2wTTwOSxZbUe1bCtM72rOQ6j0pdsuPRnim/WXvYlgXfr4l+GmwUikGDoUmyZCx99R9jS3fazNMEPc/h8hG8BO4LnAlnWmt3zX/Hksu0HzX30EU/SdNjxikpYXUvpTyF/ik/e3KAoj/4e+53wv9/PnuaMTseUewFRF7R/E7fpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugwrNakz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98FEC4CEE6;
	Mon, 24 Feb 2025 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740406254;
	bh=GiP5euhQ7Tgb9tgg9gtkD++luXm6ukZAr5cbuUIaBl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugwrNakzuxN0YDO2FiNPGQxy/XA5Um9B+l/8jkMh3tcdyLLp23RT/7w9CG5T4KM1Z
	 720iAxZGxjuRT4MfG+QqsGtho1BN2RlLMUge1wEfqNZdlXrn9KtTeFvRm2TUg0KnrR
	 IYOHRNf/TF7TG9gKFo2sGF8YvqachVKKb9RQ1Ces=
Date: Mon, 24 Feb 2025 15:10:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz
Subject: Re: Linux 6.6.78
Message-ID: <2025022439-moisten-crave-b6a5@gregkh>
References: <2025021711-elephant-decathlon-9b66@gregkh>
 <20250224182918.C75A.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182918.C75A.409509F4@e16-tech.com>

On Mon, Feb 24, 2025 at 06:29:19PM +0800, Wang Yugui wrote:
> Hi
> 
> > I'm announcing the release of the 6.6.78 kernel.
> > 
> > All users of the 6.6 kernel series must upgrade.
> > 
> > The updated 6.6.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> 
> please revert these 2 patches.
> because the struct member kernel_workload is yet not defined.
> 
> > Tomas Glozar (6):
> >       rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
> >       rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads

Can you send a series of reverts for us to apply?

thanks,

greg k-h

