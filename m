Return-Path: <stable+bounces-245985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATVDN9pA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B414B5264EE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 173FD3152A26
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297B3955CB;
	Tue, 12 May 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogf3Rz+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4C3955C3;
	Tue, 12 May 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608062; cv=none; b=fSFY8cyjTJAE5HKIKWONSoQfzZcweKytjiP4z/zHpE8kbv7ki9fsEmZ6+SMCjBTCFEa7S+BmUBU8Wwl3Eh78wNEJ8d3tr3gFTIawgTu1SHgc+Fm62F4YOioekq+zGovfDwFnjyVcQBGlFKRm0hfGR6qf6bdAiXZhzuzIJd3kFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608062; c=relaxed/simple;
	bh=NujCQtmeH/uvT2Biveg2z7MNyqGpYMD3ZCePVXafIfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYEmhWkFkWJEk+ojwrmxvkzPPevJxF0gRtn8rqJAz5uQRadjg+v8RGf7xbWtZiQ6h40gujLOT+H2Jry+cKzhiQXZh7GYdHTsFxNq58gWC/tL6hD6GuPOJESNtYEgNjNc6Ysr+vkKcfmIOVFg8pHpx4SY//zYZ9n8aDN3I2ETvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogf3Rz+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A817C2BCB0;
	Tue, 12 May 2026 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608061;
	bh=NujCQtmeH/uvT2Biveg2z7MNyqGpYMD3ZCePVXafIfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogf3Rz+hItb/jVv46WYI4PI5rK7rOrNzX+qS0aGjOT38JLrPJm8MCwCJa49PAY089
	 Tuy0rDvye89r0HgxGZzDq9/6ykVcxLWecv2gw/ggtT8QaR0NJbjjH6rT2uhf7HSmEM
	 qjUf1gjCDG5QXrx5pcGlctsAolleudK+LmIw2jEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjoern Doebel <doebel@amazon.de>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 139/206] smb: client: use kzalloc to zero-initialize security descriptor buffer
Date: Tue, 12 May 2026 19:39:51 +0200
Message-ID: <20260512173935.804478174@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B414B5264EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245985-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amazon.de:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjoern Doebel <doebel@amazon.de>

commit 5e489c6c47a2ac15edbaca153b9348e42c1eacab upstream.

Commit 62e7dd0a39c2d ("smb: common: change the data type of num_aces
to le16") split struct smb_acl's __le32 num_aces field into __le16
num_aces and __le16 reserved. The reserved field corresponds to Sbz2
in the MS-DTYP ACL wire format, which must be zero [1].

When building an ACL descriptor in build_sec_desc(), we are using a
kmalloc()'ed descriptor buffer and writing the fields explicitly using
le16() writes now. This never writes to the 2 byte reserved field,
leaving it as uninitialized heap data.

When the reserved field happens to contain non-zero slab garbage,
Samba rejects the security descriptor with "ndr_pull_security_descriptor
failed: Range Error", causing chmod to fail with EINVAL.

Change kmalloc() to kzalloc() to ensure the entire buffer is
zero-initialized.

Fixes: 62e7dd0a39c2d ("smb: common: change the data type of num_aces to le16")
Cc: stable@vger.kernel.org

Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: Kiro:claude-opus-4.6
[1] https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-dtyp/20233ed8-a6c6-4097-aafa-dd545ed24428
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsacl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1738,7 +1738,7 @@ id_mode_to_cifs_acl(struct inode *inode,
 	 * descriptor parameters, and security descriptor itself
 	 */
 	nsecdesclen = max_t(u32, nsecdesclen, DEFAULT_SEC_DESC_LEN);
-	pnntsd = kmalloc(nsecdesclen, GFP_KERNEL);
+	pnntsd = kzalloc(nsecdesclen, GFP_KERNEL);
 	if (!pnntsd) {
 		kfree(pntsd);
 		cifs_put_tlink(tlink);



