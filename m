Return-Path: <stable+bounces-196881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCCC8481F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 139D434D061
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600B30FC3C;
	Tue, 25 Nov 2025 10:36:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971542DE71A;
	Tue, 25 Nov 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067015; cv=none; b=VIwvG++5ohXCagEDiYLfMWnxW8EK+mj2rM4f8Hp11tYWtCtk6YKSTrtlG3wv05QC0xHYrRvH79aU1nLuBDna6ZmcKinYHgQ1D/zH4tvi+h1jw/TZHh2FqUdFNdKkeIzitNe5+TNfapHMKcublJy3rPirjK0q+5USA93fKVJMPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067015; c=relaxed/simple;
	bh=l7UjLiJFEUvjyW1TAyq6Iqgt4hIjRpPRwN7VpwyUJy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=feiS2XZXhFYRgVGPYQ+VkjUhubSD1oJ3VA8gqS+iW69JOczI8+Xl4g36fmnuT5U7HnZuiCpI5RYJ25ey4R70yqUZMdU2yA3ysVVNmU5cI7m358DtbGe2Myf6eID4MtPZawFRySoC1upI/56diadnLT0iAwbTp/xaHETVAV0692k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.214])
	by mtasvr (Coremail) with SMTP id _____wAn1FW4hiVphVExAA--.8854S3;
	Tue, 25 Nov 2025 18:36:40 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.18.214])
	by mail-app4 (Coremail) with SMTP id zi_KCgCXeH+uhiVp0zl8Aw--.52409S3;
	Tue, 25 Nov 2025 18:36:39 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	mitltlatltl@gmail.com,
	linux-kernel@vger.kernel.org,
	sergei.shtylyov@gmail.com,
	Duoming Zhou <duoming@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: typec: ucsi: fix probe failure in gaokun_ucsi_probe()
Date: Tue, 25 Nov 2025 18:36:26 +0800
Message-Id: <4d077d6439d728be68646bb8c8678436a3a0885e.1764065838.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1764065838.git.duoming@zju.edu.cn>
References: <cover.1764065838.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCXeH+uhiVp0zl8Aw--.52409S3
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIBAWkktQELkwAIso
X-CM-DELIVERINFO: =?B?K/QmOwXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR18YlAikpI5poxpx6509tfGtZhNDJlVfA4q6nm4NlyYKDvHEE8KkwG2V9S8VKaY2LnAMK
	1nSaSV4ci93tEAf+x+usa4vHYcAbvr5/yJ0bf8ECTdyMtp6K9PmLIeuR9pZKKA==
X-Coremail-Antispam: 1Uk129KBj93XoW7Wry7tFWfGr17WrWrWr4DGFX_yoW8WrWfpr
	Wq9w40yr15Gr4a93Z8WFn3Aa1IqwnrXryUKF47X34F9rZ7ta4fZry8t3yFgF92gw1UtF1Y
	vF1qywnxXrWDKabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1yrW5UUUUU==

The gaokun_ucsi_probe() uses ucsi_create() to allocate a UCSI instance.
The ucsi_create() validates whether ops->poll_cci is defined, and if not,
it directly returns -EINVAL. However, the gaokun_ucsi_ops structure does
not define the poll_cci, causing ucsi_create() always fail with -EINVAL.
This issue can be observed in the kernel log with the following error:

ucsi_huawei_gaokun.ucsi huawei_gaokun_ec.ucsi.0: probe with driver
ucsi_huawei_gaokun.ucsi failed with error -22

Fix the issue by adding the missing poll_cci callback to gaokun_ucsi_ops.

Fixes: 00327d7f2c8c ("usb: typec: ucsi: add Huawei Matebook E Go ucsi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Add cc: stable.
  - Correct spelling mistake.

 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
index 7b5222081bb..8401ab414bd 100644
--- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -196,6 +196,7 @@ static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
 const struct ucsi_operations gaokun_ucsi_ops = {
 	.read_version = gaokun_ucsi_read_version,
 	.read_cci = gaokun_ucsi_read_cci,
+	.poll_cci = gaokun_ucsi_read_cci,
 	.read_message_in = gaokun_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = gaokun_ucsi_async_control,
-- 
2.34.1


