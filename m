Return-Path: <stable+bounces-62429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A19B93F170
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB26AB217F4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7413DB9B;
	Mon, 29 Jul 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DcHfSgzz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAB84FDF;
	Mon, 29 Jul 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246347; cv=none; b=Jsfa3ZXF+wtrouySUs4ehNbjQpd2R4Aadz76BFd+7iqt6nJ0HxHlUXOYW/pmMaizqZXwdlPGIR120oUj0Qufu53lW2PoPDcCSUF497duhTchFg8jYj7Bije1jnSbJ8xmBmzlJCzTDWOkd/I+l/cBDFkbZQsNqwaSHFCWXXHvn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246347; c=relaxed/simple;
	bh=8ZQ2zn8Or662G4pel4BS2xL70Ie4jCL8uD1hXV8e5Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkR+jk3GF903jwJ6Gf4HzZkviwkSU0kUc7Q0QZB0IOusZzV03XSFYiMueIqAjxQIeeV8CijyX8N81DcZU3EV/dTTX1o78ysDqim+10u0hBrVhuOmfT6P/qOOeSD09xi39KuHLa+NfCyZEpDrsicolzIexCZ9Pvz6mhBX3vfdIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DcHfSgzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C199DC32786;
	Mon, 29 Jul 2024 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246347;
	bh=8ZQ2zn8Or662G4pel4BS2xL70Ie4jCL8uD1hXV8e5Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcHfSgzzSx5coCWMXPNoB1SkS9rT4jQVG9XZ+t5ASf+JFYpULeeyTV+C14HTxkysd
	 ZGbrkiyDhEJmLfOdM1E5+jeyUQRECuNsDMKBuFFytinE2rjp5AoMUjXcEMOqTEb7fB
	 /xRq5iEDNyFskPRqJLMsOK8okpUf58AKWiWq/GNk=
Date: Mon, 29 Jul 2024 11:45:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: mikhail.v.gavrilov@gmail.com,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: fix corruption with high refresh rates
 on DCN 3.0
Message-ID: <2024072937-undivided-liver-b59b@gregkh>
References: <20240716173322.4061791-1-alexander.deucher@amd.com>
 <a3af3f0b-df81-4407-a38d-2fa35b33b08c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3af3f0b-df81-4407-a38d-2fa35b33b08c@leemhuis.info>

On Mon, Jul 29, 2024 at 10:31:38AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 16.07.24 19:33, Alex Deucher wrote:
> > This reverts commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 and the
> > register changes from commit 6d4279cb99ac4f51d10409501d29969f687ac8dc.
> > 
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3478
> > Cc: mikhail.v.gavrilov@gmail.com
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > [...]
> 
> Hi Greg, quick note, as I don't see the quoted patch in your 6.10-queue
> yet: you might want to pick up e3615bd198289f ("drm/amd/display: fix
> corruption with high refresh rates on DCN 3.0") [v6.11-rc1, contains
> table tag] rather sooner than later for 6.10.y, as the problem
> apparently hit a few people and even made the news:
> https://lore.kernel.org/all/20240723042420.GA1455@sol.localdomain/
> https://www.reddit.com/r/archlinux/comments/1eaxjzo/linux_610_causes_screen_flicker_on_amd_gpus/

Thanks, now queued up.

greg k-h

