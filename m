Return-Path: <stable+bounces-99012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5319E6DB1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F9283047
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB771FF615;
	Fri,  6 Dec 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQa12A0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CC1DACB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486617; cv=none; b=W9hwQsOfqoayKUPXjwwHSIG5Jkdm3r7h/zxHRaiRoZ30kDd4bWeAAEZHNbiN2+U/Eiu+bh3wwgT7Fk2IOXTpMEJrh11nUJwzUIVuuAjIfeBGNiibB/3UrnGAtGW6UN+WBGD9sEIa8OVtW5vB69Hr7N2DRGIWe6Jih/TuKOOU9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486617; c=relaxed/simple;
	bh=Iv6u3jJECxm7nraVskPPp9dNnU/YY7aSN9VpnsxDju0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hvmZDXS2qm6lnyWryBBt4o6GTvw7KY0Jl0Frho8VzCqIzfnhq0dZgDaqZZp5W41AGEFi7WMSkBmgHXLzv22ydHKRBRYlbZD1APmj5og+xvdbt5NeAP4yiIfPhoHHoGJ5Y18EaQt8Wirm24cpTSPrwOYNVtdH9bESUBrs03YXn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQa12A0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015EDC4CED1;
	Fri,  6 Dec 2024 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486616;
	bh=Iv6u3jJECxm7nraVskPPp9dNnU/YY7aSN9VpnsxDju0=;
	h=Subject:To:Cc:From:Date:From;
	b=CQa12A0lCFP6g9Dl9MlVLYd1RuFUU++iL1Xa7Iq0PzuFeC7bQErOVqQKBgrIeufRB
	 kAtga03Te5sCW/KYXwdF0bH01L5eGDUtHpHdmWeNzNKiExzg0yjoNWmVbzjqFNp8IM
	 fQqosipIYA6/hoQ2fVyKy6LIDyiQ4vXQIXf+Vtz8=
Subject: FAILED: patch "[PATCH] ntp: Remove invalid cast in time offset math" failed to apply to 6.1-stable tree
To: marcelo.dalmas@ge.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:03:24 +0100
Message-ID: <2024120623-aloof-unearned-9578@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5807b0606da7ac7c1b74a386b22134ec7702d05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120623-aloof-unearned-9578@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


