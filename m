Return-Path: <stable+bounces-238445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE82DRnn4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:54:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26E418375
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21FD83014677
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08A36828B;
	Fri, 17 Apr 2026 07:48:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F10340A59;
	Fri, 17 Apr 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412122; cv=none; b=uiCVjN2Udl6FvnakAlo62bti2TbmHPmNIe6uQBnpPcwUt3FGC3p2ruJxTbZqOtqPY6hhZDkrcpwj8JnGAJVtLYXiZ/NwutEzhN/CU2KCaFJDof9Go6QjL5vrXUoZgPLHuxl7pr0g2s6KRFZFxcMAS+zG7tfPd+I14VeGlAc8jyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412122; c=relaxed/simple;
	bh=n2xeCTsD93o1Oz1aprLb+7cI35z3JmMxyvQIRfnDuIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYJdv7hSSuDspS0z3IRku6KjTFa2107uyX75G0uLqTV5G6UPWmncka4+8dYYd1rL1p6yqneqaQ3CNQXh3fnk/mNISv93sQOWIF3FkAfyH/vXeAc9R0sRpJtMUOkMuWwpZ9f4GPaLy843wCwgxUuTTL2O8Sq1L9Zkn20eAAnoST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAC3RgrL5eFpAzHYDQ--.61365S2;
	Fri, 17 Apr 2026 15:48:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/perf/hv-gpci: bound sysfs formatting with sysfs_emit_at()
Date: Fri, 17 Apr 2026 15:48:25 +0800
Message-ID: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3RgrL5eFpAzHYDQ--.61365S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr13Wr15ury7Zry7ur17Jrb_yoWrJw43p3
	WfKr4q9rs5Xw17CrWIkF1xZw15W397A347WrW2g393ArsxX3909FyUKFyY9ry8GFWrCa48
	urZxKrs0krnrJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz
	3UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238445-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org,iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE26E418375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

systeminfo_gpci_request() and
affinity_domain_via_partition_result_parse() hex-encode hypervisor data
into the single-page sysfs read buffer with sprintf(buf + *n, ...).
Both helpers only check PAGE_SIZE after the formatting loops have already
advanced past the end of the buffer.

Switch these appends to sysfs_emit_at() and stop once the sysfs buffer is
full.

Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/perf/hv-gpci.c | 56 +++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 5cac2cf3bd1e..325b80f01629 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/perf_event.h>
+#include <linux/sysfs.h>
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/io.h>
@@ -134,6 +135,7 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 			size_t *n, struct hv_gpci_request_buffer *arg)
 {
 	unsigned long ret;
+	int len;
 	size_t i, j;
 
 	arg->params.counter_request = cpu_to_be32(req);
@@ -176,9 +178,17 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
 		j = i * be16_to_cpu(arg->params.cv_element_size);
 
-		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size);
+		     j++) {
+			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[j]);
+			if (!len)
+				return -EFBIG;
+			*n += len;
+		}
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (!len)
+			return -EFBIG;
+		*n += len;
 	}
 
 	if (*n >= PAGE_SIZE) {
@@ -465,6 +475,7 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 			int element_size, char *buf, size_t *last_element,
 			size_t *n, struct hv_gpci_request_buffer *arg)
 {
+	int len;
 	size_t i = 0, j = 0;
 	size_t k, l, m;
 	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
@@ -483,22 +494,49 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 	 */
 	while (i < returned_values) {
 		k = j;
-		for (; k < j + element_size; k++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; k < j + element_size; k++) {
+			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[k]);
+			if (!len) {
+				*n = PAGE_SIZE;
+				return;
+			}
+			*n += len;
+		}
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (!len) {
+			*n = PAGE_SIZE;
+			return;
+		}
+		*n += len;
 
 		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
 		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
 
 		for (l = 0; l < total_affinity_domain_ele; l++) {
 			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
-				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
+				len = sysfs_emit_at(buf, *n, "%02x",
+						    (u8)arg->bytes[k]);
+				if (!len) {
+					*n = PAGE_SIZE;
+					return;
+				}
+				*n += len;
 				k++;
 			}
-			*n += sprintf(buf + *n,  "\n");
+			len = sysfs_emit_at(buf, *n, "\n");
+			if (!len) {
+				*n = PAGE_SIZE;
+				return;
+			}
+			*n += len;
 		}
 
-		*n += sprintf(buf + *n,  "\n");
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (!len) {
+			*n = PAGE_SIZE;
+			return;
+		}
+		*n += len;
 		i++;
 		j = k;
 	}
-- 
2.50.1 (Apple Git-155)


