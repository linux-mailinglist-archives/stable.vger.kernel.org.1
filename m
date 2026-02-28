Return-Path: <stable+bounces-220778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB7RHdNWo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:57:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761351C8A5F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D46613389968
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD3409F10;
	Sat, 28 Feb 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlZkXaf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990B409F0B;
	Sat, 28 Feb 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300660; cv=none; b=kwnMMKacIZdUppw/22rwxLZCURYTMUNj3dD1Hag/sRt1oMmYuh+KXx6SbJqPiIPKmGKfrcVjnwnl6XI7jRqg55O/zJ+MB9EA//F+fHkbNQ0i8GYcihfGFFHj1FQSmSoikDbPF/K4sof8gNHkmzkh6QguHqvZJDtAd8EYPA+Iins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300660; c=relaxed/simple;
	bh=hynepgpAQS62ggttobeYcs2o4UAKAYMz2B4KjnrM9KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7G5O+nAi2UFYlr8O0gQ7Z+jwssJU511GMi5LWzVwtIM93juXZgmDIwiPWI1fg3fen4nJ2d/I6UWNKvPligpd+vyCkB8l0fdm2cUNG+rZwUe8lrITZeYXnPwFmfegGRgdJ7veRGSKrTChuKhp3USs4ppVLkvbDFzqZ3Hs9Sy55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlZkXaf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435E1C116D0;
	Sat, 28 Feb 2026 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300660;
	bh=hynepgpAQS62ggttobeYcs2o4UAKAYMz2B4KjnrM9KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlZkXaf7mKTJL6Zn/WVr+4AcSLnCKi/tHcUHxlcgt1ykv8I4gUBn/qVntJg2yLlAv
	 tVA+XiYGr8y74NM1Ph9GM9cf/seLh8/Mw/YzYEZo6JokHYO2eOnfuCduG3tYVrdmI0
	 Sft7tmHW6ZcMIfM8iwowFOhhvvkX30ows3n5hSShrGADlJTEEq5PN0bxEyir+23vns
	 fcSSVAnhQhtA/LgwUDTSSw/4INf0OD4z0mkAulQS0jhw9dMCiBAsRl57KBMBEl1ujj
	 2+X4kPyzU/r9uC/0/acr+hT52B3CynKilx+SQc6KLmj2UjkFtdaM4DYizU1Bcn4j4i
	 yTolKFdimR+Ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
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
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 699/844] of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
Date: Sat, 28 Feb 2026 12:30:12 -0500
Message-ID: <20260228173244.1509663-700-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.ibm.com,amazon.com,kernel.org,redhat.com,alien8.de,gmail.com,zytor.com,suse.cz,fb.com,intel.com,linutronix.de,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-220778-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 761351C8A5F
X-Rspamd-Action: no action

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


