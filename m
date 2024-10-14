Return-Path: <stable+bounces-83813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462F99CBCA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18F0B229DE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF69475;
	Mon, 14 Oct 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRx0CkB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFD231C8A
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913565; cv=none; b=VfxUvjf6/jvFSsWN2TJOzBeG2v+cTIqZ/RPN4YRXvC5qz30afDMAgw02J3lK6hKab1IwBolieMllMmzMacJgVkrMRz5bBTDeWWs85NwHgyH/qsrmoTmg//KXU4jBHcMiSCDRuHxiqGWLcfizTZ2RitcUyYAJUEeA90jmJwSle2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913565; c=relaxed/simple;
	bh=HKBZkahpmMGflVDyaBRXvcjHLsxx0VQgUZ0K8O4EB4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urvCHojrXAZuoceEDO33EVtJ+fZcuVCW9ZSQvKYKKwVpzqPOe37Ta7LniNzMQgSErbuHKg71sem3sSGZcFcONiG3K9mZOMFvsjwnBMnWzwlkw6NQ5JGWo5OUeC98FsT7GKf/7k7ynytD34fyzPV8D0KCD9i4k0sX0mCcZxDTWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRx0CkB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CDCC4CEC7;
	Mon, 14 Oct 2024 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728913565;
	bh=HKBZkahpmMGflVDyaBRXvcjHLsxx0VQgUZ0K8O4EB4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRx0CkB4OvnHgDrgYlIdtnWewJcj3YkuUaNieKF767pIO6JepyIRATG3iLzD6IZXl
	 B+K3IY23K5lmb7Dz58C23rbjuNB2gTef3pCe36XceUNJp3z7rYKBrsxhDXIxDf8IV4
	 VbyB4JoTZaPjSgMcDQXpasOXZgg+JVIrvKaZzw+A=
Date: Mon, 14 Oct 2024 15:46:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	stable <stable@vger.kernel.org>, jroedel@suse.de,
	Sasha Levin <sashal@kernel.org>, x86@kernel.org
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
Message-ID: <2024101448-gristle-rewire-31b8@gregkh>
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
 <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
 <2024101000-duplex-justify-97e6@gregkh>
 <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
 <635be050-f0ab-4242-ac79-db67d561dae9@linux.intel.com>
 <9539f133-2cdb-4aa8-8eac-ddf649819d98@linux.intel.com>
 <CAMGffEm-4t21nrV2DPX8+7jPKH-Ahf-wQLSzCobApi=ge8GFvw@mail.gmail.com>
 <CAMGffEn38nt+GUrCTCLi6G82rD1bHXrg-aULbxfSQge6Bu+VFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEn38nt+GUrCTCLi6G82rD1bHXrg-aULbxfSQge6Bu+VFA@mail.gmail.com>

On Mon, Oct 14, 2024 at 11:39:57AM +0200, Jinpu Wang wrote:
> Hi Greg,
> 
> 
> On Fri, Oct 11, 2024 at 7:22 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> >
> > Hi Baolu, Liang
> >
> > Thanks for the reply.
> >
> > On Thu, Oct 10, 2024 at 4:01 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > >
> > > On 2024/10/10 21:25, Liang, Kan wrote:
> > > > On 2024-10-10 6:10 a.m., Jinpu Wang wrote:
> > > >> Hi Greg,
> > > >>
> > > >>
> > > >> On Thu, Oct 10, 2024 at 11:31 AM Greg KH<gregkh@linuxfoundation.org> wrote:
> > > >>> On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
> > > >>>> Hi Greg,
> > > >>>>
> > > >>>> On Thu, Oct 10, 2024 at 11:07 AM Greg KH<gregkh@linuxfoundation.org> wrote:
> > > >>>>> On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> > > >>>>>> Hello all,
> > > >>>>>>
> > > >>>>>> We are experiencing a boot hang issue when booting kernel version
> > > >>>>>> 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> > > >>>>>> 6710E processor. After extensive testing and use of `git bisect`, we
> > > >>>>>> have traced the issue to commit:
> > > >>>>>>
> > > >>>>>> `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
> > > >>>>>>
> > > >>>>>> This commit appears to be part of a larger patchset, which can be found here:
> > > >>>>>> [Patchset on lore.kernel.org](https://lore.kernel.org/
> > > >>>>>> lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
> > > >>>>>>
> > > >>>>>> We attempted to boot with the `intel_iommu=off` option, but the system
> > > >>>>>> hangs in the same manner. However, the system boots successfully after
> > > >>>>>> disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
> > > >>>>> Is there any error messages?  Does the latest 6.6.y tree work properly?
> > > >>>>> If so, why not just use that, no new hardware should be using older
> > > >>>>> kernel trees anyway 🙂
> > > >>>> No error, just hang, I've removed "quiet" and added "debug".
> > > >>>> Yes, the latest 6.6.y tree works for this, but there are other
> > > >>>> problems/dependency we have to solve.
> > > >>> Ok, that implies that we need to add some other patch to 6.1.y, OR we
> > > >>> can revert it from 6.1.y.  Let me know what you think is the better
> > > >>> thing to do.
> > > >>>
> > > >> I think better to revert both:
> > > >> 8c91a4bfc7f8 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
> > > > I'm not sure about this one. May need baolu's comments.
> > >
> > > I can't find this commit in the mainline kernel. I guess it fixes a
> > > compilation issue in the stable tree? If so, it depends on whether the
> > > issue is still there.
> > >
> > > Thanks,
> > > baolu
> >
> > Both commits are hash from stable tree for linux-6.1.y branch.
> > I tried only revert  586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon
> > capability information")
> >
> > There is a minor conflict in the Makefile, but it's easy to fix. I
> > attached the patch below,
> > Greg please consider including it.
> >
> > Thx!
> I'm attaching the revert here again, maybe you missed the email,
> please consider to include it in 6.1.y.

I did miss that, sorry, now queued up!

greg k-h

