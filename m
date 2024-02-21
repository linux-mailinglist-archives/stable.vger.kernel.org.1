Return-Path: <stable+bounces-22194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DC85DACE
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C9D1C22E29
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B777E79D;
	Wed, 21 Feb 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tHjB/gXA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579E77655;
	Wed, 21 Feb 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522388; cv=none; b=STwJStvsdeHLNVyqgevriLa6RbAoMyd+pA7uIpsm0lAZxNLv5aPGGn8WGTtMzCMRPKy1uRYi5B1hWlach8SNkwhNE5/uxX6E2mFP1kKgHDGnd02RJtV7zMPPAWsCtB73lHARqofV4EupUTIUtWXW+36G9doskCGUHe3KOEv9DtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522388; c=relaxed/simple;
	bh=cCY9rGQFcXV0wYjiMirnu6j2/zbqrhj8NlLtYBruNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoJNggr73AFbY3kVCxMMEXOtkMAOWl96Bkhylb+KqG4hDJHkd3jS36Vs8o6cC/1l+y3izT6Hr/dB8uzW19tTD1Asn+ZnSLPcp1gEZg2i3eZhXudKh8jturCah2JwDP+6vRg3TPLU0KICu9Hm95fQ2e7Tzs578R/N+Q12DDq/LgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tHjB/gXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12478C433F1;
	Wed, 21 Feb 2024 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522387;
	bh=cCY9rGQFcXV0wYjiMirnu6j2/zbqrhj8NlLtYBruNcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHjB/gXA/xgmsaNHaNaNxrOJjw93CgYG7p6OfVBvVGBovNptVQT3dQv6+pjNIi5/5
	 ho2xKYWoi/tZxMh3urQXZoSqlymXtk8fbZFfSmO4CDQZgl0DCIcddUeYvH+fJzCARz
	 BFRzgjWf5V3k1wPKUQ217F6SRVmLQbEyf/8uRHLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.15 123/476] tick/sched: Preserve number of idle sleeps across CPU hotplug events
Date: Wed, 21 Feb 2024 14:02:54 +0100
Message-ID: <20240221130012.527295867@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Chen <tim.c.chen@linux.intel.com>

commit 9a574ea9069be30b835a3da772c039993c43369b upstream.

Commit 71fee48f ("tick-sched: Fix idle and iowait sleeptime accounting vs
CPU hotplug") preserved total idle sleep time and iowait sleeptime across
CPU hotplug events.

Similar reasoning applies to the number of idle calls and idle sleeps to
get the proper average of sleep time per idle invocation.

Preserve those fields too.

Fixes: 71fee48f ("tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug")
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240122233534.3094238-1-tim.c.chen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/tick-sched.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1529,6 +1529,7 @@ void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
+	unsigned long idle_calls, idle_sleeps;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
@@ -1537,9 +1538,13 @@ void tick_cancel_sched_timer(int cpu)
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
+	idle_calls = ts->idle_calls;
+	idle_sleeps = ts->idle_sleeps;
 	memset(ts, 0, sizeof(*ts));
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
+	ts->idle_calls = idle_calls;
+	ts->idle_sleeps = idle_sleeps;
 }
 #endif
 



