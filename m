Return-Path: <stable+bounces-93801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3CD9D12E5
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4AD1F23B3E
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91F1A0BF3;
	Mon, 18 Nov 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjEQNruu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634E19F41A
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939762; cv=none; b=gmMx4wFpmqbxAGFa+j4oNM0YMyvZ8qltDZ6wsMo/cXqSB1m74b+SWIfAQiommS9Odg0uLNVh4mp9xm27h9OTwJd33Hpq1YA68UbOPJxSl4vOHvRog44JuR3oLF+L0gcdhVaQr9+nd2azKBuKFkJWV9i++WG6zeCOWKgW6ATjC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939762; c=relaxed/simple;
	bh=Jx3+KGGMRnqTMpMSN+WOX4zJ1NXsiiiQG8JGtRgJxrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHihSic0jR0QTC5jlPxA0RKVjk/V5IUWIuFPXSgoyEJLJRpvKurmZiVEHu7iTBHgpqD/a8A9Fc0s9BfwPF8TOV6RVxpgx5T/kE32iT4dOcYGW2Lt/C8HDnNtym6JGJBdFNJj9dzDCQ+ygGUzX6fB8k7eLfzQJ7jkKDAze++HcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjEQNruu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF40C4CECC;
	Mon, 18 Nov 2024 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731939762;
	bh=Jx3+KGGMRnqTMpMSN+WOX4zJ1NXsiiiQG8JGtRgJxrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjEQNruuxtt7dlcv8ZhmM/KV30YsGCBrznHksPf3VWqqOuxxF7xjNPF4p9Qqx5Z5j
	 SfM7szKKYzs8WmQx7df9OwmlZ4HY6CYgQUOc+KoC8pokkGE3ehgH9j6EZpyDVByOOh
	 jBpoyO3lprljSRhd3g0xtK7g9QNTng6ptPg6rOpM=
Date: Mon, 18 Nov 2024 15:22:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
Message-ID: <2024111856-reconfirm-obsessive-7745@gregkh>
References: <20241116130427.1688714-1-alexander.deucher@amd.com>
 <2024111614-conjoined-purity-5dcb@gregkh>
 <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>
 <2024111653-storm-haste-2272@gregkh>
 <CADnq5_MPEwVGmnMBz_xzO4ZCBM0kgqP=rzwK+L5VPjwpnRj9+A@mail.gmail.com>
 <2024111617-subarctic-repeater-c06f@gregkh>
 <CADnq5_OhPc5gia7AH4diYi3SZvUPHFLPxsJNxn20+02t+Otomg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OhPc5gia7AH4diYi3SZvUPHFLPxsJNxn20+02t+Otomg@mail.gmail.com>

On Mon, Nov 18, 2024 at 09:09:53AM -0500, Alex Deucher wrote:
> On Sat, Nov 16, 2024 at 11:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 16, 2024 at 10:07:38AM -0500, Alex Deucher wrote:
> > > On Sat, Nov 16, 2024 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Nov 16, 2024 at 08:48:58AM -0500, Alex Deucher wrote:
> > > > > On Sat, Nov 16, 2024 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> > > > > > > This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> > > > > > >
> > > > > > > This causes a regression in the workload selection.
> > > > > > > A more extensive fix is being worked on for mainline.
> > > > > > > For stable, revert.
> > > > > >
> > > > > > Why is this not reverted in Linus's tree too?  Why is this only for a
> > > > > > stable tree?  Why can't we take what will be in 6.12?
> > > > >
> > > > > I'm about to send out the patch for 6.12 as well, but I want to make
> > > > > sure it gets into 6.11 before it's EOL.
> > > >
> > > > If 6.11 is EOL, there's no need to worry about it :)
> > >
> > > End users care :)
> > >
> > > >
> > > > I'd much prefer to take the real patch please.
> > >
> > > Here's the PR I sent to Dave and Sima:
> > > https://lists.freedesktop.org/archives/dri-devel/2024-November/477927.html
> > > I didn't cc stable because I had already send this patch to stable in
> > > this thread.
> >
> > I'd much rather prefer to match up with what is in Linus's tree.  If you
> > have the git id that lands in Linus's tree, please let us know and we
> > can take that.  This way we can keep 6.11 and 6.12 in sync, right?
> 
> Sure, but if the patch happened to miss 6.12.0, it would have landed
> in 6.12.1.  If that happened 6.11 may have missed it and right now and
> for the near future, 6.11 is what is important to users and distros.
> Anyway, the patch landed before 6.12 final, so please pull:
> commit 44f392fbf628 ("Revert "drm/amd/pm: correct the workload setting"")
> into 6.11 stable.

It's already been queued up, happened yesterday :)

thanks,

greg k-h

