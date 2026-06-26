Return-Path: <stable+bounces-269008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1vfGLcmjPmrKJQkAu9opvQ
	(envelope-from <stable+bounces-269008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:07:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 297286CEC5F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269008-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269008-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3454B3015893
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A343F8890;
	Fri, 26 Jun 2026 16:07:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AA37BE7D;
	Fri, 26 Jun 2026 16:07:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490055; cv=none; b=g0vT94l+Kbqv/8L+YZU+CTHUeYj/N8v0cbARXGXYilkd2ojK1jkyIW4humY6ENkhOgaWEyPk8fReeM+UnsNDULqteJUOhtb7POCNjbfi6WkI1FzjdpLL+wBTEsDLZ8Qpb7tK+/cqOkOCHfcWb04GDhwKUnf8Cwz6w7Ifv6XmoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490055; c=relaxed/simple;
	bh=HLbFIYOK+hGfPF9akC/8g/VNcVzs/iO1iKAuxM3pkyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jee7GB6ncuan5H+39qXl9O/Iy/mJT+dZ0Ojni1TMIlcACvVL7Zv2xpf5wu77nXvOHRHks7WqGiJrMq7gER3NPvWFt6M9HyRjsvkh/oRWT5axHHamGJ1fNZVTTyUkWnkuShlxY4zjyWH0Bg2YdEgKeULDaNR/R3YeiFaGzFF0ozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowADnjNXBoz5q725tAw--.17296S2;
	Sat, 27 Jun 2026 00:07:30 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: regulator: s5m8767_pmic_dt_parse_pdata: fix leaked device_node   references on buck configuration error
Date: Sat, 27 Jun 2026 00:07:28 +0800
Message-Id: <20260626160728.54650-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjNXBoz5q725tAw--.17296S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rAry7CF4DuryruF4DJwb_yoW8uFWDpF
	W5GFW3KrWktF1xtw18twn7uFy3C3srt3yqqrWrG3WSvws8AFyDXr1F9Fn2vF1xGrWkJw13
	tFWayFW0vr4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIKA2o+idtCkgAAsR
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:lgirdwood@gmail.com,m:broonie@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269008-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 297286CEC5F

In s5m8767_pmic_dt_parse_pdata(), for_each_child_of_node() acquires
device_node references for each regulator child stored in
rdata->reg_node. On error paths where buck2/buck3/buck4 configuration
validation fails, the function returns -EINVAL without releasing
previously acquired child node references.

Add an err_out label that releases all stored reg_node references before
returning an error.

Cc: stable@vger.kernel.org
Fixes: 9767ec7fe8d9 ("regulator: Add S5M8767A regulator driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/s5m8767.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index a49b28786dd0..0f6903101314 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -571,8 +571,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 				"s5m8767,pmic-buck2-dvs-voltage",
 				pdata->buck2_voltage, dvs_voltage_nr)) {
 			dev_err(iodev->dev, "buck2 voltages not specified\n");
-			of_node_put(reg_np);
-			return -EINVAL;
+			goto err_out;
 		}
 	}
 
@@ -583,8 +582,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 				"s5m8767,pmic-buck3-dvs-voltage",
 				pdata->buck3_voltage, dvs_voltage_nr)) {
 			dev_err(iodev->dev, "buck3 voltages not specified\n");
-			of_node_put(reg_np);
-			return -EINVAL;
+			goto err_out;
 		}
 	}
 
@@ -595,8 +593,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 				"s5m8767,pmic-buck4-dvs-voltage",
 				pdata->buck4_voltage, dvs_voltage_nr)) {
 			dev_err(iodev->dev, "buck4 voltages not specified\n");
-			of_node_put(reg_np);
-			return -EINVAL;
+			goto err_out;
 		}
 	}
 
@@ -627,6 +624,11 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 	}
 
 	return 0;
+
+err_out:
+	for (i = 0; i < pdata->num_regulators; i++)
+		of_node_put(pdata->regulators[i].reg_node);
+	return -EINVAL;
 }
 #else
 static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
-- 
2.39.5 (Apple Git-154)


