Return-Path: <stable+bounces-74063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99291971FD4
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6A284C58
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD016EB7C;
	Mon,  9 Sep 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIOI5lWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF251531E6;
	Mon,  9 Sep 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901412; cv=none; b=sRpyPBU1L6eYlghieHoukv0qZgb7vwehXXK2DdXkS01wrLIe3RTEsMOmgeAaBmlx2+nSs3IC/Z43JFJkix2DdkrtZOcQM9WRUeDkOs058mWNtoHSsM/vejS9jtDmib6gmlUZJEGnqWTikD9f45sJqbDV1mp/UFRACeq4IwiNVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901412; c=relaxed/simple;
	bh=4Y9tPEx+yB14FgRlzZ2Xln0OiRO09Ye7shaG5K4o88E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKQe0IT5tIIcJfGh/n3NA75vjWzf+kKaVxufXvYzTvV1NIXdPjPUhNbC4WnbxH9pYRZTerUtZNVJoAMBy4A1MbggRQg7XTUArQbYu1joKPJSK4h/UpFGOE1vsZJwGVviQU3Jv/+knJoJcdy2q/PtQwnjmcMXv/LtqdD28K8u/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIOI5lWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC19C4CEC5;
	Mon,  9 Sep 2024 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725901410;
	bh=4Y9tPEx+yB14FgRlzZ2Xln0OiRO09Ye7shaG5K4o88E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIOI5lWiYSpudvwBTsdWRd/SBLdkEmUkNfmpD84viKWgLFZ8kpROBVqGGdJejb3Bz
	 EzzA8r2HomI4iZUkSr9Eg89tpZwUf9q5Kk0QH8giOI2XJkeaavQEK16SEzzOsIfQII
	 8sAN608R+GjTTbCgW/hx7AwPjmudTsK+nzHUaAhw=
Date: Mon, 9 Sep 2024 19:03:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Christian Theune <christian@theune.cc>, regressions@lists.linux.dev,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	mathieu.tortuyaux@gmail.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
Message-ID: <2024090952-grope-carol-537b@gregkh>
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
 <2024090309-affair-smitten-1e62@gregkh>
 <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>

On Mon, Sep 09, 2024 at 12:05:17AM -0400, Willem de Bruijn wrote:
> On Tue, Sep 3, 2024 at 4:03 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 09:37:30AM +0200, Christian Theune wrote:
> > > Hi,
> > >
> > > the issue was so far handled in https://lore.kernel.org/regressions/ZsyMzW-4ee_U8NoX@eldamar.lan/T/#m390d6ef7b733149949fb329ae1abffec5cefb99b and https://bugzilla.kernel.org/show_bug.cgi?id=219129
> > >
> > > I haven’t seen any communication whether a backport for 5.15 is already in progress, so I thought I’d follow up here.
> >
> > Someone needs to send a working set of patches to apply.
> 
> The following stack of patches applies cleanly to 5.15.166
> (original SHA1s, git log order, so inverse of order to apply):
> 
> 89add40066f9e net: drop bad gso csum_start and offset in virtio_net_hdr
> 9840036786d9 gso: fix dodgy bit handling for GSO_UDP_L4
> fc8b2a619469 net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
> 
> All three are already present in 6.1.109
> 
> Please let me know if I should send that stack using git send-email,
> or whether this is sufficient into to backport.

I just tried it, they do not apply cleanly here for me at all :(

> The third commit has one Fixes referencing them:
> 
> 1382e3b6a350 net: change maximum number of UDP segments to 128
> 
> This simple -2/+2 line patch unfortunately cannot be backported
> without conflicts without backporting non-stable feature changes.
> There is a backport to 6.1.y, but that also won't apply cleanly to
> 5.15.166 without backporting a feature (e2a4392b61f6 "udp: introduce
> udp->udp_flags"), which itself does not apply cleanly.
> 
> So simplest is probably to fix up this commit and send it using git
> send-email. I can do that as part of the stack with the above 3
> patches, or stand-alone if the above can be cherry-picked by SHA1.

Please send me a set of working, and tested, patches and we will be glad
to consider it.

thanks,

greg k-h

