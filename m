Return-Path: <stable+bounces-222299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLnbNHuuo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:11:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEC1CE4E7
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895FD3317CCA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573602F39BE;
	Sun,  1 Mar 2026 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1C+GhSW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B3190664;
	Sun,  1 Mar 2026 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330535; cv=none; b=l6nw9zeUi+wFzxWeacp4rAlnnvSe1eyO4ofqyXbgWrzLAawXVn5BJyjgYDq9RdW/ozp4Tqp0Qt6WOiaDI6OldwN8rH65JkPNdJxYNcAYVJRTGUuDwGuQYs3DHXx1tJyUbBtfs47sXgmBuF7Qw21E7k8FIA0ksh4eaBJdA4K+m2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330535; c=relaxed/simple;
	bh=4W67TqiKqOnHsF7qM5sxmMJNKQYX13SqkCgGB21UZ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpRcIO0zmp6lrA69sg4ucU+wewbinr7a9rOrqLhSN3EbUyoUwhi0+Qb+tH5f77+qiNKyXL7D8Pp8uXBGn7trBFUn2gqbd6VCzHXp/9q45kbhSEGKOGx24XssVnCnGaVDUxn8NYLsOAkr/+z2Nr30PiSxGXy+OutXK5cOrw5Jy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1C+GhSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E489AC19425;
	Sun,  1 Mar 2026 02:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330534;
	bh=4W67TqiKqOnHsF7qM5sxmMJNKQYX13SqkCgGB21UZ7I=;
	h=From:To:Cc:Subject:Date:From;
	b=N1C+GhSWr3gYIuJavBjSLrwdQwuWOCdiVAfOH46yCjcR65VI4Ciu0/F2k7RsWdtwz
	 Djfi7ZAGlCTUOEnHMEVk1FB0BBVsk1jI1uK4SBZ57C87pGka+nP7ZAp3yGFetxQ1QH
	 0SuzSeULDcgrpzEwAH1wAuymyW9eLkoSyQWkBAqp5j0gWGDvq5NxnWCPdzFLsUcY4q
	 xkIelbvpbtau49S0B51OQmW0VmzrAE9NsKqDokcDQbaCF1L7GMVw4ZhAXR4jU0D7MR
	 KXuHVH9CbwQ8McBk6hRxCcsgZwKvOyxl/9IgMN+LvmwVda08SWZKgFfQqaQQJUQ9ry
	 IpvphiPajvdXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	harshit.m.mogalapalli@oracle.com
Cc: Mimi Zohar <zohar@linux.ibm.com>,
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
	devicetree@vger.kernel.org
Subject: FAILED: Patch "of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:02:11 -0500
Message-ID: <20260301020211.1729707-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,amazon.com,kernel.org,redhat.com,alien8.de,gmail.com,oracle.com,zytor.com,suse.cz,fb.com,intel.com,linutronix.de,linux-foundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-222299-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51BEC1CE4E7
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4d02233235ed0450de9c10fcdcf3484e3c9401ce Mon Sep 17 00:00:00 2001
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date: Tue, 30 Dec 2025 22:16:08 -0800
Subject: [PATCH] of/kexec: refactor ima_get_kexec_buffer() to use
 ima_validate_range()

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
---
 drivers/of/kexec.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 1ee2d31816aeb..c4cf3552c0183 100644
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
2.51.0





