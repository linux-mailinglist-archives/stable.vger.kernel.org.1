Return-Path: <stable+bounces-264830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i++bEaV+MWpLkwUAu9opvQ
	(envelope-from <stable+bounces-264830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:49:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9856927C3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:49:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="r3jS/3bG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264830-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264830-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127D530759A6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488546AF3C;
	Tue, 16 Jun 2026 16:41:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006947799B;
	Tue, 16 Jun 2026 16:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628113; cv=none; b=QEr5IVjpgIUK6QBSxDA8s5PjObZ0Si2nytP99MmJ6UQFaGagRgYzC0XcIn92m/mz2QLiD9CYlC3PKWshL/InnJ5LTK42/NPpvTV5OujqCksJlZ3YH4h1oivQbJBZgOvrzflZaizVRBFWwDjXCMYChvY7RN7teHwcuas0IsWT5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628113; c=relaxed/simple;
	bh=OwWmUw5lTLcSLpq0SQlZU4+dQc3MtkFR0eiSGmP4ops=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZVXM/n8oyt04tM4yh1laPwl4MIhJuuxuTUpW/YRm/Vl3LfVLMvW1Sm+h+c/M/z/zocLoCXw3WnFzHq+ctRcCyPhJXJ/ZY/dOehlJopnwzinfy7JVl2cQjoIeTL2khrNCzoIU/wBy8bJPb+wKqx8we6LEgmLDwEbS68MapVpDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3jS/3bG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27971F000E9;
	Tue, 16 Jun 2026 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628112;
	bh=M9qLHsuP217t9rEB+IrybvtTCFq8aaVYXGoq9FKzvI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r3jS/3bGf5bhPSsZwbmju9fSsRfWsJXHDccQbvuQF1efVFBHvXR1A8/efsOuDUmY0
	 eYl8TzsIhmF02xTVR/80UFB4f58zjiQEu6yuXVOV5LI9XGfWdoQYM3+heKXfp5Z8Tk
	 7J1h3zoPx/Cy6uxPQGPNEjHh+YaOP/nQQ5v/2quM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Steve French <smfrench@gmail.com>,
	Sean Shen <grayhat@foxmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 033/452] ksmbd: fix FSCTL permission bypass by adding a permission check for FSCTL_SET_SPARSE
Date: Tue, 16 Jun 2026 20:24:20 +0530
Message-ID: <20260616145119.661676678@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,foxmail.com,microsoft.com];
	TAGGED_FROM(0.00)[bounces-264830-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:linkinjeon@kernel.org,m:sergey.senozhatsky@gmail.com,m:smfrench@gmail.com,m:grayhat@foxmail.com,m:stfrench@microsoft.com,m:sashal@kernel.org,m:sergeysenozhatsky@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,foxmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB9856927C3

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Shen <grayhat@foxmail.com>

[ Upstream commit cc57232cae23c0df91b4a59d0f519141ce9b5b02 ]

FSCTL_SET_SPARSE in fsctl_set_sparse() modifies the file's sparse
attribute and saves it through xattr without any permission checks.

This exposes two issues:

1) A client on a read-only share can change the sparse attribute
   on files it opened, even though the share is read-only.
   Other FSCTL write operations already check
   test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE),
   but FSCTL_SET_SPARSE does not.

2) Even on writable shares, clients without FILE_WRITE_DATA or
   FILE_WRITE_ATTRIBUTES access should not modify the sparse
   attribute. Similar handle-level checks exist in other functions
   but are missing here.

Add both share-level writable check and per-handle access check.
Use goto out on error to avoid leaking file references.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steve French <smfrench@gmail.com>
Signed-off-by: Sean Shen <grayhat@foxmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 04d4a784deaf98..97b03f76741ef2 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8067,9 +8067,20 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	int ret = 0;
 	__le32 old_fattr;
 
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		return -EACCES;
+	}
+
 	fp = ksmbd_lookup_fd_fast(work, id);
 	if (!fp)
 		return -ENOENT;
+
+	if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_WRITE_ATTRIBUTES_LE))) {
+		ret = -EACCES;
+		goto out;
+	}
+
 	idmap = file_mnt_idmap(fp->filp);
 
 	old_fattr = fp->f_ci->m_fattr;
-- 
2.53.0




