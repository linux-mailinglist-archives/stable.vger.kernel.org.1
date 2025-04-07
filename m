Return-Path: <stable+bounces-128507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50AA7DAAC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 12:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9651C3ACE63
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FC2192FA;
	Mon,  7 Apr 2025 10:03:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22291218584;
	Mon,  7 Apr 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020222; cv=none; b=emnUaLcawT+PGcp2DIGHWdZ9tBrS9zg+e3GzWFwA9UPaVot6LEufveG3elWqv7nP+57kGuqKD36OvzI+GsmdoiM9/utBH+ACzmzxijh5cObC20/l70GTuy5s+Zu/TtWXWhtjy1NM8vrKYbH6kBoUAB26UrlfU1Ns3wrvklVysPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020222; c=relaxed/simple;
	bh=bzl/B2SLdxtB7CMtvv1kT+HsF6ZxpqpxRESNrilTWBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5zZDBvbn23Ts1rmZk5xILWHc66ezxnPZX5CB6DSje1HeqKdoXFALiqgssB5AAJa1yRM8+VXztZM6JZszCnlVkU34yp6hC7pl5ZHBt0rzc+d/1EOouElSmN3gHHKhvrtG4x7mdw/4M5xXnSnEz88+bJ4X2ZbtZuj/RVgt094/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADXfwD1ovNnMYPYBg--.43428S2;
	Mon, 07 Apr 2025 18:03:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v6] staging: rtl8723bs: Add error handling for sd_read()
Date: Mon,  7 Apr 2025 18:03:18 +0800
Message-ID: <20250407100318.2193-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXfwD1ovNnMYPYBg--.43428S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUuFW8JF1kKw4fuF1fXrb_yoW8Gw1kpF
	4kKa4DArW5Gay8uF1vgr93Aas5CayxGFy5WrWjkw4Svrn5ZwsavrWrKa4UXr4UWr17Aw4Y
	qF1kCw45Ww1UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU8vtCUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoFA2fzf7Wp+gAAsH

The sdio_read32() calls sd_read(), but does not handle the error if
sd_read() fails. This could lead to subsequent operations processing
invalid data. A proper implementation can be found in sdio_readN().

Add error handling for the sd_read() to free tmpbuf and return error
code if sd_read() fails. This ensure that the memcpy() is only performed
when the read operation is successful.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v6: Fix improper code to propagate error code
v5: Fix error code
v4: Add change log and fix error code
v3: Add Cc flag
v2: Change code to initialize val

 drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 21e9f1858745..eb21c7e55949 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -185,7 +185,12 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 			return SDIO_ERR_VAL32;
 
 		ftaddr &= ~(u16)0x3;
-		sd_read(intfhdl, ftaddr, 8, tmpbuf);
+		err = sd_read(intfhdl, ftaddr, 8, tmpbuf);
+		if (err) {
+			kfree(tmpbuf);
+			return (u32)err;
+		}
+
 		memcpy(&le_tmp, tmpbuf + shift, 4);
 		val = le32_to_cpu(le_tmp);
 
-- 
2.42.0.windows.2


