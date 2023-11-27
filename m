Return-Path: <stable+bounces-2751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB807F9FCA
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 13:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E9B20D37
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682B17738;
	Mon, 27 Nov 2023 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nVugpd1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870628E0E
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 12:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A48C433C7;
	Mon, 27 Nov 2023 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701088874;
	bh=gldARJ8xUODxpuIV5dr+VmD4xfz1JJnINMyUKCosACI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVugpd1RTFXcg5Y6us98Hlk4juw9khrOSfaLGZUnOBW/3YmEq7Nbp6xRGZASZ7iNM
	 JTLqmFUNU5qpPB4VmHs4oZQwiCVyX8MgccB36pt/Q7q7pDebiqPsYaX0pm7NcQ033h
	 sSiDtRd7uddxxgvm1VO6lK/L7UT1BCRu6eEDqdDY=
Date: Mon, 27 Nov 2023 12:41:11 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5.10.y] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <2023112759-fineness-pushpin-df59@gregkh>
References: <2023102135-shuffle-blank-783e@gregkh>
 <20231124130935.168451-1-flaniel@linux.microsoft.com>
 <2023112415-salutary-visible-1485@gregkh>
 <12330827.O9o76ZdvQC@pwmachine>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12330827.O9o76ZdvQC@pwmachine>

On Mon, Nov 27, 2023 at 12:21:50PM +0100, Francis Laniel wrote:
> Hi!
> 
> 
> Le vendredi 24 novembre 2023, 17:16:43 CET Greg KH a écrit :
> > On Fri, Nov 24, 2023 at 02:09:35PM +0100, Francis Laniel wrote:
> > > When a kprobe is attached to a function that's name is not unique (is
> > > static and shares the name with other functions in the kernel), the
> > > kprobe is attached to the first function it finds. This is a bug as the
> > > function that it is attaching to is not necessarily the one that the
> > > user wants to attach to.
> > > 
> > > Instead of blindly picking a function to attach to what is ambiguous,
> > > error with EADDRNOTAVAIL to let the user know that this function is not
> > > unique, and that the user must use another unique function with an
> > > address offset to get to the function they want to attach to.
> > > 
> > > Link:
> > > https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.microsoft
> > > .com/
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
> > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > Link:
> > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kern
> > > el.org/ Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > (cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
> > > ---
> > > 
> > >  kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
> > >  kernel/trace/trace_probe.h  |  1 +
> > >  2 files changed, 75 insertions(+)
> > 
> > We also need a version for 5.15.y before we can take this, you do not
> > want to upgrade and have a regression.
> 
> I sent the corresponding 5.15.y patch some times ago here:
> https://lore.kernel.org/stable/20231023122217.302483-2-flaniel@linux.microsoft.com/
> 
> If this is easier for you, I can resend it without problems.

Please resend, that doesn't seem to be in my queue anywhere :(

