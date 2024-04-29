Return-Path: <stable+bounces-41624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59B8B55DB
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697C01F22FF2
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E33B298;
	Mon, 29 Apr 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LMHKa8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4F2C86A
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387929; cv=none; b=dct1p10Q9Pp/eVG06quVPfsTqKOtyR3LovRFmZbvcYtTPPSQQcqVHCnuCCvYZUEcJIwo3HZI1DUF997ih0JPbyCgGfMh13+ND/taTgRwQm2ip4Mx3HoZZn8yvOizgrkpsQsRi8/dADFR1Df7vxELyUW52Jw5l/cUkG97MLoqyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387929; c=relaxed/simple;
	bh=TplSGSvyRT6W63ok8ViJuEHmTniOYHRptY4QwWjj9OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYonNzLPlD61m/8scJdlyg7s2Qj1p3gIIM2TbsbXoMWqWOIYiaSdZzBiroce9cfHEp4Alpi09gBspg5nfVnpnsx0ffuNDb5L4S+IIBUimQ4x7bepQlcN1nkK1ZmG4aeTlwz+gb0UCvifgoP6Lami/hl8ehD9YjLt8lN6MrJrGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LMHKa8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B786FC113CD;
	Mon, 29 Apr 2024 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714387929;
	bh=TplSGSvyRT6W63ok8ViJuEHmTniOYHRptY4QwWjj9OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0LMHKa8LlxQAVkaE0WvaBYVXdkWOfPuTdDSjbFTBVrTgXi6rKW0Atpsq+87AoMfpQ
	 N+Wedbu77bd3H8P3KOG5WD0EroKyAJNVEhAo/zckCPSP5zW0L5vQAUhXX4M6qdZJEe
	 wezow37NnGWwUdTeVk0b0GxHPLQLVRBvzO1psrww=
Date: Mon, 29 Apr 2024 12:52:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: stable@vger.kernel.org, Chen Jiahao <chenjiahao16@huawei.com>,
	Baoquan He <bhe@redhat.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
Message-ID: <2024042944-wriggle-countable-627c@gregkh>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
 <2024041939-isotope-client-3d75@gregkh>
 <a5493f44-2aac-4005-992b-f2ac90cd1835@iscas.ac.cn>
 <2024042318-muppet-snippet-617c@gregkh>
 <5d49f626-a66f-4969-a03f-fcf83e2d2bab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d49f626-a66f-4969-a03f-fcf83e2d2bab@iscas.ac.cn>

On Wed, Apr 24, 2024 at 11:40:16AM +0800, Mingzheng Xing wrote:
> On 4/23/24 21:12, Greg Kroah-Hartman wrote:
> > On Fri, Apr 19, 2024 at 10:55:44PM +0800, Mingzheng Xing wrote:
> >> On 4/19/24 21:58, Greg Kroah-Hartman wrote:
> >>> On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
> >>>> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
> >>>>> On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
> >>>>>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
> >>>>>> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
> >>>>>> interface to simplify crashkernel reservation"), but the latter's series of
> >>>>>> patches are not included in the 6.6 branch.
> >>>>>>
> >>>>>> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
> >>>>>> loading the kernel will also cause an error:
> >>>>>>
> >>>>>> ```
> >>>>>> Memory for crashkernel is not reserved
> >>>>>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> >>>>>> Then try to loading kdump kernel
> >>>>>> ```
> >>>>>>
> >>>>>> After revert this patch, verify that it works properly on QEMU riscv.
> >>>>>>
> >>>>>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
> >>>>>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> >>>>>> ---
> >>>>>
> >>>>> I do not understand, what branch is this for?  Why have you not cc:ed
> >>>>> any of the original developers here?  Why does Linus's tree not have the
> >>>>> same problem?  And the first sentence above does not make much sense as
> >>>>> a 6.6 change is merged into 6.7?
> >>>>
> >>>> Sorry, I'll try to explain it more clearly.
> >>>>
> >>>> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
> >>>> on RISC-V") should not have existed because this patch has been merged into
> >>>> another larger patch [1]. Here is that complete series:
> >>>
> >>> What "larger patch"?  It is in Linus's tree, so it's not part of
> >>> something different, right?  I'm confused.
> >>>
> >>
> >> Hi, Greg
> >>
> >> The email Cc:ed to author Chen Jiahao was bounced by the system, so maybe
> >> we can wait for Baoquan He to confirm.
> >>
> >> This is indeed a bit confusing. The Fixes: tag in 1d6cd2146c2b58 is a false
> >> reference. If I understand correctly, this is similar to the following
> >> scenario:
> >>
> >> A Fixes B, B doesn't go into linus mainline. C contains A, C goes into linus
> >> mainline 6.7, and C has more reconstruction code. but A goes into 6.6, so
> >> it doesn't make sense for A to be in the mainline, and there's no C in 6.6
> >> but there's an A, thus resulting in an incomplete code that creates an error.
> >>
> >> The link I quoted [1] shows that Baoquan had expressed an opinion on this
> >> at the time.
> >>
> >> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
> > 
> > I'm sorry, but I still do not understand what I need to do here for a
> > stable branch.  Do I need to apply something?  Revert something?
> > Something else?
> 
> Hi, Greg
> 
> I saw Baoquan's reply in thread[1], thanks Baoquan for confirming.
> 
> So I think the right thing to do would be just to REVERT the commit
> 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem on RISC-V")
> in the 6.6.y branch, which is exactly the patch I submitted. If I need to
> make changes to my commit message, feel free to let me know and I'll post
> the second version.
> 
> Link: https://lore.kernel.org/stable/ZihbAYMOI4ylazpt@MiWiFi-R3L-srv [1]

Can someone just send me a patch series showing EXACTLY what needs to be
done here, as I am _still_ confused.

thanks,

greg k-h

