Return-Path: <stable+bounces-238448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ClMFSPo4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECEC418484
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F1B31F254B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA9D36828B;
	Fri, 17 Apr 2026 07:51:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6FA3815F9;
	Fri, 17 Apr 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412268; cv=none; b=P2czzGTz8arhm4UTB17cmfZHmjzp+sdF6LB9yUsFfHi/9vxi4ABjv6wAOIn5AYVRYr0zGfjfjkqoI4PV9iWXOe6Tg7Eu+Zk4pMax7oc+5XSpUrAZax2jjZJVZDZYP74bgyl831JB9YnH/ejB+Ik5DWnVD4fv5Eidm2nHiM9BFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412268; c=relaxed/simple;
	bh=uEFWSYZ0+B6CxK130IkgsdDwOX+v6edwWR+sanija3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJ8D//Ufeyoxxknlpf7wBq1SYl2iRrCLzFQALYyk+dpqHFvGaWo8o/1gsABbvUu1C7bxez0pRrV+w9LxgV+KIAmLMRTdW3skca4hOvRGRAi7X45b/+ZsEQ0+tjoU1OLonWnr9ysLBR9go4RZjIODzAjGBOKqAztcbQBpaN9VRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADHVQlT5uFp5T3YDQ--.39895S2;
	Fri, 17 Apr 2026 15:50:44 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Daniel Gomez <da.gomez@samsung.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] params: bound array element output to the caller's page buffer
Date: Fri, 17 Apr 2026 15:50:42 +0800
Message-ID: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHVQlT5uFp5T3YDQ--.39895S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13CF1xKr1Dtr4fCF18Grg_yoW8Zr1kpr
	4ftF1Ygws7JFWfuw4UCw4rua45Zas2qa43Can2yw4fAr15Jr1ruF1rGFyaqryFkrWfWFyj
	vrs8tF1Yka17G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUgXocUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-238448-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,vger.kernel.org,iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ECEC418484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

param_array_get() appends each element's string representation into the
shared sysfs page buffer by passing buffer + off to the element getter.

That works for getters that only write a small bounded string, but
param_get_charp() and similar helpers format against PAGE_SIZE from the
pointer they receive. Once off is non-zero, an element getter can
therefore write past the end of the original sysfs page buffer.

Collect each element into a temporary PAGE_SIZE buffer first and then
copy only the remaining space into the caller's page buffer.

Fixes: 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than get and set fns directly")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/params.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 74d620bc2521..8910daa12816 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -475,22 +475,34 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
 static int param_array_get(char *buffer, const struct kernel_param *kp)
 {
 	int i, off, ret;
+	char *elem_buf;
 	const struct kparam_array *arr = kp->arr;
 	struct kernel_param p = *kp;
 
+	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!elem_buf)
+		return -ENOMEM;
+
 	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
 		/* Replace \n with comma */
 		if (i)
 			buffer[off - 1] = ',';
 		p.arg = arr->elem + arr->elemsize * i;
 		check_kparam_locked(p.mod);
-		ret = arr->ops->get(buffer + off, &p);
+		ret = arr->ops->get(elem_buf, &p);
 		if (ret < 0)
-			return ret;
+			goto out;
+		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
+		memcpy(buffer + off, elem_buf, ret);
 		off += ret;
+		if (off == PAGE_SIZE - 1)
+			break;
 	}
 	buffer[off] = '\0';
-	return off;
+	ret = off;
+out:
+	kfree(elem_buf);
+	return ret;
 }
 
 static void param_array_free(void *arg)
-- 
2.50.1 (Apple Git-155)


