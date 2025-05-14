Return-Path: <stable+bounces-144358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D8AB6A10
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B816A1B6409C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C727703A;
	Wed, 14 May 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsQsqm9+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AD277020;
	Wed, 14 May 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222316; cv=none; b=j7flvvM/9NyEP4UCK0LpOIQut6HDpagEVD2Mau+U3KU3SQcOBsGojipKBiM/RENL6ugkt5I319zMeuxefPTluHIngrR/baWQFYpifGcquRsGOWrhSP0UPI/MEMg7xWV71vResb5r9EpOa9D+fUOy7Wo57r+9OryJ7+8nEaXl7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222316; c=relaxed/simple;
	bh=NzqA+eKHxUEF+PGJTwjMCdcX89RCrviZg/f/DP8l7OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ge71OFTNnGCuqw+KFZ74hq00IKetE1Y2W4Y057zM82pe4YE0vFqGIstMCPdHRRlRTdwUrsNRYRQQza53w6A8hHDoqSA17SMOK+3KlbKskPj975vfa/xlwl9YjQ76IMaoEtS2N9Cv+TAe7Fbp9Io5qMa/pkST+grqxGR7oppUie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsQsqm9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39ABC4CEF1;
	Wed, 14 May 2025 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222315;
	bh=NzqA+eKHxUEF+PGJTwjMCdcX89RCrviZg/f/DP8l7OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IsQsqm9+Cv6oUwM1UdOrUbglX8hxrEWScrCJE1BTLzJcqjvJhqwgZZKrpMNwzUhDV
	 j2IAAm2FJlMgsz0uET7tT1xGCbvxpwn+jhsVPBlkmax9y3ZoDI0qanBtlXccPE99nF
	 0bDb7xrqDSw1n8oHRwLeDPMIZ3cce9caD5HzZvSjqfPk8e5ka8JrA1zVkLdyZ5SkF/
	 cAZy+liB5kEtUgGWaN0Zp3h9KXMAwVvUVum05nlpl4TrQdFRX1WRya/BGuolGohjtj
	 O8GeLi8+2JA6QjEWxW1oJFOm8AjwvW1Fj3+DNEh87omuuBhgvq96jlIck3uBYGWpNE
	 uFyr5oajNQafg==
From: Vinod Koul <vkoul@kernel.org>
To: jckuo@nvidia.com, kishon@kernel.org, thierry.reding@gmail.com, 
 jonathanh@nvidia.com, Ma Ke <make24@iscas.ac.cn>
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
 stable@vger.kernel.org
In-Reply-To: <20250303072739.3874987-1-make24@iscas.ac.cn>
References: <20250303072739.3874987-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2 RESEND] phy: Fix error handling in
 tegra_xusb_port_init
Message-Id: <174722231344.74407.15426957064569052576.b4-ty@kernel.org>
Date: Wed, 14 May 2025 12:31:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 03 Mar 2025 15:27:39 +0800, Ma Ke wrote:
> If device_add() fails, do not use device_unregister() for error
> handling. device_unregister() consists two functions: device_del() and
> put_device(). device_unregister() should only be called after
> device_add() succeeded because device_del() undoes what device_add()
> does if successful. Change device_unregister() to put_device() call
> before returning from the function.
> 
> [...]

Applied, thanks!

[1/1] phy: Fix error handling in tegra_xusb_port_init
      commit: b2ea5f49580c0762d17d80d8083cb89bc3acf74f

Best regards,
-- 
~Vinod



