Return-Path: <stable+bounces-260080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQHlBPEnIGpfxwAAu9opvQ
	(envelope-from <stable+bounces-260080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 15:11:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BC637EA4
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 15:11:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="n5MGP/SA";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260080-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260080-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0852D3022043
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F774611EE;
	Wed,  3 Jun 2026 13:05:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873E47ECD6;
	Wed,  3 Jun 2026 13:05:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491914; cv=none; b=UkWC0OEoKbck0/vWyJJE7MmAIKr38I3NmboJXyzTc+bZNBpGhTtftCaKJjid5y7z/RKmyWUqzwbhZ1rPNh2mh80i/eWeVEz+lACESKG9DwM8My2DUKbhOTVN5XZU/F/PVRoHKeoulyOAFWL0uOpMxBj24G6o69HGbux7LwdMP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491914; c=relaxed/simple;
	bh=6bvuZId+QHXtI1OBaH2b6nZswD5S7sgg3GTHgV5PfhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEGUg81DhdVNUD4NyZiLk1LsxicbE1epxlf+RXFyOy72hk7MqKN1zghSXmMuYZuShf6bKLwFX7wfgnWVtOfLVdMZXByBbZe05AlFQz2wv1g56D8HOal5hr3Sl6+A8eKdyS3xO1drrjbSki0dILOLUj0YIUsAoK/DN8rrtDa66IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n5MGP/SA; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fC
	e+LnD2voXqPdswcbC3PLctRfD4+jtKyh83rTK/dIc=; b=n5MGP/SAdwiGNZjY4k
	F5Nr5sPizs8I5KZpZOYfPmQvroyiGi3kZ/U4E6iWX68sTTxwRbGPnLRbl34g9X5i
	OUStOc6BC/TIZjxrO5WRJHm5KNaXbrBtDeRSCxof/hEBKz9tCXdh7TP1LOyH/fYY
	oTbKyHdAZ/KyGOXfW/KUdP3nA=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnoqAAJiBqWd71BA--.49866S3;
	Wed, 03 Jun 2026 21:03:10 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Betkov <bp@alien8.de>,
	guoweikang <guoweikang.kernel@gmail.com>,
	Henry Willard <henry.willard@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Jonathan McDowell <noodles@fb.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Webb <paul.x.webb@oracle.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Yifei Liu <yifei.l.liu@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y 2/3] of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
Date: Wed,  3 Jun 2026 21:02:38 +0800
Message-ID: <20260603130239.81400-2-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603130239.81400-1-jetlan9@163.com>
References: <20260603130239.81400-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnoqAAJiBqWd71BA--.49866S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4fZFy8ZrWDXF17KF4rZrb_yoW8Kw4Dpr
	Wakr1xAr1xJw10gw18uFyYkFy5X3WDWryUGa9ru34vkF1rAw1UZrnY9FZ3WFy2yFyrKFW5
	WF4jgw1Sgw40qrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWCJdUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6w4v92ogJg5haQAA3X
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:harshit.m.mogalapalli@oracle.com,m:zohar@linux.ibm.com,m:graf@amazon.com,m:ardb@kernel.org,m:bhe@redhat.com,m:bp@alien8.de,m:guoweikang.kernel@gmail.com,m:henry.willard@oracle.com,m:hpa@zytor.com,m:mingo@redhat.com,m:jbohac@suse.cz,m:joel.granados@kernel.org,m:noodles@fb.com,m:rppt@kernel.org,m:paul.x.webb@oracle.com,m:sohil.mehta@intel.com,m:sourabhjain@linux.ibm.com,m:tglx@linutronix.de,m:yifei.l.liu@oracle.com,m:akpm@linux-foundation.org,m:jetlan9@163.com,m:guoweikangkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-260080-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linux.ibm.com,amazon.com,kernel.org,redhat.com,alien8.de,gmail.com,zytor.com,suse.cz,fb.com,intel.com,linutronix.de,linux-foundation.org,163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E3BC637EA4

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 4d02233235ed0450de9c10fcdcf3484e3c9401ce ]

Refactor the OF/DT ima_get_kexec_buffer() to use a generic helper to
validate the address range.  No functional change intended.

Link: https://lkml.kernel.org/r/20251231061609.907170-3-harshit.m.mogalapalli@oracle.com
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: guoweikang <guoweikang.kernel@gmail.com>
Cc: Henry Willard <henry.willard@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Webb <paul.x.webb@oracle.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yifei Liu <yifei.l.liu@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/of/kexec.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 3b98a57f1f07..23fde2d032e6 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -128,7 +128,6 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
-	unsigned long start_pfn, end_pfn;
 	size_t tmp_size;
 	const void *prop;
 
@@ -144,17 +143,9 @@ int __init ima_get_kexec_buffer(void **addr, size_t *size)
 	if (!tmp_size)
 		return -ENOENT;
 
-	/*
-	 * Calculate the PFNs for the buffer and ensure
-	 * they are with in addressable memory.
-	 */
-	start_pfn = PHYS_PFN(tmp_addr);
-	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
-	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
-		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
-			tmp_addr, tmp_size);
-		return -EINVAL;
-	}
+	ret = ima_validate_range(tmp_addr, tmp_size);
+	if (ret)
+		return ret;
 
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
-- 
2.43.0


