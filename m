Return-Path: <stable+bounces-257035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPFDBukTG2rz+wgAu9opvQ
	(envelope-from <stable+bounces-257035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67460E5F5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE3D302F381
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB634165B;
	Sat, 30 May 2026 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYUxNnV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A81DE4EF;
	Sat, 30 May 2026 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159086; cv=none; b=IpG41UFMFfYYPAjdcGw566GTbefs+ILHW/CHpUpWxoC7MAPb5lm1p+X3TTkzW9BI6KjGq79ETpl1wWKYqvi38dfziA1exKan8B9JbBO1QGKjLHEqmMfzpeM5fK1MRPOQh/fO9l/IZ5RfFZjSTl70+qNWauSshSmRKxy4dd69e40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159086; c=relaxed/simple;
	bh=bxdxVJhNOQH5YGXn/QnSxTM4XIW//9QDH98rs9etwEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6LWHsW5FMtPqtljnu8wmDV9Bsg7512pZVa0LiNug/hlaOc83a59g38eUXJsSrRGQUqHAR4EYvPDCK9XwJ6QwWOjPHOD1wsbfjxKrz4ZzmrEbzUSjUo6iVulvwvfPE39UJl+lvrm1J4ZFObjJtXSYNi80+d71L90p8SUHs9Dfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYUxNnV3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862DD1F00893;
	Sat, 30 May 2026 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159084;
	bh=ke9M0qJ+lRZMS+YELa5ZnoFoIoNp2jlUXrm8XrY8WrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYUxNnV3pQX9RmW9rkoUVbeVm+hZM/+2gjud431M+XRK7Iu0PKBgUW7iuzkpjfG7E
	 sb6XdmaROUzfjo5HbT+UxZjCYCMFnhxKpzFfnHRuZLMej7K8P3pzRauZ2Zf+zq6Ozv
	 8JkjxPaP4EVHC6bn/oJkbrRwSUukpWdzCikva4YE=
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
Subject: [PATCH 6.1 070/969] ksmbd: validate EaNameLength in smb2_get_ea()
Date: Sat, 30 May 2026 17:53:14 +0200
Message-ID: <20260530160302.301811276@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,chromium.org,talpey.com,vger.kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-257035-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A67460E5F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 66751841212c2cc196577453c37f7774ff363f02 upstream.

smb2_get_ea() reads ea_req->EaNameLength from the client request and
passes it directly to strncmp() as the comparison length without
verifying that the length of the name really is the size of the input
buffer received.

Fix this up by properly checking the size of the name based on the value
received and the overall size of the request, to prevent a later
strncmp() call to use the length as a "trusted" size of the buffer.
Without this check, uninitialized heap values might be slowly leaked to
the client.

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
 fs/smb/server/smb2pdu.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4390,6 +4390,11 @@ static int smb2_get_ea(struct ksmbd_work
 
 		ea_req = (struct smb2_ea_info_req *)((char *)req +
 						     le16_to_cpu(req->InputBufferOffset));
+
+		if (le32_to_cpu(req->InputBufferLength) <
+		    offsetof(struct smb2_ea_info_req, name) +
+		    ea_req->EaNameLength)
+			return -EINVAL;
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)



