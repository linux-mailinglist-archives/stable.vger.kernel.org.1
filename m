Return-Path: <stable+bounces-245208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAhFCW/XAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:19:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0CB50EC0A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C0F6300599E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448E3E5ED5;
	Mon, 11 May 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rbdLSwzT"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3F3A4520
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505580; cv=none; b=I1PpopmFxXlMRfSHgmHGKB7jCuWbnvrezUVTorNXp1Np+UfjAUfRNd4neLP7EjuTgGdmqvsz1MYSNQCIvvj3Thprs7IADUBg0LtNxu3TlIE9pLamc3wMO0cgPTNcg9JlBbG8PfPNRxgts4UF4zgsIGUAAndWNUjDnW5q7du4iZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505580; c=relaxed/simple;
	bh=tSxu3v1zFVmz1Ow1glgROXhvIIbM5P+KMcZs43VSTrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XhMoVr1pzR3ZjRvZN7YZ8xRb8MLMtRk12ZAessqwCvI+e2hQRNE+CXu3+wJuu6KXgGOTSWkrwFCuB9xPHxLi9wS3EFf/azEUkMu98BkX8GZCg3VsHX8QC3NTbMZRohzMLcOuV1I/yydGcqU7sVOHV0KIdjvU1BB9qKUzkWN630M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rbdLSwzT; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778505575; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qMTukbhOsh4wTjLAvEST29FKEUGQSBkjs6AvGD3bNxM=;
	b=rbdLSwzT5YBlpqy5u7C8hyCrsukO+N3PInV/7t4LMAP43+VG9mn8u5pQI0MNLSv1HGT0mpPMxLl6pzzHIh8wDBICN8MUD0G+/vIjVxL+AWBXw/KdxGxG6KPdIp6041TSkTE6NXQ2wKS1L+5+mlImzOf3qpvB97f/ZwrskVdJoms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X2ka8gr_1778505572;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0X2ka8gr_1778505572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 21:19:35 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: joseph.qi@linux.alibaba.com
Cc: oliver.yang@linux.alibaba.com,
	Ferry Meng <mengferry@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix SID memory leak in set_posix_acl_entries_dacl() on overflow
Date: Mon, 11 May 2026 21:19:31 +0800
Message-Id: <20260511131931.95685-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC0CB50EC0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245208-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[mengferry@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Commit 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16
DACL size overflow") added check_add_overflow() guards that break out
of the ACE-building loops in set_posix_acl_entries_dacl() when the
accumulated DACL size would wrap past 65535.

However, each iteration allocates a struct smb_sid via kmalloc_obj()
at the top of the loop and relies on the kfree(sid) call at the end
of the loop body (the 'pass_same_sid' label in the first loop, and
the explicit kfree at the tail of the second loop) to release it.
The newly introduced 'break' statements bypass those kfree() calls,
leaking the sid buffer every time an overflow is detected.

A malicious or malformed file with enough POSIX ACL entries to trip
the overflow check will leak one or more struct smb_sid allocations
on every request that touches the file's DACL, providing a trivial
kernel memory exhaustion vector.

Free sid before breaking out of the loops to plug the leak.

Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL size overflow")
Cc: stable@vger.kernel.org
Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/smb/server/smbacl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c1d1f34581d6..9161e9d7ed24 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -643,8 +643,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ntace = (struct smb_ace *)((char *)pndace + *size);
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
-		if (check_add_overflow(*size, ace_sz, size))
+		if (check_add_overflow(*size, ace_sz, size)) {
+			kfree(sid);
 			break;
+		}
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -655,8 +657,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 			ntace = (struct smb_ace *)((char *)pndace + *size);
 			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
-			if (check_add_overflow(*size, ace_sz, size))
+			if (check_add_overflow(*size, ace_sz, size)) {
+				kfree(sid);
 				break;
+			}
 			(*num_aces)++;
 			if (pace->e_tag == ACL_USER)
 				ntace->access_req |=
@@ -698,8 +702,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		ntace = (struct smb_ace *)((char *)pndace + *size);
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
-		if (check_add_overflow(*size, ace_sz, size))
+		if (check_add_overflow(*size, ace_sz, size)) {
+			kfree(sid);
 			break;
+		}
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
-- 
2.43.5


