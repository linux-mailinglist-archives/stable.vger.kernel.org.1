Return-Path: <stable+bounces-264550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5PPJqZ5MWowkQUAu9opvQ
	(envelope-from <stable+bounces-264550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:28:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA76921BD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:28:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LjWgkeHs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264550-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264550-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF7C531FBEF5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AD46AF02;
	Tue, 16 Jun 2026 16:15:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC204534B3;
	Tue, 16 Jun 2026 16:15:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626515; cv=none; b=EfZS/F6Tyqoqv9l55P9dEqoH4DEddOoFc+9HvlC4pj76LB128tymd2UUDXhKo8cw4exj4z72sAY6QDfmTTqTqGonwdfOvO6oMk8w4t9XlYsTpPNV7S/RFDbVqz7LuZjGSqiJHgKZFSLUQEpnYdusMTln7x1cJffX17dS8JwkNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626515; c=relaxed/simple;
	bh=or2HamKIvaSNkNBV2h7USMBZ9bGUPJXc7xdCGu3YBJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw2TyHPR+THS0t7ydPTp1H9Bu6CTjJW1yBiSarLKy7aMfCmvN3uTV1j6NLPm2EG2oU3qUAcUTYkR5vB0U/Co7Wzl8J/HbQlBY470T8+aVUj21IE1ZX2/2JmeaJstU5o0524hDTUbd3glLBY0RZEA0xB9dvYRbOtzQPu5t6Ouz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LjWgkeHs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736D11F00A3A;
	Tue, 16 Jun 2026 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626514;
	bh=D1RV+aLN3e7pKQppgL/djJhNla/NvQGnmcvkQQGTcbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjWgkeHs4d+MF+qqqQyZNGvwFommtO6Az/oa6mxMIO0d9uc+hldItF50PpxAWejtx
	 ZeGLqSaSetv0Mir6rbKhTWGjTUKrOL0ftmCBZa/p5FSefsV01n8UyRcoSrH+2C/Uf8
	 gw29NpqTVfMgwX8o9MwT0IbRcejXapHyx7QqWE+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gil Portnoy <dddhkts1@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 017/261] ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers
Date: Tue, 16 Jun 2026 20:27:35 +0530
Message-ID: <20260616145045.810341108@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-264550-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dddhkts1@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEFA76921BD

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index a84c01bceb8ba2..6454c7a4baa450 100644
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




