Return-Path: <stable+bounces-195448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E45C7700F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0C5372FABC
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77E25785E;
	Fri, 21 Nov 2025 02:28:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C9157A5A;
	Fri, 21 Nov 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692098; cv=none; b=KxCHjXqyN+LwxbN6sm/pQ7jqFIM9w3eoK8SAzKra9ubiejX5Wn07qQBi8jHlEDXTkPxNZA4JPK3Bi3YA43p+lTGTuFnlQBVTnUMGkObX8Z+eSGVRyCJCcI3KqWKrfCn25hmrkAnLFi5ESExWokZGpMP/Z27X/FgE2cNOmlhjbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692098; c=relaxed/simple;
	bh=0KSS2/XqoFDX2oUCbBuixk7EDSB0XCO0zpCJSm55RAE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FTUmHdty2LT7Scn7i2KWJJpViQ+bwv8phqh774wcy/zgR4y7Go6QYoS4ZrUHaQRDc35eg0hd1JKuxAZQpJxk/WGltXf1/DlWNaRkXOdqOUR7we0Bh2ZxFX8rRXQYf0CmXpBH50wpKVrXBfFNgGeo07h7vL2VnyFQDAy6ywbpKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowACHD9IRzh9pG958AQ--.11258S2;
	Fri, 21 Nov 2025 10:27:35 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linville@tuxdriver.com,
	aloisio.almeida@openbossa.org,
	johannes@sipsolutions.net,
	lauro.venancio@openbossa.org,
	sameo@linux.intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] NFC: Fix error handling in nfc_genl_dump_targets
Date: Fri, 21 Nov 2025 10:27:28 +0800
Message-Id: <20251121022728.3661-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowACHD9IRzh9pG958AQ--.11258S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4fuF4fWF4UXFWxZFyxKrg_yoWDKFX_Cw
	10vry8u3yYqan8KrW7tw47ZF1SyanrtrWxWrn7trZ2y3y5ZFZrWrs5XwsxAr17uws8CF1U
	A3Z5urWxu34UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwV
	AFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmLvtU
	UUUU=
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


