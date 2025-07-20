Return-Path: <stable+bounces-163458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61944B0B4E3
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CF2189B202
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA491EBFE0;
	Sun, 20 Jul 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P4pfsF6G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3351C84D7;
	Sun, 20 Jul 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753007212; cv=none; b=tY7OGp9CaPwD4ICOM1/aZDAmOW7CvHDfC3GAlPzStnkX9BWbhKpAY30M7QbyFwhouyIYwMpUT4Jvlimz+LTFfedu/o2judkxy5hhDyimu7ie/cY+TsCtpr4mFZst5k7bKu2b8zr07dWvFdVqr0xhOAGgBFQcx//rCP/KXUgzi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753007212; c=relaxed/simple;
	bh=Pz8ePT3kQcq17jbtptxl1AKFPCx1WvRQsWQDiB0w498=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbTiIs2A2YNMKnGuY7hCShXGN/CweR82AhDilWzFSCAFpy//FUPUJa1NzSk64ufTunxHN7/HeKLh5goTfjN2G28UdocOs843d3OZ8tq7Cuq80z00qN9tLlgB/xCFDIRpeDEQv8fPMns3MIXFfZaiSceIQQ1QAg6BF2YkiPGKqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4pfsF6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C786C4CEE7;
	Sun, 20 Jul 2025 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753007211;
	bh=Pz8ePT3kQcq17jbtptxl1AKFPCx1WvRQsWQDiB0w498=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4pfsF6Gch1EW10+BCYiQjpN9WTd9OYx/ty8wcBjeYU4y1TPaDNfLUXuPb1Uc0Fft
	 aDvo08qO75RRzbaHhXT+kXTVET54Fh0Qq2T0+eB94My+Lq7Oh6ebl6y6eXAQ6TrVdu
	 KPY9PEFL5/vZPLn/6uLCstH654SHa1YH9ZwqiCvc=
Date: Sun, 20 Jul 2025 12:26:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: Mario Limonciello <superm1@kernel.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [REGRESSION] [PATCH] drm/amd/display: fix initial backlight
 brightness calculation
Message-ID: <2025072012-deluge-arbitrate-9129@gregkh>
References: <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
 <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi>
 <aHy4tohvbwd1HpxI@hacktheplanet.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHy4tohvbwd1HpxI@hacktheplanet.fi>

On Sun, Jul 20, 2025 at 06:36:54PM +0900, Lauri Tirkkonen wrote:
> DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> division needs to be performed after the multiplication and not the
> other way around, to properly scale the value.
> 
> Fixes: 6c56c8ec6f97 ("drm/amd/display: Fix default DC and AC levels")

This should be a commit id in Linus's tree, NOT in just one stable
branch.

Also, you forgot to add a cc: stable@vger.kernel.org so that it will be
picked up by a stable release.

thanks,

greg k-h

