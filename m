Return-Path: <stable+bounces-10018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6178D8270AF
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDFC28157D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFC146527;
	Mon,  8 Jan 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZIDl5jkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792346538
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 14:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3500C433C8;
	Mon,  8 Jan 2024 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704722866;
	bh=ipFeWVkdlpPV8YAdbkWjVxUBbVWjwhsCo2jpsX1Wayw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIDl5jknN7GGPxCXxYpk7/M64UR4MIeV/MGCkRuZ1Q9mGSqGXbSu8ls/WmFPjp8SM
	 bQgkIwgfy9aEnb93bjnazBQ8ggKytw4RURjh4cD+YRGEZ84SkpuF3JTkKJB+SIT1pA
	 MSeCMvLOCeqWxrutjQu0nEkleaw6K5NBr7bNvrmc=
Date: Mon, 8 Jan 2024 15:07:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	stable <stable@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Boris Pismenny <borisp@nvidia.com>
Subject: Re: [missing stable fix on 5.x] [PATCH] net: tls, update curr on
 splice as well
Message-ID: <2024010822-clinking-kangaroo-e8fa@gregkh>
References: <20231214194518.337211-1-john.fastabend@gmail.com>
 <CAG48ez36YXSjKWMfpLFUj9RCRg13WzQG3dHC-cyUtyJLmZQ-Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez36YXSjKWMfpLFUj9RCRg13WzQG3dHC-cyUtyJLmZQ-Aw@mail.gmail.com>

On Mon, Jan 08, 2024 at 02:10:31PM +0100, Jann Horn wrote:
> On Thu, Dec 14, 2023 at 8:45 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > commit c5a595000e2677e865a39f249c056bc05d6e55fd upstream.
> >
> > Backport of upstream fix for tls on 6.1 and lower kernels.
> > The curr pointer must also be updated on the splice similar to how
> > we do this for other copy types.
> >
> > Cc: stable@vger.kernel.org # 6.1.x-
> 
> I think this Cc marker was wrong - the commit message says "on 6.1 and
> lower kernels", but this marker seems to say "6.1 and *newer*
> kernels". The current status is that this issue is fixed on 6.6.7 and
> 6.1.69, but not on the 5.x stable kernels.

Then can someone provide a working backport to those kernels?  Right
now, this one does not apply at all there.

thanks,

greg k-h

