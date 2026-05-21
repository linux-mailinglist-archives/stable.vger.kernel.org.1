Return-Path: <stable+bounces-253447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABjKMZqEDmrq/AUAu9opvQ
	(envelope-from <stable+bounces-253447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 06:05:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F259EA90
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 06:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F8630492A7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757663815D8;
	Thu, 21 May 2026 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FmHM/DpK"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12841299959;
	Thu, 21 May 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335854; cv=none; b=t0fFK6y+zqK2Ej3MmVZP0rsc+7+Y+WY5jdJah9OtCVT78wuyGeTo8Sx+41OkDiYckP2cQer6hUuCvGYJNLwVhG13wf0tIU1Ctx9G8/KYz/CGoJw9Va1/JebS9LFsYNiR16jK/4j6dHnuFCJF5dFQGpOtPqFLlE8CIjXXjKmX8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335854; c=relaxed/simple;
	bh=98+52IGWd5Qf8IZ2mTEfFJI7GmuSRzZvqiSsWrGaLh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICyZYQEnBwXa2c6yRby0mAJn4wBpJR/6XWRFXRxy0cZHpzKRfrW2WJZM89lSxj85jl9AHq/Fq9TQfnztxfF7Wn+9LwZFbbMZCp6ccIB8B5iw3firyyUPjW0uUZfrQ1QOxpwKbYZvsFBS/SRcixB63fyzoI5oquR7jR1SBNAc1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FmHM/DpK; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779335829;
	bh=u3wKTazTgBgNvPAuaaAg4eK1LY0/c4psmFF5uqZJntg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FmHM/DpK+b5/1SiFwp7G98QwVMftQE5IP+ptFiTOuuWf448/nup5diwJYR79RdwXf
	 v4L+nwkCZNDskzQd0kvsP5phYz/dhtP4TY/k9eodY3zOrBHoWmjO9TKdgQc0jR7E8D
	 T/qc09dNCrtRXCfyMnfijrfsxQrqf568MH4ajIE0=
X-QQ-mid: zesmtpsz8t1779335814t2f54036d
X-QQ-Originating-IP: O6ref007MsoRSWhfz5Tlg0adpccrT1pGxHAL1e7WUdk=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 May 2026 11:56:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10115838044725619944
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
Date: Thu, 21 May 2026 11:56:22 +0800
Message-Id: <20260521035623.1426374-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260521035623.1426374-1-zhaojinming@uniontech.com>
References: <9de7a91f-2dfa-7a99-9580-378c7a044bce@linux.intel.com>
 <20260521035623.1426374-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MWdgP8+gtiFRmRGrNjM6N7VbfxtVzxfdkTC84P4vdbSeiQ3OiwRIqRFn
	OEOTAPOdUa0ZZPtKzALFymROOW8oWPfcm3h8UdnnFhoSeUI0j8tdzPC4SgQwdR2ln7RbT2z
	8W3NxoEpVkbr6v3VrfIU/iDZLGegMZFloYvVKcYI4Gpr1IVnRn33sBnyo+NQiRPxIeABenO
	GPmM8De+D7lEWMrnQZtpfK0WMGht8/udk9eA4+KtecaZMThIWVudh1vGiXVZepOLPXJqyez
	hqu/NbCg2EuYe6C3L4CSx11o0PPzTOfteKEqcT4st068uAF4j4PIg1FTcMeD75bU8zku0hW
	CXR/mIT0oqA9AhW8JHKBGZatBhOkdYLguDq60hDd42efDBIkVLeGt2MjQFgYXSPEB956zjT
	rxlJfFBBo1uf975CxcoIS8ZOxzXMAsshB91S7kZDoasu84cqt/LZbUeyc0NMpliNxf6Jr+9
	aUrCVYAHfn3uPQNKvJJkWnPMhG7o/zRzbn+6a4mIKfGbqdMPgh3pdyYKVPSwV1gkYjIT6VP
	q/0/L3xibB/l4q4gVwN8aG2B++M3csTK5hdQk3NvKNoFHZoy9AAXW7PSikNE6lC7LPM4M16
	4dxVi/CUCAODREvyvuMRMcKaZ3cI/Cf9tRlv8u6pEV8RZ7RlEv2uUHhsw64tXg7zQdu0MIX
	+SpsqRA+W07jQI/TlmieOP15QlYzkWWej1ITT0PQZCA9Ud18BsSicIhe3NvODPTaQyeD4h/
	mA/HEYtIZgN1L8IuX1XGp0m/CcYvORmlP+lB6/hUWjc6QqngrhvOF3PNjYgIChUDWAEM5UC
	7n+BDuvGv73HHS8+XSEjssWv7aW7M5uNnOkw9YLNr1WtJUMr8X6ogOMfU25RcfdR0ZiNsrm
	lYrVolg/8Sm5E9vuKVJDWPBmRY/gRqsDUiGkQEEBRHW+h+SVYVR4nrXa9mB3eV3lbyNJ0LD
	wc7QBkbMVMSmHPB2IruCtZXdD7HebjBCQ7Jwi/t+T5ijYiXBMHt83cQFWAW2mikRqRSb4KV
	WhMFf61lJ4PyNOAIEDEKzNN8BWCK2xthFoMYUHylMw9zcg6G2qPngd9rTg2OI=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
	TAGGED_FROM(0.00)[bounces-253447-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 366F259EA90
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


