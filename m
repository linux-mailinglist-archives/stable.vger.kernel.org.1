Return-Path: <stable+bounces-200967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90851CBBB24
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E04E30081BC
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F87923BCF3;
	Sun, 14 Dec 2025 13:18:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2921D5AA;
	Sun, 14 Dec 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765718317; cv=none; b=s5rJ5a3RXkvcP/ETO9B5+2PuxtIfw5TIEqhIQe3C+oCNp5fMqL0f+kyXgggzdOmMCIzoJVBRk7z8aJe9AMUsEMtYeAPj6Adb5xhq5hh9rTz2uvxrgFYUGk9kbiBzsJLdhxPeWQDOCb6UoS5NakoU41SB9AG+jFj+QLzECpcBMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765718317; c=relaxed/simple;
	bh=0KSS2/XqoFDX2oUCbBuixk7EDSB0XCO0zpCJSm55RAE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H7Z2xad4SofDZzCiQsKdDCfs4HfKB5hbpXdzcM7QHd0eAmU0w6iQnSGhxlLwmk1bCVCcHUyQl5fqzJZPbI9W4foWAtQC3Tc9Gn+DcZbOPQOIeY3kpSKPd7JlDZHErr8y64cDJCSINPBMwHd8CxoNkZI4jiceP1t4eVal0+/O4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAAH7OLxuD5p2lSzAA--.52152S2;
	Sun, 14 Dec 2025 21:17:39 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aloisio.almeida@openbossa.org,
	lauro.venancio@openbossa.org,
	sameo@linux.intel.com,
	linville@tuxdriver.com,
	johannes@sipsolutions.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] NFC: Fix error handling in nfc_genl_dump_targets
Date: Sun, 14 Dec 2025 21:17:26 +0800
Message-Id: <20251214131726.5353-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAAH7OLxuD5p2lSzAA--.52152S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4fuF4fWF4UXFWxZFyxKrg_yoWDKFX_Cw
	10vry8u3yYqan8KrW7tw47ZF1SyanrtrWxWrn7trZ2y3y5ZFZrWrs5XwsxAr17uws8CF1U
	A3Z5urWxu34UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	y8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbOVy7UUUUU=
	=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

nfc_genl_dump_targets() increments the device reference count via
nfc_get_device() but fails to decrement it properly. nfc_get_device()
calls class_find_device() which internally calls get_device() to
increment the reference count. No corresponding put_device() is made
to decrement the reference count.

Add proper reference count decrementing using nfc_put_device() when
the dump operation completes or encounters an error, ensuring balanced
reference counting.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 4d12b8b129f1 ("NFC: add nfc generic netlink interface")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 net/nfc/netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index a18e2c503da6..9ae138ee91dd 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -159,6 +159,11 @@ static int nfc_genl_dump_targets(struct sk_buff *skb,
 
 	cb->args[0] = i;
 
+	if (rc < 0 || i >= dev->n_targets) {
+		nfc_put_device(dev);
+		cb->args[1] = 0;
+	}
+
 	return skb->len;
 }
 
-- 
2.17.1


