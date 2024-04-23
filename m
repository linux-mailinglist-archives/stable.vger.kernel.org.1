Return-Path: <stable+bounces-40703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A328AE7A8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606B9284DDD
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95E12C528;
	Tue, 23 Apr 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8MzvHEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5A745E2
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877985; cv=none; b=DvjzEwk0B41Jmo6aNds6Fi2Pctbf3RGvktN/0ktMHGblV70pLQwVl/K6j3cEEis6yyrvh//ZxNVEl/uC3W522QAkjv1ZLmbE4CDtsiXo4uS7AymaL4wr7Q/EdMPIyWS9CWc/PWGpjMb2p8hLNRf0FoYpH4TCFXrldvj1fL0HZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877985; c=relaxed/simple;
	bh=A85nU+hAtILnpwGFuT2zXNsm9Rw75RbR9kw8ymew0+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6tvO74f9vRXcNpRO4TV88dUOvDLaMlMkhEGrzLPMnuPMZqgwXu3PlorPQha4Q8wpry2Eroep/DaDi7I1iwYVzb7xnm1/+bbVog6CaCel+eteIe+JqSkdg2srO+O1RUEPBcISvjymJIvYufpiJ8CPwCiVDzCa4TctZcgfMRhEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8MzvHEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8675FC116B1;
	Tue, 23 Apr 2024 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877984;
	bh=A85nU+hAtILnpwGFuT2zXNsm9Rw75RbR9kw8ymew0+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8MzvHEJTt5aVpHs7aVJrleswqcrHJjgXU6LJYYeEZqwxUTCyY19m3jkqpU5GdXF/
	 KG/OE3OxIWXuI/Vt1zFwPlWCbsW8okuRDC7N/cX1MIWmw+au4wa0wNAOxkHXSmixEc
	 d2iwKv4uKmFpoQwMYxqrKQlnTHlXdqim0P9xOHiM=
Date: Tue, 23 Apr 2024 06:12:55 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: stable@vger.kernel.org, Chen Jiahao <chenjiahao16@huawei.com>,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
Message-ID: <2024042318-muppet-snippet-617c@gregkh>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>

On Fri, Apr 19, 2024 at 10:55:44PM +0800, Mingzheng Xing wrote:
> On 4/19/24 21:58, Greg Kroah-Hartman wrote:
> > On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
> >> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
> >>> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
> >>>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
> >>>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
> >>>> interface to simplify crashkernel reservation"), but the latter's series of
> >>>> patches are not included in the 6.6 branch.
> >>>>
> >>>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
> >>>> loading the kernel will also cause an error:
> >>>>
> >>>> ```
> >>>> Memory for crashkernel is not reserved
> >>>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> >>>> Then try to loading kdump kernel
> >>>> ```
> >>>>
> >>>> After revert this patch, verify that it works properly on QEMU riscv.
> >>>>
> >>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
> >>>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> >>>> ---
> >>>
> >>> I do not understand, what branch is this for?  Why have you not cc:ed
> >>> any of the original developers here?  Why does Linus's tree not have the
> >>> same problem?  And the first sentence above does not make much sense as
> >>> a 6.6 change is merged into 6.7?
> >>
> >> Sorry, I'll try to explain it more clearly.
> >>
> >> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
> >> on RISC-V") should not have existed because this patch has been merged into
> >> another larger patch [1]. Here is that complete series:
> > 
> > What "larger patch"?  It is in Linus's tree, so it's not part of
> > something different, right?  I'm confused.
> > 
> 
> Hi, Greg
> 
> The email Cc:ed to author Chen Jiahao was bounced by the system, so maybe
> we can wait for Baoquan He to confirm.
> 
> This is indeed a bit confusing. The Fixes: tag in 1d6cd2146c2b58 is a false
> reference. If I understand correctly, this is similar to the following
> scenario:
> 
> A Fixes B, B doesn't go into linus mainline. C contains A, C goes into linus
> mainline 6.7, and C has more reconstruction code. but A goes into 6.6, so
> it doesn't make sense for A to be in the mainline, and there's no C in 6.6
> but there's an A, thus resulting in an incomplete code that creates an error.
> 
> The link I quoted [1] shows that Baoquan had expressed an opinion on this
> at the time.
> 
> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]

I'm sorry, but I still do not understand what I need to do here for a
stable branch.  Do I need to apply something?  Revert something?
Something else?

confused,

greg k-h


