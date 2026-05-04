Return-Path: <stable+bounces-243014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKTyL0iT+GmwwgIAu9opvQ
	(envelope-from <stable+bounces-243014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:38:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D394BCFB1
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2A2301BC3C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E3A3D3483;
	Mon,  4 May 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQvvPU/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0A3D3308
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898260; cv=none; b=Lki7BQ/ySgMSW06/Fp8Q6y2M/5MlDvcVvb6nUiqNdoV3tI4UCBMZzET444xPTJshJTxcZFz6v3chmwbmSsB2OgldlmihJRGB+1vgchE0MzWLMvmZoX97IDIteKO3SGnSY3laNweMeUh+7n7MH1jMLhmtBDCAcLBashUEYf68p90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898260; c=relaxed/simple;
	bh=vVxMTNbdl9T5NctGJaMql6ss0kYr3Kxez8RgaaEn4a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VilSnK02rWnAhttkiGw073ZNmS9wESM2ZBk16oZ6O3YYYbjk5TOsX1uA+3iqL0bX+/bDzm5WyzDM1sKpvb+hSjSJbHb2zzzfaLgusGo27ZtpvXZUD4FRh0iU7b5iQdbu7jkhttSKDS9chpzouwVgOEFrHkWZukEwurBJQo8VznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQvvPU/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5923C2BCB8;
	Mon,  4 May 2026 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777898260;
	bh=vVxMTNbdl9T5NctGJaMql6ss0kYr3Kxez8RgaaEn4a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQvvPU/mJvgtGeIgicSKY7G4vFUuKW1MaaSur4s1/xcYtSTTMOMJaMIlX4wmwP1ZL
	 YudZey3eYp59FxPW2+YouP7X2lCIIICO37Zuzph6alq7Qjm2vdg+1tAzLvNHO6YlNm
	 sTzqDtPaidIv9x6AguS9shcttElSSGVeJbu2V2tg4n5WHtfiCbTqwCMX4tqCp0BNEk
	 8TmJ3ID3rSynHlXtzh9AiENOyvkzbGmS3FRlxhW/ZMcC5U37Tc2sYeHs2ZzRQA+taZ
	 Jy0N83Sg5syjQq92veIy6FcnbJaGD7/hSRd9sGi9Zhg8fMBJDKyeBRlO9uwpikekdr
	 IS/+GYz3bdc1Q==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.com,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/core: use time_in_range_open() for damos quota window start
Date: Mon,  4 May 2026 05:37:29 -0700
Message-ID: <20260504123729.8409-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050344-stinging-carnivore-0639@gregkh>
References: <2026050344-stinging-carnivore-0639@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29D394BCFB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243014-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]

damos_adjust_quota() uses time_after_eq() to show if it is time to start a
new quota charge window, comparing the current jiffies and the scheduled
next charge window start time.  If it is, the next charge window start
time is updated and the new charge window starts.

The time check and next window start time update is skipped while the
scheme is deactivated by the watermarks.  Let's suppose the deactivation
is kept more than LONG_MAX jiffies (assuming CONFIG_HZ of 250, more than
99 days in 32 bit systems and more than one billion years in 64 bit
systems), resulting in having the jiffies larger than the next charge
window start time + LONG_MAX.  Then, the time_after_eq() call can return
false until another LONG_MAX jiffies are passed.

This means the scheme can continue working after being reactivated by the
watermarks.  But, soon, the quota will be exceeded and the scheme will
again effectively stop working until the next charge window starts.
Because the current charge window is extended to up to LONG_MAX jiffies,
however, it will look like it stopped unexpectedly and indefinitely, from
the user's perspective.

Fix this by using !time_in_range_open() instead.

The issue was discovered [1] by sashiko.

Link: https://lore.kernel.org/20260329152306.45796-1-sj@kernel.org
Link: https://lore.kernel.org/20260324040722.57944-1-sj@kernel.org [1]
Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 049a57421dd67a28c45ae7e92c36df758033e5fa)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab5c351b276c..01da6b09ee62 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -826,7 +826,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			continue;
 
 		/* New charge window starts */
-		if (time_after_eq(jiffies, quota->charged_from +
+		if (!time_in_range_open(jiffies, quota->charged_from,
+					quota->charged_from +
 					msecs_to_jiffies(
 						quota->reset_interval))) {
 			if (quota->esz && quota->charged_sz >= quota->esz)
-- 
2.47.3


