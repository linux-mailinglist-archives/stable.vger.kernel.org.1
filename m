Return-Path: <stable+bounces-188835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0394BF8E63
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 23:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA1345BA7
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BF28506C;
	Tue, 21 Oct 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="LB9EkbVY"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705D28506B
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080903; cv=none; b=LG3P1MZOvT0GGNo4ps/PZMwopGFNQpNx97WKp7zVOFJ21iL3FEDMQ3GpWM2EcLFj8LtLjcB3e7xWKDVRKnrZdRsno0pQGHMCfUrySs9PiQ4IWBUyiscWsSMyOIANoZhBweVaFq588r5QSDp9/x94tqZYgMoWoM05qaCMr0CpYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080903; c=relaxed/simple;
	bh=2VQ6nTz/SOAwoFUxbYpiUjOxfPfx0sJdgIyJh1gwDUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hr30iedlPwu7gmvA7VID4CXEwJ+RwiD8IV6QK0d7Qia8j4NpjtzafePKZw9whkaBoltW07VX2bR/vg4zhmMR5sKUjctAlBOTGOv++B8sfUnfOQYf6ltBD6bnEmKa78OF8TFFBwvtzcLLlu+SLoVnGyPkwdEiLB8szYTvoQx574k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=LB9EkbVY; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1761080898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VQ6nTz/SOAwoFUxbYpiUjOxfPfx0sJdgIyJh1gwDUc=;
	b=LB9EkbVYINvfchak0NzjB3YWDgUOFqy9LubpPkfU0yyHJE4T4EUkb4ZWueDZnHFPsmBqXh
	+cnwSEZUrhX/xDCw==
Message-ID: <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
Date: Tue, 21 Oct 2025 23:08:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <2025102032-crescent-acuteness-5060 () gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
 <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-10-21 22:45] Mario Limonciello (AMD) (kernel.org):
> Are you cleaning your tree between builds?


Yes.

I'm building custom kernel packages in a clean chroot for my private package repo. The kernel config and the PKGBUILD can be found here:

https://remotehost.online/linux-6.17.4/debug2/config
https://remotehost.online/linux-6.17.4/debug2/PKGBUILD

Here's a tarball that contains the PKGBUILD, the config, and all source files that I used:

https://remotehost.online/linux-6.17.4/debug2/linux-hardened-6.17.4.hardened0-0.src.tar.zst

Here's a log of stdout and stderr of the build process:

https://remotehost.online/linux-6.17.4/debug2/stdout_stderr_combined.log


Here's a fixed PKGBUILD that I used successfully to build my kernel packages:

https://remotehost.online/linux-6.17.4/debug2/PKGBUILD.fixed

The only difference is that I've commented out the two patches from your patch set, and removed the corresponding sha256 sums.


Regards
Pascal

