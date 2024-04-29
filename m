Return-Path: <stable+bounces-41748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B18268B5DEF
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDEEB21536
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC19823A2;
	Mon, 29 Apr 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KMXlve6D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F27E0F6
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405286; cv=none; b=r3SfAC84pyd+2vgUvKZWKCwTPr7zAgKRSxDm6doyYvRjCS2HRdmRzQN0v70j9ohNitR2Qor5C+WsALMKtoaCuh5UKrH6trDau7FEYhyEl1YjTXeto6OGOnHvCHvscQbNHg8+IO9LuNmu27ivB0HxYMI21fRZXydcvK6mhuTE1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405286; c=relaxed/simple;
	bh=s0bMMn0xw66iKofOyRvkxvyapwQg/Bdw2IRyjfyiM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCmAo4OCZMdSzQ5O1++WTrGKFt0SFcdDZjul8LR8fYy/ZimMlym2V8f6OIMB3QE7nyn+67Grfrh0SfHhB2CiyqAIC4D92KU4O/twPVABu7oxpVxzv+GR7GO984GmZK2TpyTknO6X+fFeFVx2crM5LSDJqkP+ewcxQHmPcZSCtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KMXlve6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1204BC113CD;
	Mon, 29 Apr 2024 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714405286;
	bh=s0bMMn0xw66iKofOyRvkxvyapwQg/Bdw2IRyjfyiM6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMXlve6DMN6QzsBrb+kSuwHi1NNOVx3i80udIJ6o+Gz7OLQxQUmFcSLG2O0iRjpcB
	 vgBhD9eo3IwwbT9RsoZ8xgwvbyVaL/Zx3uTgFAf4qhvJh87C7TMCqgrHHuEEJAKcGK
	 Of1UY577PM3kXGDbxlDobFkS5n1BwSSODQ5jjVes=
Date: Mon, 29 Apr 2024 17:41:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org, Eva Kurchatova <nyandarknessgirl@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 5.15.y, 5.10.y, 5.4.y, 4.19.y] HID: i2c-hid: remove
 I2C_HID_READ_PENDING flag to prevent lock-up
Message-ID: <2024042914-asparagus-undercook-5b64@gregkh>
References: <2024042952-germless-unguarded-1be2@gregkh>
 <20240429152514.652751-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429152514.652751-1-namcao@linutronix.de>

On Mon, Apr 29, 2024 at 05:25:15PM +0200, Nam Cao wrote:
> commit 9c0f59e47a90c54d0153f8ddc0f80d7a36207d0e upstream.
> 
> The flag I2C_HID_READ_PENDING is used to serialize I2C operations.
> However, this is not necessary, because I2C core already has its own
> locking for that.
> 
> More importantly, this flag can cause a lock-up: if the flag is set in
> i2c_hid_xfer() and an interrupt happens, the interrupt handler
> (i2c_hid_irq) will check this flag and return immediately without doing
> anything, then the interrupt handler will be invoked again in an
> infinite loop.
> 
> Since interrupt handler is an RT task, it takes over the CPU and the
> flag-clearing task never gets scheduled, thus we have a lock-up.
> 
> Delete this unnecessary flag.
> 
> Reported-and-tested-by: Eva Kurchatova <nyandarknessgirl@gmail.com>
> Closes: https://lore.kernel.org/r/CA+eeCSPUDpUg76ZO8dszSbAGn+UHjcyv8F1J-CUPVARAzEtW9w@mail.gmail.com
> Fixes: 4a200c3b9a40 ("HID: i2c-hid: introduce HID over i2c specification implementation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> [apply to v4.19 -> v5.15]
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 8 --------
>  1 file changed, 8 deletions(-)

Now queued up, thanks.

greg k-h

