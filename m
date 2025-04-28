Return-Path: <stable+bounces-136852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C922A9EEF3
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA08516724E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287925D536;
	Mon, 28 Apr 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FvFDNi4e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB4EEC8
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839381; cv=none; b=E5xaMi8JIUqJ0TlqBIgW5eiXUHMSy/W05tkP5YsauY1BtMQoT69c53j4Uui4yaiMCz+AhMTcmRY5tfYpT0YTEefAodmg3WANBuT8fVQdFV6SiUSbqeS47QOFHM8HzXAjOpapRMJpU30uw5nfaH42CSW4WsRCPsnwtKvv7JcE41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839381; c=relaxed/simple;
	bh=n2bj2mKm8lql8H999vrgztuxmJPEm8yip7wyxlXior4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBHpHKWIHTq9GrjdhLpDTnrnfK3bXwdeUR7qRwKcoelxMwnZ/838qUfp7Djlzb39XwVHpVnkGt2syBK0eF3Fo9UjlZrvvbR6RsW/8IEz8I5BouuMfEvpyZHaxzPbpjf/84Uf3kbh+9nfY4nU9kEcnXEY43DWoft/4wPn2D9dAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FvFDNi4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D9DC4CEE4;
	Mon, 28 Apr 2025 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745839381;
	bh=n2bj2mKm8lql8H999vrgztuxmJPEm8yip7wyxlXior4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvFDNi4eHQ7VtfvV5I/1y/FAB0QkgRHriy8QseU0MTh0yN2aD7ZHn8rU+neOa7dlu
	 TdrUTJX/2QbWCT4h2sPxq2MNTgVorDIAO/3dQSAqibAkeD6PCVzCdWiBok02DEC3X4
	 lDpvmDQLVs6MjOzt/kRYmbk1tzS/NL8L39sGPlyM=
Date: Mon, 28 Apr 2025 13:22:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Clayton <chris2553@googlemail.com>
Cc: stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	adobriyan@gmail.com
Subject: Re: GCC 15 and stable kernels
Message-ID: <2025042814-sly-caring-8f38@gregkh>
References: <fb4cce81-1e36-4887-a1e0-0cfd1a26693e@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4cce81-1e36-4887-a1e0-0cfd1a26693e@googlemail.com>

On Mon, Apr 28, 2025 at 12:14:09PM +0100, Chris Clayton wrote:
> Hi Greg,
> 
> I've built the four stable kernels that were released on 25 April. I found that to successfully build with GCC-15, each
> of them required backports of one or both of two upstream commits. Those commits are:
> 
> Title		Commit						Author	
> nonstring 	9d7a0577c9db35c4cc52db90bc415ea248446472  	Linus
> gnu11		b3bee1e7c3f2b1b77182302c7b2131c804175870	Alexey Dobriyan
> 
> 6.14.4 and 6.12.25 required only nonstring. 6.6.87 required only gnu11, 6.1.35 required both.
> 
> Additionally, chasing down why my new Bluetooth mouse doesn't work, I also had cause to build 5.15.180 and found that it
> needed gnull.
> 
> I have TO dash out now, but I could send you a zip archive of the patches later today, if that would help.

Please send backported patches of the above, as they do not apply
cleanly as-is, and we will be glad to review and apply them.

thanks,

greg k-h

