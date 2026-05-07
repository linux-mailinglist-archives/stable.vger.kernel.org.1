Return-Path: <stable+bounces-244530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCQyDSRN/GmZNwAAu9opvQ
	(envelope-from <stable+bounces-244530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:28:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE34E4CA9
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DDF430F90B8
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ECB37DEAE;
	Thu,  7 May 2026 08:21:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E86349AE0;
	Thu,  7 May 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142076; cv=none; b=UPX1RjZ2eo0B5mRZYL3ymGh+RU3D2djI13VindrCBe4uWKGYTz5uAt0xiDzJdFev7VfWbjCW39L/uho0RIDqSlsUKIYeVDZb4r4uIUAtnAcu8sl2QQrLqnUNiJ40PDUWBWac+daYzwe7Lz6EtbAUiPwLjS8dzIVNEytWide7wU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142076; c=relaxed/simple;
	bh=pb2QAKkfMYhQ8AxH+Cy8d9mAKs1V3QIg02H2TC55MxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7MGz7aCOoxwV3AWdw7+OKNLlIeZFeVi2akzvKTd0l7XEbqFhOepVcvn/K+xSdUL1C8SzJfNEoDaHFaT33VyEH8d8k1v2WrGuYdIDeoooWvq8VlQYltx64+W+P0C6ncyRjorb4ndeM2+NUbkrydqnBinmqheTrLdsaqQ9Mf0veI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAB3XONxS_xp0whOEA--.9379S2;
	Thu, 07 May 2026 16:21:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Daniel Gomez <da.gomez@samsung.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] params: bound array element output to the caller's page buffer
Date: Thu,  7 May 2026 16:21:03 +0800
Message-ID: <20260507082103.94473-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3XONxS_xp0whOEA--.9379S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13CF1xKr1Dtr4fCF18Grg_yoW8Kw1kpw
	4fKw4Y9w4kJFy3uwsrCa1rua45Z3s7Ja43CFs2yw4rAr1UJr1ruFyrKryYqryFkrWxtryY
	vr45tr1Fka17J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Queue-Id: 87FE34E4CA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244530-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,vger.kernel.org,iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

param_array_get() appends each element's string representation into the
shared sysfs page buffer by passing buffer + off to the element getter.

That works for getters that only write a small bounded string, but
param_get_charp() and similar helpers format against PAGE_SIZE from the
pointer they receive. Once off is non-zero, an element getter can
therefore write past the end of the original sysfs page buffer.

Collect each element into a temporary PAGE_SIZE buffer first and then
copy only the remaining space into the caller's page buffer.

Cc: stable@vger.kernel.org
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- drop the incorrect Fixes tag; as Petr pointed out, the issue appears
  to predate mainline git history
- add Petr's Reviewed-by
- avoid rewriting the previous separator if the page buffer has no room
  to copy any bytes from the next element
- keep the broader kernel_param_ops::get(buffer, size) conversion as
  follow-up work, leaving this as the minimal fix

 kernel/params.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 74d620bc2521..8910daa12816 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -475,22 +475,36 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
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
-		/* Replace \n with comma */
-		if (i)
-			buffer[off - 1] = ',';
 		p.arg = arr->elem + arr->elemsize * i;
 		check_kparam_locked(p.mod);
-		ret = arr->ops->get(buffer + off, &p);
+		ret = arr->ops->get(elem_buf, &p);
 		if (ret < 0)
-			return ret;
+			goto out;
+		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
+		if (!ret)
+			break;
+		/* Replace the previous element's trailing newline with a comma. */
+		if (i)
+			buffer[off - 1] = ',';
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


