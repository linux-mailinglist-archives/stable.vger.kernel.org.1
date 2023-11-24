Return-Path: <stable+bounces-121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829B7F731C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A24F1C20DD3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E23200BA;
	Fri, 24 Nov 2023 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJqWjxjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B91F95A;
	Fri, 24 Nov 2023 11:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F7DC433C7;
	Fri, 24 Nov 2023 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700826811;
	bh=4Zhht3xw7A65E0ReKDjb+KZoZmXvjdOoyx11UcUhWTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJqWjxjXBXD0G6IobGhKX3t9r1ngVCiCtV+bQhbvdCsbwx/3WeRC1gnMGUoJbZHIc
	 4AXur/atkprGIsTEgTU1kJY051cwVEHaqi2j/EDmpYK7mTdo8NUX2KCVp2ARGGUqYw
	 0Z7/rnsGu8n5LlK54EXjXjq+OeflXwy7odBbuvb4=
Date: Fri, 24 Nov 2023 11:53:30 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Eduard Bachmakov <e.bachmakov@gmail.com>, stable@vger.kernel.org,
	linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>
Subject: Re: Unexpected additional umh-based DNS lookup in 6.6.0
Message-ID: <2023112402-handoff-spore-f997@gregkh>
References: <CADCRUiNvZuiUZ0VGZZO9HRyPyw6x92kiA7o7Q4tsX5FkZqUkKg@mail.gmail.com>
 <d2c0c53db617b6d2f9b71e734b165b4b.pc@manguebit.com>
 <CADCRUiNSk7b7jVQrYoD153UmaBdFzpcA1q3DvfwJcNC6Q=gy0w@mail.gmail.com>
 <482ee449a063acf441b943346b85e2d0.pc@manguebit.com>
 <CADCRUiN=tz85t5T00H1RbmwSj_35j9vbe92TaKUrESUyNSK9QA@mail.gmail.com>
 <cbe899ddc4bfc2835fc015eb0badfc10@manguebit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe899ddc4bfc2835fc015eb0badfc10@manguebit.com>

On Thu, Nov 23, 2023 at 10:56:53PM -0300, Paulo Alcantara wrote:
> Stable team,
> 
> Eduard Bachmakov <e.bachmakov@gmail.com> writes:
> 
> > I noticed this got pulled into 6.7. Given this is a user-facing
> > regression, can this be proposed for the next 6.6 point release?
> > Sorry, if this is already the case and I missed it.
> 
> Could you please backport
> 
>         5e2fd17f434d ("smb: client: fix mount when dns_resolver key is not available")
> 
> to v6.6.y?

Will do so now, thanks, I'm way behind in catching up with stable
patches due to the merge window and then Plumbers and now some
additional travel, sorry about that.

greg k-h

