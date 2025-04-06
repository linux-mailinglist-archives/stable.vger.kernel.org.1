Return-Path: <stable+bounces-128410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E076CA7CC91
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 04:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DFF174AC9
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185DA3BBF2;
	Sun,  6 Apr 2025 02:35:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8CF9DA;
	Sun,  6 Apr 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743906947; cv=none; b=UHy38/2Ne4icbrS7kLJlvx35bSKg/Zrv62Nfl81wVu+DTS+x8GXmBWzhr9uEif445RpDZf0se3IYNr7KIOzyIrh1VsyMq9048oyFeWGx/BtUZna+FLK7coAC6edpBap9bm3OMbNc5qK9AE8RWejNC6lghIpkY1kq2cGT0zRMmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743906947; c=relaxed/simple;
	bh=Mru3MaqtIzGklmw3niFULMv9qxTICrZtXR/bgaM/M9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDK1c1PlHNMlxAHqQ+sV1qa34ZrGDhz4V5ee8AOzwglYt7uBQ2e1YjCdK785EC+/YFPlJvHfWMGQPfIohDOdh1fSIDVByyYCSLL3IY3Yk8ro2viPE9AZbMOdgRDHpMS0nk4DzXKQS2Uhw3QZe4Mr9SyBmmEIRKv1u4LD90FkQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [221.222.48.127])
	by APP-05 (Coremail) with SMTP id zQCowACHvgZz6PFnXc9zBg--.56688S2;
	Sun, 06 Apr 2025 10:35:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v5] staging: rtl8723bs: Add error handling for sd_read()
Date: Sun,  6 Apr 2025 10:35:13 +0800
Message-ID: <20250406023513.2727-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHvgZz6PFnXc9zBg--.56688S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUuFW8JF1kKw4fuF1fXrb_yoW8GF4fpF
	4kKa4qyrZ8Gay8u3W2g3s3AasYka4xGFW5WrWjkw4Svrn5ZwsavrWrKa4jqr4UWrnrAw4Y
	qF1kCw15uw1UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYEA2fxZK2uOAAAsE

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
v5: Fix error code
v4: Add change log and fix error code
v3: Add Cc flag
v2: Change code to initialize val

 drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 21e9f1858745..d79d41727042 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -185,7 +185,12 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 			return SDIO_ERR_VAL32;
 
 		ftaddr &= ~(u16)0x3;
-		sd_read(intfhdl, ftaddr, 8, tmpbuf);
+		err = sd_read(intfhdl, ftaddr, 8, tmpbuf);
+		if (err) {
+			kfree(tmpbuf);
+			return SDIO_ERR_VAL32;
+		}
+
 		memcpy(&le_tmp, tmpbuf + shift, 4);
 		val = le32_to_cpu(le_tmp);
 
-- 
2.42.0.windows.2


