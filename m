Return-Path: <stable+bounces-58748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4892BAD3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B0B287ADC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C18158D92;
	Tue,  9 Jul 2024 13:18:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AC382;
	Tue,  9 Jul 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531110; cv=none; b=QkNGfolJGrunn7hf7XaRUYXorZBGhuGKDylAvGZ7Xnm5Ors1SAoVlVH+ZO86zb5Yk4AfEW66FVaWV4lmTuixPaoOe0ULWsZqG1efU1IyKssYAlXOojrwhxVH04kAekBO0P3vTi5/BoshrByOShCf3ftm3R7cK33H+FKchWwq2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531110; c=relaxed/simple;
	bh=uRqSv2EgEs82nXjT4mnoIzvAPWG9RwZrzwafVBscE1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAkNfFRqtuVw5iU/uQ4/ASl6Lem9U2be2K+Yr4B492djNSlWXE6do7vLQD0/mQPKIofiJLSBqPGQ8z9HmT1i8FGzRKGi6Pk8k7achvCgwvcqsHJrWRdWdA4WLUeyvSogDKcMYD24setPAhuSJHkka7XFZjtGy3Xmk9Bnybcrtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHz+eEOI1m3nhgAg--.39722S2;
	Tue, 09 Jul 2024 21:18:05 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: fbarrat@linux.ibm.com,
	ajd@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	manoj@linux.vnet.ibm.com,
	mpe@ellerman.id.au,
	clombard@linux.vnet.ibm.com,
	imunsie@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cxl: Fix possible null pointer dereference in read_handle()
Date: Tue,  9 Jul 2024 21:17:54 +0800
Message-Id: <20240709131754.855144-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHz+eEOI1m3nhgAg--.39722S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWDGrWDAw4xAr4UWry8Krg_yoW3Awc_CF
	4UZr1xXryjgr9rGr1Y9r47Zr92yrW8uF95Zr4ftFW7K3y5CF1aqr1I9rs3ZrnrWr4DXFyD
	Aw1qy3sY9r42gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In read_handle() of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Cc: stable@vger.kernel.org
Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/misc/cxl/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index bcc005dff1c0..d8dbb3723951 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
 
 	/* Get address and size of the node */
 	prop = of_get_address(np, 0, &size, NULL);
-	if (size)
+	if (!prop || size)
 		return -EINVAL;
 
 	/* Helper to read a big number; size is in cells (not bytes) */
-- 
2.25.1


