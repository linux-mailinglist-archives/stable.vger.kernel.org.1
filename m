Return-Path: <stable+bounces-28651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DE88795B
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD2B282110
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BF1E522;
	Sat, 23 Mar 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uOoPa+J4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF8523C
	for <stable@vger.kernel.org>; Sat, 23 Mar 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210996; cv=none; b=esJwyAnMggHyFJf7tVFoZs7WycZfamrisomybm7nh59T8GyKfjxtDn0t06Y6EmqNU1jaIXm9QQF1vWXjBfuNVg/RTXFEIj1AX83UO7cDeuKtTmsiL+Xf5PPIQHcxfOxg0rLhEbFT7BN7M8hBL5LHZICbZv1LLSiqpUWWXVXk344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210996; c=relaxed/simple;
	bh=9UYr5Nj4Ht4EBh04/srEX0al8bAefx1T2zllbHfkkio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1cO7WC3+jbFBXp+fOy1puVvOzW25hBev5ddC/y/FIHcNHL/66KglhK3NbpUpUGmVDlX1HnL41gd3/Gz46A62U2uWEWmRkvtzjY0gU91J7uf6Yv1Wgrf9JJqEUGSB7P5Y5yx1yyILXTn3G7BE6rnrcqbBA6EkmpiJkgNqJTiXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uOoPa+J4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B81CC433C7;
	Sat, 23 Mar 2024 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711210996;
	bh=9UYr5Nj4Ht4EBh04/srEX0al8bAefx1T2zllbHfkkio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOoPa+J4ggc5tfNcjz9HBi7yIRuZqTVTvk76+CVNyAPxYh5q2++rAQl72okhupBmd
	 nNimh/joyxO5NYx9W3Sy1RNpBzUcIR9BkNq849lAvOa1Q+iAKXHLuumYU+sB5Wxbw7
	 xA0jXW9gA9DSF/OIxeGC9hyCdMCoM6fInLAGJ4tI=
Date: Sat, 23 Mar 2024 17:23:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: 8821cu: Fix connection failure
Message-ID: <2024032355-liking-calamari-1571@gregkh>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
 <aa20f8ba-d626-4f82-9312-6cc2a4cfc097@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa20f8ba-d626-4f82-9312-6cc2a4cfc097@gmail.com>

On Sat, Mar 23, 2024 at 06:18:07PM +0200, Bitterblue Smith wrote:
> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> [ Upstream commit 605d7c0b05eecb985273b1647070497142c470d3 ]
> 
> Clear bit 8 of REG_SYS_STATUS1 after MAC power on.
> 
> Without this, some RTL8821CU and RTL8811CU cannot connect to any
> network:
> 
> Feb 19 13:33:11 ideapad2 kernel: wlp3s0f3u2: send auth to
> 	90:55:de:__:__:__ (try 1/3)
> Feb 19 13:33:13 ideapad2 kernel: wlp3s0f3u2: send auth to
> 	90:55:de:__:__:__ (try 2/3)
> Feb 19 13:33:14 ideapad2 kernel: wlp3s0f3u2: send auth to
> 	90:55:de:__:__:__ (try 3/3)
> Feb 19 13:33:15 ideapad2 kernel: wlp3s0f3u2: authentication with
> 	90:55:de:__:__:__ timed out
> 
> The RTL8822CU and RTL8822BU out-of-tree drivers do this as well, so do
> it for all three types of chips.
> 
> Tested with RTL8811CU (Tenda U9 V2.0).
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://msgid.link/aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com
> ---
>  drivers/net/wireless/realtek/rtw88/mac.c | 7 +++++++
>  1 file changed, 7 insertions(+)

What stable kernel(s) is this to be applied to?

thanks,

greg k-h

