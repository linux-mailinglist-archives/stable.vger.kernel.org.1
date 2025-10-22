Return-Path: <stable+bounces-188922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA2BFAC3F
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00C1E4F559B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD163064A5;
	Wed, 22 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xsVQDh2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41921306481;
	Wed, 22 Oct 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120171; cv=none; b=HGf5QIz6y/mwTTGXq7ZzXSNkPSQb7UcCZS0k/hEKcXmY3nlbsc6OUzSNKuOD6Vqjw4J5u99sdMhBKklWshCx2ztIIDZq80FGztKOHqQbyqt2fUMbvZ3s3ZXwWFs8Ny1FIisUnZhs6h5u/G8tp+Dlc1ItvPNMrB7I6L4rJEQe7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120171; c=relaxed/simple;
	bh=6KyeXhuRv/gbNRLF/Qqgz7ISIJRT8ewlX6UjL2d8zZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkf4mJbmF/nNRg1R20WphkSs2DFsCUa9R95fc8AaEPAuM+pBjczuLmbsPQW+flslWvBo2OslFY+0LEc717vH2Wc30hZuCTBk2gRpLqOaodirMw9l/NTmiF0uXGn8ytn6l7ro2P5LaN8tPJ2wSBPtyVzNrJQojE3UFqE29C6Ejx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xsVQDh2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743B4C116C6;
	Wed, 22 Oct 2025 08:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761120169;
	bh=6KyeXhuRv/gbNRLF/Qqgz7ISIJRT8ewlX6UjL2d8zZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xsVQDh2uXvtgGe5R6o4BH5/YGX7BTrd/69ZfNqM3BLhaJA25y/Gbu5JvvffJeGrvJ
	 4zIEaiqZ0SNLj0owXd7e6IoeFj+Rzn281KRXCfBVLZpmqPtE0sT1DcomfCxosOt98r
	 6BE8W/kEqVQLozO23ACCoS7FSTxqyjjSZGisraxs=
Date: Wed, 22 Oct 2025 10:02:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jimmy Hu <hhhuuu@google.com>
Cc: linux-usb@vger.kernel.org, badhri@google.com, stern@rowland.harvard.edu,
	royluo@google.com, Thinh.Nguyen@synopsys.com, balbi@ti.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: udc: fix race condition in usb_del_gadget
Message-ID: <2025102212-selected-ovary-6259@gregkh>
References: <20251014085156.2651449-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014085156.2651449-1-hhhuuu@google.com>

On Tue, Oct 14, 2025 at 08:51:56AM +0000, Jimmy Hu wrote:
> A race condition during gadget teardown can lead to a use-after-free
> in usb_gadget_state_work(), as reported by KASAN:
> 
>   BUG: KASAN: invalid-access in sysfs_notify+0_x_2c/0_x_d0
>   Workqueue: events usb_gadget_state_work
> 
> The fundamental race occurs because a concurrent event (e.g., an
> interrupt) can call usb_gadget_set_state() and schedule gadget->work
> at any time during the cleanup process in usb_del_gadget().
> 
> Commit 399a45e5237c ("usb: gadget: core: flush gadget workqueue after
> device removal") attempted to fix this by moving flush_work() to after
> device_del(). However, this does not fully solve the race, as a new
> work item can still be scheduled *after* flush_work() completes but
> before the gadget's memory is freed, leading to the same use-after-free.
> 
> This patch fixes the race condition robustly by introducing a 'teardown'
> flag and a 'state_lock' spinlock to the usb_gadget struct. The flag is
> set during cleanup in usb_del_gadget() *before* calling flush_work() to
> prevent any new work from being scheduled once cleanup has commenced.
> The scheduling site, usb_gadget_set_state(), now checks this flag under
> the lock before queueing the work, thus safely closing the race window.
> 
> Changes in v2:
>   - Removed redundant inline comments as suggested by Alan Stern.

This goes below the --- line.

> 2.51.0.760.g7b8bcc2412-goog

This does not apply to my usb-linus branch, what kernel was it made
against?  Can you rebase and resubmit it based on that one?

