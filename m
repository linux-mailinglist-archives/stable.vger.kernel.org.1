Return-Path: <stable+bounces-110115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE77A18CFC
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D7B3AC427
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7C1BC077;
	Wed, 22 Jan 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/Bnjn7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EE28EC
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532025; cv=none; b=ft3NlpLiksEueDTvxNMuHxWeqYlIvo5seGkBPGWLSFi98RVf+SM3ITvpRqgO5EOVdoZlZWNmHXxPmPSkBiTIOyjABrfTWkASpLNY4gfHHv/bd4atkVuCtC4G7+kQQ3Qfnhlg3PatyiwVFcJQ0Ovrc6l1oQOyuwpY0NFo7RipRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532025; c=relaxed/simple;
	bh=DHqWuP8xJ04Xig0CTRTwzokiiH1dMnq8KEgY76ASmWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+PU1lXBGdr2JIXkP6yoPaZL2425T2Bj3N6pYo8eu1r24lWo//vn8oYbO9lg0NP0H7Lhmv5FyBGbtc+8ccxUR60mEHJ8OqgperCFnue1fdf8yNRU5zxasMqTALDacmQWAqrOvZz+goBSo/oAHwfbVb8vgv6YQ5xEKqUseKg18r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/Bnjn7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA15CC4CEE2;
	Wed, 22 Jan 2025 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737532024;
	bh=DHqWuP8xJ04Xig0CTRTwzokiiH1dMnq8KEgY76ASmWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v/Bnjn7oSg5NuIB/UScXkNWIi9c5/1CNOuYc/QnZE088LEO1aJdjRes12H1lea/xp
	 /d4Ii+l1A2WUiMLE7R3XggfmR1lAIHNx8JrBwLjZ7OZ/3T3U+n5pHE5N8Zs1dS5yuU
	 uFvl3awvtdYB4Ja1OI2ZPqq4eiddvHyArEW3yzQE=
Date: Wed, 22 Jan 2025 08:47:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Zheng Zhang <zzhan173@ucr.edu>
Subject: Re: Patch "net/sched: Fix mirred deadlock on device recursion"
 should probably be ported to 5.4, 5.10 and 5.15 LTS.
Message-ID: <2025012200-hurried-abrasive-8635@gregkh>
References: <CALAgD-5WmCEvNQMkQBk+XhRFQbKCoC8XP_eMP4U7N9RTOqWmQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5WmCEvNQMkQBk+XhRFQbKCoC8XP_eMP4U7N9RTOqWmQQ@mail.gmail.com>

On Tue, Jan 21, 2025 at 11:10:23PM -0800, Xingyu Li wrote:
> Hi,
> 
> We noticed that the patch 0f022d32c3ec should be probably ported to 6.1 and 6.6
> LTS according to the bug introducing commit. Also, it can be applied
> to the latest version of these two LTS branches without conflicts. Its
> bug introducing commit is 3bcb846ca4cf. According to our
> manual analysis,  the vulnerability is a deadlock caused by recursive
> locking of the qdisc lock (`sch->q.lock`) when packets are redirected
> in a loop (e.g., mirroring or redirecting packets to the same device).
> This happens because the same qdisc lock is attempted to be acquired
> multiple times by the same CPU, leading to a deadlock. The commit
> 3bcb846ca4cf removes the `spin_trylock()` in `net_tx_action()` and
> replaces it with `spin_lock()`. By doing so, it eliminates the
> non-blocking lock attempt (`spin_trylock()`), which would fail if the
> lock was already held, preventing recursive locking.  The
> `spin_lock()` will block (wait) if the lock is already held, allowing
> for the possibility of the same CPU attempting to acquire the same
> lock recursively, leading to a deadlock. The patch adds an `owner`
> field to the `Qdisc` structure to track the CPU that currently owns
> the qdisc. Before enqueueing a packet to the qdisc, it checks if the
> current CPU is the owner. If so, it drops the packet to prevent the
> recursive locking. This effectively prevents the deadlock by ensuring
> that the same CPU doesn't attempt to acquire the lock recursively.

This commit also breaks the build on the 6.1.y and 6.6.y branches which
perhaps it is why it was not applied there.

thanks,

greg k-h

