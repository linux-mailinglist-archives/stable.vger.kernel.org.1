Return-Path: <stable+bounces-60689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82572938F36
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B433B1C21130
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22516D4C3;
	Mon, 22 Jul 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8e3lbHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B82322E;
	Mon, 22 Jul 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652252; cv=none; b=N96VprnY1ZaKHNXwr57vU0QFyLCIFbRP5MUc929xRqctVOLjOmObUKaGJB+nO7hIUaDUYhInsCrH7c0F41KpBng89xC/1fvzev2zXulVDTzvLT/fcDT2bDxL29GK4cnnBeB90tibKQJSVn9qSah02p1kvmllj8Xg62jn3KRV2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652252; c=relaxed/simple;
	bh=b7uraR+kg3VECJVI+AKWtB20lyxc+lXXuEPrdL51Vcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbI6+Yz4Jd3AqsOGTUgUN8XR0RJdYCzvZC70+BYvL0opc1BjIWbfhgevWvng7z8WZURloPH1UyeYMORTtL0XCaGRyVw1qZr96mt3F5k0DXsM77w48L7sJs5zvU1e8edlV/vCKvo2GTR2EjMwunCl8lmUqwuaIqhl/dA7GI0QM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8e3lbHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D27C116B1;
	Mon, 22 Jul 2024 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721652252;
	bh=b7uraR+kg3VECJVI+AKWtB20lyxc+lXXuEPrdL51Vcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8e3lbHfYFRQYkbWZvSkZTS4YkyNkdM4lxfrhmi2qUPQP65ffLrRI1bhsU0ucGjTB
	 4CwwBAMF+qhmSI2WJDcji4p8CeyPZZOYigiBtE39yLOtiTisb0QZgSCcVWxbukYRH7
	 agdwKVSiAAkpq4Cz3SAwm1gvJlXefqgKr5yDwlr7dcx/kI05YCqhG8OI/lSWDmAyTq
	 PPwZnLaVJ60GA5lEXJC7EL9sd8N8kXiFhB+ixPuqLplV+GpCXGU65LbEn5J9TO1KMh
	 NLz0zeI4g3CSacaMORmk0G2kxepYxJGmiuja+3885dPB4FCRanYK2KGrwUT3yIkFpX
	 Wi5wHsbgBEdcQ==
Date: Mon, 22 Jul 2024 08:44:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tom Chung <chiahsuan.chung@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
	Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
	alex.hung@amd.com, roman.li@amd.com, mario.limonciello@amd.com,
	joshua@froggi.es, wayne.lin@amd.com, srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.9 11/22] drm/amd/display: Reset freesync config
 before update new state
Message-ID: <Zp5UGit6eI_ZQ16e@sashalap>
References: <20240716142519.2712487-1-sashal@kernel.org>
 <20240716142519.2712487-11-sashal@kernel.org>
 <aac02f31-ba43-458d-b9c2-a68b7869e2a3@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aac02f31-ba43-458d-b9c2-a68b7869e2a3@amd.com>

On Tue, Jul 16, 2024 at 10:48:03AM -0400, Hamza Mahfooz wrote:
>Hi Sasha,
>
>On 7/16/24 10:24, Sasha Levin wrote:
>>From: Tom Chung <chiahsuan.chung@amd.com>
>>
>>[ Upstream commit 6b8487cdf9fc7bae707519ac5b5daeca18d1e85b ]
>>
>>[Why]
>>Sometimes the new_crtc_state->vrr_infopacket did not sync up with the
>>current state.
>>It will affect the update_freesync_state_on_stream() does not update
>>the state correctly.
>>
>>[How]
>>Reset the freesync config before get_freesync_config_for_crtc() to
>>make sure we have the correct new_crtc_state for VRR.
>
>Please drop this patch from the stable queue entirely, since it has
>already been reverted (as of commit dc1000bf463d ("Revert
>"drm/amd/display: Reset freesync config before update new state"")).

Dropped, thanks!

-- 
Thanks,
Sasha

