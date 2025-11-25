Return-Path: <stable+bounces-196889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2CAC84C7C
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 12:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7615534CE34
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8A303C83;
	Tue, 25 Nov 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAiy+kdK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B32EF646
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071000; cv=none; b=IaEfZRhgHq/PM1Nx/r+9JQW2H31EzYCMalzH/RW4zRMDITuKBqIHQrMsgGxhUdVyJiQlWINEx+pQwR2W7duABko4dkgjpaQAu2+3N8/hV8+uQUw8eemt4JF9g1lo/zXI0YfaD6NZn6j0nGYQS9uEIJf5QZ9FtqG6oD+xSF4Hjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071000; c=relaxed/simple;
	bh=yPmtGdDX0VB1pwxUW9xhO/YHcnpxWA67gK06UeDK04c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnUvWdVCHawPi0HaVaw4VYsHVM6LxeDHi9Bam+EL5PSBSGEMg6LPpAR6/exddGTj7Y9v/UDN3zJ+cXaa+eQsdTtfwj6bB1vvEHvRkOzWcTWTad2QKcSJ0X4qSONSIWVGDFoDwchb4weg5sSIuO34O5XMwEiw8z1xZNshzFPGYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAiy+kdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8326C4CEF1;
	Tue, 25 Nov 2025 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764071000;
	bh=yPmtGdDX0VB1pwxUW9xhO/YHcnpxWA67gK06UeDK04c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAiy+kdKW3VLqRk3esUmaPeXSBwGbyMka3FRzZhNiTj9gJCVSRIdAWHDbv8GRgF9C
	 LjXXGiv8HptyovZMuzpaZeeyNmQ4ieL3rKDXyRe8KSh0vx21k7+0WKd5OId/D6GhBY
	 AbbmZ9w7TxTmnohBHfEJu+FqIH9mNS6xMeFlU2RI=
Date: Tue, 25 Nov 2025 12:43:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, stable@vger.kernel.org,
	linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <2025112531-glance-majorette-40b0@gregkh>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>

On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> >
> > This software node change doesn't actually fix any current issues
> > with the kernel, it is an improvement to the lookup process rather
> > than fixing a live bug. It also causes a couple of regressions with
> > shipping laptops, which relied on the label based lookup.
> >
> > There is a fix for the regressions in mainline, the first 5 patches
> > of [1]. However, those patches are fairly substantial changes and
> > given the patch causing the regression doesn't actually fix a bug
> > it seems better to just revert it in stable.
> >
> > CC: stable@vger.kernel.org # 6.12, 6.17
> > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > Closes: https://github.com/thesofproject/linux/issues/5599
> > Closes: https://github.com/thesofproject/linux/issues/5603
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >
> > I wasn't exactly sure of the proceedure for reverting a patch that was
> > cherry-picked to stable, so apologies if I have made any mistakes here
> > but happy to update if necessary.
> >
> 
> Yes, I'd like to stress the fact that this MUST NOT be reverted in
> mainline, only in v6.12 and v6.17 stable branches.

But why?  Why not take the upstream changes instead?  We would much
rather do that as it reduces the divergance.  5 patches is trivial for
us to take.

thanks,

greg k-h

