Return-Path: <stable+bounces-43566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C58C321B
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 17:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100802820DF
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871256B66;
	Sat, 11 May 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNBmlTGI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7D5336F;
	Sat, 11 May 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440997; cv=none; b=rM90s/eh5fWxgseRuAz2CpIHpeC9SrPt2kTq9TIY0hqsOYQEyF1RzxNN5gmhjCLKOGK30uNbhX+9km3IQn66JItE8jrx77z7BwaGOWqSmSntEzDcfxsV/kZFqOTPRuKcEfai4UGNY4JYDf3fk2f1ihPzTBcGp712/9F1P1sxyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440997; c=relaxed/simple;
	bh=Vk5ReHWzVVjJeH+buVnWLB+fuULLDSItvRQbW8AbVtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HggaPb+qJfAhwPhgK87wzw7LLnO6bVkDhgU4Wo+QXJ0HZc/duCj0D2h6OLb4wPg0L766B/suKYxD+d1/x7LVLYTIDa+/mPyt6elGvqg/3WtZvgORGem3KPbD6k5XzWb+dAf9rOfyWbfW4p7AOFPE08wrnBvl62Y7ka/fggiF3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNBmlTGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9767BC2BD11;
	Sat, 11 May 2024 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715440996;
	bh=Vk5ReHWzVVjJeH+buVnWLB+fuULLDSItvRQbW8AbVtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNBmlTGIn6daiLU288vVV/TlWwLKKGfuE2Bg9yFPEEohed4IRu9FS5OYjh97pxLq9
	 FYzbpPJVPC1lb2iQKMJaBQtEJRaZZtiuggmTELgk5HLTpq0PAoLGgmCoUlBwHa18in
	 NV54gAJWFRWQaJCHLF/1oxYz2jwd2mEsKB37iqQ72ABQRjBKYkU7HQXYk5729X4M5B
	 C3dddWbsAc20i54UX8k95whjMYp77fq0lZwq2o/6TUXme6P4OslMPy+FGNgOLXJLvQ
	 m9dWFso7541iv5/Hwp9bYhwmHSsHphVhTzn8V3Wqs06YX+4GGsSSHAx6+rpDMJaWKv
	 gvgmCksRbVxRg==
Date: Sat, 11 May 2024 16:23:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Isaac Ganoung <inventor500@vivaldi.net>,
	Yongqin Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
Message-ID: <20240511152310.GL2347895@kernel.org>
References: <20240510090846.328201-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510090846.328201-1-jtornosm@redhat.com>

On Fri, May 10, 2024 at 11:08:28AM +0200, Jose Ignacio Tornos Martinez wrote:
> The idea was to keep only one reset at initialization stage in order to
> reduce the total delay, or the reset from usbnet_probe or the reset from
> usbnet_open.
> 
> I have seen that restarting from usbnet_probe is necessary to avoid doing
> too complex things. But when the link is set to down/up (for example to
> configure a different mac address) the link is not correctly recovered
> unless a reset is commanded from usbnet_open.
> 
> So, detect the initialization stage (first call) to not reset from
> usbnet_open after the reset from usbnet_probe and after this stage, always
> reset from usbnet_open too (when the link needs to be rechecked).
> 
> Apply to all the possible devices, the behavior now is going to be the same.
> 
> cc: stable@vger.kernel.org # 6.6+
> Fixes: 56f78615bcb1 ("net: usb: ax88179_178a: avoid writing the mac address before first reading")
> Reported-by: Isaac Ganoung <inventor500@vivaldi.net>
> Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


