Return-Path: <stable+bounces-267641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0P9FNSQFOWoelgcAu9opvQ
	(envelope-from <stable+bounces-267641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:49:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFE6AE6BD
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:49:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=nIslxFQq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267641-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267641-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1E0330091E3
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD639D3FC;
	Mon, 22 Jun 2026 09:49:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB86359A68;
	Mon, 22 Jun 2026 09:49:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121747; cv=none; b=jomeuNjd72BrpdO8AzSNaI3PgL6xFntDBQJUpKqZYlY8OoypWmz8+LrH9eU+wU1np12DM+EN1Pq7isOuNyEhR3+1ZJxjLGEoZtssGeccXyccHj+UAjG3k343SpoZcwKzVYBE3aBBDy7ryQvM1GJRHf1SxS/mn/cn3DG2+JMcj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121747; c=relaxed/simple;
	bh=v2yU6hcM+2EF+mmVxEZQVzwfZuqUJ0ecIg15DVQPsJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=giAGomPRmivp78TQgItJvVGtDJxg0vq1udZ6xVcKoVFkxOMDdhZyf4lIuKHdwKNpXTENRrbzrdS8Sb75oB6nHhHU2poum66vjgHeBTpBrzMixlnHlGV5Hb18wIJevdlFKKZhNip1RmtBNMmkF3ujbOGivIJxqV3X0B+HqUOyPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nIslxFQq; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hg
	o7GNE0+Rw0VXOMMZ/9z8erhMb5Ms+UQdAUs2CdoQ0=; b=nIslxFQqID9ANDTwZl
	+Z2+b1vv32aM8YCRHJHwTSBaKalXIrWv4U9kvek/tEg9qw8q109BDNUIfVsKKRwO
	eypeEH/zrpJPjgkH6ZyAwR6b+pouofyUqF457YB52VAHxXxnTO7fBZk9hxMI501O
	ehgYtGlVOFKOdK6zrHH8UhO20=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3mfjmBDlqRw3vDA--.63960S2;
	Mon, 22 Jun 2026 17:48:24 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	emillbrandt@dekaresearch.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
Date: Mon, 22 Jun 2026 17:48:22 +0800
Message-Id: <20260622094822.926166-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3mfjmBDlqRw3vDA--.63960S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4fuF1kZrykCF4xJF4kXrb_yoWDGwb_Ww
	10gw48Wr95Ary7KF9xCrWFyr42gF17WFW3Ga1FqF43Gry5Ww4Fyry5ZrsxCFWv9r40ya47
	uws8ZFZxA343JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtBT5DUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxggkkmo5BOhRtAAA3i
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lgirdwood@gmail.com,m:broonie@kernel.org,m:perex@perex.cz,m:tiwai@suse.com,m:emillbrandt@dekaresearch.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,perex.cz,suse.com,dekaresearch.com];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267641-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5EFE6AE6BD

mpc5200_audio_dma_create() creates the DMA resources before registering
the component. If snd_soc_register_component() fails, the function
returns directly and leaves the DMA resources allocated.

Call mpc5200_audio_dma_destroy() before returning from this error path.

Fixes: f515b67381de ("ASoC: fsl: mpc5200 combine psc_dma platform data")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 9ad44eeed6ad..7831136f4f12 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -170,6 +170,7 @@ static int psc_i2s_of_probe(struct platform_device *op)
 					psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
 	if (rc != 0) {
 		pr_err("Failed to register DAI\n");
+		mpc5200_audio_dma_destroy(op);
 		return rc;
 	}
 
-- 
2.25.1


