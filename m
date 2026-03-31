Return-Path: <stable+bounces-232148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G6NHLICzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:21:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168236E8D7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B74273155078
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B71425CC6;
	Tue, 31 Mar 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePzMhYr3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F013F8E04;
	Tue, 31 Mar 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976000; cv=none; b=dd2oXDZXR9XBw/eBMnplDJb8UTxlQbdji4KfpcIP9QD+U82uEUWOPlihHIiVFCA2axOoNdHLoQsNAwlj8rzlArLHhpcI5MkNoHC9EiKmBUPeIRkynV/C61DE4isyXjAHBfGlIJi1kEYOkogbiTeTU1JDl0oynPnv6Vr+kUpqNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976000; c=relaxed/simple;
	bh=rnQspb9WcOul58Fe4uJ9D6FbtaYmKoBHHPRnA9DIAzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9zJ6OI7KBxs/DDH7PP4nQlTNOSxIfHhhwZmdiikCRDzmTYHv1KLl2sj9g/yfemxyHuGE7siIB5D8RRWlKNxk7bxS+/DchReZQI0ilkY5w9hdo3kn2zCVMa1NDYqcPaRvphkG3ibuYZf3f+07lqPaaKvmOL0ZWxDvGRSSzrWn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePzMhYr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B96C19423;
	Tue, 31 Mar 2026 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975999;
	bh=rnQspb9WcOul58Fe4uJ9D6FbtaYmKoBHHPRnA9DIAzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePzMhYr3NjPb2jBSTvmkE5sF8dHdf6fbB0DHYrheGZzd9aOTuVk81qHNmq3UwZX6R
	 JN6QP1mXy+phuN47eOmIBok9dbcZH9SinoRReUeoA7WCJfZQ9YlWCtUwMo140iHAK/
	 cfaw4nt/2pjPmswg6WXDCgZ1WjnaRnsz8WVys+yM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 141/244] ksmbd: do not expire session on binding failure
Date: Tue, 31 Mar 2026 18:21:31 +0200
Message-ID: <20260331161746.976665039@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232148-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7168236E8D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

commit 9bbb19d21ded7d78645506f20d8c44895e3d0fb9 upstream.

When a multichannel session binding request fails (e.g. wrong password),
the error path unconditionally sets sess->state = SMB2_SESSION_EXPIRED.
However, during binding, sess points to the target session looked up via
ksmbd_session_lookup_slowpath() -- which belongs to another connection's
user. This allows a remote attacker to invalidate any active session by
simply sending a binding request with a wrong password (DoS).

Fix this by skipping session expiration when the failed request was
a binding attempt, since the session does not belong to the current
connection. The reference taken by ksmbd_session_lookup_slowpath() is
still correctly released via ksmbd_user_session_put().

Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1945,8 +1945,14 @@ out_err:
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
-			sess->last_active = jiffies;
-			sess->state = SMB2_SESSION_EXPIRED;
+			/*
+			 * For binding requests, session belongs to another
+			 * connection. Do not expire it.
+			 */
+			if (!(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
+				sess->last_active = jiffies;
+				sess->state = SMB2_SESSION_EXPIRED;
+			}
 			ksmbd_user_session_put(sess);
 			work->sess = NULL;
 			if (try_delay) {



