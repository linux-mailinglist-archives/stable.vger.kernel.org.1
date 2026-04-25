Return-Path: <stable+bounces-241083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ImetFrUM7Gn3TwAAu9opvQ
	(envelope-from <stable+bounces-241083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E446445F
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27D15301E7CA
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBA1A01BE;
	Sat, 25 Apr 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjIxbPgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026E1B808
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077426; cv=none; b=QXefFmRXaZtA+U02MQUCTvkI9XPWE9byihXtBka70uHMcfz3cbyTaZ5ciWBJN7GzSV1PLq8rm2v7MbTrSQOJxM/dvS6IQzwMgd5eLc9v2ESf4pbd08b5HKwnPD0EFgq9aS7Pb36OLvzFphGIF0uTPchxx75QlqgYeZq5/UfOURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077426; c=relaxed/simple;
	bh=U3kQ8jxBBlIcScWRb+NfvLX4M/zqy++/xvvbPVWqxV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcK2O4i0ZoA2UI+9yGQIC845waR14oVJSxnBb7w59ZMDC/iNZnJjH9dhv4l/xfv+d0zszoymTSBxszZckwImc5ucgCaMfuOuVOytXJYb0gFb9F5FAAQDweg80yLqI1VbmInDcfzBQqRQFJEr19B5aaTdyC47sqpw74ZbFKuH3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjIxbPgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CADC19425;
	Sat, 25 Apr 2026 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777077425;
	bh=U3kQ8jxBBlIcScWRb+NfvLX4M/zqy++/xvvbPVWqxV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjIxbPgBImCDNFFJ0HkeZOzwlrVqne4sIuZ4+VU4QII6xm8SpMN7RfrctbsOjKRi2
	 3NnKcaaChhpKjRlD6XNzX9hbpmjblcY/IEMAB1bat8HaPVdwCgDNZieFaLmhXvhKxh
	 dpYG/mkExzc6wyJ1ixw6wi1VdcxRPkjaWMwGPda2kZY1ark8o41Ue0uggHByk3fuzp
	 cujYaDGBNuGte+aX623fnsRpkpT0qox4Tu3HSB/Os49GWFdsxtBGk4wIVN57eAbrUE
	 ddOQMFfvq/Bri4dzfvdd1FUL9zAcqXyti0H/WLCoPRV6KPS4bhds/P/BdrniZtyoz6
	 ceTQJd7wTEagA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: use check_add_overflow() to prevent u16 DACL size overflow
Date: Fri, 24 Apr 2026 20:37:03 -0400
Message-ID: <20260425003703.2641747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042457-bullfrog-connected-a810@gregkh>
References: <2026042457-bullfrog-connected-a810@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA3E446445F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241083-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 299f962c0b02d048fb45d248b4da493d03f3175d ]

set_posix_acl_entries_dacl() and set_ntacl_dacl() accumulate ACE sizes
in u16 variables. When a file has many POSIX ACL entries, the
accumulated size can wrap past 65535, causing the pointer arithmetic
(char *)pndace + *size to land within already-written ACEs. Subsequent
writes then overwrite earlier entries, and pndacl->size gets a
truncated value.

Use check_add_overflow() at each accumulation point to detect the
wrap before it corrupts the buffer, consistent with existing
check_mul_overflow() usage elsewhere in smbacl.c.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smbacl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index ecf9db3d69c38..29ef33715e8a4 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -588,6 +588,7 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 	struct smb_sid *sid;
 	struct smb_ace *ntace;
 	int i, j;
+	u16 ace_sz;
 
 	if (!fattr->cf_acls)
 		goto posix_default_acl;
@@ -632,8 +633,10 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 			flags = 0x03;
 
 		ntace = (struct smb_ace *)((char *)pndace + *size);
-		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
+		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
+		if (check_add_overflow(*size, ace_sz, size))
+			break;
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -642,8 +645,10 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		if (S_ISDIR(fattr->cf_mode) &&
 		    (pace->e_tag == ACL_USER || pace->e_tag == ACL_GROUP)) {
 			ntace = (struct smb_ace *)((char *)pndace + *size);
-			*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
+			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
+			if (check_add_overflow(*size, ace_sz, size))
+				break;
 			(*num_aces)++;
 			if (pace->e_tag == ACL_USER)
 				ntace->access_req |=
@@ -683,8 +688,10 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		}
 
 		ntace = (struct smb_ace *)((char *)pndace + *size);
-		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
+		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
+		if (check_add_overflow(*size, ace_sz, size))
+			break;
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -720,7 +727,8 @@ static void set_ntacl_dacl(struct user_namespace *user_ns,
 				break;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			size += nt_ace_size;
+			if (check_add_overflow(size, nt_ace_size, &size))
+				break;
 			aces_size -= nt_ace_size;
 			ntace = (struct smb_ace *)((char *)ntace + nt_ace_size);
 			num_aces++;
-- 
2.53.0


