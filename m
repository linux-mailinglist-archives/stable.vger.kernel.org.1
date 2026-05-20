Return-Path: <stable+bounces-251882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBjxFWECDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-251882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:50:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AD59749D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2197C31EAF07
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337183F1AB8;
	Wed, 20 May 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwHLs4De"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B783546C8;
	Wed, 20 May 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299134; cv=none; b=rJMr8RzTS+RxL1KQJwebGeftkW0hU7P+sdDCcNoxL8OdUDyedAF69fmcaEeaeX6t/SG8MbkDznSBS6pevITb9mJ9DzXUHeBFvoyvcszWvC6zIdrfyTdJCQL5mk+Rs2BK51bV+uq64yoLjJwlIiKr4DYKngRDRfR9kX2X5HpeZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299134; c=relaxed/simple;
	bh=yGAWFZNA0nn/KN2cQsGn6h3yrCOwOF4s9bVB0/N1PFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZzd/H7NzQf9OpdHwFIItZDlM+zBGiZmufbb78hWRyjFJyrznlnDxutpE+69IyPcjGANkbF5ufPEVBwguIqkKt1jgSbUTiiORpeaa68D2A7OaCPKmv1a2GSO2W3q/DfZPRcftw+i1L6iUldLyrtIzzJGDDLhWk1DAm2EACt0sSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwHLs4De; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FE01F000E9;
	Wed, 20 May 2026 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299132;
	bh=y6jcDqYUzotVLml1CEm8iT6M3cvS6ErnoBJC9bbe9OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rwHLs4DeWkJ6PZc+fSLFvwAMaS4gzy+kCb2S1NgyKCr6M8AWhcABWYRjRKipsQl3h
	 V3nGtepqSX+ZfaAyMip3z39k5Jyw/C6UkOXHQRcCCIF2jT33ndC07CYSR/8i96QPP+
	 GB0VdNLdFB5Yj+ovPMAgk77TMeqRIkwO70Zte3gU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 676/957] ksmbd: fix durable fd leak on ClientGUID mismatch in durable v2 open
Date: Wed, 20 May 2026 18:19:19 +0200
Message-ID: <20260520162149.199172492@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251882-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 776AD59749D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 4bfbfe53aa4eb..756624b4e90e0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2854,6 +2854,8 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 					dh_info->reconnected = true;
 					goto out;
 				}
+				ksmbd_put_durable_fd(dh_info->fp);
+				dh_info->fp = NULL;
 			}
 
 			if ((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
-- 
2.53.0




