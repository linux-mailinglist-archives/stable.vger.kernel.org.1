Return-Path: <stable+bounces-23374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787385FEA9
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C7B2744B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6601552E5;
	Thu, 22 Feb 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZ9G9Rpx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tOeaEK7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZ9G9Rpx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tOeaEK7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75515154BE3
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621574; cv=none; b=N8/ZG9g0OF5mzaqh4N/60dpjSssSNMvY3MZ/B5FT8mqNgoeihM7FskR/NyzGOxigaCnX19qJ25UJvlRtgPylgtaEvF0A2ZofIilHI0hveq48OyfiBry4CGx5xCeU0nsTLq/q+rlewWAoHXXHTYaSKoDpS8Pekz9lihc+geSfd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621574; c=relaxed/simple;
	bh=zyRyhni8RsiWmp28yTXDU/EbrbQzf4ZjP505+R7cCAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFKYaexj6tbR0KR0FDLSCK4nQNO2YdrZbswoOlhROH2lhn3sNfXF64EWTf8WlUUp40AVSwMmIG3Q8BwggL2zBOEDtfS2l0+nquUmg16US/htzoQEqKTXSd0BYFl07cI8RQ04kcCjZqW3N8N8KKI3cupcUSu/DlJ1AWNWVQTpic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZ9G9Rpx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tOeaEK7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZ9G9Rpx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tOeaEK7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB3B422362;
	Thu, 22 Feb 2024 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nXfWDnSSb02C8/70rEMnnPQQ2ndZZnTAbJOsCQ/Zuo0=;
	b=LZ9G9Rpxl0SECeRNjnH1A+DEAoHVsKAa1RdCdVRldNZjLJLDG+MVkgt5kH+ogPGlhV6PBG
	5853OLjOSZ8r3AzGjD3Jid4/5sOjQWVsplsFqSWckvueXes8cHmUHvQBiSBqCxjEQ1S3RM
	wG8nYZnjZxC0iiVF/zOfPUZevSUgVsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nXfWDnSSb02C8/70rEMnnPQQ2ndZZnTAbJOsCQ/Zuo0=;
	b=+tOeaEK7zs5oZnR/ggTY5pGnzvUSbCfhr2iZ7Fc5EUba18vg1b1gG6u9oycsQ44j1qsuG8
	V1v/SQSepAjTueBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nXfWDnSSb02C8/70rEMnnPQQ2ndZZnTAbJOsCQ/Zuo0=;
	b=LZ9G9Rpxl0SECeRNjnH1A+DEAoHVsKAa1RdCdVRldNZjLJLDG+MVkgt5kH+ogPGlhV6PBG
	5853OLjOSZ8r3AzGjD3Jid4/5sOjQWVsplsFqSWckvueXes8cHmUHvQBiSBqCxjEQ1S3RM
	wG8nYZnjZxC0iiVF/zOfPUZevSUgVsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nXfWDnSSb02C8/70rEMnnPQQ2ndZZnTAbJOsCQ/Zuo0=;
	b=+tOeaEK7zs5oZnR/ggTY5pGnzvUSbCfhr2iZ7Fc5EUba18vg1b1gG6u9oycsQ44j1qsuG8
	V1v/SQSepAjTueBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AF43213419;
	Thu, 22 Feb 2024 17:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dr0hKQF/12WSCAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 17:06:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH 6.1 v2 1/2] sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
Date: Thu, 22 Feb 2024 18:06:00 +0100
Message-ID: <20240222170601.1376084-1-pvorel@suse.cz>
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
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LZ9G9Rpx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+tOeaEK7
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
	 BAYES_HAM(-0.00)[19.12%]
X-Spam-Score: 1.99
X-Rspamd-Queue-Id: AB3B422362
X-Spam-Flag: NO

From: Cyril Hrubis <chrubis@suse.cz>

[ Upstream commit c1fc6484e1fb7cc2481d169bfef129a1b0676abe ]

The sched_rr_timeslice can be reset to default by writing value that is
<= 0. However after reading from this file we always got the last value
written, which is not useful at all.

$ echo -1 > /proc/sys/kernel/sched_rr_timeslice_ms
$ cat /proc/sys/kernel/sched_rr_timeslice_ms
-1

Fix this by setting the variable that holds the sysctl file value to the
jiffies_to_msecs(RR_TIMESLICE) in case that <= 0 value was written.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Mel Gorman <mgorman@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>
Link: https://lore.kernel.org/r/20230802151906.25258-3-chrubis@suse.cz
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 kernel/sched/rt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 76bafa8d331a..f79a6f36777a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -3047,6 +3047,9 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		sched_rr_timeslice =
 			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
 			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+
+		if (sysctl_sched_rr_timeslice <= 0)
+			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
 	}
 	mutex_unlock(&mutex);
 
-- 
2.35.3


