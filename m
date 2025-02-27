Return-Path: <stable+bounces-119820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E7A478B3
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 10:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B85E188FA43
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C211226885;
	Thu, 27 Feb 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRHgRjEH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610015DBB3;
	Thu, 27 Feb 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647274; cv=none; b=MgvLZ0z0STvooJf8LwqFg7YpVGBPJibLmbIwVy0cZ2/ZKINZ+l/2oSPhy7YzIuVBo0RGXg+DbA3HBuM0LHa62N46RcrGghZ2UK+++vzaxPOWQYI7+XLoq9c6xqCRhqyV+7n41mPISWN6p+byjd1Q6o8+Mo6s5eW6d2kHHgkEUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647274; c=relaxed/simple;
	bh=uSI5UxGrxM8RkQ3jlqH3utlrAtw26PUYGq0eb+CxpaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeNbD9Yd9gHKjAAsfQ7bPaOqiGDsiDppyWNx+wJfqC8Ikd45YXIApiZrD6ZwB7Gk5qYsqrqBxXGCwM+OjYDqBk6idr/Th8Do+6XoJqhsK5/pftgbQce3ip8Dkxpb3XhYNFHT3j2aYK9SNssoQbv9b4/R3k675gfxEYHYB6A+o2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRHgRjEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA92C4CEDD;
	Thu, 27 Feb 2025 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740647273;
	bh=uSI5UxGrxM8RkQ3jlqH3utlrAtw26PUYGq0eb+CxpaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRHgRjEHSGuyhFlBsSI3fVwcQLn8G0QLVjvEpK22Hf/qHsNoqA3J8xe1pybOh0ogD
	 nJ1bwQFWo4Wc3NgcjkwIizQRSBnsG3znd2AYGF6nPH/VbqkploZ0NepfWU1V5E050w
	 ZVCWW5vZASztI5bzZPDQAxzY/CooUQKOvqK6T7qW+ODLnMTA/Fdn/8V/1+IApzX2yt
	 buC68N2O+xPt1bpJ6UfumBgk0lSmO5d2jTUPP9ZOnClX8RcoLZPE104Wmj7zJEsYXf
	 ZTwCQxwsxDmIO8PONTvP0WQcYujO46xkRjXHS2YhSNP1KxwshJEqWNWXn+2b8bIIPt
	 BWlOMT79ptYtg==
Date: Thu, 27 Feb 2025 10:07:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Atsushi Ochiai <Atsushi.Ochiai@sony.com>,
	Daniel Palmer <Daniel.Palmer@sony.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] Documentation/no_hz: Remove description that
 states boot CPU cannot be nohz_full
Message-ID: <Z8ArXtTa8zAZDCtK@gmail.com>
References: <20250227-send-oss-20250129-v2-1-eea4407300cf@sony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-send-oss-20250129-v2-1-eea4407300cf@sony.com>


* Krishanth Jagaduri <Krishanth.Jagaduri@sony.com> wrote:

> Hi,
> 
> Before kernel 6.9, Documentation/timers/no_hz.rst states that
> "nohz_full=" mask must not include the boot CPU, which is no longer
> true after commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be
> nohz_full").
> 
> When trying LTS kernels between 5.4 and 6.6, we noticed we could use
> boot CPU as nohz_full but the information in the document was misleading.
> 
> This was fixed upstream by commit 5097cbcb38e6 ("sched/isolation: Prevent
> boot crash when the boot CPU is nohz_full").
> 
> While it fixes the document description, it also fixes issue introduced
> by another commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
> timers on queue_delayed_work").
> 
> It is unlikely that upstream commit as a whole will be backported to
> stable kernels which does not contain the commit that introduced the
> issue of boot crash when boot CPU is nohz_full.
> 
> Could we fix only the document portion in stable kernels 5.4+ that
> mentions boot CPU cannot be nohz_full?

So you are requesting a partial backport to -stable of the 
Documentation/timers/no_hz.rst chunk of 5097cbcb38e6?

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

================={ partial backport of 5097cbcb38e6 }=================>
From 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 11 Apr 2024 16:39:05 +0200
Subject: [PATCH] sched/isolation: Prevent boot crash when the boot CPU is
 nohz_full

Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
include the boot CPU, which is no longer true after:

  08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").

However after:

  aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")

the kernel will crash at boot time in this case; housekeeping_any_cpu()
returns an invalid CPU number until smp_init() brings the first
housekeeping CPU up.

Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
return smp_processor_id() in this case.

This is just the simple and backportable workaround which fixes the
symptom, but smp_processor_id() at boot time should be safe at least for
type == HK_TYPE_TIMER, this more or less matches the tick_do_timer_boot_cpu
logic.

There is no worry about cpu_down(); tick_nohz_cpu_down() will not allow to
offline tick_do_timer_cpu (the 1st online housekeeping CPU).

Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240411143905.GA19288@redhat.com
Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
---
 Documentation/timers/no_hz.rst |  7 ++-----
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index f8786be15183..7fe8ef9718d8 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
 online to handle timekeeping tasks in order to ensure that system
 calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
 (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
-user processes to observe slight drifts in clock rate.)  Therefore, the
-boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
-"nohz_full=" mask that includes the boot CPU will result in a boot-time
-error message, and the boot CPU will be removed from the mask.  Note that
-this means that your system must have at least two CPUs in order for
+user processes to observe slight drifts in clock rate.) Note that this
+means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.

