Return-Path: <stable+bounces-83730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E699BF82
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B791F219F8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8713CFA1;
	Mon, 14 Oct 2024 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dOb4t4Z8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BB13C81B
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885240; cv=none; b=ZA/Xywn/YTlwVkqACEPhKmvNtJHSGCadMFdYYX0cGKm75dFSMDI3/gZd3qGo1JrO/suCW6ph5+uqKb1GFT71Eqg6p3J6t9M5VPlXOr1nqIAMCtWZ58gHBmH92WkRaJRpcDWOF6sXtQs/hXBf//YLYSXZb7Z7FHl5Ksv/vtqvHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885240; c=relaxed/simple;
	bh=+ou7eoMNwzL7fYiCbEmMdpNnPEJ+GKLUS3YaksMZwRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDyl5NwPBwI9fkjYKbtnrhN8lqeeAcOXwVrmAu2KI2hj2lOKs4aLfC5HxGODxLZIUSlVMlmaFOLtGx5O8gUII0XtPFdQjzj2g090WRMq9xYMRZZ2fM7L/nQjinmyF8XMmw68TnQCXLHc6eIbHK1ApgI4hAo3IqbQIdMjqLDAX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dOb4t4Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A03CC4CECE;
	Mon, 14 Oct 2024 05:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728885239;
	bh=+ou7eoMNwzL7fYiCbEmMdpNnPEJ+GKLUS3YaksMZwRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOb4t4Z8X0FuOFevxY4HZx91YbxTrCsIEva1zrpwkfaSD9Dvepg10rQzkZv5cO0qD
	 qRpYzI/3+8/U2/IlHRDHNbnP0eg2MeMI9TPZi9fONg0m6RiiwuI4vD9n6wPErrUE57
	 Qn8r0s+4MdXIKuBIdwspR6PnJEvNl27xL7BdGqdo=
Date: Mon, 14 Oct 2024 07:53:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pedro.falcato@gmail.com>, stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: backport mseal and mseal_test to 6.10
Message-ID: <2024101439-scotch-ceremony-c2a8@gregkh>
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>

On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> Hi Greg,
> 
> How are you?
> 
> What is the process to backport Pedro's recent mseal fixes to 6.10 ?

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how all of this works :)

> Specifically those 5 commits:
> 
> 67203f3f2a63d429272f0c80451e5fcc469fdb46
>     selftests/mm: add mseal test for no-discard madvise
> 
> 4d1b3416659be70a2251b494e85e25978de06519
>     mm: move can_modify_vma to mm/vma.h
> 
>  4a2dd02b09160ee43f96c759fafa7b56dfc33816
>   mm/mprotect: replace can_modify_mm with can_modify_vma
> 
> 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
>       mseal: replace can_modify_mm_madv with a vma variant
> 
> f28bdd1b17ec187eaa34845814afaaff99832762
>    selftests/mm: add more mseal traversal tests
> 
> There will be merge conflicts, I  can backport them to 5.10 and test
> to help the backporting process.

5.10 or 6.10?

And why 6.10?  If you look at the front page of kernel.org you will see
that 6.10 is now end-of-life, so why does that kernel matter to you
anymore?

> Those 5 fixes are needed for two reasons: maintain the consistency of
> mseal's semantics across releases, and for ease of backporting future
> fixes.

Backporting more to 6.10?  Again, it's end-of-life, who would be
backporting anything else?

confused,

greg k-h

