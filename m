Return-Path: <stable+bounces-206328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C019D03D83
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F673288BB4
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E057481FD8;
	Thu,  8 Jan 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMhz8XVJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D937FF5B;
	Thu,  8 Jan 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873675; cv=none; b=bmg8d9rDcwKu8cwd4I96lKD+Zeu0TxCS7PbLp8e1bIncSQOyS0ouJjFq/dOkixvq7q0PCZ2sJK+hVNfkueowZYBxy7f/6i5eQam/GjpzAUPcbNCBm2F29ponCZprkwISh3kcgayvt+uGVWlHUa1IYAoOD6cinvQl8CX8+ppgb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873675; c=relaxed/simple;
	bh=hip/B8IhiN8vIxdsrSp0c8svaZSApdYaowiPnsBLIGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/AQ328hinmbuGctE/0oMk62OzwCM6jt4bjZrv7kBoloiCajRrPtGxkwn7Mc8uy8FIxW/Dg6ExBwpZ/GykDS/4wTGQfWrkf6OkZReFQhNrib3V2MFzEPmGK0SH90E54eOADHYX4bppsfuhvaHxtl8W7/3XD1Y+uICQwDAIQYqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMhz8XVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253FEC116C6;
	Thu,  8 Jan 2026 12:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767873674;
	bh=hip/B8IhiN8vIxdsrSp0c8svaZSApdYaowiPnsBLIGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMhz8XVJwzh4cQox7WsEnyGH/hSlk1oLGD5528klXFFSC/95yRWG8pOz6xyTrS2t8
	 ECN4ooQMQ44Rs+iezTHsSeDmgkFMXoPMgP0gFj0N01H0GuSVxBU/6Z4hnuimX8DoET
	 KuSblb/4PaTe+3DbOmmIuBFVKzol2ZCvilOdFNSin8f/YmBImy0bHLUkm1s8Buq9ha
	 A+xh2cOMrii9tf947xO8NVJkmFanzxfO10UgV+ZQmV+Df6DWKGZp5TPI9RSP0LWk6S
	 g+PvuNMvEjHDEsH1xefMTET1TRBEivg3yiFzwIEsr5Ak6Jnc6yxufEpd902yWynDFF
	 VTxCNvlbCKU6w==
Date: Thu, 8 Jan 2026 12:01:10 +0000
From: Lee Jones <lee@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] mfd: core: Add locking around `mfd_of_node_list`
Message-ID: <20260108120110.GG302752@google.com>
References: <20251210113002.1.I6ceaca2cfb7eb25737012b166671f516696be4fd@changeid>
 <176787356909.903532.13506820629482222413.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176787356909.903532.13506820629482222413.b4-ty@kernel.org>

On Thu, 08 Jan 2026, Lee Jones wrote:

> On Wed, 10 Dec 2025 11:30:03 -0800, Douglas Anderson wrote:
> > Manipulating a list in the kernel isn't safe without some sort of
> > mutual exclusion. Add a mutex any time we access / modify
> > `mfd_of_node_list` to prevent possible crashes.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] mfd: core: Add locking around `mfd_of_node_list`
>       commit: b7c72be160385730cfcc3991178ba7867fe0b018

Applied, but I replaced the backticks with single-quotes for fear of
unintended consequences when managing through handling scripts.

-- 
Lee Jones [李琼斯]

