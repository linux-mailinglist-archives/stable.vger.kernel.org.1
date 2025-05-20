Return-Path: <stable+bounces-145374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1AABDB9D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE77A8A0B25
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1AD2459FE;
	Tue, 20 May 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMTmz4l1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875E2F37;
	Tue, 20 May 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749991; cv=none; b=KVQf3Nq8mm12PDbdZJyMnbe0XETfDEawmh4pMzEUaL5nduTaTI0lWPEJr80+UlSvMVOVI4AhQfz0Mc2WtrXByhRwn28h5ONUYl2a+u+D1AY7NFJTNGF6XKvChbemvxvlWIj/BOC4fPiEeMUd5OhLUq7Y3EPHAns35lyLToTYBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749991; c=relaxed/simple;
	bh=J8Nnu0+0C7RcYK7SzGdMl+rht0/3u+/XlcGoxeUaRXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PptKIwiqllMaqT9ZNy66xXPOtfoGCe4CbPsrGFM/Hzz+Tz0F6332nY0qfEXrZGYB0vVNay9O8EAom+ODdtNMzq6TdFwd1ypveg4uPNjiWXFlQXqB91ZAuYFY6QYzXoH3WEVbuKtw5nlslhiyDNkS/RX0MZt1n7YO/LNGMU7jdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMTmz4l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFFCC4CEEA;
	Tue, 20 May 2025 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749991;
	bh=J8Nnu0+0C7RcYK7SzGdMl+rht0/3u+/XlcGoxeUaRXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMTmz4l1D5ourzsVmUpjAL9mBLX2qNMGwWlXkv7Za0mYaSTDodm7NSfQ1M3Q68F8P
	 VcQ+NuToW6mDyjatw1upBI1aMjVUQE3lAUtT0NtG1pc4aRhlfb9HjwTqve54eN/av2
	 ZTMS2lSrkmxC6mt9owaDSssl1K35qedBUTuHx7/1KWTkMpCkbGBetb71zgku7/ZvTA
	 GUVgfv2nDOGZ+Sk5kc7Sjogt8fz5AHu26QCPKtNf5QtObiM0Csv46Z3f+aC5OKrS83
	 yNfiJZ+NSRPzty2pEuzqnnQObixwv7GTl0U4qNIOHkIBC8GNxoTxU9TrukFLIwj2Ci
	 yzZSesdrYunTw==
Date: Tue, 20 May 2025 10:06:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
	sunpeng.li@amd.com, christian.koenig@amd.com, airlied@gmail.com,
	simona@ffwll.ch, hamzamahfooz@linux.microsoft.com,
	Daniel.Sa@amd.com, alex.hung@amd.com, rostrows@amd.com,
	Wayne.Lin@amd.com, Syed.Hassan@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 5.15 090/153] drm/amd/display: fix dcn4x init
 failed
Message-ID: <aCyMZQyha8ftILL2@lappy>
References: <20250505231320.2695319-1-sashal@kernel.org>
 <20250505231320.2695319-90-sashal@kernel.org>
 <CADnq5_NhYbp2SMivbG2pvB8oZNie5LBxS_ME5nMofX-2syQHrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NhYbp2SMivbG2pvB8oZNie5LBxS_ME5nMofX-2syQHrw@mail.gmail.com>

On Tue, May 06, 2025 at 11:00:58AM -0400, Alex Deucher wrote:
>On Mon, May 5, 2025 at 7:16 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Charlene Liu <Charlene.Liu@amd.com>
>>
>> [ Upstream commit 23ef388a84c72b0614a6c10f866ffeac7e807719 ]
>>
>> [why]
>> failed due to cmdtable not created.
>> switch atombios cmdtable as default.
>>
>> Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
>> Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
>> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
>> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Support for DCN 4 was added in 6.11 I think so there is no need to
>backport DCN 4.x fixes to kernels older than 6.11.

I'll drop it from older trees, thanks!

-- 
Thanks,
Sasha

