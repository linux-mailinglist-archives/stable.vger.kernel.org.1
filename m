Return-Path: <stable+bounces-2789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3C7FA871
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D721F20F0C
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035A3BB3F;
	Mon, 27 Nov 2023 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRw4lzPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD483BB3D
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 17:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22D7C433C8;
	Mon, 27 Nov 2023 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701107893;
	bh=anjONufVNV6G6njVV54Ravuf8cMhWiB9CT+qw5j5eQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRw4lzPrETGvpDr8rczpMzMFD0HJErvyH/v5HxQZBbUt58BjepWSwJJROp17tpuPg
	 dY/iDcpIZtYoj3FB0cQYZ5cT6ALj5sDkVaRImp7odgcymkZZQEY8K9R5p5EHy8m6LZ
	 E3GHJAJpEXKLzWqvDITmtZ/xPnS7FBV8zc4F2YO0=
Date: Mon, 27 Nov 2023 17:58:10 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.19.y] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <2023112749-dismay-blemish-3eac@gregkh>
References: <2023102138-riverbed-senator-e356@gregkh>
 <5993767.lOV4Wx5bFT@pwmachine>
 <2023112701-comfy-resemble-4e42@gregkh>
 <2305896.ElGaqSPkdT@pwmachine>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2305896.ElGaqSPkdT@pwmachine>

On Mon, Nov 27, 2023 at 06:36:32PM +0100, Francis Laniel wrote:
> Hi!
> 
> 
> Le lundi 27 novembre 2023, 16:44:22 CET Greg KH a écrit :
> > On Mon, Nov 27, 2023 at 03:41:31PM +0100, Francis Laniel wrote:
> > > Hi!
> > > 
> > > Le vendredi 24 novembre 2023, 17:17:04 CET Greg KH a écrit :
> > > > On Fri, Nov 24, 2023 at 01:24:13PM +0100, Francis Laniel wrote:
> > > > > When a kprobe is attached to a function that's name is not unique (is
> > > > > static and shares the name with other functions in the kernel), the
> > > > > kprobe is attached to the first function it finds. This is a bug as
> > > > > the
> > > > > function that it is attaching to is not necessarily the one that the
> > > > > user wants to attach to.
> > > > > 
> > > > > Instead of blindly picking a function to attach to what is ambiguous,
> > > > > error with EADDRNOTAVAIL to let the user know that this function is
> > > > > not
> > > > > unique, and that the user must use another unique function with an
> > > > > address offset to get to the function they want to attach to.
> > > > > 
> > > > > Link:
> > > > > https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.micros
> > > > > oft
> > > > > .com/
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
> > > > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > > Link:
> > > > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@k
> > > > > ern
> > > > > el.org/ Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > (cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
> > > > > ---
> > > > > 
> > > > >  kernel/trace/trace_kprobe.c | 48
> > > > >  +++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 48 insertions(+)
> > > > 
> > > > Again, we need a version for 5.4.y as well before we can take this
> > > > version.
> > > 
> > > I sent the 5.4.y patch some times ago, you can find it here:
> > > https://lore.kernel.org/stable/20231023113623.36423-2-flaniel@linux.micros
> > > oft.com/
> > > 
> > > With the recent batch I sent, I should have cover all the stable kernels.
> > > In case I miss one, please indicate it to me so I can fix this problem and
> > > ensure all stable kernels have a corresponding patch.
> > 
> > I only see the following in my stable mbox right now:
> > 
> >    1   C Nov 27 Francis Laniel  (4.4K) ┬─>[PATCH 5.10.y] tracing/kprobes:
> > Return EADDRNOTAVAIL when func matches several symbols 2 r C Nov 24 Francis
> > Laniel  (4.4K) └─>[PATCH 5.10.y] tracing/kprobes: Return EADDRNOTAVAIL when
> > func matches several symbols 3   F Nov 24 To Francis Lani (1.5K)   └─>
> >    4 r T Nov 27 Francis Laniel  (1.9K)     └─>
> >    5   F Nov 27 To Francis Lani (2.0K)       └─>
> >   23 r C Nov 24 Francis Laniel  (2.7K) [PATCH 4.19.y] tracing/kprobes:
> > Return EADDRNOTAVAIL when func matches several symbols 24 r + Nov 27
> > Francis Laniel  (2.0K) └─>
> > 
> > So could you resend them all just to be sure I have all of the latest
> > versions that you wish to have applied?
> 
> I normally sent again the patch for version 4.14 to 5.15 (it was already 
> present in 6.1 and 6.6).
> I tested all of them by building the corresponding kernel with the patch 
> applied before sending, so they should not break compilation or testing.
> 
> Can you please confirm me you received them?

Got them now, thanks, I'll dig through them after this latest round of
stable kernels gets released.

thanks,

greg k-h

