Return-Path: <stable+bounces-229286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFolEy1fwWmHSgQAu9opvQ
	(envelope-from <stable+bounces-229286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:41:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B35F52F6B94
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C315303CED2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F63B7B83;
	Mon, 23 Mar 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LInIMCEi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F243B52E2;
	Mon, 23 Mar 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278641; cv=none; b=dQOA6QFFBcrRgjszfLhA2VOB3IKsA3A/qt8ZIJ8elUNmXeExiwETLqhSlBVWuf+1Aj8rUZFyDWwITej6q86dd2kGUdfrscWFLM6P68kMkryjB1gXysyF8lnnFghRlnRjiT0zfVxMqzeggUwK11SU2fQSt/9Yx+4z2ixAMziqD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278641; c=relaxed/simple;
	bh=ltvzdzyfF7LKsLTF1bs1mdw/3Pqm77O5ZLR6vIRKpzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jia8orJlx0UIa+0Fz1siT9nbjEuQj3VzSJz+K99fReYR8mAlczuKUjcpoYX8f+OT1Vv506jykcG1Z3RU7kmR7nImpD0u1T7Hqbe9rWBMCHvDD/74zxn4UEemgmFH+4ifEJ80chFryiw2TACFd87yyEy2QqJVb6mDpyGSU5dFqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LInIMCEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F63C4CEF7;
	Mon, 23 Mar 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278640;
	bh=ltvzdzyfF7LKsLTF1bs1mdw/3Pqm77O5ZLR6vIRKpzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LInIMCEiXl4TTNPIC9FlxYrZYXg3/isPduu+zcOnQ1viP8KC0yAGk71Ggnmmfp+2V
	 u4cUlsMUiwSanrcph82ZmTZDY3Ejv3z0XC8sQrjRithez5fw2h7+inN1N4AyvcKel8
	 KHHY3hSdx25KrrPTfWjlspsvD+3HdXaII9zRqTG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 329/567] smb: server: fix use-after-free in smb2_open()
Date: Mon, 23 Mar 2026 14:44:09 +0100
Message-ID: <20260323134541.971809083@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229286-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B35F52F6B94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3593,10 +3593,8 @@ int smb2_open(struct ksmbd_work *work)
 
 reconnected_fp:
 	rsp->StructureSize = cpu_to_le16(89);
-	rcu_read_lock();
-	opinfo = rcu_dereference(fp->f_opinfo);
+	opinfo = opinfo_get(fp);
 	rsp->OplockLevel = opinfo != NULL ? opinfo->level : 0;
-	rcu_read_unlock();
 	rsp->Flags = 0;
 	rsp->CreateAction = cpu_to_le32(file_info);
 	rsp->CreationTime = cpu_to_le64(fp->create_time);
@@ -3637,6 +3635,7 @@ reconnected_fp:
 		next_ptr = &lease_ccontext->Next;
 		next_off = conn->vals->create_lease_size;
 	}
+	opinfo_put(opinfo);
 
 	if (maximal_access_ctxt) {
 		struct create_context *mxac_ccontext;



