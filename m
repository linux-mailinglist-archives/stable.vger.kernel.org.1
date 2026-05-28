Return-Path: <stable+bounces-256281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ1oLoGrGGpEmAgAu9opvQ
	(envelope-from <stable+bounces-256281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:54:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2209E5F9D49
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283343104F43
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF3328B7B;
	Thu, 28 May 2026 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ra+iV+n3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D13317142;
	Thu, 28 May 2026 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001260; cv=none; b=P8/a/EUyfyvr+PElTbtc7XmXF58dTJ/Uy87W8KarQLxe5UHKWaldOUGTpNsLzer9YLrPJ1BkQsTXRtz07axOkFvN14OeIX8dtHPNKijs7djWo2DZZYKdW9gaFWaAr+gjsraVUOrw4tYi01Ai3ll45GgAyfRBgTVJ2WtjWyocMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001260; c=relaxed/simple;
	bh=Wo/z59+ULUxEfTpbQH8n1TEcUvnmcnNpPlpc/YnYZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buxfVuJAsopvdie5Q04hZZZ+KaAWEfBkaYpKic+OCeXWc9lqCZwXXIbkGVnfqi6vWWAAtAgZiILHORXKDijFvTRC046mxYLJadHWfmMsb+wTf70viFMaX17qmvF5W40evGQo8JIPk98eib3mAZC6D+kIcMyJJ4v5LAaEosAJMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ra+iV+n3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1493E1F000E9;
	Thu, 28 May 2026 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001259;
	bh=zAo8L/nJ6Bno47UklucIwUJH5hqDh/RLf8TCViMdT9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ra+iV+n3YGteP/ezELlI7c4KmlAHoRrAsmp38w9l8K8QWZBVbJ45+W1tXqqQWg/8/
	 bVYrGrmF6iYPZ7kWGvjuORRkbQflqci90H8CdodUzJdy1vHOAESGV9T7JrET/I1bYZ
	 DyviD2bz4MNdjlLSMDIUw6bECWboKdDG8O3+ap6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huiwen He <hehuiwen@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.6 027/186] smb/server: promote S_DEL_ON_CLS to S_DEL_PENDING when close
Date: Thu, 28 May 2026 21:48:27 +0200
Message-ID: <20260528194929.695123995@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256281-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,chenxiaosong.com:url]
X-Rspamd-Queue-Id: 2209E5F9D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

commit 4ec9c8e023c79f613fe4d5ad8cc737112efb2e44 upstream.

Reproducer:

  1. server: systemctl start ksmbd
  2. client: mount -t cifs //${server_ip}/export /mnt
  3. client: C program: openat(AT_FDCWD, "/mnt", O_RDWR | O_TMPFILE, 0600)

Do not treat `FILE_DELETE_ON_CLOSE_LE` as delete pending while files
remain open.

This patch fixes xfstests generic/004.

Cc: stable@vger.kernel.org
Link: https://chenxiaosong.com/en/smb-xfstests-generic-004.html
Co-developed-by: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Tested-by: Steve French <stfrench@microsoft.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs_cache.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -118,7 +118,7 @@ int ksmbd_query_inode_status(struct dent
 		return ret;
 
 	down_read(&ci->m_lock);
-	if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
+	if (ci->m_flags & S_DEL_PENDING)
 		ret = KSMBD_INODE_STATUS_PENDING_DELETE;
 	else
 		ret = KSMBD_INODE_STATUS_OK;
@@ -134,7 +134,7 @@ bool ksmbd_inode_pending_delete(struct k
 	int ret;
 
 	down_read(&ci->m_lock);
-	ret = (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS));
+	ret = (ci->m_flags & S_DEL_PENDING);
 	up_read(&ci->m_lock);
 
 	return ret;
@@ -302,12 +302,20 @@ static void __ksmbd_inode_close(struct k
 		}
 	}
 
+	down_write(&ci->m_lock);
+	/* Promote S_DEL_ON_CLS to S_DEL_PENDING when close */
+	if (ci->m_flags & S_DEL_ON_CLS) {
+		ci->m_flags &= ~S_DEL_ON_CLS;
+		ci->m_flags |= S_DEL_PENDING;
+	}
+	up_write(&ci->m_lock);
+
 	if (atomic_dec_and_test(&ci->m_count)) {
 		bool do_unlink = false;
 
 		down_write(&ci->m_lock);
-		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
-			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
+		if (ci->m_flags & S_DEL_PENDING) {
+			ci->m_flags &= ~S_DEL_PENDING;
 			do_unlink = true;
 		}
 		up_write(&ci->m_lock);



