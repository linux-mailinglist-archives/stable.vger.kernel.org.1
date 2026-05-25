Return-Path: <stable+bounces-254124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJxDHJgnFGrfKAcAu9opvQ
	(envelope-from <stable+bounces-254124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:42:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F07885C9520
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8908301ECDB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22A8360ED2;
	Mon, 25 May 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kcWUKpGh"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6435DA5D;
	Mon, 25 May 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705712; cv=none; b=drnyaRF9Vmui/duGT5KEzMDSDIjFuhRc2JQqhrv2+tJkjdsO4ITxqFfVa64PemRK3SXv86CbBepm+3SXcS9FFHNb1jzAZbhd32ZwDFtVTw5A5Fqq2+swRp/qlJeOgzSS2xXacI4enoQ88XOCz0h708qP4OrF2B/zOOXyLEpRBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705712; c=relaxed/simple;
	bh=SVtVwZZPOwmM4d6QNcYKT9Iw0MfHNlHQEFrkODkFC2c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TDKiAS98ePbMJVkl+lwU4F3GlasXpnvV7/F6NlNmR/IfOnanv8OGYsPJIQoEr9Yf6uSaFAtC6XWfFoP9G462DRRIZhCadoxSTP3tRuwQjZeb+wZYvOy/WvIemxgCMtcx5cGh1BraP61LFkonvcYuHiVIMfkKGLytLEr79L5QJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=kcWUKpGh; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779705705;
	bh=ZRsGJLsKLuEBJMLjNkF+qNmYusyXWPd4VdS0QO5oZyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kcWUKpGhgsy+u1JdNzUyC4aZAIWq5aFX/kPFCRtCYPH/7yo41CfBupF/ISxGJl4zZ
	 inChaBQmirIUtJZGKW/02UOn/hBHrphooY+NT2q9iMQx85hvzA7biJtwe0hZuB0ctU
	 KApi/HKs4aJH+Q3ybDyPs/Zq6vZO/FUSPmEiT9jA=
Received: from China-team ([183.241.55.175])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A60AAA03; Mon, 25 May 2026 18:41:32 +0800
X-QQ-mid: xmsmtpt1779705692t3u28iuh4
Message-ID: <tencent_149C7F98EE86395AE21AD48F1E4907EB0007@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe60M4C9TS/XvHwBPmBhAg1pdlTa4YO6qbdM4k77BS0q0MIJTsdv
	 Lb7kKaVEvwiR1H3Vrw2EOMtWA1CleRXGBQMnPh/TaMpbVInlXC1JPTWclvlNei34blbzE3YboBbf
	 dm/uKvICb62aqWkMyJnJbAPS0/xRyL03j00dw3zfUuqdFKHlaltjdVEBocoqAHYKJPEJ8Oz3qnnU
	 ir8XhvfIm1B3rii6x1SklEvu3Ztk5lJWV1BqGywIq2Sm7NFQvPSam8fLPDJJFOWq5ge0fO76DOqx
	 dWmzF9wvfnTaFQ8pNfG76JNOV7VlOguJCQmnywkKRNVCZjIGYYnPfBIiTpw0DqNJerJvWZdnSYZv
	 iKywex8a9/qYXLAbL5nEEJADSP3Sx4NjMpSLtPVcCrI7GYyHNJ/E9epfKWWH+oU7yYh+ZTTyK5fD
	 MpLyIXidVTKO0CWJpTxG+c1orgOfVLE6VCmVF2kFWvHQf7+wQtO+yxzyzK9OkvI3HCil5ScRp6Wj
	 G+ZgSG/RevXQVsTUkSWOXkjwZhv6I8meXNDxR3WQGUWhlNiFMK5XrlAxl6mq/eAOF/fRdyTw3Zut
	 hM5Ha6gdmYMG9gkVww9vS7mKd4F1pDAJcvuUscMtbofTmTKvcXzf/CgHlhOxEupYosYJL95LjmXi
	 WHmGgtocD5tlS1Rb851a8jZ7So9GReqsE7XsX7nm9RDKkqw4q2D9AZGifFUNeMtG9yjA+213tO8s
	 NUA0ltsxcemJgsNJA0EoImNlz3PpGTW00BgFujUcMSlV2POQWXLqTbcb3gccYj08AtQpZfIdaVda
	 21Zkrd5055BIVVXjCnN3dKvk+Mi/tR03yrpiMCwfZpSUetnnoiLOA5eVgfnbVVgFWTFu9uaHdMZV
	 eZEwMzF+KUHBqB0oQuLmMY6K023s+lS/2gfG5RMB2+K6BpuyOmaOi+bm4MmdoaY15FEZb/E1mBBM
	 FMgpwoK5tNgEu02AP0f8vAuHG9Si0qSzrareTJuda9mlG2Is7rBEDTEHDjlhmIBgYrwd3jzHZDGy
	 JdpuOoRmoCGcGQEzDKyn+ihZ0mjvmnjlCnvahZ5UeCU1CHXz+pP8RKUmqOgOue8VWeBKBhp1LY2R
	 /oxUiS
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v2 1/3] ksmbd: avoid reclaiming expired durable opens by the client
Date: Mon, 25 May 2026 18:41:28 +0800
X-OQ-MSGID: <20260525104130.1252-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254124-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F07885C9520
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


