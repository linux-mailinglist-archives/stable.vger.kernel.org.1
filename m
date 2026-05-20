Return-Path: <stable+bounces-249750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AbpMABKDWpEvgUAu9opvQ
	(envelope-from <stable+bounces-249750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA10587DC4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190D93026C0F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4F367B64;
	Wed, 20 May 2026 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n4p93Lud"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502F34041E;
	Wed, 20 May 2026 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255769; cv=none; b=e7qob1jX+M2tzlXWoU21neCSL3+jqAz0qdYax9KT5joizNyJcKU+7OqfRbbDp/ll+6c6rJsV16pbGUFQkG+QdrxMO03BXToOXqvy/x97xgaEMpkw82696yT/ReK0L7vPQ+8yzbyu9+Nm1M/hnef8+usc4frh24cxKdwC2d25fgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255769; c=relaxed/simple;
	bh=rAwIxrIzvapYzGhKTh7yR5K4P6evEJUOirV7nbTxXYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntwg4SUG5bGFYELn1Mf9gpwWD3Ks7Kj/oU11t5uHTzfVCmTa2m8asKUXYDY9U8NVfX0kkXBV2Tw9jMlYOHzJUGS6rylWA7M4D/F31rQWrFnwW3l3LER6FztuzqZzbaLxa5qKPyY3wzhoQpCoWzmCG5klb94dR/AAQDuKvDYPX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n4p93Lud; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779255747;
	bh=RdJ4Ye8htQ7W/kxA6uzcSK1PmdVGTESwG0T1+Tl3U2o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=n4p93LudvC0Fk0pyN3Shc+UUdGpT01xjq6kb/lNpRU72P+66hg5Tiblr6f3MmMbux
	 CXK3yGkDQIG5sxt2jMTTZ/R3xR+qoVLJFMS5SqKtTVn/XDTlUSuMJiHzHc47UAaaPZ
	 IiYoJyeBLy9RW6ZXOCI2BmX1sMyC7Rvyatb62F9Y=
X-QQ-mid: zesmtpsz3t1779255731tdc0c600d
X-QQ-Originating-IP: 6qQhozOgPDRmah4gPO3FSR8M3uZjbyzUSEj/T/8/i2A=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 May 2026 13:41:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6721937287254691689
EX-QQ-RecipientCnt: 7
From: ZhaoJinming <zhaojinming@uniontech.com>
To: ilpo.jarvinen@linux.intel.com,
	srinivas.pandruvada@linux.intel.com
Cc: hansg@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/tpmi: use cleanup helpers in mem_write()
Date: Wed, 20 May 2026 13:41:21 +0800
Message-Id: <20260520054122.1630021-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260520054122.1630021-1-zhaojinming@uniontech.com>
References: <b1006ce4-f596-b2aa-421a-518fe3cfe1f0@linux.intel.com>
 <20260520054122.1630021-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MAN6sKHDZ5xSlFgxiLlGgULDo447VmPlFOvN7p26qXP0JUQlWR1srVp8
	5zIezwLGayn8U4Vouo70WvFmycw6PrTaoyZYkjwtcZyTNxf1xofObs5wZ07WiiC489H4Fx/
	jvBiE2cBcD8iT0EDgoZ96MMv8XLbbNiKRY6D4dhGxoFc9MK+JL4nrvlK/dhbk0+ioGrwRH3
	BmZneHqjqLGIbFzHEua5viz5o7JRcjkgpiRdXmEak8qg5XLMQ5+1YPjiSvhzOJT8OGAX5Hg
	z4brx9IYIKrkimTmJ7B1ZuMBzT0Y50TvNRlzKK4ci5mdP6O2yE5Fu6T8Sbq9lTb9TsCr+ft
	Jgq9zywXquJ/byQFSEMNZCnq/bIZs2aj/y56qyT3cn9aa3lYEB/CAvxKooUALQPgL+Xhg+v
	OiXXbDknqSdSapQhVTiL35fcUoSw/y4RdIXGyNyRIk0K9zShwmSqhBUUNG7egQwkO0lMHld
	E9BP33L8cpWU83bYbmsutBR+nf6CkaP05uv5PBjOR5BjkW3weM+5t2BJC2JCao1Xc/swkdD
	sJp6J0oCrErZqXu11r9P8V5gOQA9c5k0PfIGjy1cuNx8hz276kS/D/qBNhxe1UGIBdeB0bM
	W4QEqTzAcMFONKJ5YD+2LboZ+/QKh5aoHs38Fjl7Jo/X9giWN63Em5ageiRsHOBGz6LA8ZZ
	XmkGy/VB2vOjSOZgjL0jeid8jSXurOWZxsnrN+QNehY35GfxUQFDpFIbDO/C2iSYVkCmdxp
	Ei3PaFvT83SmPAmPgh7iCUTvx/6/BV9xWVDuz8fx611qYbRxu3CC04vefjieFTE3czJf7mr
	fpLpMZgQkilaHS9tLYdalLTWiGpjEF1oNjJmoIwKRQnnk9KessMXPHEZbg3G5pLXbxlbWUR
	3qeUeHnfxo+5JOWnzIRFBhlPPDAJUu+al8zEvk6C6IKvGM4JmgSEcN85VFVOqJBAzmC2eqQ
	FRTydPgXrk2UYrR7uHYQmEmqcVKd8QA5Cpup+qm6KI3JuXsS0T9Aeu20v0X82Zx6f9IlYbM
	ZlhkuM21tRyC54rrl6TL7zoMKRU5QwtVfcUD/xQ6coiA7sSK9Z
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249750-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: 6EA10587DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mem_write(), the temporary array returned by parse_int_array_user() must be released on all error paths. Convert the array variable to use cleanup.h scope-based cleanup so it is freed automatically on return.

This also moves the array declaration next to parse_int_array_user() as required by cleanup.h usage guidelines.

Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned address for debugfs mem write")
Cc: stable@vger.kernel.org
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/platform/x86/intel/vsec_tpmi.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 16fd7aa41f20..e7bc3474c7aa 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -51,6 +51,7 @@
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/cleanup.h>
 #include <linux/intel_tpmi.h>
 #include <linux/intel_vsec.h>
 #include <linux/io.h>
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
 
@@ -522,12 +518,8 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 
 	ret = len;
 
-unlock_mem_write:
 	mutex_unlock(&tpmi_dev_lock);
 
-exit_write:
-	kfree(array);
-
 	return ret;
 }
 
-- 
2.20.1


