Return-Path: <stable+bounces-28091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE91687B2B8
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9666284161
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA24D133;
	Wed, 13 Mar 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ2oDWbB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85834CB41
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361098; cv=none; b=iQLqk0AU6kToIUcOLNNfDR5bfXgdXZoLVn1WHdTJLEwXbDqjmUM08dJVD4G2+oE0eCVyVpfg1rs0AD59B2Dg48W/GhSmpmD5QZo1hHyEc8dopC8iicOceQPJLf6MeHBI58a7gdXQF75PKk8XeGshdCETrud4Ma7uhs+AFNXsY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361098; c=relaxed/simple;
	bh=tCMpM0PpObL3XjTDSuN/iyD7AM+olV1i9xmcgy8FvGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgnicCRrJJW7kWOQhZ/gdXJFChYYeypCDFV0eewR/LuTodeaJUdd5eYr3p0Yz10JwFQcJasHqYOVTH8/+vlXDMv8LtlxlSgioj+BuLOX94qTdAjXGJ5WQGTK8rFBVs10X30wTdX04mXK9uv8iro90GjA/EYghyTPZUP59oTY37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ2oDWbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B38C433F1;
	Wed, 13 Mar 2024 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710361098;
	bh=tCMpM0PpObL3XjTDSuN/iyD7AM+olV1i9xmcgy8FvGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ2oDWbBNojv/Cua1of7Lo07poL2EoLzf5W5Row8YoaP76SkLCxRPUeTAjxpo0mTY
	 1kQK6Q4i8QWJnyQCQoSDfem1cutfKanXzne+T/GdeNORe3XjeBjbhqGnPztmPSq8Rp
	 AhTk4rhmMlbLOFsjsFWdJDOvx2f2rBzZJwVIFF5430hMOt+L+hEJxuQaUpYIAZDQBX
	 gmq4zn7dwELJBdRs2wXkvRNMx3k3pAvP1aboFCD8D6CH1r1S3bpdT+yUWyfKmt44AI
	 CHhnlt+ONaJOyGMX6UvenK1mQlQq0+YITlRLQ+awdCHsOg67FckkxjcsAU89YOfiuA
	 TXPS2oX49t/iQ==
Date: Wed, 13 Mar 2024 16:18:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Richard Narron <richard@aaazen.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Message-ID: <ZfIKCLek_q-Wzn0D@sashalap>
References: <7f21928-bc75-adac-7260-d2b0cc8dd3fe@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7f21928-bc75-adac-7260-d2b0cc8dd3fe@aaazen.com>

On Wed, Mar 13, 2024 at 10:55:47AM -0700, Richard Narron wrote:
>This patch file link does not work for me:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151
>
>When using Mozilla Firefox 115.8.0esr it gives me an error message:
>
>  Bad object id: v5.15.151
>
>And it gives me no download patch file...

For some reason the v5.15.151 release tag wasn't pushed.

I've pushed it now, so the link above should start working whenever the
git.kernel.org caches expire. I'll check back in an hour.

Thanks for reporting!

-- 
Thanks,
Sasha

