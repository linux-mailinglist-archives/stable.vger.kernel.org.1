Return-Path: <stable+bounces-274310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gX0KA7pMVmo63AAAu9opvQ
	(envelope-from <stable+bounces-274310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:50:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC70756117
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:50:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mE1+nLSJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274310-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274310-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA11430059BB
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A025481FAF;
	Tue, 14 Jul 2026 14:50:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8B48C3F9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:50:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040630; cv=none; b=EyQMUKlszBLqmxw/TlyfES0kds+pVjgBrr+sPMnYNgJCBQXs0FtPs+mpwoyvGx6rHv6GbaGLcLhWDvqEnsIusKhQakC8I+L2GJ64KajnLQHszX2sUZ9ECugoJbf4kxjXwxhu9Mx4ey6VQgrmLZuNwAaRoW/akOZl9hgQ8KV5c4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040630; c=relaxed/simple;
	bh=3s/c7515yZXab2h7sU7pR//1NrY5X8DLAtNr7V3V/k8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=taqWTXYN/Tm8ePNRhcRVMZukJFLg1Zf2wPbRMFIWr7eIs30L2HtCdsQhPZOOIvTd7wfWkZ3HUi6mVdJlQwONsRzHIOOtj9gP/SMq6HY+WW6DUotFhJgDZYku75lNkHie7YvVuZMdxZ/pa/ut2ymp2q8W6yGQaJ9WDALz+7mhzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mE1+nLSJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C61F000E9;
	Tue, 14 Jul 2026 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040622;
	bh=NIQvyM48JZKQdHcNmAI8pFGpGTn/ZzVDTLYLib+5QTM=;
	h=Subject:To:Cc:From:Date;
	b=mE1+nLSJMB1pLEUY9kiuqTZFf9rFtRxD3P0SNizkBKZC1Je0YqsRpLCiwdMPG8TOl
	 UprTjB0oEfnJYCSuKieLdPvICAW3YNF5WTQn/gthKgfjSdRM9T2miY/xaJcfVZcco2
	 SPxKn0VchsL3hRPii8sYgc6PtcjE2t5KhwCxyPXI=
Subject: FAILED: patch "[PATCH] smb/server: do not require delete access for non-replacing" failed to apply to 6.18-stable tree
To: chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:47:08 +0200
Message-ID: <2026071408-album-feel-56ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274310-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:chenxiaosong@kylinos.cn,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,vger.kernel.org:from_smtp,kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EC70756117


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 851ed9e09639e0daf79a506ce26097b296ed5518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071408-album-feel-56ee@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 851ed9e09639e0daf79a506ce26097b296ed5518 Mon Sep 17 00:00:00 2001
From: ChenXiaoSong <chenxiaosong@kylinos.cn>
Date: Sun, 28 Jun 2026 07:42:43 +0000
Subject: [PATCH] smb/server: do not require delete access for non-replacing
 links

Reproducer:

  1. server: systemctl start ksmbd
  2. client: mount -t cifs //${server_ip}/export /mnt
  3. client: touch /mnt/file; ln /mnt/file /mnt/hardlink
  4. client err log: ln: failed to create hard link 'hardlink' =>
     'file': Permission denied
  5. server err log: ksmbd: no right to delete : 0x80

Fixes: 13f3942f2bf4 ("ksmbd: add per-handle permission check to FILE_LINK_INFORMATION")
Cc: stable@vger.kernel.org
Reported-by: Steve French <stfrench@microsoft.com>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

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


