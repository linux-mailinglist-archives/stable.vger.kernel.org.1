Return-Path: <stable+bounces-165807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDFB1901F
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B4E17CEF5
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5423817D;
	Sat,  2 Aug 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJJcui2K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2901F428F;
	Sat,  2 Aug 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754170228; cv=none; b=mt/Xqwbd0/oNBoP7KQhQF4UM9YdkHuoT5BmuRGIqi6KElqHXig5UgaPpERUbcNv7HEW1J+hRNCckFpFOskgwkkQ/5IzNmngcnAAPlYka5/n3lFEiOSMqE9BQDqQ4MqEIRiOhL6lTbsh6lZjiR/dGFrIRcBOCBtpPhElgc09+HJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754170228; c=relaxed/simple;
	bh=WMP3Sv2eHg7fyXQr6Qc3qTQEOfDb6nSqtqBIaMNeD/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX12FwEZyJg722gq5lSs8RhLCa3pMi5iZenB8DlEroen7J7r0Ko757rHqr5Da4+1EP0OckAETOXTIo5GCeDigzhMpU7yY8Gr8b2B9NfNalA2SFEg9FJu3MmbGyXhuV95wSbQ2YsLsZh1JQGhBnZ7dotsRnnNWfTcUXaIJzrCx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJJcui2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A7EC4CEEF;
	Sat,  2 Aug 2025 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754170227;
	bh=WMP3Sv2eHg7fyXQr6Qc3qTQEOfDb6nSqtqBIaMNeD/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJJcui2KmespbOUNr1NMdKcKSuxE0HtTZQYBGWAclcW6gFmUHivVCsDkpEraiTUN+
	 PNHxxpIohwBQVYYlXFxM7gcA1ghU11sTw4a5dyu5D0jTJsexJmOW0/Dv1Gjv+kppxI
	 3tHA5aDL35eTU40aGAX1HsYVjS/1zCVEnfV/NM0s=
Date: Sat, 2 Aug 2025 22:30:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	"ppbuk5246 @ gmail . com" <ppbuk5246@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org, kasan-dev@googlegroups.com,
	syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path
 on PREEMPT_RT
Message-ID: <2025080212-expediter-sinless-4d9c@gregkh>
References: <20250802142647.139186-3-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802142647.139186-3-ysk@kzalloc.com>

On Sat, Aug 02, 2025 at 02:26:49PM +0000, Yunseong Kim wrote:
> The KCOV subsystem currently utilizes standard spinlock_t and local_lock_t
> for synchronization. In PREEMPT_RT configurations, these locks can be
> implemented via rtmutexes and may therefore sleep. This behavior is
> problematic as kcov locks are sometimes used in atomic contexts or protect
> data accessed during critical instrumentation paths where sleeping is not
> permissible.
> 
> Address these issues to make kcov PREEMPT_RT friendly:
> 
> 1. Convert kcov->lock and kcov_remote_lock from spinlock_t to
>    raw_spinlock_t. This ensures they remain true, non-sleeping
>    spinlocks even on PREEMPT_RT kernels.
> 
> 2. Refactor the KCOV_REMOTE_ENABLE path to move memory allocations
>    out of the critical section. All necessary struct kcov_remote
>    structures are now pre-allocated individually in kcov_ioctl()
>    using GFP_KERNEL (allowing sleep) before acquiring the raw
>    spinlocks.
> 
> 3. Modify the ioctl handling logic to utilize these pre-allocated
>    structures within the critical section. kcov_remote_add() is
>    modified to accept a pre-allocated structure instead of allocating
>    one internally.
> 
> 4. Remove the local_lock_t protection for kcov_percpu_data in
>    kcov_remote_start/stop(). Since local_lock_t can also sleep under
>    RT, and the required protection is against local interrupts when
>    accessing per-CPU data, it is replaced with explicit
>    local_irq_save/restore().

why isn't this 4 different patches?

