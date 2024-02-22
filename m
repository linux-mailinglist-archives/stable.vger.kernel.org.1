Return-Path: <stable+bounces-23376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6BE85FEAA
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D225F1F238F6
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80077153BEF;
	Thu, 22 Feb 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWnMivux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzhD1job";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mWnMivux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzhD1job"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE5153BC5
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621581; cv=none; b=NAJBMZwZ5gFg0TeGMMuYh5yvS09NX3PACk+kSAp6LmXSwe0OXIs7OqXiMd++M5a3zi/fGVjU8oJGfTTbC13DZTySs7mUmH8QaXkpJOGXreI8BpdqjdqconVIEZRRxwPpQ7HrRPifBB7guQIPt1nwhY6SNsHH+S2u0ZUzW1Lq+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621581; c=relaxed/simple;
	bh=Y/11QfPPmRXT2fDhjODagioAoOnYB0WN7Xyn6CEI7yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTNAWtjtTUJ3g79/gxElsIewAEowLbJDKVY49HQEFT3WoTNsCP8D7L+bjsURa3b1VIPQxjqPfJvOyTmBcSzQTrw5IsoXbIWCnNcNgAXFN4Nlkl5vOuCuE25vbLzTRbuEKBYHPyC6hCu54GwB1kr2xc9F+DLVVOj5uVogpE60ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWnMivux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzhD1job; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mWnMivux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzhD1job; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDBE3222AE;
	Thu, 22 Feb 2024 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1FagxONApRngwKyCzC+JjqudNSOZT1ZWTlukxF89xxg=;
	b=mWnMivux5W9DEBPQE7sXtizm78AWB/3id6o/rfEtIOjTWqLlHh+QRZ9LLSkOhofiKSYuUj
	GlyT4JF6M6F534/MRq1WKzQxWRzcY730BDXeMWrCv9VKgGjTJGO7s0B8b91ZqH0oQpbXJo
	MFgfslaLp6eX91vKXyyTNSDYBIPsuqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1FagxONApRngwKyCzC+JjqudNSOZT1ZWTlukxF89xxg=;
	b=UzhD1jobPbcHtwUxhtKPnBV04sDSetV0HaHWNUll85mUZZSZw5AnencTReANRTLRlw5xbB
	zoap6qLjuyTC01AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1FagxONApRngwKyCzC+JjqudNSOZT1ZWTlukxF89xxg=;
	b=mWnMivux5W9DEBPQE7sXtizm78AWB/3id6o/rfEtIOjTWqLlHh+QRZ9LLSkOhofiKSYuUj
	GlyT4JF6M6F534/MRq1WKzQxWRzcY730BDXeMWrCv9VKgGjTJGO7s0B8b91ZqH0oQpbXJo
	MFgfslaLp6eX91vKXyyTNSDYBIPsuqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1FagxONApRngwKyCzC+JjqudNSOZT1ZWTlukxF89xxg=;
	b=UzhD1jobPbcHtwUxhtKPnBV04sDSetV0HaHWNUll85mUZZSZw5AnencTReANRTLRlw5xbB
	zoap6qLjuyTC01AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 70BC313419;
	Thu, 22 Feb 2024 17:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QBBWFQh/12WXCAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 17:06:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 6.6 v2 1/1] sched/rt: Disallow writing invalid values to sched_rt_period_us
Date: Thu, 22 Feb 2024 18:06:11 +0100
Message-ID: <20240222170611.1376110-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mWnMivux;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UzhD1job
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
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
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.99
X-Rspamd-Queue-Id: DDBE3222AE
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
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 904dd8534597..4ac36eb4cdee 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -37,6 +37,8 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
+		.extra1         = SYSCTL_ONE,
+		.extra2         = SYSCTL_INT_MAX,
 	},
 	{
 		.procname       = "sched_rt_runtime_us",
@@ -44,6 +46,8 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
+		.extra1         = SYSCTL_NEG_ONE,
+		.extra2         = SYSCTL_INT_MAX,
 	},
 	{
 		.procname       = "sched_rr_timeslice_ms",
@@ -2989,9 +2993,6 @@ static int sched_rt_global_constraints(void)
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_validate(void)
 {
-	if (sysctl_sched_rt_period <= 0)
-		return -EINVAL;
-
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
 		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
 		 ((u64)sysctl_sched_rt_runtime *
@@ -3022,7 +3023,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (!ret && write) {
 		ret = sched_rt_global_validate();
-- 
2.35.3


