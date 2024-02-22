Return-Path: <stable+bounces-23341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110E85FC0A
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA22B26177
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217E14A0B3;
	Thu, 22 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r99meLOK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iO9guHNH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r99meLOK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iO9guHNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C114A0BE
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614831; cv=none; b=mpQReD/+Gaq3IwvmcsgvKjso2tLF4yYBrOy1andg8DxZMVJ1rdHCHC/uIQVSmDtv7QZcb8RtIexJA3pJNPBZ3hptjtNk/9bj3RFgKCmTQb0oeRsvGhxsjDdEMb/AzvjXLxvaiSbr2cEIwHl7ATIW7kPfLGo+61oP1gj2jBseH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614831; c=relaxed/simple;
	bh=vRPzqyL0oNJ6evtYEE/idcNMqUn8nIWfzgsqQEI2sK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4JQ5Zw7iBIBtsbLvRUvJtgwIriu4WgzCBepo0ex3eEov59vLFkRPewUJFhVciVxQIIuuYIpDUE7axztXrCbGwKmOSu6YYQarVaH9I3vSypZfNL2kFYZ843IrpFE5OwJRRh+rrpiubce33cUCHf8S9fKhw32QayfBSpceL3kg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r99meLOK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iO9guHNH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r99meLOK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iO9guHNH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0201F74D;
	Thu, 22 Feb 2024 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYWBjbJK94/9r1JUQspdqYLQVeI9glpBN8K1XDDIRso=;
	b=r99meLOKLF2bzMpZAzTNt4vODO2BNRoHh+nRCzZfoWx7bbx+e+RalEG7Xd452c766eUIRm
	J0n3v550RnzPMrUgmETTbAc+V5A2PFhgA2AsQlvZ8ndIDpQPNRyV9Am8pDPEufbIEB+PzX
	zd1am0+2CoiBtPHOQ13eoAqucKI7WQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYWBjbJK94/9r1JUQspdqYLQVeI9glpBN8K1XDDIRso=;
	b=iO9guHNH8yShRAA9pYlOuHw97XAj76v6y8oOgayVuMuHJCVnZ2M6uuAYPRvNaqJR1U++kk
	KLUR1u7OS/0yOyBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYWBjbJK94/9r1JUQspdqYLQVeI9glpBN8K1XDDIRso=;
	b=r99meLOKLF2bzMpZAzTNt4vODO2BNRoHh+nRCzZfoWx7bbx+e+RalEG7Xd452c766eUIRm
	J0n3v550RnzPMrUgmETTbAc+V5A2PFhgA2AsQlvZ8ndIDpQPNRyV9Am8pDPEufbIEB+PzX
	zd1am0+2CoiBtPHOQ13eoAqucKI7WQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYWBjbJK94/9r1JUQspdqYLQVeI9glpBN8K1XDDIRso=;
	b=iO9guHNH8yShRAA9pYlOuHw97XAj76v6y8oOgayVuMuHJCVnZ2M6uuAYPRvNaqJR1U++kk
	KLUR1u7OS/0yOyBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A2513A71;
	Thu, 22 Feb 2024 15:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oGl/Eqtk12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 3/3] sched/rt: Disallow writing invalid values to sched_rt_period_us
Date: Thu, 22 Feb 2024 16:13:24 +0100
Message-ID: <20240222151333.1364818-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222151333.1364818-1-pvorel@suse.cz>
References: <20240222151333.1364818-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r99meLOK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iO9guHNH
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 3B0201F74D
X-Spam-Flag: NO

From: Cyril Hrubis <chrubis@suse.cz>

[ Upstream commit 079be8fc630943d9fc70a97807feb73d169ee3fc ]

The validation of the value written to sched_rt_period_us was broken
because:

  - the sysclt_sched_rt_period is declared as unsigned int
  - parsed by proc_do_intvec()
  - the range is asserted after the value parsed by proc_do_intvec()

Because of this negative values written to the file were written into a
unsigned integer that were later on interpreted as large positive
integers which did passed the check:

  if (sysclt_sched_rt_period <= 0)
	return EINVAL;

This commit fixes the parsing by setting explicit range for both
perid_us and runtime_us into the sched_rt_sysctls table and processes
the values with proc_dointvec_minmax() instead.

Alternatively if we wanted to use full range of unsigned int for the
period value we would have to split the proc_handler and use
proc_douintvec() for it however even the
Documentation/scheduller/sched-rt-group.rst describes the range as 1 to
INT_MAX.

As far as I can tell the only problem this causes is that the sysctl
file allows writing negative values which when read back may confuse
userspace.

There is also a LTP test being submitted for these sysctl files at:

  http://patchwork.ozlabs.org/project/ltp/patch/20230901144433.2526-1-chrubis@suse.cz/

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231002115553.3007-2-chrubis@suse.cz
[ pvorel: rebased for 4.19 ]
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 5 +----
 kernel/sysctl.c   | 5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2ea4da8c5f3a..deb9366e4f30 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2658,9 +2658,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		(sysctl_sched_rt_runtime > sysctl_sched_rt_period))
 		return -EINVAL;
@@ -2690,7 +2687,7 @@ int sched_rt_handler(struct ctl_table *table, int write,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4bb194f096ec..6ce9f10b9c7d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,6 +127,7 @@ static int zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
+static int int_max = INT_MAX;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
@@ -464,6 +465,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= &one,
+		.extra2		= &int_max,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -471,6 +474,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= &neg_one,
+		.extra2		= &int_max,
 	},
 	{
 		.procname	= "sched_rr_timeslice_ms",
-- 
2.35.3


