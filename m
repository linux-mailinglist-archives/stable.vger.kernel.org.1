Return-Path: <stable+bounces-254528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHHMA77EFmrOqgcAu9opvQ
	(envelope-from <stable+bounces-254528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:17:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454D5E27DD
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3C4300BDA4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935E3E4C9D;
	Wed, 27 May 2026 10:10:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12A280318;
	Wed, 27 May 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876617; cv=none; b=HFr+wn8sFaTuJJw3AB7CXI6ImCUEkZW2UY+Z6kcJbPAg1p6veDePsopqe2rCXpkqxAj2Izsm740qdcUreP56UpKUU6pD/elbp4S9ePZHZsrHmzQ3m5EcaFumazc1Wvo5aRAYdt8rXV1ZRDXL3zswku07Bky/XLin4bN+baDInZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876617; c=relaxed/simple;
	bh=lFDe5C0ViBHCtU63G+Iu4849aG/k7gBGP5dWgk11pLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZxOv2pvJaN3x0J/yxa6I9Ob7FU/xQqFbi5nGkb2xRYnTd5X3ieMWFV3BcnhxjVyCEpEa6FUGaL0PHgPCzBDi3GHp2HF7j40zWvjs4zEyzX+0fMImwXRWRMxZ94m2A+GPV41Oe6b4ARg4CBUhRDdnTnEt2ewydOWRUU7owE1Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.3])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt7twhZqvXSLEQ--.67S2;
	Wed, 27 May 2026 18:09:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Kees Cook <kees@kernel.org>,
	Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: fix IO refcount leak in efct_hw_io_abort()
Date: Wed, 27 May 2026 10:09:35 +0000
Message-Id: <20260527100935.868042-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt7twhZqvXSLEQ--.67S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWfCF48ZrWrGFyUXr1kKrg_yoWkAFc_C3
	WSqrn3u34rKF48Kr1xGrZrZrsIkF4DW340qF4FgFySgF48trWDAr1UurZ3JrW2yw4vyF95
	Aw18JF4UCw13XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAAA2oWibzwXwAAs8
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254528-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5454D5E27DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

efct_hw_io_abort() calls efct_hw_io_alloc() which initializes the IO
reference counter to 1. On the error path where the abort operation
fails after IO allocation, the function returns without calling
kref_put() to release the IO reference, leaking the refcount.

Add kref_put() on the error path to properly release the reference.

Fixes: 63de51327a64 ("scsi: elx: efct: Hardware I/O and SGL initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/scsi/elx/efct/efct_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index 1838032f6486..4ecd6f4165f4 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -1997,6 +1997,7 @@ efct_hw_io_abort(struct efct_hw *hw, struct efct_hw_io *io_to_abort,
 	wqcb = efct_hw_reqtag_alloc(hw, efct_hw_wq_process_abort, io_to_abort);
 	if (!wqcb) {
 		efc_log_err(hw->os, "can't allocate request tag\n");
+		kref_put(&io_to_abort->ref, io_to_abort->release);
 		return -ENOSPC;
 	}
 
-- 
2.34.1


