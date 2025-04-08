Return-Path: <stable+bounces-128813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC7A7F3C4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1381897231
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 04:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB635206F31;
	Tue,  8 Apr 2025 04:42:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93B1CAA7D;
	Tue,  8 Apr 2025 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087349; cv=none; b=hzIMGchEqe/Ey+TvlyFNx2VJKiZhBv9aaEaeFzEMSxZWK2dBam7Izo96tVB57CvXZ+1maQ4ROJ5x9VQKdgvNJRoYBYr1gpEcKh4ZbS1meG38B370jqAKKtubCv7AOgJTr5Cc+InUcfv2k5oWVOtupdWz6YvzGmSQGTY052NSfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087349; c=relaxed/simple;
	bh=D31vUVu32ORyo4H6+P+jGQhtvqYv+1sDFDa93HUVz9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ET37hgwKVtLPl//E/vfJI7Y+VBENHNfOuE88ft9nLlz6y0HWzjY/KmCr3g7f0r1GyTwT+hfNkF9dFSQ5doyonGv+/7SeVyld24wk2Krtr0nWKTzA1W35BuxxfPRw+32RYoKrmH/sFcFT2pT9vL+GTknTer9wgXscsabTbOMaFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADHbf4sqfRnikMWBw--.31690S2;
	Tue, 08 Apr 2025 12:42:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v7] staging: rtl8723bs: Add error handling for sd_read()
Date: Tue,  8 Apr 2025 12:41:52 +0800
Message-ID: <20250408044152.3009-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHbf4sqfRnikMWBw--.31690S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUuFW8JF4xur15Jr1UZFb_yoW8Kw18pF
	4kKa4DArZ8Wa95ZFn2qas3Ca4rAryrGFW5WrW0kw4Svw15uwsavrWrKa42gr18Gr4qkw4Y
	qF1v93Z8uw1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUbzVUUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsGA2f0dv3HmQAAsO

The sdio_read32() calls sd_read(), but does not handle the error if
sd_read() fails. This could lead to subsequent operations processing
invalid data. A proper implementation can be found in sdio_readN(),
which has an error handling for the sd_read().

Add error handling for the sd_read() to free tmpbuf and return error
code if sd_read() fails. This ensure that the memcpy() is only performed
when the read operation is successful.

Since none of the callers check for the errors, there is no need to
return the error code propagated from sd_read(). Returning SDIO_ERR_VAL32
might be a better choice, which is a specialized error code for SDIO.

Another problem of returning propagated error code is that the error
code is a s32 type value, which is not fit with the u32 type return value
of the sdio_read32().

An practical option would be to go through all the callers and add error
handling, which need to pass a pointer to u32 *val and return zero on
success or negative on failure. It is not a better choice since will cost
unnecessary effort on the error code.

The other opion is to replace sd_read() by sd_read32(), which return an
u32 type error code that can be directly used as the return value of
sdio_read32(). But, it is also a bad choice to use sd_read32() in a
alignment failed branch.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v7: Fix error code and add patch explanation
v6: Fix improper code to propagate error code
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


