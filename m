Return-Path: <stable+bounces-265019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DjnIIxyBMWp0lAUAu9opvQ
	(envelope-from <stable+bounces-265019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:00:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57581692A52
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="v/snFwsc";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265019-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265019-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16518302C2FA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A97466B4B;
	Tue, 16 Jun 2026 16:57:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388431328E;
	Tue, 16 Jun 2026 16:57:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629069; cv=none; b=k60aDfG3K9Tc9Q8mq1sg3VBKUYJvnMt0bjwmbpPlHTX5WLQNv8VA1/jy9Whu5W0cZFgTXKcZ2zSbQjTm5D7CBZ/bFqlG33B2eXO4/uUJYJ4L2RKoPIG2KvcaLWYUZCGPjTwwGvq8HRtsbcDjRF1gncy/3ZLKBbVrqupgg9FxACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629069; c=relaxed/simple;
	bh=PbJuk+FFMVxuUflrGXw5rwLguWcxDM2aRxQi74vwtYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr5XV0KVnl6O0/BdCuWJ3xNuv1QUNjDdufdNbZfSoBk7DyuGA3c6XhA2Zb+pDDvGVzRktwIxnGmXKBWmqzW3jh14cY6MyfwcvWHVkiOhtpEszJBWXb4tnBfvdeg3PGWeJzEMJ3ZLhtYFWCmCv77/MWUUYds78AtuVTVFm8h3w5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/snFwsc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A131F000E9;
	Tue, 16 Jun 2026 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629068;
	bh=AvPl+v6o3Asd8DnkWADI9+FcZjVZu1VhurFIzJlTkIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v/snFwsc1M98IbJpDhEh3ZLbnOynssa/rcrjjRZbly0Z4SYxgwwR/5aAwORlX9XE2
	 7lFaDuk7r6uVXCB17IXTKGa/uKBLqoo9vkh9WMsWqZSL0RuANK+IGr4BIWJZMDWn7b
	 NhXNa8LgFMpC3nY6n8mxjXwoXg3yE1xh1NUjGRJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gil Portnoy <dddhkts1@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 214/452] ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers
Date: Tue, 16 Jun 2026 20:27:21 +0530
Message-ID: <20260616145129.037375824@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-265019-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dddhkts1@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57581692A52

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gil Portnoy <dddhkts1@gmail.com>

[ Upstream commit b003086d76968298f22e7cf62239833b5a3a06b1 ]

smb2_oplock_break_noti() and smb2_lease_break_noti() read opinfo->conn
into a local with neither READ_ONCE() nor a NULL check.  Both run from
oplock_break() after opinfo_get_list() has dropped ci->m_lock, so a
concurrent SMB2 LOGOFF (session_fd_check()) can set op->conn = NULL
under ci->m_lock within that window.  ksmbd_conn_r_count_inc(conn) then
writes through NULL at offset 0xc4 -- a remotely triggerable oops.

Guard both reads the way compare_guid_key() already does: read
opinfo->conn with READ_ONCE() and return early if it is NULL, before
allocating the work struct so nothing leaks.  A NULL conn means the
client is gone and the break is moot, so return 0; oplock_break() treats
that as success and runs the normal teardown.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Assisted-by: Henry (Claude):claude-opus-4
Signed-off-by: Gil Portnoy <dddhkts1@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/oplock.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 5302c30a4a91d7..bba17ea84023e2 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -714,11 +714,16 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
  */
 static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 {
-	struct ksmbd_conn *conn = opinfo->conn;
+	struct ksmbd_conn *conn;
 	struct oplock_break_info *br_info;
 	int ret = 0;
-	struct ksmbd_work *work = ksmbd_alloc_work_struct();
+	struct ksmbd_work *work;
+
+	conn = READ_ONCE(opinfo->conn);
+	if (!conn)
+		return 0;
 
+	work = ksmbd_alloc_work_struct();
 	if (!work)
 		return -ENOMEM;
 
@@ -818,11 +823,15 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
  */
 static int smb2_lease_break_noti(struct oplock_info *opinfo)
 {
-	struct ksmbd_conn *conn = opinfo->conn;
+	struct ksmbd_conn *conn;
 	struct ksmbd_work *work;
 	struct lease_break_info *br_info;
 	struct lease *lease = opinfo->o_lease;
 
+	conn = READ_ONCE(opinfo->conn);
+	if (!conn)
+		return 0;
+
 	work = ksmbd_alloc_work_struct();
 	if (!work)
 		return -ENOMEM;
-- 
2.53.0




