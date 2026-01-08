Return-Path: <stable+bounces-206301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7AD04208
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BC4D30E4760
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B762358D2B;
	Thu,  8 Jan 2026 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2vY4++ms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C0320CA7
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867694; cv=none; b=oLsRaIx+Glhdnl0uKschPEqRhsPlva+b1Ig6PF4BbjM06oOCoFKllOCNQmi9O9xjxXeZ5jJtW8a1Xpyv0ir510/j03gsW2Fu4AEj2GNFpb7zDZ3m3NAG/BUA6fIVoRI/1PHsdcEWUUDrt0Yzi9kiD79DS8/1k9P+lUkk3vXY/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867694; c=relaxed/simple;
	bh=LlDC+52H2OkWQCFlkYOxNG0lg9a4ZDE6B5qGLfa5gT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaCm+XjZvGz0/vUIrTa+WWS1wUZPvN6pubqwCzLk2Lq268erNa0cnfpnUpCvSmIRQO6IBd2m9Cyr4z4GhjBn04gwFp5Br4fTeDf2MdXfjhTPq9wi6/ZnymaYZ0iiozIk6uSHhcQ7pLPGpRBn1Botnxm0o+Lw+iUmMc+EirYTXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2vY4++ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902F3C116C6;
	Thu,  8 Jan 2026 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767867693;
	bh=LlDC+52H2OkWQCFlkYOxNG0lg9a4ZDE6B5qGLfa5gT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2vY4++mscI6lgX01vOJ8MQQ7xWxwadVQoFUxxKx1iLaUQFuTA9qO0lYVBg+O57X5H
	 hzlFZb4BuvHGessF9QEZAtTtOLKOLJJmuwAH23Q69eB8UFz/2eCmuKzONpesTm25Fi
	 4wcODPiHsuIPjNb5j9pj4r4YutZpF3PiBSSnq76g=
Date: Thu, 8 Jan 2026 11:21:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Viktor =?iso-8859-1?Q?J=E4gersk=FCpper?= <viktor_jaegerskuepper@freenet.de>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
Message-ID: <2026010817-tidy-levers-5919@gregkh>
References: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
 <2025121502-amenity-ragged-720c@gregkh>
 <b78aadb1-d2ca-459c-8078-b1cd9a500398@oss.qualcomm.com>
 <2025121500-portside-coleslaw-915b@gregkh>
 <0f92d42d-5df8-423b-82a4-7fa9342d69ef@oss.qualcomm.com>
 <e67f2f0b-e9ce-4dfb-a4b4-1ff0425b52dd@freenet.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e67f2f0b-e9ce-4dfb-a4b4-1ff0425b52dd@freenet.de>

On Fri, Dec 19, 2025 at 02:41:17PM +0100, Viktor Jägersküpper wrote:
> (Adding Sasha to this thread)
> 
> Hans de Goede wrote:
> > Hi Greg,
> > 
> > On 15-Dec-25 10:05 AM, Greg KH wrote:
> >> On Mon, Dec 15, 2025 at 09:15:17AM +0100, Hans de Goede wrote:
> >>> Hi greg,
> >>>
> >>> On 15-Dec-25 9:12 AM, Greg KH wrote:
> >>>> On Sun, Dec 14, 2025 at 10:53:36AM +0100, Hans de Goede wrote:
> >>>>> From: Alex Deucher <alexander.deucher@amd.com>
> >>>>>
> >>>>> commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.
> >>>>>
> >>>>> SI hardware doesn't support pasids, user mode queues, or
> >>>>> KIQ/MES so there is no need for this.  Doing so results in
> >>>>> a segfault as these callbacks are non-existent for SI.
> >>>>>
> >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
> >>>>> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
> >>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> >>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
> >>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> What kernel tree(s) should this go to?
> >>>
> >>> This fixes a regression introduced in at least 6.17.y (6.17.11)
> >>> and 6.18.y (6.18.1). So it should at least go to those branches.
> >>
> >> But that commit is in 6.19-rc1, not anything older.
> >>
> >>> If any other branches also have gotten commit f3854e04b708
> >>> backported then those should get this too.
> >>
> >> I don't see that commit in any stable tree, what am I missing?
> > 
> > Ah, I see now the Fixes tag in the original fix (which I cherry
> > picked) is wrong and does not point to the canonical commit id as
> > merged into Torvalds tree, sorry.
> > 
> > This is b4a7f4e7ad2b120a94f3111f92a11520052c762d  ("drm/amdgpu:
> > attach tlb fence to the PTs update") in Torvalds' tree:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4a7f4e7ad2b120a94f3111f92a11520052c762d
> > 
> > and this actually made it into the v6.18 tag (vs being introduced
> > in 6.18.1 as I originally thought).
> > 
> > This is also in 6.17.11 as 23316ed02c228b52f871050f98a155f3d566c450
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd?h=linux-6.17.y&id=23316ed02c228b52f871050f98a155f3d566c450
> > 
> > FWIW I don't see it in 6.12.y (and I did not look further back).
> > 
> > Regards,
> > 
> > Hans
> Can this fix be added to the 6.18 queue, please? All relevant
> information can be found in the previous email from Hans.

This is now in the 6.18.4 release.

thanks,

greg k-h

