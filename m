Return-Path: <stable+bounces-262686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GWo7NfSoKmo7ugMAu9opvQ
	(envelope-from <stable+bounces-262686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:24:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE3671CB8
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:24:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262686-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262686-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED35338CFFD
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E33F4DD5;
	Thu, 11 Jun 2026 12:22:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD963F7A9E;
	Thu, 11 Jun 2026 12:22:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180535; cv=none; b=B6nI2EfrKZNuRJIRalfu22e91rrV08h6chzcso4cmO/HbtXWwvSzufRlTACxkcFhwjQZCsAKGdFyuEDvrn6pT139eoHJ5x0IMOKljNO/nYUMPnu20nBSq5La0qps/S3N0Ltt5q9dMV229o3p0HK6Ey2fsFTPKjggiI0T22HoJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180535; c=relaxed/simple;
	bh=NNuGjHW7aiMuGvUX+YqgBQNUEL3YlheFCzAZacSIzBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YuuE7jl70ozE3tAK4RVG1YTlvZxAnx7FIYE1PTo5wlhHyJqdWcEuzAwJEJzjD0LwPRMHAwwTbFS8O+8NHBSjFgZJkcMnHppIuaWlUAN+wIsbDMcyz2ts0R6WRpQl2ZR/+NSYe+cpI3zvOCrXVMjU2aRQcCCothTbf6Q4rdiHe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACXHgJtqCpqb3IVEw--.237S2;
	Thu, 11 Jun 2026 20:22:07 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: martin.petersen@oracle.com
Cc: kees@kernel.org,
	vulab@iscas.ac.cn,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: cxgbit: fix refcount leak in __cxgbit_free_cdev_np
Date: Thu, 11 Jun 2026 20:22:03 +0800
Message-ID: <20260611122203.78379-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXHgJtqCpqb3IVEw--.237S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fGw1fCF4rGw15XFWkZwb_yoW8CFyfpF
	W0kFyUJF1DJrW5Jr4kAw4Ikr1Iva1ayFW3C348CwsIvws0vr4DKr1UAw12gay5Crykur43
	Xa1Yvr15G3yDAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcPA2oqh3hi8AAAsq
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-262686-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:kees@kernel.org,m:vulab@iscas.ac.cn,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73EE3671CB8

__cxgbit_free_cdev_np() calls cxgbit_get_cnp() to take a reference
on cnp for the duration of the firmware remove-server operation.
If cxgb4_remove_server() fails, the reference is correctly released
in the error path with cxgbit_put_cnp(). However, once past that
check, the reference is never released on any other path:
 - when cxgbit_wait_for_reply() times out,
 - when cxgbit_wait_for_reply() succeeds,
 - or when cxgbit_wait_for_reply() returns another error.

All three paths return without dropping the reference, and no
called function consumes or releases the kref. The caller,
cxgbit_free_cdev_np(), does not balance the reference either.

Add the missing cxgbit_put_cnp() on the timeout and success paths,
and use a unified cleanup to handle all non-early-error returns.

Cc: stable@vger.kernel.org
Fixes: 9730ffcb8957 ("cxgbit: add files for cxgbit.ko")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 146705845fa3..f8cd6457666b 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -544,8 +544,10 @@ __cxgbit_free_cdev_np(struct cxgbit_device *cdev, struct cxgbit_np *cnp)
 
 	ret = cxgbit_wait_for_reply(cdev, &cnp->com.wr_wait,
 				    0, 10, __func__);
-	if (ret == -ETIMEDOUT)
+	if (ret == -ETIMEDOUT) {
+		cxgbit_put_cnp(cnp);
 		return ret;
+	}
 
 	if (ipv6 && cnp->com.cdev) {
 		struct sockaddr_in6 *sin6;
@@ -558,6 +560,7 @@ __cxgbit_free_cdev_np(struct cxgbit_device *cdev, struct cxgbit_np *cnp)
 
 	cxgb4_free_stid(cdev->lldi.tids, stid,
 			cnp->com.local_addr.ss_family);
+	cxgbit_put_cnp(cnp);
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)


