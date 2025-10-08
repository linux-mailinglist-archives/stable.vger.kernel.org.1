Return-Path: <stable+bounces-183582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E4BC3667
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 07:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40D33C7DD5
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3022EA491;
	Wed,  8 Oct 2025 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTHiFudH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929314A09C;
	Wed,  8 Oct 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759902847; cv=none; b=uHshFhesxpL3nxg+EmWZb6pFhQgFV0VR53SfGt8YdTeND/MMIv1TYQK2X1M0kzD7MnlZLmLQKr6CiWhCd3vRxKK6309rQh+uS7/C6yIykeF14/hqzBAfJi7QDH6jtKWY1Xh37HhbwCeVT2a9Xg4AX8ZLvALkU0cxk5q4qnEv+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759902847; c=relaxed/simple;
	bh=ik0Hlz3eWe16I+0HWwL85cFBzx9FNEbvtzDp8YkHiQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKDWGdbduIp70QcHQSeu5aC583NOKqGNHADrgwnOu4gVC2w/qom8s92HQ3n8MRgE24TOAhBwjnxORKqT4MJaH4kJE4JDhLsn6SyULEld9jkHgM34YjPBbFPup6V8HqBC14Bd0WdHRk6/a0nk4UMUuRcisSUU97qGYXzjOGpgNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTHiFudH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C2BC4CEFF;
	Wed,  8 Oct 2025 05:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759902845;
	bh=ik0Hlz3eWe16I+0HWwL85cFBzx9FNEbvtzDp8YkHiQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTHiFudHBYHLJqpVkXrX6V4PYKb7Vi9sNmzx6NwnD2hdCKeUIE8gO6XK3/8UswvbH
	 Lhl1q5RXERF1LD/+akpnVtCiGBBSNf9Hp0XL8kJrQIfAUYNtFiIte2XKm23UU+uolC
	 OV4Qwjh2hUHJaAHEilOMS8XC1HRpAomYn5rXhtEQ=
Date: Wed, 8 Oct 2025 07:54:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio:
 Kill timer properly at removal
Message-ID: <2025100824-frolic-spout-d400@gregkh>
References: <20251007155808.438441-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007155808.438441-1-aha310510@gmail.com>

On Wed, Oct 08, 2025 at 12:58:08AM +0900, Jeongjun Park wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> [ Upstream commit 0718a78f6a9f04b88d0dc9616cc216b31c5f3cf1 ]
> 
> The USB-audio MIDI code initializes the timer, but in a rare case, the
> driver might be freed without the disconnect call.  This leaves the
> timer in an active state while the assigned object is released via
> snd_usbmidi_free(), which ends up with a kernel warning when the debug
> configuration is enabled, as spotted by fuzzer.
> 
> For avoiding the problem, put timer_shutdown_sync() at
> snd_usbmidi_free(), so that the timer can be killed properly.
> While we're at it, replace the existing timer_delete_sync() at the
> disconnect callback with timer_shutdown_sync(), too.
> 
> Reported-by: syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/681c70d7.050a0220.a19a9.00c6.GAE@google.com
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20250519212031.14436-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [ del_timer vs timer_delete differences ]
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  sound/usb/midi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index a792ada18863..c3de2b137435 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1530,6 +1530,7 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
>  			snd_usbmidi_in_endpoint_delete(ep->in);
>  	}
>  	mutex_destroy(&umidi->mutex);
> +	timer_shutdown_sync(&umidi->error_timer);

This function is not in older kernel versions, you did not test this
build :(

I've applied this to 6.6.y and newer, but for 6.1.y and older, please
use the proper function.

thanks,

greg k-h

