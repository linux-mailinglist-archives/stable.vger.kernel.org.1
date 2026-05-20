Return-Path: <stable+bounces-253292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PLZB0QGDmqv5gUAu9opvQ
	(envelope-from <stable+bounces-253292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:06:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B712A597C3E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BE8A32EAA36
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DCD3FFAA0;
	Wed, 20 May 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LCROW9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29A3FE663;
	Wed, 20 May 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302898; cv=none; b=bCNqQNSDoOfG/YTPLrP/ly5aPrbdqyUDaRCtjnbjpzGAXQu6k8ED55sScvborw4F0rHIrQu+Fw9avSyRiDKA2F/Ml37y45NGYjj50ekRpMgVTYMSPlTpjurhcOBoTr1WJ1Nx2PalT1cSu56mq0XNxjgnTWLn1qvW6/tCkfsmM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302898; c=relaxed/simple;
	bh=4+ZVo7JBQedz82/H8SCNQ6RHFBk7Mqi9dOH3cXVgVoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek1ZQbVXr7qmJeO3xogVpOYxY09XPjatMOsG4E9d2R+EDtiwDw/GLXd9jgh3ajuvVkWYSDUT7KljZeGKupQl4OGnDUwWj0F90mchir9fDfIQjJnj193FQwKKxIjeJoGvaDmAAubYmxMqULvu1uAnanf7pIRRwMWvvT1NUIxOKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LCROW9s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9240B1F00893;
	Wed, 20 May 2026 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302896;
	bh=KTAFyQpmUEkEw1zLdUOL2DyCQx4H4Cd7GmijpdrEWbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0LCROW9sMo2FMdCs3DTmLhlRRY7Z2CfffII6u5Yq7E2RPTOzK8D5QrfnUyogQmr/y
	 PVwcBxa7jRYcgLoRkqJS/UpF0hCalY1sW9TNisXpY5tVbq7rZcmpVYIYBj6SP4aRPZ
	 +7yYLwwOKcO6RYUDJIt+N1Pov8t4IAeBWeqf871o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liang Jie <liangjie@lixiang.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 442/508] smb: client: correctly handle ErrorContextData as a flexible array
Date: Wed, 20 May 2026 18:24:25 +0200
Message-ID: <20260520162108.175482039@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253292-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,lixiang.com,talpey.com,microsoft.com,foxmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,lixiang.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,talpey.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B712A597C3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liang Jie <liangjie@lixiang.com>

[ Upstream commit 215b7f9ecb8d7c14d56febdcdd246f3579c32aba ]

The `smb2_symlink_err_rsp` structure was previously defined with
`ErrorContextData` as a single `__u8` byte. However, the `ErrorContextData`
field is intended to be a variable-length array based on `ErrorDataLength`.
This mismatch leads to incorrect pointer arithmetic and potential memory
access issues when processing error contexts.

Updates the `ErrorContextData` field to be a flexible array
(`__u8 ErrorContextData[]`). Additionally, it modifies the corresponding
casts in the `symlink_data()` function to properly handle the flexible
array, ensuring correct memory calculations and data handling.

These changes improve the robustness of SMB2 symlink error processing.

Signed-off-by: Liang Jie <liangjie@lixiang.com>
Suggested-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Remove the __counted_by_le annotation in v6.6. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2file.c | 4 ++--
 fs/smb/client/smb2pdu.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 4e7d5c612256d..3a5b62b298063 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -42,14 +42,14 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 		end = (struct smb2_error_context_rsp *)((u8 *)err + iov->iov_len);
 		do {
 			if (le32_to_cpu(p->ErrorId) == SMB2_ERROR_ID_DEFAULT) {
-				sym = (struct smb2_symlink_err_rsp *)&p->ErrorContextData;
+				sym = (struct smb2_symlink_err_rsp *)p->ErrorContextData;
 				break;
 			}
 			cifs_dbg(FYI, "%s: skipping unhandled error context: 0x%x\n",
 				 __func__, le32_to_cpu(p->ErrorId));
 
 			len = ALIGN(le32_to_cpu(p->ErrorDataLength), 8);
-			p = (struct smb2_error_context_rsp *)((u8 *)&p->ErrorContextData + len);
+			p = (struct smb2_error_context_rsp *)(p->ErrorContextData + len);
 		} while (p < end);
 	} else if (le32_to_cpu(err->ByteCount) >= sizeof(*sym) &&
 		   iov->iov_len >= SMB2_SYMLINK_STRUCT_SIZE) {
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 076d9e83e1a04..2eb15f3a7fe66 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -79,7 +79,7 @@ struct smb2_symlink_err_rsp {
 struct smb2_error_context_rsp {
 	__le32 ErrorDataLength;
 	__le32 ErrorId;
-	__u8  ErrorContextData; /* ErrorDataLength long array */
+	__u8  ErrorContextData[];
 } __packed;
 
 /* ErrorId values */
-- 
2.53.0




