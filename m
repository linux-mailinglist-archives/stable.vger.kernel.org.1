Return-Path: <stable+bounces-81180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF0991B8F
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC891C20E90
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DB2582;
	Sun,  6 Oct 2024 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCwo/oWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E724C66
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174165; cv=none; b=lrUbC6Mi69qmJ1GUrwrAt5m9TDcDWPkikORL3cOjhDvDWL95eUvnj9UhYmX/ztQhC6tqbSm/E3kPYIrujNcK7lA+iH2QiDYkWhsPmdGepxd5eSqT7HsZgWSubgd1t1h9oyminvtJv/ZL5Rg+x76v/+5H2+14T+L7m3D8iO2EWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174165; c=relaxed/simple;
	bh=aTp53eDu1pp2aLC9Eo70jDCaTegJ7QEREu4pKaxZ8AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaNgwIiWySBIwxTGk9leMXVmnUiFkcfzgJac2LWnUfXJURZ3WKTqipn0MzeT0pC1ZwaezGxAMq0A5exfXrSm7mv9o5KWZ7Gp1D+s+zrG52wlcZm/Nfk0L15tmCtrRSg9ywK+PxRayNWFMys8wrZpv1ndE5J8Sp9axXKbZbObHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCwo/oWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C4C4CEC2;
	Sun,  6 Oct 2024 00:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174164;
	bh=aTp53eDu1pp2aLC9Eo70jDCaTegJ7QEREu4pKaxZ8AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCwo/oWDdWWgheEsa/aYdCizifXPnZt+Qbp3NJRSeyfCOxrz4LlqePJkK42wPpRcf
	 I1T2L2HVC1VpBT4nR/ZJdCI4DoRdzGJWzdYPbznJ7dziFJ3yGfrySzgEe2noA1Djoo
	 Ha3MGe6EhfjNikE0xk3VKlwzyBA2Up6qzjQaC9NpMw8ysEpoxBFn/d2ROWHd+SqhJo
	 Uqm5EMWUk0jceXIRDfEIh4IECE6SjV7E1j4XrOMDWQjgyOuqUG5aqd7D8qJrf9Lg8u
	 2HE9V+EkTW1SlVhooycKdRuuqLCihC+MByP8hVu74RpAUR2HuHQN6bQnEkIgNzSD2z
	 FPcXja8wOvVeA==
Date: Sat, 5 Oct 2024 20:22:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Re-enable panel replay on 6.11 kernel
Message-ID: <ZwHYUwzZ0cmJFTl5@sashalap>
References: <14faf893-2206-49c5-b32a-3aa19c6270ad@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14faf893-2206-49c5-b32a-3aa19c6270ad@amd.com>

On Thu, Oct 03, 2024 at 12:53:52PM -0500, Mario Limonciello wrote:
>Hi,
>
>"Panel replay" is a power saving technology that some display panels 
>support.
>
>During 6.11 development we had to turn off panel replay due to reports 
>of regressions.  Those regressions have now been fixed, and I've 
>confirmed that panel replay works again properly on 6.11 with the 
>following series of commits.
>
>Can you please consider taking these back to 6.11.y so that users with 
>these panels can get their power savings back?
>
>commit b68417613d41 ("drm/amd/display: Disable replay if VRR 
>capability is false")
>commit f91a9af09dea ("drm/amd/display: Fix VRR cannot enable")
>commit df18a4de9e77 ("drm/amd/display: Reset VRR config during resume")
>commit be64336307a6 ("drm/amd/display: Re-enable panel replay feature")

Queued up, thanks!

-- 
Thanks,
Sasha

