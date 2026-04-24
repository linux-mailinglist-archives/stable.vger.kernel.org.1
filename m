Return-Path: <stable+bounces-240799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p995OERy62nmMwAAu9opvQ
	(envelope-from <stable+bounces-240799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6375545F448
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE023006F18
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14A3D5643;
	Fri, 24 Apr 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uv2fRNSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1D179A3;
	Fri, 24 Apr 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037870; cv=none; b=PdMgqyktIgLKxS/uBsE2UJ7vc4kOtcBh0cr6YAOWIT1iUKmi8XSBWDpwOrufgXxbxlLrCLqe8JipByp7wPi5NUnktAiRDC9JNgkfoqZDj0n7qjQUPHqUNfe7jcYXG+9xhXiT8iBQ+KE3Vo0oW2hY6U5q4HWpcNSkOPum3bn+E5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037870; c=relaxed/simple;
	bh=w/OFTXUJilIgJcRaNDr644fBhgBZRYR//M3uJji6EnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF6yl6kDBdGP6g69woPiIZfNrnu5BEcOKnj67ADQVdcQ005uagLNqAWkA145REd8hJ9x4q1AQ3WyidMabyRn7NxkDhaEnXpfZoTwRWOibV84lPoTKslEYmCV/8Qsyu7XAWLOVApLb7qoAElTyXhAKE8vb541zN6BKU1TdxO4tSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uv2fRNSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FA3C19425;
	Fri, 24 Apr 2026 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037870;
	bh=w/OFTXUJilIgJcRaNDr644fBhgBZRYR//M3uJji6EnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uv2fRNSXfCftczu+J0TDZ9loACvOhKp9ak6qROylONamYolqvu24HmcMYrlJdgC48
	 RAmO/umABhzj2WsSxRf3WYDIrAPsaEmpfdioyY8EJlBdf+TRhAz0yftShrKGjw6Ugm
	 jrwtWQOln6VTfSsQvfdY8+Wjsg2r3LAzJi0PFu0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	stable@kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 084/166] ksmbd: fix mechToken leak when SPNEGO decode fails after token alloc
Date: Fri, 24 Apr 2026 15:29:58 +0200
Message-ID: <20260424132550.343994907@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6375545F448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,chromium.org,talpey.com,vger.kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-240799-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit ad0057fb91218914d6c98268718ceb9d59b388e1 upstream.

The kernel ASN.1 BER decoder calls action callbacks incrementally as it
walks the input.  When ksmbd_decode_negTokenInit() reaches the mechToken
[2] OCTET STRING element, ksmbd_neg_token_alloc() allocates
conn->mechToken immediately via kmemdup_nul().  If a later element in
the same blob is malformed, then the decoder will return nonzero after
the allocation is already live.  This could happen if mechListMIC [3]
overrunse the enclosing SEQUENCE.

decode_negotiation_token() then sets conn->use_spnego = false because
both the negTokenInit and negTokenTarg grammars failed.  The cleanup at
the bottom of smb2_sess_setup() is gated on use_spnego:

	if (conn->use_spnego && conn->mechToken) {
		kfree(conn->mechToken);
		conn->mechToken = NULL;
	}

so the kfree is skipped, causing the mechToken to never be freed.

This codepath is reachable pre-authentication, so untrusted clients can
cause slow memory leaks on a server without even being properly
authenticated.

Fix this up by not checking check for use_spnego, as it's not required,
so the memory will always be properly freed.  At the same time, always
free the memory in ksmbd_conn_free() incase some other failure path
forgot to free it.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/connection.c |    1 +
 fs/smb/server/smb2pdu.c    |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -39,6 +39,7 @@ void ksmbd_conn_free(struct ksmbd_conn *
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
+	kfree(conn->mechToken);
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		conn->transport->ops->free_transport(conn->transport);
 		kfree(conn);
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1901,7 +1901,7 @@ out_err:
 	else if (rc)
 		rsp->hdr.Status = STATUS_LOGON_FAILURE;
 
-	if (conn->use_spnego && conn->mechToken) {
+	if (conn->mechToken) {
 		kfree(conn->mechToken);
 		conn->mechToken = NULL;
 	}



