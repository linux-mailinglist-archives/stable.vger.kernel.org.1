Return-Path: <stable+bounces-152854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E8ADCDE0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B164C188CEDA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9C2DE20F;
	Tue, 17 Jun 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jUKHjELU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D02DE1FA
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167869; cv=none; b=dNqfY11ELKYXXyQkrUH5MfW+AwkBtXg6yYVq0aH7bkOUQ5l8RXHZLbjC2HoGi77WuU9sftjgzycGD7yJlF+BmvJyUpG6C9vj5399J6FzNPxxRo3sDi5GAXhcovus4jxyrLwaNxYlDy1G+ERROgI3dVRgHJbSpCShsphtPqBVu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167869; c=relaxed/simple;
	bh=BfaKeFtc8o/tlow8RhnB2t9XFMwWDWO5CRkQer2Hy5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC2pwmdEwfFtpQQ1Cw5KFU7Uo2pDmhCZUEswuNHvr1/xTu53i2SpN5r4BB6PObc8WUPm6+CoeWVSUqe3XMFvvwP4HEpS/7XCP6e5nIJ7WaBq3ehVAq4/h7Rf9lgh1NPKetaXhGds6ohu8cpc4zGK6UP1A+XZPn0AoMlDAtPW5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jUKHjELU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA029C4CEE3;
	Tue, 17 Jun 2025 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750167869;
	bh=BfaKeFtc8o/tlow8RhnB2t9XFMwWDWO5CRkQer2Hy5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUKHjELU0NYYuBehj36QfMlyje5I6h9rgz1OYFmzK+IfsXNSr6boMiGWNQAd1S2ej
	 2D2OgBbPHVJX0Wkty57vaMEPJptstZoCe1yHRpXOiBFOstAZtJlE09ZS2XrP+XmPKD
	 9N3xJO6sUIKw3S5X3yQWH2cXlM+O7DuE7XdmCoOo=
Date: Tue, 17 Jun 2025 15:44:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	holger@applied-asynchrony.com
Subject: Re: [RFC PATCH 5.10 16/16] x86/its: FineIBT-paranoid vs ITS
Message-ID: <2025061751-wrongdoer-rebuttal-b789@gregkh>
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
 <20250610-its-5-10-v1-16-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610-its-5-10-v1-16-64f0ae98c98d@linux.intel.com>

On Tue, Jun 10, 2025 at 12:46:10PM -0700, Pawan Gupta wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> commit e52c1dc7455d32c8a55f9949d300e5e87d011fa6 upstream.
> 
> FineIBT-paranoid was using the retpoline bytes for the paranoid check,
> disabling retpolines, because all parts that have IBT also have eIBRS
> and thus don't need no stinking retpolines.
> 
> Except... ITS needs the retpolines for indirect calls must not be in
> the first half of a cacheline :-/
> 
> So what was the paranoid call sequence:
> 
>   <fineibt_paranoid_start>:
>    0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
>    6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
>    a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
>    e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
>   10:   41 ff d3                call   *%r11
>   13:   90                      nop
> 
> Now becomes:
> 
>   <fineibt_paranoid_start>:
>    0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
>    6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
>    a:   4d 8d 5b f0             lea    -0x10(%r11), %r11
>    e:   2e e8 XX XX XX XX	cs call __x86_indirect_paranoid_thunk_r11
> 
>   Where the paranoid_thunk looks like:
> 
>    1d:  <ea>                    (bad)
>    __x86_indirect_paranoid_thunk_r11:
>    1e:  75 fd                   jne 1d
>    __x86_indirect_its_thunk_r11:
>    20:  41 ff eb                jmp *%r11
>    23:  cc                      int3
> 
> [ dhansen: remove initialization to false ]
> 
> [ pawan: move the its_static_thunk() definition to alternative.c. This is
> 	 done to avoid a build failure due to circular dependency between
> 	 kernel.h(asm-generic/bug.h) and asm/alternative.h which is neeed
> 	 for WARN_ONCE(). ]
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> [ Just a portion of the original commit, in order to fix a build issue
>   in stable kernels due to backports ]
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Link: https://lore.kernel.org/r/20250514113952.GB16434@noisy.programming.kicks-ass.net
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Note, I did not sign off on the backports here, are you sure you want to
do it this way?  :)

Also, I need someone to actually test this series before we can take
them...

thanks,

greg k-h

