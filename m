Return-Path: <stable+bounces-249264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNapIxL/Cmp8/AQAu9opvQ
	(envelope-from <stable+bounces-249264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:59:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5D56C1B4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D402304EF44
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB813F888F;
	Mon, 18 May 2026 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="oKl8gKZ+"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5023F870F;
	Mon, 18 May 2026 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105209; cv=none; b=lKZB2eyeuE8KZqbA9b5OtM8ecHot/tNXKF/gleKeAnB6Ofs0AmPWzRUKtOY2BqbWfspWL04tqFG7nKOL3hbfBa1qliAByjCRRyvUC57RJQsReAOnfuZgD7R1O23TOIgDk5+7KdKQOzcyg/YnmQV/ruMr4GkYBy9hjSK3Snwbo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105209; c=relaxed/simple;
	bh=vOXqvyPbktfU4nViu1gg2q6M+WtpmquINDMz4D15gEs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qMyLne335Kss/HLyRYY2IdFn18a1tLhd8hzNMfd6nV22PWWpavbuGdZp4hUZ35IZnT+37stPuEXmk8TybJnK/GyLn6g/Oy2B7olq/HA36bGBnr+tvXxcQRjUnuB+p7UCJNjgDtEejC/quGJO86jYDLc0I650ck+N5EzlwkOlZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=oKl8gKZ+; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779105194;
	bh=2XNlZC/pNIKOxQdvoyAUjMKvunbUTotZ+x/yvWqeksA=;
	h=From:To:Cc:Subject:Date;
	b=oKl8gKZ+a5U6doPc4hWEfka3Mid78ysKInT7FDmHz+6DdfS9V5IkPtr9pJYB7M4/Y
	 Y2oFe3IkZrYTou4QHsG8oYniA4jJn0lGXk03I+punMDaU3d2HFA302axTpM+Wkb2Gb
	 LJZwv+kC/4q+i0vR7e7SUxvTyPxPJLfTJt1TULio=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D45BF675; Mon, 18 May 2026 19:53:05 +0800
X-QQ-mid: xmsmtpt1779105185thwx7kqqn
Message-ID: <tencent_A2DDAC857112606A1A6068F56ACE3EAE2409@qq.com>
X-QQ-XMAILINFO: MK9ZM/6TSGijjHWBNvZGxqGnftSVzafbbNIzlaYwQKkLSIQrjOY54mREBuU1T2
	 julvpDTSc0y3cx/vaW3gA2yKnPVbbsKxLRaCkfzZGg5qpyKkLXCzp2RrHcPhWm1N0KyT+3XPHm5h
	 AbRj3Fy5crGYKfIGdVvc75Edfi5IGr7xODRKlosGG+3dUr2VmZtfFyRx6q44bW5tDWkfckoY7eTS
	 WRuqkOCq5Bpmxl0LymYsu+PCqRLwXADZD5hzkCq2Ffd5qM/Wdmhz/e4E1xGRFODJU7kGN8rcRUmx
	 +aMs2FjojPEjuDbWuqPFaItHxTArSJDN+GBWJaunUKOBzrUPOyiMBskix3bBNYhSreN8DheVqS1H
	 bsXMCQ7ShlMFPQNNn4HGRdUryPUZAIW3D8mkHlyHFyQBbdCusFevU+9yFU47o+0rBzYLmnrt4/Ve
	 ZYAU8Cj+NqAB8Whi6+88z0vNSlNn9wEBG3HM60ZNxXxwW1vK5cHFO1Alp4CvbrjT1akT8nZrseza
	 Pwq64FmN8quvajqVQ3v+Nh9ixcXen/4nEHVZFwCXeuN8KHf2fFs7wpSfkuFzQYO538nvOjoGeM1m
	 SlMF5PJ/FyvB3EDetCqjmYCh4jujo/gHBLexPZKHZ2pmTpYn4XUQwGsmKpGNLcs/gn7e0CtviPrH
	 kHxmXrSmKPrsN5iBQOLHs7Y2pRjHAC+So5HiqKBWWuOvweCSig1DEpPmh9BN2GiGNYEnYngqpFSr
	 dJ61sxtT1tCUhF7w9DhThG915Ks5MJHelrrjp9aZEuxhRdETme8xMDa35ca0gdKX+SjPUtJ5gaKC
	 zVKi4unDJxprrlAR/3MYcpkw+luXFD7zRXF/CD4zsgUkKyrxooV0nrbNHqAaNA4LnRKzCbvmYsyu
	 ssNmVd91wUTSS+dDC/ye3+TSxrpA2lLGj7vep4vzTet3TTrsajTaCGrgvX7+YuUWSCcPL0PKVEui
	 9HwjWoduSxQlRnP1v/ZphQ9ZURLc6Nb3A1sNq5M8ni7EXqo9+3g+19mBeI94nZBiTWa/y9oyQMbS
	 W2CUQRTi7AHIsANHc61TyAGIaxOaecwy8+kd1O5v1Q4i90rhGsjbUzk3Uih+tMcPUs3KzzhD2H6y
	 gvy22KPkwZ8BKPWM1ZjsXKcwecAQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y 1/2] smb: client: correctly handle ErrorContextData as a flexible array
Date: Mon, 18 May 2026 19:52:51 +0800
X-OQ-MSGID: <20260518115252.22162-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33F5D56C1B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249264-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lixiang.com,talpey.com,microsoft.com,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:mid,foxmail.com:email,foxmail.com:dkim,lixiang.com:email]
X-Rspamd-Action: no action

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
[ Remove the __counted_by_le annotation in v6.1. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/smb/client/smb2file.c | 4 ++--
 fs/smb/client/smb2pdu.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index fe016144f340..def2602ea0fb 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -41,14 +41,14 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
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
index 2823526b66f7..d12ca9c7e62b 100644
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
2.43.0


