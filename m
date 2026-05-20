Return-Path: <stable+bounces-253199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B8DAS0ODmqe5wUAu9opvQ
	(envelope-from <stable+bounces-253199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:40:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D07598948
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D5E831F4A1E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD98409601;
	Wed, 20 May 2026 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ADpxIiK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85CD409116;
	Wed, 20 May 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302660; cv=none; b=KnFLwEvdMcC+eLyJumbZ1Va4zWXWRSCtI/+TZAWG1HZ1N12T7lSI/rUeAK8Vr7xtrOHxJotRYbx/Cr7Qnnl9DHFGcLxWwDCyLETlngAT4dQsxi18uIGBKWl1DANhMWkzeY4KodfWS/qb4XBa/gYtx5c0FFvdvNXvHGWUxPwhN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302660; c=relaxed/simple;
	bh=WlRT7YoI8bfdOkPL+L3LGtr2cJ3a7059tN7TpKGFiks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2NYal1fQtYKliVDgnEL0cNATMXxv+rknEKDum23yGofobR+XpEvufyBsM79YMkMje9ioTi5XMWvjWkB34wJBGnzMvUBVHDqpO+2DcW9xdyce9NcUL9FKT6QawV5EdJq2v4E61gLBlmm7Iz4EJO26/9UlhmoE4I20OH3nQiSpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ADpxIiK0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61E41F000E9;
	Wed, 20 May 2026 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302659;
	bh=t03AgFH47eWJ6Fc026Ey3mNR5DGzNrLd2xQrjeP2aEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADpxIiK0vC3pAv0kOuTl95yoSGOSv+UDj8Hj4V4K2iFeGYbDyFt1gNZ56LXW38ped
	 Gk4tB2eYccoqoAjLcoruUHsLh2N1sUEPH+iMtFKmgXz6uu22dbzoIxyRH0y0gTzNZ3
	 9mxwxyufcTIgOjyHScS2GRjlFFDvG+BEJwbZ3vD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 344/508] ksmbd: scope conn->binding slowpath to bound sessions only
Date: Wed, 20 May 2026 18:22:47 +0200
Message-ID: <20260520162106.087136445@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-253199-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07D07598948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit b0da97c034b6107d14e537e212d4ce8b22109a58 ]

When the binding SESSION_SETUP sets conn->binding = true, the flag stays
set after the call so that the global session lookup in
ksmbd_session_lookup_all() can find the session, which was not added to
conn->sessions. Because the flag is connection-wide, the global lookup
path will also resolve any other session by id if asked.

Tighten the global lookup so that the returned session must have this
connection registered in its channel xarray (sess->ksmbd_chann_list).
The channel entry is installed by the existing binding_session path in
ntlm_authenticate()/krb5_authenticate() when a SESSION_SETUP completes
successfully, so this condition is a strict equivalent of "this
connection has been accepted as a channel of this session". Connections
that have not bound to a given session cannot reach it via the global
table.

The existing conn->binding gate for entering the slowpath is preserved
so that non-binding connections keep the fast-path-only behavior, and
the session->state check is unchanged.

Fixes: f5a544e3bab7 ("ksmbd: add support for SMB3 multichannel")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/user_session.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index d0a13a5cccece..6c7fbd589087e 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -323,8 +323,13 @@ struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
 	struct ksmbd_session *sess;
 
 	sess = ksmbd_session_lookup(conn, id);
-	if (!sess && conn->binding)
+	if (!sess && conn->binding) {
 		sess = ksmbd_session_lookup_slowpath(id);
+		if (sess && !xa_load(&sess->ksmbd_chann_list, (long)conn)) {
+			ksmbd_user_session_put(sess);
+			sess = NULL;
+		}
+	}
 	if (sess && sess->state != SMB2_SESSION_VALID) {
 		ksmbd_user_session_put(sess);
 		sess = NULL;
-- 
2.53.0




