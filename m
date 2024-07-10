Return-Path: <stable+bounces-58989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68092CF59
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC66F1C22023
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DCA19006D;
	Wed, 10 Jul 2024 10:34:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F600190067;
	Wed, 10 Jul 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607677; cv=none; b=UtRMxsfija5MmxT5M2ThJsOKAgEjpMp4IXsEwHbaSwMPR5kEoESOK68Itf1MbGvkxGlfIv93S7YMpyanpnBHK9Zqx38LkscRbRoOMMXF2S+Sklx+R0Q1euAb3ctz+mnfpwJWj+I4jweKnd5XKejlmmsxf8JTTsfirG4x9uVBRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607677; c=relaxed/simple;
	bh=5iVCEpSHOTR5t3oDkyI7Mh4X2c3tYcpmu3Xe7ap1nCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZvU8Dmn5PnNXIYMx7io4ptzHV9a0mNt2MP0MsrJr4LMcHjL3xAeLbls05RHlmxThrLF7z+YBkjjPFfRWTDQj1e1FwaAKhUWTQ/RPyPUt/q7QQvMAAFVsjd34RGNvKGTZEmSnZm68aWu+IFGFzDctLERhZNSVFMfNHT8KBfai2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAD3_7eRY45mBMyMAg--.50608S2;
	Wed, 10 Jul 2024 18:34:03 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: fbarrat@linux.ibm.com,
	ajd@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	clombard@linux.vnet.ibm.com,
	imunsie@au1.ibm.com,
	mpe@ellerman.id.au,
	manoj@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] cxl: Fix possible null pointer dereference in read_handle()
Date: Wed, 10 Jul 2024 18:33:52 +0800
Message-Id: <20240710103352.1890726-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_7eRY45mBMyMAg--.50608S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWDGF18Kr1DAFy5Zw47Arb_yoWkurc_uF
	47Xr1xW34jgr12kw1Y9r43Zrnav3ykuF95Zr4Sqay3K345AF1Yqr1SvrZYvwnrXr45ZFWD
	Cw1qg3sa9w12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
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

In read_handle(), of_get_address() may return NULL which is later
dereferenced. Fix this by adding NULL check.

Cc: stable@vger.kernel.org
Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- The potential vulnerability was discovered as follows: based on our 
customized static analysis tool, extract vulnerability features[1], and 
then match similar vulnerability features in this function.
- Reference link:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=2d9adecc88ab678785b581ab021f039372c324cb
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


