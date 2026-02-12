Return-Path: <stable+bounces-215915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNjjKaF1jWnN2wAAu9opvQ
	(envelope-from <stable+bounces-215915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:39:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7112ACAD
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 360E83067764
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762F2296BD2;
	Thu, 12 Feb 2026 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="CPrBsPfL"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46319CC14
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770878364; cv=none; b=ruEsh7RGHrG1LNVKxPiyyFz+TjT1kTuSDAJAzP+9kE4FH21EbtW57RBUpuCYhPqucvxgq0w7IdkbHnNTvBCPNROzfNd6riiNTAi/T+tjTGPktaNwERrS+4wg1k0vvfjGPTPcDSp6vrPVzDR8Sjk0Hl3Vc8ar1o6NffPC3rdzUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770878364; c=relaxed/simple;
	bh=O34gZIYg49kZyNPTCzXcE+jPWhdJA8mJFoL0W1Dbogw=;
	h=From:To:Subject:Date:Message-Id; b=Jug36oZwed+2UQUuosx08c2Z50/OKBWbxNDgh2w0e5Nz8gABSEubd824cF+OjjtnB5PFnGrD49N/n2QI/AYw6U9uRqjF/wmwN7d8JKi21MNdNkA0JdTv08rDDSMYi1+6/qHCulbcUC/KffClZu8xpQ1FKh+Oaz1K4pqjwxQQnA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=CPrBsPfL; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CPrBsPfLjaduzZXUZjp1eByIv6Rl7QKWRXtU15MNusDfg3Btn9J7fxfMI21ppJ3cJm3mLh/+JsVrn
	 SC99vzeExEQDStWXEzHPduUVF54JvSOyaccRKH6/d1c+xwN0J2o+YFgo4P1qZFlZOa/whpw/ba9GNg
	 D6hVk+sVOLaUP01s=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.232])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f37698d74d6bad-96254;
	Thu, 12 Feb 2026 14:36:08 +0800 (CST)
X-RM-TRANSID:2f37698d74d6bad-96254
From: Rajani Kantha <681739313@139.com>
To: xueshuai@linux.alibaba.com,
	jarkko@kernel.org,
	Jonathan.Cameron@huawei.com,
	yazen.ghannam@amd.com,
	jane.chu@oracle.com,
	guohanjun@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered
Date: Thu, 12 Feb 2026 14:36:05 +0800
Message-Id: <20260212063605.2284-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215915-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	DKIM_TRACE(0.00)[139.com:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,oracle.com:email,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: 43D7112ACAD
X-Rspamd-Action: no action

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit 79a5ae3c4c5eb7e38e0ebe4d6bf602d296080060 ]

If a synchronous error is detected as a result of user-space process
triggering a 2-bit uncorrected error, the CPU will take a synchronous
error exception such as Synchronous External Abort (SEA) on Arm64. The
kernel will queue a memory_failure() work which poisons the related
page, unmaps the page, and then sends a SIGBUS to the process, so that
a system wide panic can be avoided.

However, no memory_failure() work will be queued when abnormal
synchronous errors occur. These errors can include situations like
invalid PA, unexpected severity, no memory failure config support,
invalid GUID section, etc. In such a case, the user-space process will
trigger SEA again.  This loop can potentially exceed the platform
firmware threshold or even trigger a kernel hard lockup, leading to a
system reboot.

Fix it by performing a force kill if no memory_failure() work is queued
for synchronous errors.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://patch.msgid.link/20250714114212.31660-2-xueshuai@linux.alibaba.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ Using pr_err instead of dev_err due to ghes doesn't have member "dev"]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/acpi/apei/ghes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 03344c273222..9fb86d0c4ff0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -684,6 +684,16 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 	}
 
+	/*
+	 * If no memory failure work is queued for abnormal synchronous
+	 * errors, do a force kill.
+	 */
+	if (sync && !queued) {
+		pr_err(GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
+			current->comm, task_pid_nr(current));
+		force_sig(SIGBUS);
+	}
+
 	return queued;
 }
 
-- 
2.17.1



