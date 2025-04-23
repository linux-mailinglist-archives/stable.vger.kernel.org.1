Return-Path: <stable+bounces-135260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A6A98816
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB88F5A3049
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6824467E;
	Wed, 23 Apr 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PH51YCgh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99224215F48
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406436; cv=none; b=u4HJIW+5J1gSoxY/XCjCMuXh6+J6asYtEjo0SnOiPgojhvt1RtLXOUtZgC/1mPwcdIOryqZ6mbyUZemoB+5QuZJuqvGK7GAdCIjSCvE9rE6eL+aSKVri8lGlTDcj8rLUYj5IvX89ECaoDLlCxV9aqBBkzuUPYLp5RaAu/eFbtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406436; c=relaxed/simple;
	bh=ywcTdIPHFmbSg1FQSfHka5ZiGZT8KzhaeNVxeDPX82A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjoktYz8pRQoytSdewm9edP59Vguu6dpEI12VELFrL9Iv587lm/RASu3GC0czWM8lSuFCvTySPqz0UTirt2iWUKWNnHkISBpguwlMqgcDYyW2yJQ6Cp9PIc0D5YQJCbBGq7lWAjbDXVH8xqXl1B3AS4VwpYgwFEJP3e3Q6VAERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PH51YCgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D7C4CEE2;
	Wed, 23 Apr 2025 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745406436;
	bh=ywcTdIPHFmbSg1FQSfHka5ZiGZT8KzhaeNVxeDPX82A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PH51YCghQUYYSH4ADgurb1T4ZNP6ilRP3w/ofpEEKxf8PL8AZjLzbLaA2wEWoNKPj
	 Qd8OH11z5ZCuUaCS6x/MKOCzdYUfOmROTURzodBqFOObjfN3xwJEqNJ2qhvPWFnzIa
	 JhbCRGvcnXFmDOwowqCL/CsLoAN77xtbZH9amgeQ=
Date: Wed, 23 Apr 2025 13:07:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org,
	Kunwu Chan <chentao@kylinos.cn>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/3 v5.4.y] dmaengine: ti: edma: Add some null pointer
 checks to the edma_probe
Message-ID: <2025042315-tamer-gaffe-8de0@gregkh>
References: <2025042230-equation-mule-2f3d@gregkh>
 <20250422151709.26646-1-hgohil@mvista.com>
 <20250422151709.26646-2-hgohil@mvista.com>
 <2025042204-scrambler-dropkick-e453@gregkh>
 <CAH+zgeHyrhAVmJOHZ7BKE3BX2CaTK8Es3MDqSU=HRwz7yX0OTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeHyrhAVmJOHZ7BKE3BX2CaTK8Es3MDqSU=HRwz7yX0OTA@mail.gmail.com>

On Wed, Apr 23, 2025 at 03:30:39PM +0530, Hardik Gohil wrote:
> >
> > Sasha did not sign off on the original commit here.
> >
> > And you didn't either.  Please read the documentation for what this
> > means, and what you are doing when you add it.
> >
> > thanks,
> >
> > greg k-h
> 
> There have been no changes from my side for those patches. Do we still
> need to add a signed-off sign?

Please take some time and work with the kernel developers on your team
and your group's corporate lawyer, to understand what a signed-off-by
means and why it is required here.

thanks,

greg k-h

