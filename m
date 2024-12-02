Return-Path: <stable+bounces-95948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CAF9DFD4E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9EF280D3B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94F1F9F69;
	Mon,  2 Dec 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="glLFVMua"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8C22331;
	Mon,  2 Dec 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132227; cv=none; b=Dr/b75IbNaCO80ar7fx8HhJ1heG6lw73xrXK8pR6r+AEglxm0egViFeMcPGnXQ8siZuOHd1Ee4J9yWxuDm7atq7ARv4MvC20NAQgdt4f5y6Ss1AAnrnD4IVLoIG98UZLBQn0Tm1DqUw4nprztTnWul+tvwB5N01ktTcrkz0X16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132227; c=relaxed/simple;
	bh=lOayRBayZGSlXgUrI9KvTQ7rdb+QafjbTeNRnQUzG6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtLU9Fk3zpdEzixLFDoB/A+s6saRbsfz61aoTLM5UgT9ihgGI8tkjgOWuNO3nriqSWhieVVgQiArR1gpzT3xZtkEet8YFJZ8S4F0Vidzndob8G+kZL0NSZt5C0wC0MliK/ZoERGTIunGnkEGQNiiM3KDKLaQdIGaoLwbX7oN7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=glLFVMua; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1733132212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vsUdwmzHEUtFp4dw0uNgWDj5eMaa/8lI8CftTMle4BI=;
	b=glLFVMuaIeiD46Uyv90P/ajVMXJ/VOaRvcswdnYRFuhN0y+EZu27Of8BxNORqwI+3Kb49t
	4DzqNEhsZlr0UJrt25WT6+tj2M9CiYWAzNPvnXVGWCywPDUPpOrZFiS2mPxCKpvWTBP9BG
	hLTueajQ7kTDQsFVEe/0pcMPspNYTh8=
To: Richard Weinberger <richard@nod.at>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: ubi: Added a check for ubi_num
Date: Mon,  2 Dec 2024 12:36:52 +0300
Message-Id: <20241202093652.5911-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
V1 -> V2: changed the tag Fixes and moved the check to ubi_mtd_param_parse()
 drivers/mtd/ubi/build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 30be4ed68fad..ef6a22f372f9 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1537,7 +1537,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 	if (token) {
 		int err = kstrtoint(token, 10, &p->ubi_num);
 
-		if (err) {
+		if (err || p->ubi_num < UBI_DEV_NUM_AUTO) {
 			pr_err("UBI error: bad value for ubi_num parameter: %s\n",
 			       token);
 			return -EINVAL;
-- 
2.25.1


