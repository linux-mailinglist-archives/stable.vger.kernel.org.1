Return-Path: <stable+bounces-126047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59ADA6FE98
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703FE3A9EFB
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50584264A6C;
	Tue, 25 Mar 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijMb11DF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AD2594B7;
	Tue, 25 Mar 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905502; cv=none; b=r2xHxH6OPqfe1PcTkUWKSxrRkiXI6ZkJZaKnik2ZhG7ABYU02UNt2BmkKGrWevxm4QrKpUPMx5IWWu8u7Uu0HOmPpohWxiHIhsu9LFubBrbQhHu1PsX9yit/Jnx3NJmGhbd4toDWcHkQKIlZW4E4Emut9WEaz9tpFosMen6Np3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905502; c=relaxed/simple;
	bh=swJPjodcyIDMfsjk7f+YEg1eX0Toln5dcjYJohnw7O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwm4qrB+JKkKR+gnoKdBqVIipPC31AZZ/U++fInCxCKNU77/IqjtSaFY3spC1X0TIDavMrHB4ZhMhjtZf2ufzcRxkHP6+Yc5cOzgWX7+M57p1oK5QVts8sNhFB2H357dl5eMgJXMG+mLc5XFXHWearp7qeuRLWLNEdL/B3rBPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijMb11DF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D6AC4CEEF;
	Tue, 25 Mar 2025 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905501;
	bh=swJPjodcyIDMfsjk7f+YEg1eX0Toln5dcjYJohnw7O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijMb11DFPT/qUuR+AI6NDSorTLdD1HqrOsZh05OJmr0nlO0TpRRu5JUyWwLN9Nzfy
	 mfjyYUHKZtO4NrkARB8zNzSKrzi8r4UYBkDksj0E78D4vfUvGZpsEuf6O030S8SA4J
	 MgrnKM4DmFqXBAuWbZ79S5AcIDmnq8drE+uX3zhU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Phil Auld <pauld@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
Subject: [PATCH 6.1 002/198] sched/isolation: Prevent boot crash when the boot CPU is nohz_full
Date: Tue, 25 Mar 2025 08:19:24 -0400
Message-ID: <20250325122156.702442458@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

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

[ Apply only documentation changes as commit which causes boot
  crash when boot CPU is nohz_full is not backported to stable
  kernels - Krishanth ]

Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240411143905.GA19288@redhat.com
Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
Signed-off-by: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
[ strip out upstream commit and Fixes: so tools don't get confused that
  this commit actually does anything real - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/timers/no_hz.rst |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-ad
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



