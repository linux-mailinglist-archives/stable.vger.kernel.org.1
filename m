Return-Path: <stable+bounces-111238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D6A22604
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 23:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EA01883AA7
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBE1B6525;
	Wed, 29 Jan 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Bibcts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C621917C7;
	Wed, 29 Jan 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188106; cv=none; b=L2r7S29iltm1Oqkzx/EwO7OwjtHQd0pPxQhxFQ3uHFARiTYPZWHh20fEgtXjX8HUsOqAw3DbFFZz58FUoJn45zLFqOFIs3A5OE5uggRfUGT+Rkzx1wdL5HcbRmdUem0psQU33GM7wNe3HXRGtVz93/GwyES+wV36w7O+OVrHIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188106; c=relaxed/simple;
	bh=2Fp+uQjCLRYwrOD0BSfZrFoIEtJ6UcOoCawTUl51tD4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RZFO3Sdg2jXDS3E2sKGZ1/oON3U56BwDcUVKojVmrIRrcRAwCzsFGyu1K2rBacXINAdsdaasxwDmhv+T6JY5VJU0z/3IKvSI7LtFsSDXu24+Pj3GjvtDny85CfZAjSQ33Znllgp76NkPaDZiBjIw4fgY3QPyMgdx46wYPt9EGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Bibcts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC67C4CED1;
	Wed, 29 Jan 2025 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738188105;
	bh=2Fp+uQjCLRYwrOD0BSfZrFoIEtJ6UcOoCawTUl51tD4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=M1Bibcts0FNJcnusFPjMrEJ5gQxIzgQPHrO+EUT7BpuoxONsXjElEICLQqUPo9xNV
	 ckUoU2CvH+RQ3ejer5U4meHn2AnViAnLmEq122K8wOr3tCiV+j/zpjpF2rrPbmQS0w
	 BCtA0EUiG3vorW1tvp2czdQcAPFIPLZLeUI5HMX9W6/gUoVFmaHHxSh8WR+2Pd91Tg
	 CHdtqgqxB5xDmWGnqi1Dm9RO4FbztV2U5SogwdAJd+gvcu3sY5rVfcjM7dmxNxagza
	 Fr1H9/FqUGSkUTNf37YktvvkxJFEF0MlodCAFmHt1li22/uMA4mGzkTsbl47J4Crsv
	 nhX/Ziy5oujlg==
Date: Wed, 29 Jan 2025 14:01:35 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, 
    Greg KH <gregkh@linuxfoundation.org>, Konrad Wilk <konrad.wilk@oracle.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    "sstabellini@kernel.org" <sstabellini@kernel.org>, 
    "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
    stable@vger.kernel.org
Subject: Re: v5.4.289 failed to boot with error megasas_build_io_fusion 3219
 sge_count (-12) is out of range
In-Reply-To: <de6912ad-3dba-4d66-8ca2-71a0aa09172c@suse.com>
Message-ID: <alpine.DEB.2.22.394.2501291401290.11632@ubuntu-linux-20-04-desktop>
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com> <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com> <2025012919-series-chaps-856e@gregkh> <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com> <2025012936-finalize-ducktail-c524@gregkh>
 <1f017284-1a29-49d8-b0d9-92409561990e@oracle.com> <2025012956-jiffy-condone-3137@gregkh> <1f225b8d-d958-4304-829e-8798884d9b6b@oracle.com> <83bd90c7-8879-4462-9548-bb5b69cac39e@suse.com> <b4ab0246-3846-41d1-8e84-64bd7fefc089@oracle.com>
 <de6912ad-3dba-4d66-8ca2-71a0aa09172c@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-408514709-1738188105=:11632"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-408514709-1738188105=:11632
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jan 2025, Jürgen Groß wrote:
> On 29.01.25 19:35, Harshvardhan Jha wrote:
> > 
> > On 29/01/25 4:52 PM, Juergen Gross wrote:
> > > On 29.01.25 10:15, Harshvardhan Jha wrote:
> > > > 
> > > > On 29/01/25 2:34 PM, Greg KH wrote:
> > > > > On Wed, Jan 29, 2025 at 02:29:48PM +0530, Harshvardhan Jha wrote:
> > > > > > Hi Greg,
> > > > > > 
> > > > > > On 29/01/25 2:18 PM, Greg KH wrote:
> > > > > > > On Wed, Jan 29, 2025 at 02:13:34PM +0530, Harshvardhan Jha wrote:
> > > > > > > > Hi there,
> > > > > > > > 
> > > > > > > > On 29/01/25 2:05 PM, Greg KH wrote:
> > > > > > > > > On Wed, Jan 29, 2025 at 02:03:51PM +0530, Harshvardhan Jha
> > > > > > > > > wrote:
> > > > > > > > > > Hi All,
> > > > > > > > > > 
> > > > > > > > > > +stable
> > > > > > > > > > 
> > > > > > > > > > There seems to be some formatting issues in my log output. I
> > > > > > > > > > have
> > > > > > > > > > attached it as a file.
> > > > > > > > > Confused, what are you wanting us to do here in the stable
> > > > > > > > > tree?
> > > > > > > > > 
> > > > > > > > > thanks,
> > > > > > > > > 
> > > > > > > > > greg k-h
> > > > > > > > Since, this is reproducible on 5.4.y I have added stable. The
> > > > > > > > culprit
> > > > > > > > commit which upon getting reverted fixes this issue is also
> > > > > > > > present in
> > > > > > > > 5.4.y stable.
> > > > > > > What culprit commit?  I see no information here :(
> > > > > > > 
> > > > > > > Remember, top-posting is evil...
> > > > > > My apologies,
> > > > > > 
> > > > > > The stable tag v5.4.289 seems to fail to boot with the following
> > > > > > prompt in an infinite loop:
> > > > > > [   24.427217] megaraid_sas 0000:65:00.0: megasas_build_io_fusion
> > > > > > 3273 sge_count (-12) is out of range. Range is:  0-256
> > > > > > 
> > > > > > Reverting the following patch seems to fix the issue:
> > > > > > 
> > > > > > stable-5.4      : v5.4.285             - 5df29a445f3a xen/swiotlb:
> > > > > > add
> > > > > > alignment check for dma buffers
> > > > > > 
> > > > > > I tried changing swiotlb grub command line arguments but that didn't
> > > > > > seem to help much unfortunately and the error was seen again.
> > > > > > 
> > > > > Ok, can you submit this revert with the information about why it
> > > > > should
> > > > > not be included in the 5.4.y tree and cc: everyone involved and then
> > > > > we
> > > > > will be glad to queue it up.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > This might be reproducible on other stable trees and mainline as well so
> > > > we will get it fixed there and I will submit the necessary fix to stable
> > > > when everything is sorted out on mainline.
> > > 
> > > Right. Just reverting my patch will trade one error with another one (the
> > > one which triggered me to write the patch).
> > > 
> > > There are two possible ways to fix the issue:
> > > 
> > > - allow larger DMA buffers in xen/swiotlb (today 2MB are the max.
> > > supported
> > >    size, the megaraid_sas driver seems to effectively request 4MB)
> > 
> > This seems relatively simpler to implement but I'm not sure whether it's
> > the most optimal approach
> 
> Just making the static array larger used to hold the frame numbers for the
> buffer seems to be a waste of memory for most configurations.
> 
> I'm thinking of an allocated array using the max needed size (replace a
> former buffer with a larger one if needed).

You are referring to discontig_frames and MAX_CONTIG_ORDER in
arch/x86/xen/mmu_pv.c, right? I am not super familiar with that code but
it looks like a good way to go.
--8323329-408514709-1738188105=:11632--

