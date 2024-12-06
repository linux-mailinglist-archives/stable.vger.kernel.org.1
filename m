Return-Path: <stable+bounces-99010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B439E6DAF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD3E16757B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96C1FF7D9;
	Fri,  6 Dec 2024 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qMurHATt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9711DACB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486609; cv=none; b=ltnvQRVc++ihoBnhHnuI8RfZ70KwzbfNZVAxG0JBHBxpBklsicchI0Cmt3Nygs1kz1gdAjxm5zBnHMSR26mLqL27Sc/bKGuMg4wGrhpp9z6vBqFaYBZoTbEwnzSXCcIwvcvkNZThxzSP3mtEP2nnNmDi1NP77tX6H2M/YKtHKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486609; c=relaxed/simple;
	bh=0EYu9rcizjYsJYzuR7jkYvCzWMGCQSFcqcEWvKmhScA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GkQNqApvKShMIY+anpJ8FuZ1JnBZEmFIA+ZjQizoyIfqKA5Trm5ljDVgm00kN1KXhKQnMfy4jqpUUdZyhGRftvJreCPW8agJUFuU+PGzyhuTZZ1w10o291/F5LIfQK2L3iqt+26yCPdD4dMJW33ydGVt+Kq5CQFH7Tbv1cRl2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qMurHATt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2467DC4CEDD;
	Fri,  6 Dec 2024 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486609;
	bh=0EYu9rcizjYsJYzuR7jkYvCzWMGCQSFcqcEWvKmhScA=;
	h=Subject:To:Cc:From:Date:From;
	b=qMurHATt69NXHXRf8zG9Bk7Tosmb127Zo1Z5Me1YQEKDcgrMWWb/6cB+WcU4tM+AW
	 c2CX2PXp2d6EtNogeypj9IZJfcmJD02NxIsEspvCAATySfliEimOCyOC+WQM331vkf
	 3z/POuwWy9b7jnu7tlB+2zT8fFdLkyqfAht/J3ug=
Subject: FAILED: patch "[PATCH] ntp: Remove invalid cast in time offset math" failed to apply to 6.6-stable tree
To: marcelo.dalmas@ge.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:03:23 +0100
Message-ID: <2024120623-recharger-elevation-99e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f5807b0606da7ac7c1b74a386b22134ec7702d05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120623-recharger-elevation-99e1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


