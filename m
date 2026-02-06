Return-Path: <stable+bounces-214594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKn+LN1uhWnqBQQAu9opvQ
	(envelope-from <stable+bounces-214594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 05:32:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B6FA1AD
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 05:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFEFA300DF4A
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 04:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C21335BB4;
	Fri,  6 Feb 2026 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mSAH2xIy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C1338F40;
	Fri,  6 Feb 2026 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770352334; cv=none; b=M0jpC86fAi5Nf6KSbSdJ5d2MC8Ah2RIXFqMpBtHEUM0ffELZaMyGCmggeyWtYGA/uPiYtOORPvRuyX3CuqRK4YORh4ymzUfzcES/Jz7P3kC5n0D1q6xvI1EOpK0hJMdNzXVYQsCrbdPUfEqhkkyN8KQjJb6szLV2LetV+uB489g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770352334; c=relaxed/simple;
	bh=BbOOS0pWroSW/3/E5wqcJrdhWdMAyw+4cG24+VR43aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZqni5RWa5joyfuHd5w9XOImG/wqxsXka1mtwXZJVks6Pit37JRokfpxuMI72YpxK94px52Fn64SsK16MqbeHV7V9v9IN9qv6tjsxl+BmCnWN7ONlek4CWAepjE4LVH4wZ7pO0q42J2FWwK6xV1EVN+e4Mc93gIcrwpf/Rwmw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mSAH2xIy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qr
	3LVoOJqpEYjoT7a1xDOpnKMJ8q6Fi6UAoB055FyKQ=; b=mSAH2xIywMiN4NWJgL
	oOlitNnqti8W2haqwcBKXPNlMx1EiG7SwjW2jaRZuCxYTK/j/a5sd3GunkLRLm/o
	NBSx4t38ylHfmq1ihvSmVXS7ELxqMcQwF15NHKXOx5w8jVxh1SBI9/C0bODLhaGK
	fNdM0czovFKpu2KxaSMOyUe5U=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3sLWbboVpASh5QQ--.27597S3;
	Fri, 06 Feb 2026 12:31:27 +0800 (CST)
From: ranxiaokai627@163.com
To: graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	stable@vger.kernel.org
Subject: [PATCH -next 1/2] kho: fix missing early_memunmap() call in kho_populate()
Date: Fri,  6 Feb 2026 04:31:20 +0000
Message-ID: <20260206043121.197564-2-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206043121.197564-1-ranxiaokai627@163.com>
References: <20260206043121.197564-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3sLWbboVpASh5QQ--.27597S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4fAF1rGw1xtw18WFWktFb_yoW8WF4fpr
	yrG3WxCw48Jayqqa17J3WxW34rW3ykK3W3ta4jk34fAFnxXr1kuFWxX3WIyF12qFySgw12
	yFs5tayrW3WkCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zErcTPUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7R9+ymmFbp-e1AAA3R
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kvack.org,vger.kernel.org,zte.com.cn,163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214594-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D4B6FA1AD
X-Rspamd-Action: no action

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

kho_populate() returns without calling early_memunmap() on success
path, this will cause early ioremap virtual address space leak.

Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---

b50634c5e84a ("kho: cleanup error handling in kho_populate()")
has not landed in upstream, so
Cc: <stable@vger.kernel.org> is unnecessary?

 kernel/liveupdate/kexec_handover.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index fb3a7b67676e..76b714db175d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1463,6 +1463,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	struct kho_scratch *scratch = NULL;
 	phys_addr_t mem_map_phys;
 	void *fdt = NULL;
+	int populated = 0;
 	int err;
 
 	/* Validate the input FDT */
@@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.scratch_phys = scratch_phys;
 	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data.\n");
 
-	return;
+	populated = 1;
+	pr_info("found kexec handover data.\n");
 
 err_unmap_scratch:
 	early_memunmap(scratch, scratch_len);
 err_unmap_fdt:
 	early_memunmap(fdt, fdt_len);
 err_report:
-	pr_warn("disabling KHO revival\n");
+	if (!populated)
+		pr_warn("disabling KHO revival\n");
 }
 
 /* Helper functions for kexec_file_load */
-- 
2.25.1



