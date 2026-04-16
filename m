Return-Path: <stable+bounces-238363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JOlLQlB4WmaqgAAu9opvQ
	(envelope-from <stable+bounces-238363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:05:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A258841470B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 484673016B04
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861EA34B1B4;
	Thu, 16 Apr 2026 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLNWkov4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEA3ECBF1
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369906; cv=none; b=rcwnlAMi3eGsFu809vZqwTWWZnoqIKPwaGbDx7+ypZ8XzK7TasEe/WxYC3CqvDnUqZrsHufgcZwIJ4L5gSuMvw9RVCwfVp2z1gP82N8gKLiXvO8QM1EkK8xBevwbJ2UmXAVlMmjKZk4oGVnucuOi1snjrIb5trnhrtW0WC/SAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369906; c=relaxed/simple;
	bh=A4WGfbNBFS+TdPdlv/yvtGkWO3BanuhGpctzicatogg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpiywaECshO7Y7JjiQC3mnOfKG42ITBqT+yxwegvj0WMfH5k1er7yVhtxLi5n2yS3LHtdbi7rQBHumre1iB8nqm0WOPDCXo9sZ1HSbq1nLqr9jpIUQO3hQsLMjziVQwcuKUnnpsK8DV2DqLgZ9eokLj+K+4PfL8PKSfa9EDfyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLNWkov4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79ea87af213so16342647b3.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776369899; x=1776974699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiiYXSwG5ruRWxUExLzY5qAI02mOLD9DcmFtQKqN3Hw=;
        b=eLNWkov4H05Og4pWFrsxQ/DAKPjhjqj2CgcKZRmNGVUU5niWTO80IsxxqsYkj+Y5sx
         0r6VpOl+pSbybxQDaBs3A+VplPsPGC+iBd8qfwgxMB/4697t51Q6EjQ46+957Vvezw3e
         uPzYjQYpnOJ3/VOS6cPVNDz3+LHdsrdqBqBOsfJx5FvbdB1ccGsZIV+uWEVByebV3tAi
         I8HXuclvegWdSHJR+3Mruhz45IJnaKGiu8glT0dtMVfrpq8Sj+VVFKQNS4RuXpajlYxD
         6kMrWk9a3e1Wx3jhzI4UijZRHFlglc3j7TKEb//m2R+aaB87jqJIJIiLi/hNCKutikPx
         xnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369899; x=1776974699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiiYXSwG5ruRWxUExLzY5qAI02mOLD9DcmFtQKqN3Hw=;
        b=CA8M5wTnLd8+/UIFhvEmdjfpuQO1rfbuAZwBpgSC0iQHl0N71SjvI4tukeJ9gbip8v
         ZAacuXjTy10Ikx3n1mHvfmD/obPuWmngFcnbf9tf8ek/nDYK5SBBUM8oeZTuLewADx1n
         eh8vqhA3qtUqCOXW7wecbYXXoOwszrmuni/ZtLFm6oa8RXArasIsvUmMn54tojezcMo4
         PozlcJUkU+AB3ty18p/jfugCfcYF9aHxFCFIcjIAXHGluEsZrAppueDi59LdAZnp6aYH
         yxnMmf4JXEIxHw9BbdpUFhtqDV6Lz6MU8FMC6OoArgKOZH69049d+Gzyd8i0ji7fFKwG
         PJmA==
X-Forwarded-Encrypted: i=1; AFNElJ9bPUewkIH7DhrD8VaJQ/R+KCxjSfwAaz2kcMCsLAoXWNVXC4EhhRABNmtdgvT2QG/OjGcmJLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCOVS0Mj/YHcN3soEiH/u6oFIEjsnsc8j6FyO2E6WgXUkKszA
	6aS7fCQeV+V6u+0oxYetEWczEph7EanstMdkiAi0xfVrnWZDToIhXQnl
X-Gm-Gg: AeBDiesa0rIGAwUqo+1P2SKnxy6ZxLbaN2DjO1/gcAIVthX3peDlIrmEQQzWn+Dr1UY
	jtXKdgIIa/WXfBHc01zeDUNt1fl7rJpmtwahoic7ng0QwxPd3sgfrBrkU2f+dmYy80najGUlC3t
	jb872df7m5ZxwuTfiZKXuA4EnsmbCNvHa3SR+sAGuRCUEbbTYhagm5ST2QW5ZNho3ockwZ+6yNX
	a9AIp6oRA4Tq7IFqoivPPIWadtP3iO64P0LRI7zMBa1W2Je40kfdHvJQV0ZOANF0NFBlnEDTPoK
	5kvtdfSHqnRDapJ/LSFyowhr5KznzYpZUuGkEqcJheL7/tsTfOawbkMqqpA/LZ5ZkNtF5q8moqD
	6XYBPuRZJY6Hio+0ThlP0PlgyypL//yENMdgvbNyYhnxBHomKrPev8Kdv6v+dsnt0B8BKVtAvXt
	OsrxioW8bkyenfWKz1iFK8sjBHl/enug+5PSIMcsouJ32zoFsvF2SO1qlO3xpzPuZ83ZmDPvU0d
	YumZu375K4DbQlwFSBvFyyACnEDqIla/mBrSty3tb3qV1WVwcsgLRHX4GFPnpuZ
X-Received: by 2002:a05:690c:86:b0:7b0:3180:e827 with SMTP id 00721157ae682-7b9d8195b11mr5990557b3.22.1776369899204;
        Thu, 16 Apr 2026 13:04:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e640504254sm208810585a.28.2026.04.16.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:04:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	linux-cifs@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()
Date: Thu, 16 Apr 2026 16:04:39 -0400
Message-ID: <20260416200439.2987930-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238363-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A258841470B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Another one on the smbd side this time. smb_inherit_dacl() trusts
the on-disk num_aces value from the parent directory's DACL xattr
and uses it to size a heap allocation:

  aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, ...);

num_aces is a u16 read from le16_to_cpu(parent_pdacl->num_aces)
without checking that it is consistent with the declared pdacl_size.
An authenticated client that can set a crafted DACL on a parent
directory can declare num_aces = 65535 while providing minimal actual
ACE data.  This causes a ~2.6 MB allocation (not kzalloc, so
uninitialized) that the subsequent loop only partially populates, and
may also overflow the three-way size_t multiply on 32-bit kernels.

Additionally, the ACE walk loop uses the weaker
offsetof(struct smb_ace, access_req) minimum size check rather than
the minimum valid on-wire ACE size, and does not reject ACEs whose
declared size is below the minimum.

Reproduced the ACE walk OOB under UML + KASAN by constructing a
12-byte DACL (smb_acl(8) + 4-byte undersized ACE with size=4,
num_aces=1).  The old 4-byte guard passes, then reading
ace->access_req at offset 4 within the ACE triggers:

  BUG: KASAN: slab-out-of-bounds in kcifs3_test_inherit_dacl_old
  Read of size 4 at addr ... by task mount.nfs4/220

Confirmed clean exit without splat after patch applied: the new
16-byte minimum (offsetof(smb_ace, sid) + CIFS_SID_BASE_SIZE)
rejects the undersized ACE before any field read.

Fix by:

  1. Validating num_aces against pdacl_size using the same formula
     applied in parse_dacl() by commit 1b8b67f3c5e5169535e2
     ("ksmbd: fix incorrect validation for num_aces field of
     smb_acl").

  2. Replacing the raw kmalloc(sizeof * num_aces * 2) with
     kmalloc_array(num_aces * 2, sizeof(...)) for overflow-safe
     allocation.

  3. Tightening the per-ACE loop guard to require the minimum valid
     ACE size (offsetof(smb_ace, sid) + CIFS_SID_BASE_SIZE) and
     rejecting under-sized ACEs, matching the hardening in
     smb_check_perm_dacl() and parse_dacl().

Let me know if you want 2/2 instead of this single patch.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/server/smbacl.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index d5943256c071..fc4fcd48d6c9 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1105,8 +1105,25 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		goto free_parent_pntsd;
 	}
 
-	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2,
-			    KSMBD_DEFAULT_GFP);
+	aces_size = pdacl_size - sizeof(struct smb_acl);
+
+	/*
+	 * Validate num_aces against the DACL payload before allocating.
+	 * Each ACE must be at least as large as its fixed-size header
+	 * (up to the SID base), so num_aces cannot exceed the payload
+	 * divided by the minimum ACE size.  This mirrors the check in
+	 * parse_dacl() added by commit 1b8b67f3c5e5 ("ksmbd: fix
+	 * incorrect validation for num_aces field of smb_acl").
+	 */
+	if (num_aces > aces_size / (offsetof(struct smb_ace, sid) +
+				    offsetof(struct smb_sid, sub_auth) +
+				    sizeof(__le16))) {
+		rc = -EINVAL;
+		goto free_parent_pntsd;
+	}
+
+	aces_base = kmalloc_array(num_aces * 2, sizeof(struct smb_ace),
+				  KSMBD_DEFAULT_GFP);
 	if (!aces_base) {
 		rc = -ENOMEM;
 		goto free_parent_pntsd;
@@ -1115,7 +1132,6 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	aces = (struct smb_ace *)aces_base;
 	parent_aces = (struct smb_ace *)((char *)parent_pdacl +
 			sizeof(struct smb_acl));
-	aces_size = acl_len - sizeof(struct smb_acl);
 
 	if (pntsd_type & DACL_AUTO_INHERITED)
 		inherited_flags = INHERITED_ACE;
@@ -1123,11 +1139,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	for (i = 0; i < num_aces; i++) {
 		int pace_size;
 
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 
 		pace_size = le16_to_cpu(parent_aces->size);
-		if (pace_size > aces_size)
+		if (pace_size > aces_size ||
+		    pace_size < offsetof(struct smb_ace, sid) +
+				CIFS_SID_BASE_SIZE)
 			break;
 
 		aces_size -= pace_size;
-- 
2.53.0


