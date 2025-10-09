Return-Path: <stable+bounces-183684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A49BC8CAD
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF453A6B3B
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC52DECAA;
	Thu,  9 Oct 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMEeY56d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430B24418E;
	Thu,  9 Oct 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009186; cv=none; b=V+Ch7mmsGkMFIRvOLLJ/MIqBU0j7HnwE277XNMkMfY77GhlkOTmXeuRIihoQ0YUrSEMMre1ebGTtikNMf2X7Yv5DJZgr7D8+ryaw5GyAqLiip2SOuKMKkNSuKPrqNOzCF9cO89V9mB2TuVk+P0zq+6dJesykMF8bmPqzLbIKjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009186; c=relaxed/simple;
	bh=zIKOZbd68lJ41wH30gEwKJuQE0RnMS2JMWAzhmI7j2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxSHBtdnoo+qWK1xYOLpx5ZUjAYpzmExkgRzoGv/4mp9XbuOVxUkDrwM0lTsuAnnzrmPIqRnLPRDJUwkEIcGDO7bnPuFSvYo+jJbWosboJX6xryr3tmsAw74s248znrJL5l/7auxER2+WtT94kvSxY6XPZva4aB9sZt5iJvFFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMEeY56d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167D6C4CEE7;
	Thu,  9 Oct 2025 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760009185;
	bh=zIKOZbd68lJ41wH30gEwKJuQE0RnMS2JMWAzhmI7j2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMEeY56dLi8IBy10c8k2ueHt/UWB5qI2ZOkzSyoZ/n0QKttfSku0wWA3OulvQkkRY
	 IhLESDHx8+CUw8XT4j1KN83q7MNmLeUog0IJEYUUgyjWuYhClqEs0OpPsUp4LJPhqx
	 /a9Em48neWPipuEFiMAtXYeOrv5yNkss90d77csI=
Date: Thu, 9 Oct 2025 13:26:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio:
 Kill timer properly at removal
Message-ID: <2025100940-unrevised-passcode-6682@gregkh>
References: <20251007155808.438441-1-aha310510@gmail.com>
 <2025100824-frolic-spout-d400@gregkh>
 <CAO9qdTEo46hCZ0UXKjjBQ4W2sLT2+5zw9DugQF98sqpHLyNzPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTEo46hCZ0UXKjjBQ4W2sLT2+5zw9DugQF98sqpHLyNzPg@mail.gmail.com>

On Thu, Oct 09, 2025 at 08:23:42PM +0900, Jeongjun Park wrote:
> Hi Greg,
> 
> Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 08, 2025 at 12:58:08AM +0900, Jeongjun Park wrote:
> > > From: Takashi Iwai <tiwai@suse.de>
> > >
> > > [ Upstream commit 0718a78f6a9f04b88d0dc9616cc216b31c5f3cf1 ]
> > >
> > > The USB-audio MIDI code initializes the timer, but in a rare case, the
> > > driver might be freed without the disconnect call.  This leaves the
> > > timer in an active state while the assigned object is released via
> > > snd_usbmidi_free(), which ends up with a kernel warning when the debug
> > > configuration is enabled, as spotted by fuzzer.
> > >
> > > For avoiding the problem, put timer_shutdown_sync() at
> > > snd_usbmidi_free(), so that the timer can be killed properly.
> > > While we're at it, replace the existing timer_delete_sync() at the
> > > disconnect callback with timer_shutdown_sync(), too.
> > >
> > > Reported-by: syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/681c70d7.050a0220.a19a9.00c6.GAE@google.com
> > > Cc: <stable@vger.kernel.org>
> > > Link: https://patch.msgid.link/20250519212031.14436-1-tiwai@suse.de
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > [ del_timer vs timer_delete differences ]
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  sound/usb/midi.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > > index a792ada18863..c3de2b137435 100644
> > > --- a/sound/usb/midi.c
> > > +++ b/sound/usb/midi.c
> > > @@ -1530,6 +1530,7 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> > >                       snd_usbmidi_in_endpoint_delete(ep->in);
> > >       }
> > >       mutex_destroy(&umidi->mutex);
> > > +     timer_shutdown_sync(&umidi->error_timer);
> >
> > This function is not in older kernel versions, you did not test this
> > build :(
> >
> > I've applied this to 6.6.y and newer, but for 6.1.y and older, please
> > use the proper function.
> 
> Sorry, I didn't realize that the timer_shutdown_sync() implementation
> commit wasn't backported to versions prior to 6.2.
> 
> But why wasn't this feature backported to previous versions? I understand
> that most drivers write separate patches for pre-6.2 versions that don't
> implement timer_shutdown_sync() to address this type of bug.

Features are not backported to older kernels.  If you want this fix in
an older kernel, then you need to either backport that feature, or fix
up the driver to use whatever was used before that function existed.

thanks,

greg k-h

