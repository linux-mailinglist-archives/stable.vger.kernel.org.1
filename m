Return-Path: <stable+bounces-155312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B094AE37D0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAED7A1A8B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0F1FE46D;
	Mon, 23 Jun 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HDAhguiP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F311A00F0;
	Mon, 23 Jun 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666016; cv=none; b=dp38gGUYdCg5IRosYA0CVUgACbko+S5v0p21m91maKatmBayKe9TS0IKstnI0tF1WxX/+nz6/lObCBoPCKHYQs0g7zgwgZLrbpFrwlTrGeCXledi0zrmdA6th8YxxmeUVUt7SRj+AVK441YXnjhwy/lkzYZGrpWtgIeH6skDRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666016; c=relaxed/simple;
	bh=09rqRbBWAlLYpNaeCTHk/N0kkFFk5OoiTuOahpYtECk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtOzKlgtMcx9DuBqYKXiII/hearZOmNUFCsNOzX9SvUKfxdTgMrnlTUVu3ijxj5NFJqdCxvbpRS5VfGnOL/ybGIZF/IVIv6aeZHJBHI/0csPFYo5fnplWvfXgG60m0Fw3Eoe1SynhwvPpn/iULkOGKpzQk0WSRs8I08uW5srYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HDAhguiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115B8C4CEED;
	Mon, 23 Jun 2025 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750666015;
	bh=09rqRbBWAlLYpNaeCTHk/N0kkFFk5OoiTuOahpYtECk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDAhguiPNG0elOcj+63NI9runvnxw8L5tTfDp9J2K/9KYpmQ9FMnUa3Dd3mN9IYYp
	 ExVMOxi4HxPJV8AkV//t3BX8ehblUwkuftwtbcSgRL9PXLyGTDrT+NQmnsZr/kfWa5
	 Rb79c33au1GYth9EQ+auL8zGXL69xDkahWTD2RWI=
Date: Mon, 23 Jun 2025 10:06:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Aaron Kling <webgeek1234@gmail.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 6.6] Revert "cpufreq: tegra186: Share policy per cluster"
Message-ID: <2025062344-molecule-running-1e49@gregkh>
References: <20250605125341.357211-1-jonathanh@nvidia.com>
 <2025062347-snaking-daytime-b878@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062347-snaking-daytime-b878@gregkh>

On Mon, Jun 23, 2025 at 08:36:15AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 05, 2025 at 01:53:41PM +0100, Jon Hunter wrote:
> > This reverts commit ac64f0e893ff370c4d3426c83c1bd0acae75bcf4 which is
> > upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.
> > 
> > This commit is causing a suspend regression on Tegra186 Jetson TX2 with
> > Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
> > this change but indicates that there are there changes missing.
> > Therefore, revert this change.
> 
> But this is the 6.6.y tree, not 6.12.y tree.  So is this still a
> regression in 6.6.y?

Ah, nevermind, I'll just edit this by hand :)

