Return-Path: <stable+bounces-252696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKjPMzAoDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:31:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4597B59AF80
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0638B33344AC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C072D7386;
	Wed, 20 May 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmNNqSrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A6372B31;
	Wed, 20 May 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301350; cv=none; b=jKAPEkfmbu/S1KIT4oyL9do+ZIzVzdRlzyykXlT1zq9n2x3+ugn9xKyFXSUJSgtCDptwJ2OaBtpS/bmaiPkxwkHvszM2pvbT9wDRFlOBZ+zbaIAWGGK9y7iVwHQz4ehs9cVZYjbASAQIXF4xbgRNmoXcyF3yY4BHJGFc4FiYppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301350; c=relaxed/simple;
	bh=+6qLZiDQ3C0gMrr+KL7OINcBKxessFeuQJYPM0s6j3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeqOm4lQGHF6tPxYSrYF7958mUF3uoSwi3uIFAKunZmJokddKXkQnIH7CNwH/lpzzdw3WOS4sk+BNHvZj3TOiDoqR1ixdT0zD8YgHB/s7AeV3v0uNfabWKQjNCEOowAGMicGdEp6PfYhmr1fDxqrEweJ2igeFZXyGo/ssIe6k60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmNNqSrm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B131F000E9;
	Wed, 20 May 2026 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301349;
	bh=NNAeqabFzzYCyRRiIpQPkcG1vvBBHZd0hPWMgiWCNq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CmNNqSrmL7LQ6CjEokJRu7/Zuh+mZuStRSKF/1y0uRC7Xo53dvuZMqGxrkHLOJHmt
	 hn9gV0qEd09weDYu97EGF0wEW/8rJngLHaOTCIW6maTwWz7BIExhJuIk7JIsvcmApg
	 LYY661UXx63dvtyw3Ngi7SffFfzI7tAczkq6ydMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 480/666] ksmbd: fix durable fd leak on ClientGUID mismatch in durable v2 open
Date: Wed, 20 May 2026 18:21:31 +0200
Message-ID: <20260520162121.669457277@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252696-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4597B59AF80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit 804054d19886ac6628883d82410f6ee42a818664 ]

ksmbd_lookup_fd_cguid() returns a ksmbd_file with its refcount
incremented via ksmbd_fp_get(). parse_durable_handle_context() in
the DURABLE_REQ_V2 case properly releases this reference on every
path inside the ClientGUID-match branch, either by calling
ksmbd_put_durable_fd() or by transferring ownership to dh_info->fp
for a successful reconnect. However, when an entry exists in the
global file table with the same CreateGuid but a different
ClientGUID, the code simply falls through to the new-open path
without dropping the reference obtained from ksmbd_lookup_fd_cguid().

Per MS-SMB2 section 3.3.5.9.10 ("Handling the
SMB2_CREATE_DURABLE_HANDLE_REQUEST_V2 Create Context"), the server
MUST locate an Open whose Open.CreateGuid matches the request's
CreateGuid AND whose Open.ClientGuid matches the ClientGuid of the
connection that received the request. If no such Open is found, the
server MUST continue with the normal open execution phase. A
CreateGuid hit with a ClientGUID mismatch is therefore the
"Open not found" case: proceeding with a new open is correct, but
the reference obtained purely as a side effect of the lookup must
not be leaked.

Repeated requests that hit this mismatch pin global_ft entries,
prevent __ksmbd_close_fd() from ever running for the corresponding
files, and defeat the durable scavenger, leading to long-lived
resource leaks.

Release the reference in the mismatch path and clear dh_info->fp so
subsequent logic does not mistake a non-matching lookup result for
a reconnect target.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 29fbdada7259a..700d9da3c65a9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2849,6 +2849,8 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 					dh_info->reconnected = true;
 					goto out;
 				}
+				ksmbd_put_durable_fd(dh_info->fp);
+				dh_info->fp = NULL;
 			}
 
 			if ((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
-- 
2.53.0




