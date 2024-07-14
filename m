Return-Path: <stable+bounces-59244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D08979309E7
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 14:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724251F21538
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E676BFCF;
	Sun, 14 Jul 2024 12:21:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100B2AD18;
	Sun, 14 Jul 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720959691; cv=none; b=Jwbf/dUwHFi1g5gcsyPQLKHVcvpA0AeBVDbEytHCP2ZmQ0HJ/yq99QqFGXx5wqfyTKPXV161IS/5JB4E17N6ldCD9aNPGxlP0MbtDox26iPA7Nznd0lSvF1RpY/ZrZC6bcWRSTVJWkB02Dso1MliSgvrvQ64y1njjd5V/0i/Qcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720959691; c=relaxed/simple;
	bh=YRHv5fsDJGyctfKksAdnR2UkCnhiBMAz5R3uCj7+QQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzbOgxDJN79lTLwKt42mVYDxnvYqXtvFcKJ+eHAiUa6+MSR8RGzH9aYAdsmvKSUNiQbdiEse3tK8BvWnc95vTVUy4lu7oGn0ZDfxDN2AbqG+AqJOwDKjhWTAPC55iREspSMkcAJUmvxMUE8KTPsf3en2BrWpWoFFS8UwbSKrrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABHaCUOwZNmidK1FQ--.9182S2;
	Sun, 14 Jul 2024 20:14:15 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: fbarrat@linux.ibm.com,
	ajd@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	imunsie@au1.ibm.com,
	manoj@linux.vnet.ibm.com,
	mpe@ellerman.id.au,
	clombard@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] cxl: Fix possible null pointer dereference in read_handle()
Date: Sun, 14 Jul 2024 20:14:04 +0800
Message-Id: <20240714121404.1385892-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHaCUOwZNmidK1FQ--.9182S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury7CF4DWFWDGFWDWFWxZwb_yoW8JFyfpr
	WxJryUCrWDJw4jya1DX3y8AFyY9as5KFWagFy8u34fZws8XF18X345ua40va4qy348tFyS
	qF4Dtan0gay8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In read_handle(), of_get_address() may return NULL which is later
dereferenced. Fix this by adding NULL check.

Based on our customized static analysis tool, extract vulnerability
features[1], then match similar vulnerability features in this function.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit
/?id=2d9adecc88ab678785b581ab021f039372c324cb

Cc: stable@vger.kernel.org
Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- fixed up the changelog text as suggestions.
Changes in v2:
- added an explanation of how the potential vulnerability was discovered,
but not meet the description specification requirements.
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


