Return-Path: <stable+bounces-99014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF89E6DB3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF45167436
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D120010E;
	Fri,  6 Dec 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gmVh3u+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BE1DACB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486623; cv=none; b=QswEZfwYNMJji+GkWafGDkWUzmjyZua4c6Qh2JeakLt6RksfejnaF4V2aKxBjfywQBJyhxKhZ21zeKJ+uBfZcVvDgv2D89k8SFvWayUoLq9MDiJOju8EaGerRiQ1wt3If7lVQwfeYuuNeVrXu2xLpyj8chP2sAVP/eZ5Xbk2Ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486623; c=relaxed/simple;
	bh=y9ZfW52BqVXdjjEe/WUbNUWbd7hlbJOnEeQm3VeRJic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rPWhRwsVu4pfYVpxmA88G23gmWLjmnUyuQHSLIjzjUw0YIHvPCcRTmNQ0Jld2P7WNhuTTaD8ugjsT993OAdwTHVaJBnrrfvB1RF4gV2gQiYfDFasEOYzK/XkIbTwvlPwzKZaaVBJbr7duej/Tmps2mRpqP/YKbNheB0Rh5zzh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmVh3u+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3518C4CED1;
	Fri,  6 Dec 2024 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486623;
	bh=y9ZfW52BqVXdjjEe/WUbNUWbd7hlbJOnEeQm3VeRJic=;
	h=Subject:To:Cc:From:Date:From;
	b=gmVh3u+POArCLDZltzHD/6yzh8r7cECDcwiyx4Lbpdzhqh4osui2S4iUTJJ4f3Bjf
	 HCNVcuIjQx428/g75hLoIjPHmkHPCy9yEylsHkb/4N/u+kc2ylT8mpshEymrmn6eYW
	 2tMwOSti/hdS8JDGI6CQYG8WjSexcI7MiYR7Y250=
Subject: FAILED: patch "[PATCH] ntp: Remove invalid cast in time offset math" failed to apply to 5.4-stable tree
To: marcelo.dalmas@ge.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:03:26 +0100
Message-ID: <2024120626-macaroni-copy-e7b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f5807b0606da7ac7c1b74a386b22134ec7702d05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120626-macaroni-copy-e7b8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5807b0606da7ac7c1b74a386b22134ec7702d05 Mon Sep 17 00:00:00 2001
From: Marcelo Dalmas <marcelo.dalmas@ge.com>
Date: Mon, 25 Nov 2024 12:16:09 +0000
Subject: [PATCH] ntp: Remove invalid cast in time offset math

Due to an unsigned cast, adjtimex() returns the wrong offest when using
ADJ_MICRO and the offset is negative. In this case a small negative offset
returns approximately 4.29 seconds (~ 2^32/1000 milliseconds) due to the
unsigned cast of the negative offset.

This cast was added when the kernel internal struct timex was changed to
use type long long for the time offset value to address the problem of a
64bit/32bit division on 32bit systems.

The correct cast would have been (s32), which is correct as time_offset can
only be in the range of [INT_MIN..INT_MAX] because the shift constant used
for calculating it is 32. But that's non-obvious.

Remove the cast and use div_s64() to cure the issue.

[ tglx: Fix white space damage, use div_s64() and amend the change log ]

Fixes: ead25417f82e ("timex: use __kernel_timex internally")
Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b550ebe0f03b..163e7a2033b6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -798,7 +798,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 		txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
 		if (!(ntpdata->time_status & STA_NANO))
-			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
+			txc->offset = div_s64(txc->offset, NSEC_PER_USEC);
 	}
 
 	result = ntpdata->time_state;


