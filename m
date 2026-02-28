Return-Path: <stable+bounces-220841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAW6CZBGo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9591C7605
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12A0B32416BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D74182D1;
	Sat, 28 Feb 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh/jtuh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878954182DB;
	Sat, 28 Feb 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300728; cv=none; b=mffpy8hiSBLc+bKwRyTE0wmPNJqJ9+rdzcfKzZH8aC5BM59+yuOPFm1HsR0fkkGWj6f5muXFOLpN/pRjy1HAfUn6RA0u+yuR7eg1pcCmimJGKqVEAQ4u82v2cRT2O8oWZdujNvS6Crp94CCivVnJFIGxIilrQcnslNhBGdr+pEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300728; c=relaxed/simple;
	bh=r1CH4diocVV5/6lId/JsDHVBZyZjEV5vcT3Jy3BE2Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsajJcTYOf/Ir+WJtBJZw6cLVwSYWmCfZhkzdPR0HEEen5PBeQ9aUVSnfHJ6Sio3hGZl3LynlAvcK/SxgKzwKTiGE3Md8XTUP0i8bMmvZmWf0oFXYz6ukkOIXGATG2V20BgCOWVtBmlNDky3616QPuAR7vci+GkEJbW6iO84148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh/jtuh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5598FC116D0;
	Sat, 28 Feb 2026 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300728;
	bh=r1CH4diocVV5/6lId/JsDHVBZyZjEV5vcT3Jy3BE2Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nh/jtuh3S0Fhn15I2BkHviS0Ukirg7MkTuEYlKjjLL9Eznx39qZDGQFYewHfea227
	 j2mgUe8U8UIzjffXum4ew9i2FDl1nQHaCjYT+53GXGCYpV6f9ZOcpzxoje0ZRhg+fP
	 Q1t7y3vqWgdL2RTVNzU6xq3Vo3wRt2d9TGEnDKYS/vVUqCYvO4b7FR1m2hHw0J23JJ
	 3VKFrf7U1kif6Ujg4g15be6Qi7dfo/D+3u8nYpxA4WuKaXQhYPIsXyxRhTwa+qITeP
	 pNfi833n3AGh7t6vKzbKu3WZYUOb+sBTUrEoFf07qbOOVPYfR+hGnokEByDhA5mgf3
	 NMIOnINMDPwkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengming Hu <hu.shengming@zte.com.cn>,
	Petr Mladek <pmladek@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zhang Run <zhang.run@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 762/844] watchdog/softlockup: fix sample ring index wrap in need_counting_irqs()
Date: Sat, 28 Feb 2026 12:31:15 -0500
Message-ID: <20260228173244.1509663-763-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220841-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:email,linux-foundation.org:email,zte.com.cn:email]
X-Rspamd-Queue-Id: BA9591C7605
X-Rspamd-Action: no action

From: Shengming Hu <hu.shengming@zte.com.cn>

[ Upstream commit cafe4074a7221dca2fa954dd1ab0cf99b6318e23 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 366122f4a0f87..70eaa77242814 100644
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


