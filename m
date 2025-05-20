Return-Path: <stable+bounces-145399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13601ABDB7E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC4C189BF33
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4824728B;
	Tue, 20 May 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhPfhdPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B8242907;
	Tue, 20 May 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750067; cv=none; b=W8OySsTHkB+vreWixAHZkko0ZhqHAby1CdLs63hrSW+CyaftliwmUNhI1qAwovAPTSfsh3M98TWDaThHKX4A8brVeyMNKzzCj1QAI9S6DOci3YZOUbXW5Dqovb8MU8P8AYQ2kVKMdpxGDlRb7+nAoyRtIjums2L4ay/y9CmzvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750067; c=relaxed/simple;
	bh=LSCg1WtZiijRBQPQNeV6HQ3meIGHPHi5xW3N/tJxwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfrv2iau0lDUu8vtxJQszOR++05fnvPjC9KqzLAnP56xvp2C+geJQ02BEVYW3OyJrZFyZVeT12vHnQyXxsXGcivLDUhKDV2XQoOLfBVDHr0+Ay34SnTgIloykLtA3QUzO5LANyN5JQ0dZQf+QhGU0oOFH27islrWaJkObQ2YYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhPfhdPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B65C4CEE9;
	Tue, 20 May 2025 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750067;
	bh=LSCg1WtZiijRBQPQNeV6HQ3meIGHPHi5xW3N/tJxwKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhPfhdPmp2r2S7/maxTkCUhqOKs6wqRP2tJXDr41s4uQ30rwwCfFCHh14mB777rua
	 6me++dEJQX7EPUHHuF0JwWs2C0SF9MEMKaK2D4rM9MvCJozy4od20TpghXrlhnjS81
	 e+SJJ4myQfzFDM6VdI67ETDzz5f5+UeEGqOYtx3cSR/ypMwwQHpGxT5ns1OVHx6Gze
	 TBNdCtksbBTjCKuPlS8n8viFJJNT0JpcG00EV4IcwvUSZvT2K559/FFZc9tJrAgkeD
	 Fxkx1gV9RNVMnuiK0hxR4ifjyKCyFp3YQPirQ1RNPjrC4IQNymJSdp5j0AcAiKC4da
	 PhDwwv6/Ads/g==
Date: Tue, 20 May 2025 10:07:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.6 229/294] drm/amd/display/dc: enable oem i2c
 support for DCE 12.x
Message-ID: <aCyMsX3_LQXsUuE4@lappy>
References: <20250505225634.2688578-1-sashal@kernel.org>
 <20250505225634.2688578-229-sashal@kernel.org>
 <CADnq5_OGPGwbKfFSP6BpNAhtOXnZ+L3Vmga9TxLDAAub=bu9JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OGPGwbKfFSP6BpNAhtOXnZ+L3Vmga9TxLDAAub=bu9JA@mail.gmail.com>

On Tue, May 06, 2025 at 11:02:34AM -0400, Alex Deucher wrote:
>On Mon, May 5, 2025 at 7:04 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> [ Upstream commit 2ed83f2cc41e8f7ced1c0610ec2b0821c5522ed5 ]
>>
>> Use the value pulled from the vbios just like newer chips.
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is a new feature not a bug fix and this change only makes sense
>with the other changes in kernel 6.15.

I'll drop it, thanks!

-- 
Thanks,
Sasha

