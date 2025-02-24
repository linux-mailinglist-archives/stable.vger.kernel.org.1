Return-Path: <stable+bounces-118931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66841A420C5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AE43B6B10
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3A23372B;
	Mon, 24 Feb 2025 13:30:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B471B041E;
	Mon, 24 Feb 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403838; cv=none; b=YFH4cubRP53YdeKS4Lb6Ukwo8591dJVxhRi5I3eDHpfgGoTJ9Hi1pkf+glha3sYo5NpmC3neXyv9aLq6pHWAbeHlXhm2coHUclwb9jv3CjUHGnIWpC8a69qnDOlX5SSHVs7gnF+z2q+e5o/ljqfqEbKU64M12+AKJgvsIbGRozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403838; c=relaxed/simple;
	bh=ABZeoDoCXyMZznzUxsqlycvSyByLRS8r9I1i4W5KKZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/T/mou8GGv9LrYmfeHDrfjtbJqX3Srr2bIMAiaR3KAyQZ0/C7v/bCU7E0S5JZd4jmBm+rp1N6fOpEfhkCw5WX31MWKav4TR4FOqR+e3wJC6Hd6lRNFbtqNyLg1MDAyg4ic2ogTeSEvhdnrsdRgBHJ6sGGGFBOkv8dDoZo91NvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAAnLAxldLxnkjsEEA--.4476S2;
	Mon, 24 Feb 2025 21:30:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	David.Woodhouse@intel.com,
	jarkko.lavinen@nokia.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: Fix potential UAF for mtdswap_dev pointers
Date: Mon, 24 Feb 2025 21:30:07 +0800
Message-Id: <20250224133007.3037357-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnLAxldLxnkjsEEA--.4476S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyrtr13trWrGF4ftry7Jrb_yoW8GF1UpF
	Z8CrWay398Jw1fG3ZrAw4DAFyFkw15urW5Gr4rJ3y2vwn5A34fAr90vayY9Fy3KF4DKa4Y
	qrsFqr98Wr1rGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In the mtdswap_init(), if the allocations fail, the error handling
path frees d->page_buf, d->eb_data, d->revmap and d->page_data without
setting these pointers to NULL. This could lead to UAF if subsequent
error handling or device reset operations attempt to release these
pointers again.

Set d->page_buf, d->eb_data, d->revmap and d->page_data to NULL
immediately after freeing them to prevent misuse. Release immediately
and set to NULL, adhering to the 'release implies invalid' defensive
programming principle.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a32159024620 ("mtd: Add mtdswap block driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/mtd/mtdswap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index 680366616da2..b315dab2a914 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1318,12 +1318,16 @@ static int mtdswap_init(struct mtdswap_dev *d, unsigned int eblocks,
 
 oob_buf_fail:
 	kfree(d->page_buf);
+	d->page_buf = NULL;
 page_buf_fail:
 	vfree(d->eb_data);
+	d->eb_data = NULL;
 eb_data_fail:
 	vfree(d->revmap);
+	d->revmap = NULL;
 revmap_fail:
 	vfree(d->page_data);
+	d->page_data = NULL;
 page_data_fail:
 	printk(KERN_ERR "%s: init failed (%d)\n", MTDSWAP_PREFIX, ret);
 	return ret;
-- 
2.25.1


