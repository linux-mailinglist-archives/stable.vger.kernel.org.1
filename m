Return-Path: <stable+bounces-33133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792E891628
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF10287A49
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1414879E;
	Fri, 29 Mar 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A9Pk2JMD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5850A70
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704897; cv=none; b=qQ5b4AepAKiKi7vSI9HJRdU0nfLkrCWFdl/RmmqL77Xb2Sh5uSqeVzZ2JeAXLjR2k3J1WVsCRp9YpMg2bXR5C/M/UVqP26xVfJ6whtffyR/G9nILSxwtowAmi4gePQNamaaOAhI47dzsxE9td7lCveNlo7v1sMhmUQypm03N2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704897; c=relaxed/simple;
	bh=pd9C6pX+93cFOzuotOgN8WslUaPmRkmjKqAO/1q22N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/wRl9xHEYbWvV0s0+zyg34rmHN4diw3azuTjVKUj2fk1DWw//1Ztzsjj9xjLE65xmPYd3lK2h4Fhv5V61uJ9RmCxQzVp0uZl+rem0W0MDuq/Pr7+gyyUjnNzdXTeVLPp0mQbjKUQeOxt7pXM7QfT3+ESCKTpXIFTIrhBwgJR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A9Pk2JMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C7EC433F1;
	Fri, 29 Mar 2024 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711704897;
	bh=pd9C6pX+93cFOzuotOgN8WslUaPmRkmjKqAO/1q22N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9Pk2JMDdxLxH8/WTpkoQroin6O+HqU3PWTkY/WJkJBD+E6zffDeJk3Q8ApBMszsh
	 KmJE1DZn8Bm4LLMOOpiWPUzxsuZJTEs4mSwlahoOMoJPFIiLQSFGZ2+cpx9zyqAIG9
	 nuWA5seoaDk1ZQI4TEKr6CgjVUpR+Y13vp85u9i4=
Date: Fri, 29 Mar 2024 10:34:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: 8821cu: Fix connection failure
Message-ID: <2024032942-security-edginess-9e4a@gregkh>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
 <aa20f8ba-d626-4f82-9312-6cc2a4cfc097@gmail.com>
 <2024032355-liking-calamari-1571@gregkh>
 <3585a148-2d88-454a-a6b1-d34cfa64460c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3585a148-2d88-454a-a6b1-d34cfa64460c@gmail.com>

On Sat, Mar 23, 2024 at 11:48:07PM +0200, Bitterblue Smith wrote:
> On 23/03/2024 18:23, Greg KH wrote:
> > On Sat, Mar 23, 2024 at 06:18:07PM +0200, Bitterblue Smith wrote:
> >> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> >>
> >> [ Upstream commit 605d7c0b05eecb985273b1647070497142c470d3 ]
> >>
> >> Clear bit 8 of REG_SYS_STATUS1 after MAC power on.
> >>
> >> Without this, some RTL8821CU and RTL8811CU cannot connect to any
> >> network:
> >>
> >> Feb 19 13:33:11 ideapad2 kernel: wlp3s0f3u2: send auth to
> >> 	90:55:de:__:__:__ (try 1/3)
> >> Feb 19 13:33:13 ideapad2 kernel: wlp3s0f3u2: send auth to
> >> 	90:55:de:__:__:__ (try 2/3)
> >> Feb 19 13:33:14 ideapad2 kernel: wlp3s0f3u2: send auth to
> >> 	90:55:de:__:__:__ (try 3/3)
> >> Feb 19 13:33:15 ideapad2 kernel: wlp3s0f3u2: authentication with
> >> 	90:55:de:__:__:__ timed out
> >>
> >> The RTL8822CU and RTL8822BU out-of-tree drivers do this as well, so do
> >> it for all three types of chips.
> >>
> >> Tested with RTL8811CU (Tenda U9 V2.0).
> >>
> >> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> >> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> >> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> >> Link: https://msgid.link/aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com
> >> ---
> >>  drivers/net/wireless/realtek/rtw88/mac.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> > 
> > What stable kernel(s) is this to be applied to?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 6.6, 6.7, and 6.8, please. The older ones don't have USB support
> in rtw88.

Now queued up, thanks.

greg k-h

