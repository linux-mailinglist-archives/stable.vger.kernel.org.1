Return-Path: <stable+bounces-148339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE15AC9970
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 07:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB543B5650
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 05:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504228CF60;
	Sat, 31 May 2025 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0H3TW+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D02904
	for <stable@vger.kernel.org>; Sat, 31 May 2025 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748670478; cv=none; b=AQdFWa9h0QR6BPVwbE7y30uHsWCMYiq60BzvgGEur4T+7AXchHneTZMGT7fom1kPGFj6NwtaUQUzrc+uCRxm8eBKjGERRgQd1lrzB0Ynkr01z5D8gA4x7LLbQsAqMgpAsvUei+eute7pO8eEel5cP7XvT9yLyhlr+dDu+4lcY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748670478; c=relaxed/simple;
	bh=x4YUptglCn5UW41tZL9K5m/4bPCSYoDZP/jxq2xvqYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH3nxb6tScA9i+TDw8fo83gyAGR1CgM2ExITdVCEDj5VQeiVkoJJ6VNb+JRWlKsSszBIbkOvtOtoG3mvVeCdyM+sjStbhTcszPZV00xBwh/zfy05I7x8jHiz7o+uGXtarqvgF6h+Gg6Srfa4vReW6otk3CPyk0c4HbvbQiNsSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0H3TW+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B7BC4CEE3;
	Sat, 31 May 2025 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748670478;
	bh=x4YUptglCn5UW41tZL9K5m/4bPCSYoDZP/jxq2xvqYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0H3TW+SN48HLK5nWcrxYNozvITgKV7yKLQz6x3tVQ8td5yqpVzsjio6cM9MXKWOv
	 pLpLPqJOjSMqG9046lMp8pRA8S8vTvg0lgKGtZ2LSN7cHwz7ytm9PU1aPlZBB35Q5T
	 /nTGFyI6BUjznZaYUAMOTKgvjM2eM8ZlSI5k/z9w=
Date: Sat, 31 May 2025 07:47:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: stable@vger.kernel.org, alexdeucher@gmail.com,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
Message-ID: <2025053142-timothy-charity-3f46@gregkh>
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530200918.391912-1-aurabindo.pillai@amd.com>

On Fri, May 30, 2025 at 04:09:18PM -0400, Aurabindo Pillai wrote:
> This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
> causes regressions on certain configs. Revert until the issue can be
> isolated and debugged.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

