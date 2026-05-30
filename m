Return-Path: <stable+bounces-257656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE0iHHgdG2qV/QgAu9opvQ
	(envelope-from <stable+bounces-257656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6F60F980
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BD9C301EE05
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5F332EA7;
	Sat, 30 May 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rGd0VHRI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE334695;
	Sat, 30 May 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161732; cv=none; b=LCvtxSLbE2sEYH1rWpyrBLs6edMtX3TaVEJ4zLI9C72mSyLjKwCDxQjvS4KZLVMgV9Z42rQMM28hSuNz03fWMRteV4Hblev7f00GUy1HKIak8h4/Bj8q41PhRGTbho9UDqpS8Zo1BVxWnB4B3yeCTSZabCQieiqrQ27JjGZLAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161732; c=relaxed/simple;
	bh=ecOF30m10JLxh01ktUyPujcR3tuFZ+knYMhgtyw7HjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPdEZ3UCVfVnufmYN0XRZX34GSCgK4pFXj3a8cFXAfVwsPQkEOTyXhymfsrUYxIl16YT/18fqcCTjmAeA9/3yBYAU8czDni49NQF3FyBzv5j9FyEZoYhgyP2tvO6vNb6pNGxG7eO0usLy9VEdkznWri6pxdMMHyjMeZ1OJSkjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rGd0VHRI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0061F00893;
	Sat, 30 May 2026 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161731;
	bh=ncr3+kbU2k6AIbqO9P8LAjQ2FvZUE2wT5Sw6ZCF0kXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rGd0VHRIkByEfLp+rkpuQaMSALn9nEOrN8UH2kyMWRiXzS5b+1KhzCYZsw5YPtII7
	 Hrk2bbBnclLn7gB3hiBr0oLdiKaL2sa6rWH6ZMmVWTiqrG+xZ6oIhV7QwAQI+BY+cq
	 /7bonqZBZbeuIZMuExClLUQi9dR5PnzZ9+95NUnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 711/969] ksmbd: scope conn->binding slowpath to bound sessions only
Date: Sat, 30 May 2026 18:03:55 +0200
Message-ID: <20260530160320.164582490@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257656-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 57C6F60F980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index f7ba243c854e2..08eeca8ab0042 100644
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




