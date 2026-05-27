Return-Path: <stable+bounces-254534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCzgOkrKFmr7sAcAu9opvQ
	(envelope-from <stable+bounces-254534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:41:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494F5E2E13
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B3883013AA3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8763EF0D3;
	Wed, 27 May 2026 10:38:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368073E3D86;
	Wed, 27 May 2026 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878328; cv=none; b=dpcNRcuXxFAR+ppkFpqUIJxoYr43a8cAb7Lt4XdPiKm5yqfM6m9VKili0p8D6tBA6MSUE0mym7Jsn4ym/pkKN/a+79yZkFHJfw8e7NF1NSMklXZv40eOj3dI/t1kSNdUTsFdk3HRMBmSxCRMtjZ+KpFArr6AeUw3fciyk6K4sKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878328; c=relaxed/simple;
	bh=xvVfFGqu0pRxJc8OdISO4s9Ig358JwKumzrKecXeUX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=In/EFu0zB4zoeYKf8I3kGU+EMSRJEAKp48pb9Opo72XCRpdSn7bUxG13HusUf4DMQu5eKt7XCvaFMjytatWzr4kFtcj8UbjiPYm1G/w+MY2tnOkdVbn1nL9VCqcrajLUlgxCbOqu6rNmtoiBCByGcyYtpnGawyDSTER8ujrywkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.3])
	by APP-05 (Coremail) with SMTP id zQCowAD3fACuyRZq6N+LEQ--.1041S2;
	Wed, 27 May 2026 18:38:38 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] target: iscsi: cxgbit: fix cnp kref leak in __cxgbit_free_cdev_np()
Date: Wed, 27 May 2026 10:38:23 +0000
Message-Id: <20260527103823.869792-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3fACuyRZq6N+LEQ--.1041S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47Wr1xZr4kZr1UArWfuFg_yoW8Gw4rpF
	40kFyUJr1UJ3y3Kr18Jw4I9FyxZanIyrW3C348CwsY9w4Y9ryDKFyayw42qay5Crykur43
	Xan8AryUGryqy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73PUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwAA2oWirr+lwAAst
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254534-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 9494F5E2E13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__cxgbit_free_cdev_np() calls cxgbit_get_cnp() which takes a kref
reference on the cnp structure. This reference is only released on
the immediate error path after cxgbit_get_cnp(). On the timeout path
and the normal completion path that successfully processes the NP,
the reference is never released via cxgbit_put_cnp(), leaking the
kref.

Add cxgbit_put_cnp(cnp) on the timeout and success paths to properly
release the kref reference.

Cc: stable@vger.kernel.org
Fixes: 9730ffcb8957 ("cxgbit: add files for cxgbit.ko")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 146705845fa3..11149d73c844 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -545,6 +545,7 @@ __cxgbit_free_cdev_np(struct cxgbit_device *cdev, struct cxgbit_np *cnp)
 	ret = cxgbit_wait_for_reply(cdev, &cnp->com.wr_wait,
 				    0, 10, __func__);
 	if (ret == -ETIMEDOUT)
+		cxgbit_put_cnp(cnp);
 		return ret;
 
 	if (ipv6 && cnp->com.cdev) {
@@ -558,6 +559,7 @@ __cxgbit_free_cdev_np(struct cxgbit_device *cdev, struct cxgbit_np *cnp)
 
 	cxgb4_free_stid(cdev->lldi.tids, stid,
 			cnp->com.local_addr.ss_family);
+	cxgbit_put_cnp(cnp);
 	return 0;
 }
 
-- 
2.34.1


