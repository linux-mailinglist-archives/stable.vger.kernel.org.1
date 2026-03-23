Return-Path: <stable+bounces-229717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FIwHHd0wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:12:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DD2F9928
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 681D7303943C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19B1258CD9;
	Mon, 23 Mar 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMmeRrqT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F083BED34;
	Mon, 23 Mar 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282677; cv=none; b=JXaNURUw6QFD849vt3gkYGT2ph93UbnoRBQqB05WHeBgT/OGf9KI+eRpZe5IHlZQqofkyMqDmQOoWvGzmMxKJaTvzLWyxgBPRSr1qDnZs8dQc5OabY3mf+sE8jPVKDhogKtMhDMOe7dnjQEZVeMjJsUi5Fgexm4s41UOCmOssYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282677; c=relaxed/simple;
	bh=FqEOeWCpbit8nKQ8yQ1jMcjmxDiDohxaKA5OwbFZYAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULHZrmr3XorgAM9waALDgcw5BbhZVOZQyA37SWCeHMJ/TyDKidmVx7xkykHOsJaCpT/OEz0tcEI1tg+2gAGZWvyY1xRzQPOcRFsooh1eRDDlpcA5UEdrdVXB7ulkGZpKyCnN+FsIkqs2u+bgbsr73ZWPsAzxAMR5h8HU2d4GpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMmeRrqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA77C4CEF7;
	Mon, 23 Mar 2026 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282677;
	bh=FqEOeWCpbit8nKQ8yQ1jMcjmxDiDohxaKA5OwbFZYAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yMmeRrqTathw0sVqQ8LqovBsn04Ok1RZElG/Y+803oANCbIa9ucMGkZ25ENAEZztw
	 kostl9YtLl7IIrLTlPFC3W7p8SI4k+BXcT4OkSMQFPLVnTVHmYnxztXO6ANQPWh2QP
	 bU+CQBuknvcXK1meM9Ti2kD3t9o26TQitN2nvQqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 246/481] smb: server: fix use-after-free in smb2_open()
Date: Mon, 23 Mar 2026 14:43:48 +0100
Message-ID: <20260323134531.148684742@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229717-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 932DD2F9928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marios Makassikis <mmakassikis@freebox.fr>

commit 1e689a56173827669a35da7cb2a3c78ed5c53680 upstream.

The opinfo pointer obtained via rcu_dereference(fp->f_opinfo) is
dereferenced after rcu_read_unlock(), creating a use-after-free
window.

Cc: stable@vger.kernel.org
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3343,10 +3343,8 @@ int smb2_open(struct ksmbd_work *work)
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
 	rsp->StructureSize = cpu_to_le16(89);
-	rcu_read_lock();
-	opinfo = rcu_dereference(fp->f_opinfo);
+	opinfo = opinfo_get(fp);
 	rsp->OplockLevel = opinfo != NULL ? opinfo->level : 0;
-	rcu_read_unlock();
 	rsp->Flags = 0;
 	rsp->CreateAction = cpu_to_le32(file_info);
 	rsp->CreationTime = cpu_to_le64(fp->create_time);
@@ -3387,6 +3385,7 @@ int smb2_open(struct ksmbd_work *work)
 		next_ptr = &lease_ccontext->Next;
 		next_off = conn->vals->create_lease_size;
 	}
+	opinfo_put(opinfo);
 
 	if (maximal_access_ctxt) {
 		struct create_context *mxac_ccontext;



