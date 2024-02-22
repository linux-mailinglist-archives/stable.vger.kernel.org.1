Return-Path: <stable+bounces-23344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EBE85FC0B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC10B263C9
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122A14C5B5;
	Thu, 22 Feb 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BHhHK9Xo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJGL7fGc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BHhHK9Xo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJGL7fGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6214A0BE
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614834; cv=none; b=U8ahj2wCfBODPn5hITbgn6hKZousDJl9hhFvaFrv+r7G8Rd/OJXokceMUVPjKrBLQBoUYtR5zEWANVz3GTu7FrRcyvXTkBCeJNj4y0hqmWuixRqU7DsfaS8V58sio4Fv92pe8zc6l5KSJGK9HdgfgBKq+0DhgWZijTuj9xp9Qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614834; c=relaxed/simple;
	bh=bLCAwnxOq08tcN9ftQvDuD1+/rVNBM156oM6ZAYM8oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaPoAHJ8jFoodgbHatISZplnF+NAg63PDU2vt21IXT0QFgMMWAXQuyBjqtSF9AB5lF3cYkfTe1h54rqCsZb2BKVt6L61eQ/R3a9nPdXI5LVOhg5jG9vTi5jj+KU00r4695ub/zOp8VimnvV4BMc7yF/179eSP0aqaSPrTpBEPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BHhHK9Xo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJGL7fGc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BHhHK9Xo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJGL7fGc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C59AE21F71;
	Thu, 22 Feb 2024 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCo3mvCy8IoilP/e4+Rlk2BeZ2tMqJEP/jbjzplv49c=;
	b=BHhHK9Xodxpr5bFW+8htdSFKeEBsUlMHKvxLgNc94khcUW4ZmoHafTET59UbKhKgBi3Mm0
	pH+hVPtmxstRsFigQGTRIF3i2amzThfqbB3M99ZA+n4AbSXNkclQgrTMX5X9YnD8fq2y0O
	KjtyCdtMUFwMOSXz/VHaEXCMqoIVrTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCo3mvCy8IoilP/e4+Rlk2BeZ2tMqJEP/jbjzplv49c=;
	b=dJGL7fGcb7gNPLPMJE0Pb0UARs8amVRAL8TEF2OsgUoBbBL6xlKMGMQgsxXvnRQCEOAZgx
	/XLkHqplARGXHtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCo3mvCy8IoilP/e4+Rlk2BeZ2tMqJEP/jbjzplv49c=;
	b=BHhHK9Xodxpr5bFW+8htdSFKeEBsUlMHKvxLgNc94khcUW4ZmoHafTET59UbKhKgBi3Mm0
	pH+hVPtmxstRsFigQGTRIF3i2amzThfqbB3M99ZA+n4AbSXNkclQgrTMX5X9YnD8fq2y0O
	KjtyCdtMUFwMOSXz/VHaEXCMqoIVrTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCo3mvCy8IoilP/e4+Rlk2BeZ2tMqJEP/jbjzplv49c=;
	b=dJGL7fGcb7gNPLPMJE0Pb0UARs8amVRAL8TEF2OsgUoBbBL6xlKMGMQgsxXvnRQCEOAZgx
	/XLkHqplARGXHtCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 64A2213A71;
	Thu, 22 Feb 2024 15:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ML/DFa1k12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH 2/3] sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
Date: Thu, 22 Feb 2024 16:13:27 +0100
Message-ID: <20240222151333.1364818-7-pvorel@suse.cz>
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,infradead.org:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[30.31%]
X-Spam-Level: ****
X-Spam-Score: 4.90
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
index 3394b7f923a0..b05684202b20 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2883,6 +2883,9 @@ int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
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


