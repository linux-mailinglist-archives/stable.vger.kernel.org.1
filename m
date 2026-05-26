Return-Path: <stable+bounces-254265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHunLoRTFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:02:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 392885D22F0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C646303C020
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF23CC7FE;
	Tue, 26 May 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZlljLakO"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B113CC7FD;
	Tue, 26 May 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782353; cv=none; b=rm5is+Aqu0K4cuSSzSNZwhL0+pFAeSpBRJXkbHlx9Pa50MyG/GuvDj1R93ULvNOWCdY1/7Xr90rfvTCUtFtGtX5ZureFHYMHREsnXkWuVFzqOBekE1/TAVC6tEdZLrvAHFHmStgU/6NX7x4gjpU6qO0NGoUcmYcmlRS3MkCWgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782353; c=relaxed/simple;
	bh=SVtVwZZPOwmM4d6QNcYKT9Iw0MfHNlHQEFrkODkFC2c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ikvuvmdPexovjfdoWSRMhln06aqCUZmXmGe+f1g1TrmWwQERFSy6TN+0n7GZL6iHiHS4IxG/hQIctEVh8ukFIM3GxLe49k1jh+gWW6h6LayP3kRNCoCYotOIbXriYHVwoBF0JRXYQCLvnJaZF35Oc4TzLCChdTG18X6DLBanrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZlljLakO; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779782342;
	bh=ZRsGJLsKLuEBJMLjNkF+qNmYusyXWPd4VdS0QO5oZyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZlljLakOXkI3A6w9BBWxXqZ7gxgma79fk3ocXZFrGNWXWb7eALf4IO9y0zHhi4X22
	 J1WKnyv+U3WtnHcJprVV5U3LPUtYP6zh5tl8GxCXnPhmFOrSpDGQ3OVAj8xlor+oxk
	 nqxp3TFuM1Esj4qhh01n4QHjNIckbr8xdWKmeoVw=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id EB912EE0; Tue, 26 May 2026 15:58:57 +0800
X-QQ-mid: xmsmtpt1779782337t2cxcopso
Message-ID: <tencent_BBF2D52C7CD44B325AEFE16CC12C3444D00A@qq.com>
X-QQ-XMAILINFO: Mna2+20dcVhjBSqYktAdnq/d8DcpaMpJkiN7FbQTGrZkLXt1zs9j1Cm2DUGQTQ
	 TsHoMWVGwa2sQKOeeE37WqwH/sElLNKFv16imDnkk9StB8vwx7PBLbzISHLrk2ZhLWHrq37FwPc6
	 9GgVlBmelQRPE0UkXDyscHPu7q6zTL9jN3wGjEOvhFOA7L3nigBab+8iCgHaWrQwTeFgrDBdk19R
	 aNi4LueXcab8ajMuT0/L+7zGLeDovxAILj4CpbDGOXfuiNv29Gd/EsSIOLYCIFC/OvSC/jp/8SeJ
	 nOW4ji7JNBrT4OPqCh3Ww5oahzfpLOATpWcbDpr3ByK3r82NzwwZbZauxqhhB3ADVSQ4M/rjBjDL
	 3N1gFWPRdLULZgyd99/HENvyqltotQmkZ6OebMeLKP+xlXu3rk3DnUVIWqjtvnt7od3p9Ub3SbHb
	 VUCqlCNGlamkubQ+hPleR5DEHzrSU9B93USBkrCSRr0i2iBmx+YEXsHtjY0/QkDBAyWlhoJaQJlo
	 t3KRmljo6G9RXcKP2GbJWfU6GO6xJT1TsIsD03D28BNiwXgQgjL72DxxqDybJg1bxLysR1s7umH/
	 q7PA5KbZTPIH1nJIVOoDkxoWryKWSD1IO4P2ty7xJCdmrldgfDl0d+FYSUEPVApKGOv1mwr3Gn8S
	 ppL/atEVeP6IXY19ZjydEUG4RXnw0rixIwoRggln8LGA9V/MdisI706unpyM/cxQRv9x6dCP7tBn
	 r2+goBD63dpCb3MuxCDgSdAiKTt9EDOPc2N8LYqH1iVnBjwHztY+1Rfj8Voy7vgSLF+goz37MQtI
	 mPgG0GSmgVziEnluEKgqf+yxNeY/4VUAPw0EkJK3h8bQaMRolslBKIKrrRTGOCs2QhYofN0RB17E
	 NSx9ZZF80i2SpELag3dZXYCnhyYzUoa2JHVFNHSiOclGJvcIX7utPneqH+mXAjpun/tXWR5bb9it
	 nwWSaC9hDXBXDjUe9x4qooXROzH4Q+ueax4tE6V6kRmMQ46jPYCoUmMbyddQeklSbwP6+DN5xAM4
	 hNgdvGQ7BjOKNiJidGsKZCTPSedIdcSDWdsm71esuVElI1lufPYSs0BgEaJiJBq8af633nt2EFyH
	 Rs3D7H
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	charsyam@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v3 1/4] ksmbd: avoid reclaiming expired durable opens by the client
Date: Tue, 26 May 2026 15:58:39 +0800
X-OQ-MSGID: <20260526075843.50277-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
References: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254265-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: 392885D22F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 520da3c488c5bb177871634e713eb8a106082e6b ]

The expired durable opens should not be reclaimed by client.
This patch add ->durable_scavenger_timeout to fp and check it in
ksmbd_lookup_durable_fd().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/smb/server/vfs_cache.c | 9 ++++++++-
 fs/smb/server/vfs_cache.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index eacc6ef41db0..729758697c12 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -515,7 +515,10 @@ struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
 	struct ksmbd_file *fp;
 
 	fp = __ksmbd_lookup_fd(&global_ft, id);
-	if (fp && fp->conn) {
+	if (fp && (fp->conn ||
+		   (fp->durable_scavenger_timeout &&
+		    (fp->durable_scavenger_timeout <
+		     jiffies_to_msecs(jiffies))))) {
 		ksmbd_put_durable_fd(fp);
 		fp = NULL;
 	}
@@ -784,6 +787,10 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	fp->tcon = NULL;
 	fp->volatile_id = KSMBD_NO_FID;
 
+	if (fp->durable_timeout)
+		fp->durable_scavenger_timeout =
+			jiffies_to_msecs(jiffies) + fp->durable_timeout;
+
 	return true;
 }
 
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 5a225e7055f1..f2ab1514e81a 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -101,6 +101,7 @@ struct ksmbd_file {
 	struct list_head		lock_list;
 
 	int				durable_timeout;
+	int				durable_scavenger_timeout;
 
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
-- 
2.43.0


