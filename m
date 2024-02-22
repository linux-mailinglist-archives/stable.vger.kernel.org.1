Return-Path: <stable+bounces-23345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E8285FC0C
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27DCB26166
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB514C5BD;
	Thu, 22 Feb 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x++xDKFb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="my2wfEc9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uNVpHwQo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8fJ8Nv+B"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBC14C5A2
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614835; cv=none; b=ILVPa4oss7ZvQRAWaoJOqjgcWvFJKJFm3gAgVlDfuXxNRmZvOEJmauIWoeUyYBCBraA3lmQC7fJA4Vwda6iXS29NFkPNq0sYd/xflGL5WwIk/hK4F8ogS5W4L07VnipTobsu/L0M7DIwilw1hz+lfIrfG9PHD4nIbkNHsrRyLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614835; c=relaxed/simple;
	bh=EzjcxpfKTyKDVJIz63v9HbvRw+5IWJ/lXQ53GCrXLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzCIxukuZqcAgO+uuHWc7j6vzxZ2GQVDvwJ1n2mnRz5zkv/2ahyTAXwxZ5aVIJX4S+gObJl01Eyd1DCEO3nqNYeLUvUpRC04VK7GdV44Fq715vSVtOosoiLPkVFmZZ7lg5AUrw/TJ2ZgEV/mWoPQsyyrIDnUocuIjY6vlHEuOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x++xDKFb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=my2wfEc9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uNVpHwQo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8fJ8Nv+B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E750221FAB;
	Thu, 22 Feb 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cegPLn5Vd3KYExPYPWwmzEC9DLsyLxuhf4apwv7DAwE=;
	b=x++xDKFbHV+RnvuEhhpyO/niKwN7sFJNR4WdaIVLVtMNW/NYa+n4D3hsQhGeLGFRmhFMgZ
	rUK08pFRgsA/osn54BxsyJluDvqEC7/en7mTrDKTrjPnKwC57AKFZGvydVBAa4Ho64lig0
	2+XOtBRL7AzZrIJOzMGO1mMM/LhqFMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cegPLn5Vd3KYExPYPWwmzEC9DLsyLxuhf4apwv7DAwE=;
	b=my2wfEc93HX+x12cIJqIFXXFu7+rMmkx+e27+zaKIT2N9jEMKPZqcNT3a+sqg1R9NuNAjq
	MPfMtCaKgQEBoCCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cegPLn5Vd3KYExPYPWwmzEC9DLsyLxuhf4apwv7DAwE=;
	b=uNVpHwQoEcQmFq1/wlWgsF7r8gInEsh/z/xQYNso/zAhD7+Huuz6fcdSKH9oVFEDEaSNcm
	gSINc87xUq/GMzqs891cor9o5OmTDAhDlQs+mlBka13g8Xg9Yit4vgwmo/c0a5oJGDaFkI
	cTCO6isz57Rljxo9hF9dXk3NeodMBBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cegPLn5Vd3KYExPYPWwmzEC9DLsyLxuhf4apwv7DAwE=;
	b=8fJ8Nv+BEYnEabEOJRMYb46gKmaMPH8VyvCMkwv+rYoI+dGda6Rzev/1tFE5AYMLkABBmo
	xLwWU8FUIFe5a0AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D509413419;
	Thu, 22 Feb 2024 15:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CDcXMa5k12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 3/3] sched/rt: Disallow writing invalid values to sched_rt_period_us
Date: Thu, 22 Feb 2024 16:13:28 +0100
Message-ID: <20240222151333.1364818-8-pvorel@suse.cz>
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
[ pvorel: rebased for 5.15, 5.10, 5.4 ]
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 5 +----
 kernel/sysctl.c   | 4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b05684202b20..5fc99dce5145 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2806,9 +2806,6 @@ static int sched_rt_global_constraints(void)
 
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -2839,7 +2836,7 @@ int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 928798f89ca1..4554e80c4272 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1821,6 +1821,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_rt_runtime_us",
@@ -1828,6 +1830,8 @@ static struct ctl_table kern_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
+		.extra1		= SYSCTL_NEG_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "sched_deadline_period_max_us",
-- 
2.35.3


