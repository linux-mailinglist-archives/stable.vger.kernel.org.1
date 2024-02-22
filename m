Return-Path: <stable+bounces-23366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05685FE9A
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66E92875A1
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3481E488;
	Thu, 22 Feb 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MyuK5VGk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pwNl+SW4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MyuK5VGk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pwNl+SW4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D915443A
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621551; cv=none; b=a5zd1MJ7ebyXuYtr/CtZLPjfb8hbA31LbX26SxorQJNwcqD6kpDA86m3/tHohVR+EASLGLBc93rYlHQp6o55Fy8sL+hAlms+CvmQFlg1ETkuJZm6rQnkA/zaxWDpBs2IHKsd2NpJWHHeKOGu6O4hxKr0w1LDGDrEyrl6i00Xhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621551; c=relaxed/simple;
	bh=+X7m6y31U7ZDbuigQgTqKsWgprk15a67GyhErQgh1us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZjnXtaQlmyz5jdVj3Nc4LYFpnuzduw+EKhKd5gRyCKimfoE31q5FXQ9DD9gCOTgXfqnO4Q/yK7Qpl5vd7K/KSpCHWECvfJjH6Les/u3sreLi7/9Pj6J7T6xctQb0H7jZyVPcol519sarpTtvHzzwhgAlbSvqSLDT4VsZFGiOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MyuK5VGk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pwNl+SW4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MyuK5VGk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pwNl+SW4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48EFF1FBA2;
	Thu, 22 Feb 2024 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuwU+ucleCSxQcTxFZN6uI4RToW/X+dkOPJ0fxFpi2g=;
	b=MyuK5VGkIPSKwGVGERL7zYVyfdXRvqT+mtmtnr00F+WjvwklP1wFft6zrss/6iGsrZIZa2
	y4iPh18fb9jGJn56ispgmeP9oF4ki8NJal8MJ5cFX0RztXQItvLpv7rE4E1k2mQGDha7YT
	LwD9KTIEcRUVUiVM4mnWzs/QtPZj+vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuwU+ucleCSxQcTxFZN6uI4RToW/X+dkOPJ0fxFpi2g=;
	b=pwNl+SW4Coq4Lj2vrX5ElN+oxiOAnWUTab75DhT+5M05tdiDn/6idoci2mp0Nnio3bTSK0
	k+xKN/3hhpH7TmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708621548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuwU+ucleCSxQcTxFZN6uI4RToW/X+dkOPJ0fxFpi2g=;
	b=MyuK5VGkIPSKwGVGERL7zYVyfdXRvqT+mtmtnr00F+WjvwklP1wFft6zrss/6iGsrZIZa2
	y4iPh18fb9jGJn56ispgmeP9oF4ki8NJal8MJ5cFX0RztXQItvLpv7rE4E1k2mQGDha7YT
	LwD9KTIEcRUVUiVM4mnWzs/QtPZj+vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708621548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuwU+ucleCSxQcTxFZN6uI4RToW/X+dkOPJ0fxFpi2g=;
	b=pwNl+SW4Coq4Lj2vrX5ElN+oxiOAnWUTab75DhT+5M05tdiDn/6idoci2mp0Nnio3bTSK0
	k+xKN/3hhpH7TmCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AACAA13A71;
	Thu, 22 Feb 2024 17:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IFv/Jet+12V+CAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 17:05:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Vorel <pvorel@suse.cz>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH 4.19 v2 2/3] sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
Date: Thu, 22 Feb 2024 18:05:39 +0100
Message-ID: <20240222170540.1375962-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222170540.1375962-1-pvorel@suse.cz>
References: <20240222170540.1375962-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[30.84%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

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
index ce4594215728..2ea4da8c5f3a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2735,6 +2735,9 @@ int sched_rr_handler(struct ctl_table *table, int write,
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


