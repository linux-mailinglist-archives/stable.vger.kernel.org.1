Return-Path: <stable+bounces-269492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6I+BpXQQGp4iQkAu9opvQ
	(envelope-from <stable+bounces-269492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:43:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A46D35EF
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:43:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chenxiaosong.com header.s=key1 header.b=ZyuThpLu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269492-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269492-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=chenxiaosong.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC62301158F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3C1DF980;
	Sun, 28 Jun 2026 07:43:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249C1632DD
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 07:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782632590; cv=none; b=goj7GfrCkO8xIpy/F9BY2eAtCZli4kE3dw1eWovyuY3B4+pjCJKHeuYEgm7orQWC9YdiyaNK1plvIOD+hGWoabxPD3CiqegK0sXopMLYB7IQ+1B3xEX6A9DfnaBo3MdcgIx4kX/GMu/qsmlqmJnwXIuU5ljFO60jnaAhwink4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782632590; c=relaxed/simple;
	bh=i5CgBVtWKAWoD38X4fXX+bQ6nqvrE/YZp5mGApIHbTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ipe6mAJ3tkUXPMqATetjm2gApeJ+Jbz20nIpZE3TkV9DlwwM3dpvBJRwnBBt9sAeX5IcHANlejcGnirCRGPK0b6R8lELQMxPwT21ldoFPqXVlqu1+f1wqL8qJlWPoRDaFWmLnNIdTk6OoPzUrEr8ndtjn+5YIVGZHSZELWElJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=ZyuThpLu; arc=none smtp.client-ip=95.215.58.174
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1782632584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pjGABgNPVjaNKjIE/S3mwWMX6HndcGe2takmIDDRUzA=;
	b=ZyuThpLuNqgAcuQDt3qUH+ynLTZzD0lalWT52nA0/eMM36j551Ml/cUaHYqDGKW/wwRyhF
	PBI++QxX1UCu+rnPmVLxvG6QxPy3vhdRL/r0MkBUbNZGzu3SC/FFTd8bpE62SDx8LaYKaM
	DPL/MY34rBhkpZ22py+nScIctHN9zLKfassMdau0GHi7xRS+j+oQx7hHzsBoATlQZ/YMcC
	6Jcs9HET3nuJlv7ubzkT6ry6Wv8fZttCEw60Ing0w9MqwGUTrirAeAFvvwBkqebdguH51a
	cRo3C8NLVj+bS/UpXqCmQlwPpB+M6gzfkerCPKhztNNs0g1YuDIxnajN1c4k5g==
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	senozhatsky@chromium.org,
	dhowells@redhat.com,
	metze@samba.org
Cc: linux-cifs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] smb/server: do not require delete access for non-replacing links
Date: Sun, 28 Jun 2026 07:42:43 +0000
Message-ID: <20260628074243.629589-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:senozhatsky@chromium.org,m:dhowells@redhat.com,m:metze@samba.org,m:linux-cifs@vger.kernel.org,m:chenxiaosong@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com,samba.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C8A46D35EF

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Reproducer:

  1. server: systemctl start ksmbd
  2. client: mount -t cifs //${server_ip}/export /mnt
  3. client: touch /mnt/file; ln /mnt/file /mnt/hardlink
  4. client err log: ln: failed to create hard link 'hardlink' => 'file': Permission denied
  5. server err log: ksmbd: no right to delete : 0x80

Fixes: 13f3942f2bf4 ("ksmbd: add per-handle permission check to FILE_LINK_INFORMATION")
Cc: stable@vger.kernel.org
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 727ba86ede36..097f51fc7ed6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6921,16 +6921,18 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_LINK_INFORMATION:
 	{
-		if (!(fp->daccess & FILE_DELETE_LE)) {
-			pr_err("no right to delete : 0x%x\n", fp->daccess);
-			return -EACCES;
-		}
+		struct smb2_file_link_info *file_info;
 
 		if (buf_len < sizeof(struct smb2_file_link_info))
 			return -EMSGSIZE;
 
-		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)buffer,
+		file_info = (struct smb2_file_link_info *)buffer;
+		if (file_info->ReplaceIfExists && !(fp->daccess & FILE_DELETE_LE)) {
+			pr_err("no right to delete : 0x%x\n", fp->daccess);
+			return -EACCES;
+		}
+
+		return smb2_create_link(work, work->tcon->share_conf, file_info,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
-- 
2.54.0


