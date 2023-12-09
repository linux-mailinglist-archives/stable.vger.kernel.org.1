Return-Path: <stable+bounces-5090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AB80B26B
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 07:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572431F21131
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E61C04;
	Sat,  9 Dec 2023 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaIueYZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B9185C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 06:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDEEC433C7;
	Sat,  9 Dec 2023 06:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702104931;
	bh=RnX4tNfYphJ6n5jxx1Nyjlzq/Kx/ktZS4VIl6uBAn6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaIueYZ7b51WjtwHl1O7uqi4Z7vB9lnd24n43TLVPTb/T+SxboTZRdE2XDFu6Hmvp
	 pooV2eP40w1SnYFNgiKuoRpER9qAnOkP/JWWVTUs3Rt2Z8XzkFw4s6kzf+gDGxhc6M
	 RKDnMXEKBi5ABMzbh7h8yhTX3sz2YzKfVd6/008wFIUrEijucSTuq50xXEWoeN2TEk
	 DzpbpG7gBrpB3ddzAVMJaQFSIg5vSVNDqcdfLr90jK0oNnld/CN840UBBYQy7oe/2T
	 tJm/daVJfxXIF5RIn6eNlu1ANbeHcVh3T6d+I/gR7DxG+lpk8fSGZHyB3cnsPTHtV9
	 NeeuH0bSs+dRQ==
Date: Sat, 9 Dec 2023 01:55:17 -0500
From: Sasha Levin <sashal@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: amdgpu fixes for 6.6 stable
Message-ID: <ZXQNhbyKrSez9DDQ@sashalap>
References: <CADnq5_NJSb0+TNdsFR2hGji53AOTwzoU7vjh6+r58gjAT7xn1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADnq5_NJSb0+TNdsFR2hGji53AOTwzoU7vjh6+r58gjAT7xn1g@mail.gmail.com>

On Fri, Dec 08, 2023 at 12:40:17PM -0500, Alex Deucher wrote:
>Hi Greg, Sasha,
>
>Please pick up the following upstream commits for 6.6.x stable:
>commit 04cef5f58395 ("drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct
>misdocumented param 'doorbell_index'")
>commit 367a0af43373 ("drm/amdkfd: get doorbell's absolute offset based
>on the db_size")
>
>They fix the following reported issue:
>Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
>Fixes: c31866651086 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")

Queued up, thanks!

-- 
Thanks,
Sasha

