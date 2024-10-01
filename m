Return-Path: <stable+bounces-78588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3B98C850
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 00:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491011F25319
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B11CEE81;
	Tue,  1 Oct 2024 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE0lJaEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC319CC39
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822395; cv=none; b=LUy570347SODRheIG5vC324V9qaYDCmRtv9TvB5UFjRw3A0aUhQXbVPxgGk/bYaOGHto72tbQLN35g1smhGhIuFA0mjUxDgYkC/CCDXEZVe5KjOxsE2KwBTJGw9vwjROel+C5NMqK0tm0ZdKCK0Lt+qQNgjHn+mPdDXMbZC+BLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822395; c=relaxed/simple;
	bh=NG9aR0JoGvkupUxpOJZkVr6E28NyKd7pww9OIcMkdvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvBjHh33FINDurSXstjRRdv4DJXqslXdtS9PUVxpfXmmeiDHGjBuMwlV8oVOI0IxBj2huHmdD3AnbBnNIjy+f1qwy/aRC91f2J1b1LOBW6xhX4mETmqH0F6/uFEEQ6KCLJc4aHvsMpenkf+LBYFs019H30bR+6/EDf4bkNPwqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE0lJaEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25312C4CECD;
	Tue,  1 Oct 2024 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727822394;
	bh=NG9aR0JoGvkupUxpOJZkVr6E28NyKd7pww9OIcMkdvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uE0lJaENAmPFNCzIugc+nwsZ+xW1g/hPv9BvzaeVqU/vgNLYKkSr+8EqIwdvISxXd
	 2EGN9L6wCVFVLWsUYYgKsTroNeAZRDc+32otPAPmkmp3hnQI2S/QKTgJn+0FveD4L5
	 L08KDu1uTCmXvbNQ8jnNylXC0hae+KW/gdKXmvSmZfKSqEsdFDp8jOW6xehpg4+CQc
	 oF9fE0/wsPsByZY1nJgKrD7PnurEXRe0PvRdtNEaZOHoyQlFmZSEgu4K5Q7OPLOQru
	 TeV4DjsvaMSkVqJCNev6G65E6GYNk4aLU2FLQa3SNtNT++bu33DUUwoetUravr+8BZ
	 w4xvBkqkNCjxA==
Date: Tue, 1 Oct 2024 15:39:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jiri@nvidia.com,
 stable@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, sashal@kernel.org, vkarri@nvidia.com
Subject: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a
 devlink instance
Message-ID: <20241001153953.4de43308@kernel.org>
In-Reply-To: <Zvv7X7HgcQuFIVF1@shredder.lan>
References: <20241001112035.973187-1-idosch@nvidia.com>
	<2024100135-siren-vocalist-0299@gregkh>
	<Zvv7X7HgcQuFIVF1@shredder.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 16:38:39 +0300 Ido Schimmel wrote:
> > You need to document the heck out of why this is only relevant for this
> > one specific kernel branch IN the changelog text, so that we understand
> > what is going on, AND you need to get acks from the relevant maintainers
> > of this area of the kernel to accept something that is not in Linus's
> > tree.
> > 
> > But first of, why?  Why not just take the upstrema commits instead?  
> 
> There were a lot of changes as part of the 6.3 cycle to completely
> rework the semantics of the devlink instance reference count. As part of
> these changes, commit d77278196441 ("devlink: bump the instance index
> directly when iterating") inadvertently fixed the bug mentioned in this
> patch. This commit cannot be applied to 6.1.y as-is because a prior
> commit (also in 6.3) moved the code to a different file (leftover.c ->
> core.c). There might be more dependencies that I'm currently unaware of.
> 
> The alternative, proposed in this patch, is to provide a minimal and
> contained fix for the bug introduced in upstream commit c2368b19807a
> ("net: devlink: introduce "unregistering" mark and use it during
> devlinks iteration") as part of the 6.0 cycle.
> 
> The above explains why the patch is only relevant to 6.1.y.
> 
> Jakub / Jiri, what is your preference here? This patch or cherry picking
> a lot of code from 6.3?

No preference here. The fix as posted looks correct. The backport of
the upstream commit should be correct too (I don't see any
incompatibilities) but as you said the code has moved and got exposed
via a header, so the diff will look quite different.

I think Greg would still prefer to use the bastardized upstream commit
in such cases.

