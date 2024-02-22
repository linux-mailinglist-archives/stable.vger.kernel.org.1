Return-Path: <stable+bounces-23373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77C385FEA5
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CE1F28AD9
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310B154420;
	Thu, 22 Feb 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EM2vNDIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oubp1O7h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EM2vNDIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oubp1O7h"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758F154422
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621564; cv=none; b=cbeXSpRn8sZGdBcPxZNwNqaZ580kslPtedwbk6ylDvgsgcTumjg6p6Ta0O+ZOgCLh0UNDb7XELac6jIMPvyQTWtz+DjJiVZVJzjbiMBo75BvvMUY2f3WOLlcFFwyf/g4Cdu5b+rnn/NDW4djIdukff3Bwsa8PZDIjRqAVeSwF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621564; c=relaxed/simple;
	bh=3ros1Lc/ZrndziZiaV4ajh/fd20j7UUWgAnFPQKrKNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibqjcoMmKZzKOt31gkoJ4lPFA0NfBSjRYd+eXOKenzQ+Hsa68LO6mAkE6Kg/ZOILJTgiyeJoZ7NbJBQhHEoRNI8wCetEzWMSRCcH4PUvKh0B1+g3hQtDzWiOuUvidWZZi0pTgsiD+UUJfP/rAZrWlAiaKwYrtaau6Bq2jyqnUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EM2vNDIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oubp1O7h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EM2vNDIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oubp1O7h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7890E222B5;
	Thu, 22 Feb 2024 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPCQqyYEpFK68iodLzbBQpQZ7vbAv5wRA47VxYAC8DQ=;
	b=EM2vNDIWq3C0wgahPIzL1e3HOK3z0vSocx7Kum9sZ3wiv7WcCts5QQa/+MEWS608ogibOx
	JgcegqmFQ2u9RNzsI1C+RaXHOeCCieSWuaUdhp2ii9/ALGYq7IoFxeND0zvgzWDw7ytkqW
	uyFagk9ylU9/R0gAkBuqGscK6gFdPP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPCQqyYEpFK68iodLzbBQpQZ7vbAv5wRA47VxYAC8DQ=;
	b=Oubp1O7hM5n+2ZTcTDvrSzxn4s/mUYPvHO//a2szWrcB2K75AL+jI+KIwjSND9D4v2HWte
	gOqTCjuKlEgsTMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPCQqyYEpFK68iodLzbBQpQZ7vbAv5wRA47VxYAC8DQ=;
	b=EM2vNDIWq3C0wgahPIzL1e3HOK3z0vSocx7Kum9sZ3wiv7WcCts5QQa/+MEWS608ogibOx
	JgcegqmFQ2u9RNzsI1C+RaXHOeCCieSWuaUdhp2ii9/ALGYq7IoFxeND0zvgzWDw7ytkqW
	uyFagk9ylU9/R0gAkBuqGscK6gFdPP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPCQqyYEpFK68iodLzbBQpQZ7vbAv5wRA47VxYAC8DQ=;
	b=Oubp1O7hM5n+2ZTcTDvrSzxn4s/mUYPvHO//a2szWrcB2K75AL+jI+KIwjSND9D4v2HWte
	gOqTCjuKlEgsTMCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0653913419;
	Thu, 22 Feb 2024 17:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YD6LOvh+12WJCAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 17:06:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 5.4 v2 3/3] sched/rt: Disallow writing invalid values to sched_rt_period_us
Date: Thu, 22 Feb 2024 18:05:55 +0100
Message-ID: <20240222170555.1376055-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222170555.1376055-1-pvorel@suse.cz>
References: <20240222170555.1376055-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
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
[ pvorel: rebased for 5.4 ]
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 5 +----
 kernel/sysctl.c   | 4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fea993827c4f..873f364cb3c6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2659,9 +2659,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2693,7 +2690,7 @@ int sched_rt_handler(struct ctl_table *table, int write,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4f85f7ed42fc..865e539c7354 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -465,6 +465,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -472,6 +474,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= &neg_one,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rr_timeslice_ms",
-- 
2.35.3


