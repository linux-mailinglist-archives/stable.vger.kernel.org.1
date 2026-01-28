Return-Path: <stable+bounces-212654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN2sOPVSemnk5AEAu9opvQ
	(envelope-from <stable+bounces-212654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:18:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFADCA7AA1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F23653023DC1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74D2BEC2E;
	Wed, 28 Jan 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ta6HgQEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0D35A93C;
	Wed, 28 Jan 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624017; cv=none; b=MLTDcz6uW6WvCsxrkS3w5Kcbghs5wwuW+/tzHTe8m/7l/x6JBwOZVTtO7aK8GxVFMXl+cGYGaTOCNBpyPuhdrUHhHR/GmqXV9PUVJFbeaq3vbn0D2W4mq4o96Kn6dP3DFUg2TvIoZ+5bzQZDB9IFdpgQZ4XxUVJJ3LDZQQpTHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624017; c=relaxed/simple;
	bh=FNTeVPL/7h0F29bmgKcXfoiBpwnhcjzlPRUqsspWBBI=;
	h=Date:To:From:Subject:Message-Id; b=GhxiCbE8Jl5ug9H0D2m/DRAfFJO2DQK5d/ecOBXdDBd7gu4HAnFcymBUR37288KZE3ahP6V8nRLLUwWHf1O1MSF03VbyubMOXGRpZy6kSi3wayIoC/wqedlC/5pjgqty2ymGl8jcg5qn5avF+gJgz1dZ2+NkouJ1y8V1kD7YEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ta6HgQEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A426C4CEF1;
	Wed, 28 Jan 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769624017;
	bh=FNTeVPL/7h0F29bmgKcXfoiBpwnhcjzlPRUqsspWBBI=;
	h=Date:To:From:Subject:From;
	b=Ta6HgQEEXCYfVMUN1UcDbe0AvktSvDEdag0cOwxyoQ4bGEA2ylTDByTtGchzT2ehd
	 PJd3trDq3z+WwvvJIQRWSkaUwwbi5eWfuVi4WNWMxDI6LMATp7mxDe+XH8g06kYCnV
	 TBIQJObHPOBagMGO00Jz7dkGE9wK/IjrthlqvnIE=
Date: Wed, 28 Jan 2026 10:13:36 -0800
To: mm-commits@vger.kernel.org,zhang.run@zte.com.cn,tglx@linutronix.de,stable@vger.kernel.org,pmladek@suse.com,mingo@kernel.org,broonie@kernel.org,hu.shengming@zte.com.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + watchdog-softlockup-fix-sample-ring-index-wrap-in-need_counting_irqs.patch added to mm-nonmm-unstable branch
Message-Id: <20260128181337.0A426C4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212654-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AFADCA7AA1
X-Rspamd-Action: no action


The patch titled
     Subject: watchdog/softlockup: fix sample ring index wrap in need_counting_irqs()
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     watchdog-softlockup-fix-sample-ring-index-wrap-in-need_counting_irqs.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/watchdog-softlockup-fix-sample-ring-index-wrap-in-need_counting_irqs.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Shengming Hu <hu.shengming@zte.com.cn>
Subject: watchdog/softlockup: fix sample ring index wrap in need_counting_irqs()
Date: Mon, 19 Jan 2026 21:59:05 +0800

cpustat_tail indexes cpustat_util[], which is a NUM_SAMPLE_PERIODS-sized
ring buffer. need_counting_irqs() currently wraps the index using
NUM_HARDIRQ_REPORT, which only happens to match NUM_SAMPLE_PERIODS.

Use NUM_SAMPLE_PERIODS for the wrap to keep the ring math correct even if
the NUM_HARDIRQ_REPORT or  NUM_SAMPLE_PERIODS changes.

Link: https://lkml.kernel.org/r/tencent_7068189CB6D6689EB353F3D17BF5A5311A07@qq.com
Fixes: e9a9292e2368 ("watchdog/softlockup: Report the most frequent interrupts")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhang Run <zhang.run@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/watchdog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/watchdog.c~watchdog-softlockup-fix-sample-ring-index-wrap-in-need_counting_irqs
+++ a/kernel/watchdog.c
@@ -550,7 +550,7 @@ static bool need_counting_irqs(void)
 	u8 util;
 	int tail = __this_cpu_read(cpustat_tail);
 
-	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
+	tail = (tail + NUM_SAMPLE_PERIODS - 1) % NUM_SAMPLE_PERIODS;
 	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
 	return util > HARDIRQ_PERCENT_THRESH;
 }
_

Patches currently in -mm which might be from hu.shengming@zte.com.cn are

watchdog-softlockup-fix-sample-ring-index-wrap-in-need_counting_irqs.patch


