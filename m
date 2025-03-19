Return-Path: <stable+bounces-124912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C8A68B62
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C9F4254B3
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52A25486D;
	Wed, 19 Mar 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="sXhWKfUy"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E225179F;
	Wed, 19 Mar 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382996; cv=none; b=Wiv0zEh51lqcUbq38r780XZ+m0kk/o8LQvAKvlGJgLRBV9W77AphpfQLMESp5TANJI7rA3jYyC9Tmq1U6wVubzGXuFrNjQIyUC9oklODkpXr+xRxSJoSnPvmjQAfAI/KXn6X/4oo/7kccjBud3NQEQblMFsWuKytHQtTv+CZePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382996; c=relaxed/simple;
	bh=gpbvjdms4Rrry5x3aYgBkWxK8NldF01k+Ac5eSpURJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcxrX4xucvB5RUnHSrzmzr1WiGR/4sHZ2C+emrqqP5kZhbTjkiYtnnAYmxqEtc3PB3FWLWgXnDs0Nx+FlvVYL3vG9OawVzBZX6+SXqnSUzEDPMKhJODWQ1fMZ7xVs7iiaFT7b+lJV3pi6LEzdIWJnG50B2V24diUnv73Vcf/YQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=sXhWKfUy; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742382982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fxGghcda7/TGIIY3lDBoKyvwQc1Uh2+ER/W7JsyZyok=;
	b=sXhWKfUySwCy73is8UVrucnMK194LvsAqaXhYFzS843cxDeTna6bqxizrj6cvOhkEL9/tf
	A3G85sN0j9/sI8W4zlugN5tQuj/onJ+y8Dzg6/eosLnVfFSGngrfquL9lHhf4dMZBVs6tv
	2ONBzx7pCr4LgZ17fXcykPnU2oBavVs=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH 6.1] ubi: Add a check for ubi_num
Date: Wed, 19 Mar 2025 14:16:20 +0300
Message-ID: <20250319111622.34057-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Arefev <arefev@swemel.ru>

commit 97bbf9e312c3fbaf0baa56120238825d2eb23b8a upstream.  

Added a check for ubi_num for negative numbers
If the variable ubi_num takes negative values then we get:

qemu-system-arm ... -append "ubi.mtd=0,0,0,-22222345" ...
[    0.745065]  ubi_attach_mtd_dev from ubi_init+0x178/0x218
[    0.745230]  ubi_init from do_one_initcall+0x70/0x1ac
[    0.745344]  do_one_initcall from kernel_init_freeable+0x198/0x224
[    0.745474]  kernel_init_freeable from kernel_init+0x18/0x134
[    0.745600]  kernel_init from ret_from_fork+0x14/0x28
[    0.745727] Exception stack(0x90015fb0 to 0x90015ff8)

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 83ff59a06663 ("UBI: support ubi_num on mtd.ubi command line")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mtd/ubi/build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 6fbd77dc1d18..6a7577e57617 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1460,9 +1460,9 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 	if (token) {
 		int err = kstrtoint(token, 10, &p->ubi_num);
 
-		if (err) {
-			pr_err("UBI error: bad value for ubi_num parameter: %s",
-			       token);
+		if (err || p->ubi_num < UBI_DEV_NUM_AUTO) {
+			pr_err("UBI error: bad value for ubi_num parameter: %s\n",
+					token);
 			return -EINVAL;
 		}
 	} else
-- 
2.43.0


