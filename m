Return-Path: <stable+bounces-237086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOE5G2gd3WlhaAkAu9opvQ
	(envelope-from <stable+bounces-237086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D353EFA75
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CBA0302D67D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1A2311C15;
	Mon, 13 Apr 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmEWA6Hx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6343148A3;
	Mon, 13 Apr 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098551; cv=none; b=IZQxgbmwlvjdO4YoSEGQMKT6TbsYWYSRV91CsGuK7EnOwT063QGRSMav3o646kxoNsYD+oX3yb6xGUaFYW2hNIzGXSpPYmkyjQP1ot8krAIHWCK/1f73k/8Jo+2FUqCBoJ5LJnxmz+oYwOHJfUfQVWkXLDtzEXikOgEbdRzG4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098551; c=relaxed/simple;
	bh=1wFqu9JT2joKHekLk5Y8JoDtaCNMIGn2DB8giCMXE5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMkDU1652cFPz/G1J7Dd0RPJpuDffmDPvjA/7X5SVysS0my3kGzqHVMcACZ2lmBvcQ80TdDHJ0sUIS6YGKDHgXvajJcc9lnrkw3j6bi+kUR7ocGOGC9r2h9KDUfR9Uoi9nI8IPA7GaCRm3W7MsUD2s1IEIfiyvaLIQawIpcBUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XmEWA6Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC276C2BCB0;
	Mon, 13 Apr 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098551;
	bh=1wFqu9JT2joKHekLk5Y8JoDtaCNMIGn2DB8giCMXE5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmEWA6HxyVzc+Ski51q4RcAanp4pvSj2Sjq416D8UZEm9GzHoe3paUxCj9CzucJen
	 rqgY4VB6LJMgbNLKc04/6k5SKy/lznHWnj8kcz1Vg5aHfGhGtjtqnEpDxWsDaT94DM
	 WQ6+Y8vdHldRSLYzTmQn72Wbqmy9XNAc4Ff+fqkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Heelan <seanheelan@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Leon Chen <leonchen.oss@139.com>
Subject: [PATCH 5.15 568/570] ksmbd: Fix dangling pointer in krb_authenticate
Date: Mon, 13 Apr 2026 18:01:39 +0200
Message-ID: <20260413155851.755021446@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com,139.com];
	TAGGED_FROM(0.00)[bounces-237086-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 23D353EFA75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Heelan <seanheelan@gmail.com>

[ Upstream commit 1e440d5b25b7efccb3defe542a73c51005799a5f ]

krb_authenticate frees sess->user and does not set the pointer
to NULL. It calls ksmbd_krb5_authenticate to reinitialise
sess->user but that function may return without doing so. If
that happens then smb2_sess_setup, which calls krb_authenticate,
will be accessing free'd memory when it later uses sess->user.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Heelan <seanheelan@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Leon Chen <leonchen.oss@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1619,8 +1619,10 @@ static int krb5_authenticate(struct ksmb
 	if (prev_sess_id && prev_sess_id != sess->id)
 		destroy_previous_session(conn, sess->user, prev_sess_id);
 
-	if (sess->state == SMB2_SESSION_VALID)
+	if (sess->state == SMB2_SESSION_VALID) {
 		ksmbd_free_user(sess->user);
+		sess->user = NULL;
+	}
 
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
 					 out_blob, &out_len);



