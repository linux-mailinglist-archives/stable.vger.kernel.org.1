Return-Path: <stable+bounces-268993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3OLKVCePmrCJAkAu9opvQ
	(envelope-from <stable+bounces-268993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:44:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E983F6CE9C1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:44:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268993-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268993-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7135A30063B2
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428137FF4E;
	Fri, 26 Jun 2026 15:39:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803653769E6;
	Fri, 26 Jun 2026 15:39:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488365; cv=none; b=rxWjtC7VHaxaozCxOtB28CNXj3mV2w7s+ScaGgFP8wYC3BDFDLb1zSipdgUH/gj4ZwGzQKx3p9EUtmZ1tg2UUG7KDnQiXQc0R3g0lPz8/7NzOpRKjPfqrvj6zewy/U8taYqY05Srh4r5F8m1AfqVvNOmzaZnw3f7gwJOV1hzYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488365; c=relaxed/simple;
	bh=El+twBrZ/dZwnHSN051E5CvTtV2aQ/sFwCxniafycDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMOsNfGfN29MAxjOgfSQIj1Bg1lYodAYEAtN+Joszajm8dsnyeWPFfAvw/EkUfslF/81fsRynoldAmUFY1BX8+ddXtN3hM8UbiNzn6yFpo0UlV+jiRd7WCd4DPBowT+sOp8oRZuQqDXcdv1EzKs/zkyg4rHdfro6p1qstFew65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACXOtMlnT5qpZVsAw--.54216S2;
	Fri, 26 Jun 2026 23:39:18 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	linux-ntb@googlegroups.com
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: ntb: perf_copy_chunk: fix tx descriptor and unmap kref leak on   dmaengine_submit failure
Date: Fri, 26 Jun 2026 23:39:17 +0800
Message-Id: <20260626153917.53128-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXOtMlnT5qpZVsAw--.54216S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWUCryUCr1xtry7urWktFb_yoWkurX_KF
	y2gwnxGr4DCFWUK34xtr43ArWakF9rWF929rZ7Ka4fC343WF43JFW8urZ8JFnrur4UJFy7
	Gw1jyF4Fvw17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU11SoJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQKA2o+iCg4HAADsH
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jdmason@kudzu.us,m:dave.jiang@intel.com,m:allenbh@gmail.com,m:linux-ntb@googlegroups.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268993-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E983F6CE9C1

When dmaengine_submit fails after dma_set_unmap has been called, the
  unmap object has two references (one from dmaengine_get_unmap_data and
  one from dma_set_unmap held by the tx descriptor). The error path
  err_free_resource only calls dmaengine_unmap_put once, leaving the tx
  descriptor's reference and the descriptor itself leaked.

Add dmaengine_desc_put(tx) in the err_free_resource path to properly
  release the tx descriptor and its held unmap reference.

Cc: stable@vger.kernel.org
Fixes: 282a2feeb9bf ("NTB: Use DMA Engine to Transmit and Receive")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/ntb/test/ntb_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f..64783bfa5a2c 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -851,6 +851,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
 
 err_free_resource:
+	dmaengine_desc_put(tx);
 	dmaengine_unmap_put(unmap);
 
 	return ret;
-- 
2.39.5 (Apple Git-154)


