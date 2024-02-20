Return-Path: <stable+bounces-20844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B085BFFA
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1E81C21BAB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6D6BB3C;
	Tue, 20 Feb 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHJsZO2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A3664CF
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443121; cv=none; b=dpSOCs16JI1z1c+t/WHgmmhVBzg5Xg9xf48cCwI4yOkKD7s14nFC2vfCFcs+qEWZ1TZzRwrJcEeiMO1mcoUXA3ts1vqNLkEDRomu+znqFQVxGQrBavcT8HADRcbotg5tf0QlZCxmQZ/dsmBJlPjOUDP/jlJzIJ6y91q+Vkx/Wrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443121; c=relaxed/simple;
	bh=9XnRy+40nbiu0URK19IolUXgdwSZ/3szEu9iR3CRAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPhaYCdUTF77k9TIxXPrj/8AAdlmwAbmWIYbMq+6uKjWREfwGQkI30b/dwUJxRz/TNETTPC3ue13tbZal/NAt6c3ZyMslazuWq9zXkHcigywCNXX9kA9Cr+KqPqlAYpp4keR7shV9dnIbDtyPdA9BhtlzUFCOSzDentV8WizZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHJsZO2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022FAC433C7;
	Tue, 20 Feb 2024 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708443120;
	bh=9XnRy+40nbiu0URK19IolUXgdwSZ/3szEu9iR3CRAtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHJsZO2gyWSmB1GXrt2hwT0cMBxcAMLB1kBRo5voX7XKCwMY0YbDvWORqLsw5aG+K
	 /oOOGgGLzqYhR4TbJ2BAtxHI8VGJ8zHsnk1bXu58cZvbPPEvUuUk/7Gb1iHboCnF47
	 Cz7aEwtNXllUVvOrsHxby+ub2JQd5QCRfDb8AuEE=
Date: Tue, 20 Feb 2024 16:31:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Xiang Yang <xiangyang3@huawei.com>, mark.rutland@arm.com,
	catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	xiujianfeng@huawei.com, liaochang1@huawei.com
Subject: Re: [PATCH 5.10.y v2] Revert "arm64: Stash shadow stack pointer in
 the task struct on interrupt"
Message-ID: <2024022049-worst-dividable-0f1c@gregkh>
References: <20240219132153.378265-1-xiangyang3@huawei.com>
 <CAMj1kXFwTLJ77MYy3Pm+S9WGgkMw0hAGdTKOF05xdqqBg8giMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFwTLJ77MYy3Pm+S9WGgkMw0hAGdTKOF05xdqqBg8giMw@mail.gmail.com>

On Mon, Feb 19, 2024 at 05:57:07PM +0100, Ard Biesheuvel wrote:
> On Mon, 19 Feb 2024 at 14:24, Xiang Yang <xiangyang3@huawei.com> wrote:
> >
> > This reverts commit 3f225f29c69c13ce1cbdb1d607a42efeef080056.
> >
> > The shadow call stack for irq now is stored in current task's thread info
> > in irq_stack_entry. There is a possibility that we have some soft irqs
> > pending at the end of hard irq, and when we process softirq with the irq
> > enabled, irq_stack_entry will enter again and overwrite the shadow call
> > stack whitch stored in current task's thread info, leading to the
> > incorrect shadow call stack restoration for the first entry of the hard
> > IRQ, then the system end up with a panic.
> >
> > task A                               |  task A
> > -------------------------------------+------------------------------------
> > el1_irq        //irq1 enter          |
> >   irq_handler  //save scs_sp1        |
> >     gic_handle_irq                   |
> >     irq_exit                         |
> >       __do_softirq                   |
> >                                      | el1_irq         //irq2 enter
> >                                      |   irq_handler   //save scs_sp2
> >                                      |                 //overwrite scs_sp1
> >                                      |   ...
> >                                      |   irq_stack_exit //restore scs_sp2
> >   irq_stack_exit //restore wrong     |
> >                  //scs_sp2           |
> >
> > So revert this commit to fix it.
> >
> > Fixes: 3f225f29c69c ("arm64: Stash shadow stack pointer in the task struct on interrupt")
> >
> > Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Now queued up, thanks.

greg k-h

