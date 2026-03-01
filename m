Return-Path: <stable+bounces-221489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JW4AGqYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:37:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDF1CB2C1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A47B831786A5
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E27284662;
	Sun,  1 Mar 2026 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6U/XRM1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A081F9F70
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328392; cv=none; b=LsoO8AQ03NP0lprMPDk9BO3KWEdgvoqjuJdiQPXdEaf8piFcXlkreSl4mPZCccnOS5oqIhbTMy5uVngGAaug7QY2YPS19NU0VaLqiJpLeUzd5VW5rWD7mewVQRmD0WiwkqKtPKC7t9mcjSIP4MCFXEiqNdkmtAIG4wDdCT0dXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328392; c=relaxed/simple;
	bh=n3TpooueMfRLxjtqOx3t/UWIQR+wKbX5Wj8YMYzqdic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I16cY4/ajYLOGeORnUWrDVQTGjj8DwDKeDpouvWoYqJv/tpd7fJbS1FHF4dIyOMkjNZRKt+M3FJxXtISgSuCrbAtUFPsqRp9xgjfAEHkI0OdMkvygt6w1fZhCNtnsVRUmfuE7XK6HL6KEuWWyj30Wfb/YdsYyyoCVABN057k3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6U/XRM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A2C19424;
	Sun,  1 Mar 2026 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328392;
	bh=n3TpooueMfRLxjtqOx3t/UWIQR+wKbX5Wj8YMYzqdic=;
	h=From:To:Cc:Subject:Date:From;
	b=P6U/XRM1s6VpLP9sa3vwjufwgECe8bToZwY+MzcOw6KWKKjo9PSrsbETaFVfw3hh7
	 pMpBDQgJaEU3lhWOgVR6XMdboXu9YNF7yYEVGk7H8N9WhhgGfjzh3I+bmOShmJwUGk
	 REcbDkAFitm4YbVvSa2w6aaweionK1tj/yUhhInQLJM37YGzhVnSK+RHJ3XqHt8RiE
	 IVC4UXYnbg7S1Dln/LX7ud7DA6/x52E1cwgKhf7JenWL+c8Jqsl3F7EIMIoPW/NWx2
	 xQod/DbVRJSULWS6R7+mPDu6yqkDOjGBCbuHcFsp6eZmo0DLua6Y6M/RGwwrS0u9tx
	 VBrMf2z5GkVxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hu.shengming@zte.com.cn
Cc: Petr Mladek <pmladek@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zhang Run <zhang.run@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: FAILED: Patch "watchdog/softlockup: fix sample ring index wrap in need_counting_irqs()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:29 -0500
Message-ID: <20260301012630.1683887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221489-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1FFDF1CB2C1
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cafe4074a7221dca2fa954dd1ab0cf99b6318e23 Mon Sep 17 00:00:00 2001
From: Shengming Hu <hu.shengming@zte.com.cn>
Date: Mon, 19 Jan 2026 21:59:05 +0800
Subject: [PATCH] watchdog/softlockup: fix sample ring index wrap in
 need_counting_irqs()

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
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b4d5fbdb933a2..7d675781bc917 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -550,7 +550,7 @@ static bool need_counting_irqs(void)
 	u8 util;
 	int tail = __this_cpu_read(cpustat_tail);
 
-	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
+	tail = (tail + NUM_SAMPLE_PERIODS - 1) % NUM_SAMPLE_PERIODS;
 	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
 	return util > HARDIRQ_PERCENT_THRESH;
 }
-- 
2.51.0





