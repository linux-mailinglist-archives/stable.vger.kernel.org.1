Return-Path: <stable+bounces-23368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED585FE9D
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A96F1C24E5F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B43154420;
	Thu, 22 Feb 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XWOapDO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8VzVyup";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XWOapDO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8VzVyup"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8F153BEF
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621557; cv=none; b=Tkn/Jgl51XUCSuWo0kloj0g5/pn/8ORIe6BDhrooswFlDL+1+57b0WCqG9tQXee1sccwhMY9iSvN7rCNH+u9oQuO6r/F7po5A+5/X1J+TT/XzPhIt8nP+KmFDVNw4U0imyM1yPsrAUn36PI5AZVmDxW/QV1k/YBao9UkESLIb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621557; c=relaxed/simple;
	bh=2OJOYTBcSvWBxwOwJB3nlno+sMpcq4Fox3eE42fj6mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyDtNcAakLHP6/Akida9SEtDP3O4BrWTh/n6Ug0TZ1gjOH1ZzDo0swXPzqFVfhFUprYQGhLSlDF4rJxwhuaFWVhy/CjlFcwJ9yM60KxEQuboYsj3jPFN9kZCIgjEiIwMR7NpghJ7f0uip+je2h+XM0jv63xNejV6LpxRL6o8a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XWOapDO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8VzVyup; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XWOapDO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8VzVyup; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EE68222AE;
	Thu, 22 Feb 2024 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8erHjgmfQb64xVqL7z168otiVT/OLGLVYQU73SumQo=;
	b=0XWOapDOpTK7vw2f+G0k8nYaDNn5jsLyz31aH+unefRrcy1cDjSJxYRYEMJQAAiYqMsRDP
	jl4Dx8qAXIjIPzxdNWKnk/b02uw6FAvzP0J/dLxDBzbY30psyf2Qo5VP0Q/xyXLmDXEtUD
	oh8fbopVWrk3bNaA66l3pG5e6K4Xk/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8erHjgmfQb64xVqL7z168otiVT/OLGLVYQU73SumQo=;
	b=G8VzVyupdFdLNzh5JXnNdI79U7o6zBpKOQpaD4ZjZX2IsExoTufTpsgZLFTkFG2VdOXG6E
	r3IG3oHOs7EFwaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8erHjgmfQb64xVqL7z168otiVT/OLGLVYQU73SumQo=;
	b=0XWOapDOpTK7vw2f+G0k8nYaDNn5jsLyz31aH+unefRrcy1cDjSJxYRYEMJQAAiYqMsRDP
	jl4Dx8qAXIjIPzxdNWKnk/b02uw6FAvzP0J/dLxDBzbY30psyf2Qo5VP0Q/xyXLmDXEtUD
	oh8fbopVWrk3bNaA66l3pG5e6K4Xk/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C8erHjgmfQb64xVqL7z168otiVT/OLGLVYQU73SumQo=;
	b=G8VzVyupdFdLNzh5JXnNdI79U7o6zBpKOQpaD4ZjZX2IsExoTufTpsgZLFTkFG2VdOXG6E
	r3IG3oHOs7EFwaCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E3113419;
	Thu, 22 Feb 2024 17:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aXC0KvB+12WGCAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 17:05:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH 5.15, 5.10 v2 1/3] sched/rt: Fix sysctl_sched_rr_timeslice intial value
Date: Thu, 22 Feb 2024 18:05:46 +0100
Message-ID: <20240222170548.1375992-1-pvorel@suse.cz>
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
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0XWOapDO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G8VzVyup
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[16.33%]
X-Spam-Score: 1.99
X-Rspamd-Queue-Id: 9EE68222AE
X-Spam-Flag: NO

From: Cyril Hrubis <chrubis@suse.cz>

[ Upstream commit c7fcb99877f9f542c918509b2801065adcaf46fa ]

There is a 10% rounding error in the intial value of the
sysctl_sched_rr_timeslice with CONFIG_HZ_300=y.

This was found with LTP test sched_rr_get_interval01:

sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90

What this test does is to compare the return value from the
sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
fails if they do not match.

The problem it found is the intial sysctl file value which was computed as:

static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;

which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
introduces 10% rounding error for CONFIG_HZ_300:

(MSEC_PER_SEC / HZ) * (100 * HZ / 1000)

(1000 / 300) * (100 * 300 / 1000)

3 * 30 = 90

This can be easily fixed by reversing the order of the multiplication
and division. After this fix we get:

(MSEC_PER_SEC * (100 * HZ / 1000)) / HZ

(1000 * (100 * 300 / 1000)) / 300

(1000 * 30) / 300 = 100

Fixes: 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Mel Gorman <mgorman@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>
Link: https://lore.kernel.org/r/20230802151906.25258-2-chrubis@suse.cz
[ pvorel: rebased for 5.15, 5.10 ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7045595aacac..3394b7f923a0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
-- 
2.35.3


