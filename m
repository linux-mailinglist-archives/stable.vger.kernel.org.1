Return-Path: <stable+bounces-253556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCqoIWwMD2omEgYAu9opvQ
	(envelope-from <stable+bounces-253556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:45:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 933135A62B5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CA1531AD71B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DDE3D75B6;
	Thu, 21 May 2026 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cfJd8691"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4B25B084;
	Thu, 21 May 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368997; cv=none; b=DKvExXQIrpmqFm53lMOAXuHOWNqojmCzEQDeZlx9YxX8h12UzrQ7m9yX4izPhjS/0FVNg77s4a/1t/O0z3qX0bRH3n6sKhPZXg+ATLwCAwYHp6YRhUdKPzIscBsV24QQ6E4jaOw86pjGjo3i4Bmwa+fk+i62yL40X8PB0UkYNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368997; c=relaxed/simple;
	bh=98+52IGWd5Qf8IZ2mTEfFJI7GmuSRzZvqiSsWrGaLh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RtqugrSBOl/SCU6tVujiNAoLQK/8luKw09uxmc8L+atx7lPZmXXJaFj7y5/MIRfE5K+2vibUx6bWDDHD3n0M2dceSaM0OGjyyv4gG6JB4kQXrPS191BMLvcHkP75XER8LvDWlgk7ufwS0I917MCC4ytoqcXdcAjeehX/5mpAdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cfJd8691; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779368969;
	bh=u3wKTazTgBgNvPAuaaAg4eK1LY0/c4psmFF5uqZJntg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cfJd8691WNGGrpq33AKbnmVeEh6IGk1gZBBFxHyokTeJcvDq3UOfa2yU3XCCNSsOC
	 acsN008lBfAkREOiQgCcozp3r1ZtHQSMG56tZWzEAOKIeJIpHYSIbwk+ywSmG+8NHo
	 Z+f2wmyq23wOObRv0KpXVLJiph9KEercTgq2h4fE=
X-QQ-mid: esmtpgz13t1779368950tfb6c16a8
X-QQ-Originating-IP: KrHN0IkV0jv59zRJttVM4fQgbtP4HU4YnfJR1mZjyyw=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 May 2026 21:08:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15588208067032243093
EX-QQ-RecipientCnt: 7
From: ZhaoJinming <zhaojinming@uniontech.com>
To: ilpo.jarvinen@linux.intel.com,
	srinivas.pandruvada@linux.intel.com
Cc: hansg@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] platform/x86/intel/tpmi: use cleanup helpers in mem_write()
Date: Thu, 21 May 2026 21:08:47 +0800
Message-Id: <20260521130848.2860219-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N79g/BZ3s2bFtVUIT4t9cLx1ueo7+PjbB4cjTo2ghM0wntcUl6720Wyr
	pEpxjq1OTki8yTkrc8kApRAZ5fhi3qAEhmgmhJbqRBTfR9/RJOVv5b0BVYpD8mkD20CxONh
	mb+ArWfryvYFTfKLeLCLA6TZc0VkHiWAj+Aja3yaQZMB2KK4sUc0fVh8pViRafnPi4IUlXy
	+xtZpZbHoE2ThoXk+PY3adikpnBts4jMONmqGcaB/VcS4hb/BuFhjfr+in3l9lvsSG8/ImV
	0DSxMkBfC7mkeKwBvcRflNjqaRsU6CgxQfzovTMXrS+jrSOhLOwDk7LXIsNSJVaSHgQoYYN
	56P8Oo1Dj0DdmviaIzAHhM+bIe4559h8rXlQ+xGeHRZkDDo4cQZldTORSus6SxvWWlr0hje
	8aFEh/uZWA1Y7tToyC0yjv2kzZjVoiJzhv1luykMIso5odJFc+odH2zf8SPlsiWTrvieDxa
	PQDFThMun0SKdBmERz3xRz4cnt+32MHTP7pA9BKBRrc8o66AN/q/v/xO+BXnS9zgua4gyr9
	KGttnoVwtv3h3upc0LxwvkjqvBoKCi5doxl0BOmVsWRrHogHdXs6aDTM1YTjIe9xQIZNJVt
	zixFVEZR8+k8lqny6GnAXon/iFBcYuRlOnkRsGThXcwM9KIj7HkTJ5BU0cYQ7qnXCc8TBU+
	z0qW7rByTiic3yAr9DrC+VvrU7jzZ5NLq/tUcBjDuqnH/n+OSSIBscZU+RPsdKPuKJI3GuI
	iUeTfZ1GkeBsTYJnTdaaxEifwZlxC8aHMp4D9xBXa/gSmC0INuKhKXFHhXiaMDOKFv+TXBs
	DfAVjuh2w81Opp4GEauNUQZbwcgbKTVFHBMW2cjvIn/YXnQjXTBoAAjEEK9qtr/m19OaSDO
	rTzBTKeVYQkS1YSxwOkG6TUtWz5eJ29xBB7avGxA6qw6CLKumtq9V39JdrM6VgKS4t2oNfR
	xDwYdGIx3uInIzVsDYCmR8TmfP9pllOtmc6usH0T0mfmBcQZiy53Fr+LUbD8Wk0axmGf975
	vP+uuyUzxPcKjEcQpCs9RI1WetFFWtZAw0rsX5snOY4hU5Xx9YkWMMrORwY53rlsIPV0i+p
	Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253556-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 933135A62B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mem_write(), the temporary array returned by
parse_int_array_user() must be released on all exit paths.
Convert the array variable to use cleanup.h scope-based
cleanup so it is freed automatically on return.

This also moves the array declaration next to
parse_int_array_user() as required by cleanup.h usage
guidelines.

Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned address for debugfs mem write")
Cc: stable@vger.kernel.org
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/platform/x86/intel/vsec_tpmi.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 16fd7aa41f20..88f14d0ad410 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -50,6 +50,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/intel_tpmi.h>
 #include <linux/intel_vsec.h>
@@ -473,7 +474,7 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 	struct seq_file *m = file->private_data;
 	struct intel_tpmi_pm_feature *pfs = m->private;
 	u32 addr, value, punit, size;
-	u32 num_elems, *array;
+	u32 num_elems;
 	void __iomem *mem;
 	int ret;
 
@@ -481,15 +482,14 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 	if (!size)
 		return -EIO;
 
+	u32 *array __free(kfree) = NULL;
 	ret = parse_int_array_user(userbuf, len, (int **)&array);
 	if (ret < 0)
 		return ret;
 
 	num_elems = *array;
-	if (num_elems != 3) {
-		ret = -EINVAL;
-		goto exit_write;
-	}
+	if (num_elems != 3)
+		return -EINVAL;
 
 	punit = array[1];
 	addr = array[2];
@@ -498,15 +498,11 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 	if (!IS_ALIGNED(addr, sizeof(u32)))
 		return -EINVAL;
 
-	if (punit >= pfs->pfs_header.num_entries) {
-		ret = -EINVAL;
-		goto exit_write;
-	}
+	if (punit >= pfs->pfs_header.num_entries)
+		return -EINVAL;
 
-	if (addr >= size) {
-		ret = -EINVAL;
-		goto exit_write;
-	}
+	if (addr >= size)
+		return -EINVAL;
 
 	mutex_lock(&tpmi_dev_lock);
 
@@ -525,9 +521,6 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 unlock_mem_write:
 	mutex_unlock(&tpmi_dev_lock);
 
-exit_write:
-	kfree(array);
-
 	return ret;
 }
 
-- 
2.20.1


