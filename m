Return-Path: <stable+bounces-93654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F079CFFC5
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8699B287A48
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837773477;
	Sat, 16 Nov 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cl37xQx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F038385
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773239; cv=none; b=kYySHqGC2Z4WWv1HScCo2ETY9fi7c5i8DD1i6lrLf5h1jXYdpT5V0q+5XvAxM2Fe4oZ4S+K8p61j3gqNG96JXikuLKNSzjr1CEy2u2awhToJBUiZXGgzTOCZE5Xu2vHfUdr5dDe08EBKVZOzPp2ApCuVPec02hUs7xxHEpoNKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773239; c=relaxed/simple;
	bh=IuOCJT9rqQH1aWOOxcQHnK5i7CUcLjGUPoo0r+PtysA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3O12JQCYNwwmNzaXFrrjVSTdpx2l/+y3KL9McYZrc2QAnXuTTQxAKMYgo+NwJ6K8wRGtDcmpu2WYmpn0zyMGG3KxKCEabfvZC222z/p3YDH3otxuK1AMTLEt/lEf/fI4rPGc1HatL2JcFwnBe0Ybq51+E5VklgYr7z0Y378lyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cl37xQx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A493C4CEC3;
	Sat, 16 Nov 2024 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731773237;
	bh=IuOCJT9rqQH1aWOOxcQHnK5i7CUcLjGUPoo0r+PtysA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl37xQx/DAYq2Vcx6uEiBCHtmYz+ef93zXrwxfqM20Z+fH2ahX+DOsQ1hDrI83Fs8
	 NpihF317EYErHYnRkd2rWL2RhkybnCdzk6Bqe5EkTNtQOdHgM3ciYINRgzifZ1gyMC
	 083IGzt8VJ7zJ9RfIjEl8AUiFnrSD5XEiUCm5NmY=
Date: Sat, 16 Nov 2024 17:06:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
Message-ID: <2024111617-subarctic-repeater-c06f@gregkh>
References: <20241116130427.1688714-1-alexander.deucher@amd.com>
 <2024111614-conjoined-purity-5dcb@gregkh>
 <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>
 <2024111653-storm-haste-2272@gregkh>
 <CADnq5_MPEwVGmnMBz_xzO4ZCBM0kgqP=rzwK+L5VPjwpnRj9+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MPEwVGmnMBz_xzO4ZCBM0kgqP=rzwK+L5VPjwpnRj9+A@mail.gmail.com>

On Sat, Nov 16, 2024 at 10:07:38AM -0500, Alex Deucher wrote:
> On Sat, Nov 16, 2024 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 16, 2024 at 08:48:58AM -0500, Alex Deucher wrote:
> > > On Sat, Nov 16, 2024 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> > > > > This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> > > > >
> > > > > This causes a regression in the workload selection.
> > > > > A more extensive fix is being worked on for mainline.
> > > > > For stable, revert.
> > > >
> > > > Why is this not reverted in Linus's tree too?  Why is this only for a
> > > > stable tree?  Why can't we take what will be in 6.12?
> > >
> > > I'm about to send out the patch for 6.12 as well, but I want to make
> > > sure it gets into 6.11 before it's EOL.
> >
> > If 6.11 is EOL, there's no need to worry about it :)
> 
> End users care :)
> 
> >
> > I'd much prefer to take the real patch please.
> 
> Here's the PR I sent to Dave and Sima:
> https://lists.freedesktop.org/archives/dri-devel/2024-November/477927.html
> I didn't cc stable because I had already send this patch to stable in
> this thread.

I'd much rather prefer to match up with what is in Linus's tree.  If you
have the git id that lands in Linus's tree, please let us know and we
can take that.  This way we can keep 6.11 and 6.12 in sync, right?

thanks,

greg k-h

