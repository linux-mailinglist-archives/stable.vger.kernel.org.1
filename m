Return-Path: <stable+bounces-240542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI+TMdig6mlF1gIAu9opvQ
	(envelope-from <stable+bounces-240542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 00:44:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5F4582F9
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 00:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39B6E30117A7
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4E37754E;
	Thu, 23 Apr 2026 22:44:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404C374187;
	Thu, 23 Apr 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984275; cv=none; b=nSYNoHMX8UKsAFtfFkrpbdGdyyMosCpinsG8IcCBpFmlrQpyTwa80mcVytDPKfWGuz6fh0LCivskl8iszVkeXYeDLK4GmaW597O1mlj3ypvW9COD8ktMEqkUX2HdrNlTFWZuIuedkzn8Em3WKIdOHAKZIHGkgEpbnIaKnYa5gdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984275; c=relaxed/simple;
	bh=w2I7jvG9cWubIHHJQDKhkkbpwWnXYxAtC2JpEUrLr84=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References; b=WbecdlysbvbP765bmVgJgxXkq4ObRhXE8Xe1CfKiUoLQqOl8EONfrQliFL01zbZHa5xMdBmI68QoeK0HtYxv/ExoDYF8ongnAfb+7VORgs9hkJCJ0cqth3slwbVk1tawDvGNmEiq99I017o7uwHsMtxpZU8elOiKpLXFUTs0I8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 03-hv-gpci-v2.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADXZQnEoOppH3RsDg--.36943S2;
	Fri, 24 Apr 2026 06:44:20 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 23 Apr 2026 23:32:00 +0800
Message-ID: <20260424070103.1-hv-gpci-v2-pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH v2] powerpc/perf/hv-gpci: bound sysfs output with helpers
In-Reply-To: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
References: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
X-CM-TRANSID:zQCowADXZQnEoOppH3RsDg--.36943S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1UKrWxKF4DCrykZw45GFg_yoWxXF48pF
	4rCr47Kw45Gw1UurW0k3Z7Zr13u39Fy347Jay8Kr9ayrs7A39FkFyIyFyYkryxCrWxCFy8
	CrZxtws8CanrXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JFv_Gryl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjc
	xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-240542-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org,iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41F5F4582F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

systeminfo_gpci_request() and
affinity_domain_via_partition_result_parse() hex-encode hypervisor data
into the single-page sysfs read buffer with sprintf(buf + *n, ...).
Both helpers only check PAGE_SIZE after the formatting loops have
already advanced past the end of the buffer.

Add small helpers around sysfs_emit_at() for hex-byte and newline
appends, and stop once the sysfs buffer is full. This keeps the repeated
bounds handling local instead of open-coding it at each append site.

Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- refactor the repeated sysfs_emit_at() handling into helpers as suggested
  by Christophe Leroy

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 5cac2cf3bd1e..2f543f0671ba 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/perf_event.h>
+#include <linux/sysfs.h>
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/io.h>
@@ -129,11 +130,36 @@ static int sysinfo_counter_request[] = {
 
 static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
 
+static int hv_gpci_emit_hex_byte(char *buf, size_t *n, u8 byte)
+{
+	int len;
+
+	len = sysfs_emit_at(buf, *n, "%02x", byte);
+	if (len <= 0)
+		return -EFBIG;
+
+	*n += len;
+	return 0;
+}
+
+static int hv_gpci_emit_newline(char *buf, size_t *n)
+{
+	int len;
+
+	len = sysfs_emit_at(buf, *n, "\n");
+	if (len <= 0)
+		return -EFBIG;
+
+	*n += len;
+	return 0;
+}
+
 static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 			u16 secondary_index, char *buf,
 			size_t *n, struct hv_gpci_request_buffer *arg)
 {
 	unsigned long ret;
+	int rc;
 	size_t i, j;
 
 	arg->params.counter_request = cpu_to_be32(req);
@@ -176,9 +202,14 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
 		j = i * be16_to_cpu(arg->params.cv_element_size);
 
-		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++) {
+			rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[j]);
+			if (rc)
+				return rc;
+		}
+		rc = hv_gpci_emit_newline(buf, n);
+		if (rc)
+			return rc;
 	}
 
 	if (*n >= PAGE_SIZE) {
@@ -461,10 +492,14 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
 	return ret;
 }
 
-static void affinity_domain_via_partition_result_parse(int returned_values,
-			int element_size, char *buf, size_t *last_element,
-			size_t *n, struct hv_gpci_request_buffer *arg)
+static int affinity_domain_via_partition_result_parse(int returned_values,
+						      int element_size,
+						      char *buf,
+						      size_t *last_element,
+						      size_t *n,
+						      struct hv_gpci_request_buffer *arg)
 {
+	int rc;
 	size_t i = 0, j = 0;
 	size_t k, l, m;
 	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
@@ -483,27 +518,40 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 	 */
 	while (i < returned_values) {
 		k = j;
-		for (; k < j + element_size; k++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; k < j + element_size; k++) {
+			rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[k]);
+			if (rc)
+				return rc;
+		}
+		rc = hv_gpci_emit_newline(buf, n);
+		if (rc)
+			return rc;
 
 		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
 		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
 
 		for (l = 0; l < total_affinity_domain_ele; l++) {
 			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
-				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
+				rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[k]);
+				if (rc)
+					return rc;
 				k++;
 			}
-			*n += sprintf(buf + *n,  "\n");
+			rc = hv_gpci_emit_newline(buf, n);
+			if (rc)
+				return rc;
 		}
 
-		*n += sprintf(buf + *n,  "\n");
+		rc = hv_gpci_emit_newline(buf, n);
+		if (rc)
+			return rc;
 		i++;
 		j = k;
 	}
 
 	*last_element = k;
+
+	return 0;
 }
 
 static ssize_t affinity_domain_via_partition_show(struct device *dev, struct device_attribute *attr,
@@ -514,6 +562,7 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	size_t n = 0;
 	size_t last_element = 0;
 	u32 starting_index;
+	int element_size, rc, returned_values;
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
 	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
@@ -546,10 +595,16 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	 * to buffer util we get all the information.
 	 */
 	while (ret == H_PARAMETER) {
-		affinity_domain_via_partition_result_parse(
-			be16_to_cpu(arg->params.returned_values) - 1,
-			be16_to_cpu(arg->params.cv_element_size), buf,
-			&last_element, &n, arg);
+		returned_values = be16_to_cpu(arg->params.returned_values);
+		element_size = be16_to_cpu(arg->params.cv_element_size);
+		rc = affinity_domain_via_partition_result_parse(returned_values - 1,
+								element_size, buf,
+								&last_element, &n,
+								arg);
+		if (rc) {
+			put_cpu_var(hv_gpci_reqb);
+			return rc;
+		}
 
 		if (n >= PAGE_SIZE) {
 			put_cpu_var(hv_gpci_reqb);
@@ -578,10 +633,15 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	}
 
 parse_result:
-	affinity_domain_via_partition_result_parse(
-		be16_to_cpu(arg->params.returned_values),
-		be16_to_cpu(arg->params.cv_element_size),
-		buf, &last_element, &n, arg);
+	returned_values = be16_to_cpu(arg->params.returned_values);
+	element_size = be16_to_cpu(arg->params.cv_element_size);
+	rc = affinity_domain_via_partition_result_parse(returned_values,
+							element_size, buf,
+							&last_element, &n, arg);
+	if (rc) {
+		put_cpu_var(hv_gpci_reqb);
+		return rc;
+	}
 
 	put_cpu_var(hv_gpci_reqb);
 	return n;
-- 
2.50.1 (Apple Git-155)


