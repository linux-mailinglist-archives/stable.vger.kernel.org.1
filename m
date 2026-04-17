Return-Path: <stable+bounces-238516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cYoJByCQ4mmX7QAAu9opvQ
	(envelope-from <stable+bounces-238516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3966E41E640
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44A163003BC6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220ED3ACA41;
	Fri, 17 Apr 2026 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGnDF11z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C61355049
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455701; cv=none; b=YscyNckBTe4JdTU5FmOj2Cag66PT3eLP87sKLD5AJy0G3A8m3qQhrViA321Iw2iendB88+K4FSMuH8oMR/BVkhCu58FqljFvcLi+sMu4QcbZ3entlGJbQF6tKsmYUDJWeQSYpYIwV5dcmA2qLoU8kAuondYdAL58BG70W1mnDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455701; c=relaxed/simple;
	bh=g1a4NjQ0YasAtH/RDF+pfDpWyspBU5f8h0C0GiMqcmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/NpR/FT4v/HID6DGUbNGjq+Id75NsYVCiIND7TRJALAmhsWUjXSvMzJRAWaurJrLx3pj152m5WigQT/BTEVIe93HXWWsWzMl4wrUMIWqRQxDYMGKdQ9JLAPsDQoDzZEyiPlcUl8LCvJ/1ljo1tDBXGb87FbUHfiTHOIJaOmWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGnDF11z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so3017955e9.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455699; x=1777060499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9XW0gTTB47FyXrLw42IqaYzWKbmSzjD3wkWgsQ0RHA=;
        b=hGnDF11zTZbe4YJBWqxuGr/mTz/IssuaoyKF2RbnSTTpTB4opu6b7NqD8x1wBpzmvp
         v83Fg77/r0BTnG9qfW1OWD1GW1hUfTRHawRuP0xBID4Ns9n7mUOOrQePm+lV9MQwWRFW
         CNyqY7ACRJFHNEdI/cuewgUg7T9Sqc814mUUiVI+Ha3vJIFwiZsMB/pVc57nRfLlgXDE
         1RZrsoXM49f4RU/gWl6lVoERTugnL637p6M1xyfZ/YQCSgJxNk4zGUQzRji9y0oYBto+
         aN0T2pvoJYQkuPXZxm7pMjpjAW+vKz1m5/MrfJxa2yFmPwgpWsFYjKrmFEzIx3I32o/y
         gNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455699; x=1777060499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9XW0gTTB47FyXrLw42IqaYzWKbmSzjD3wkWgsQ0RHA=;
        b=jE3yc8ddVbdg+ajNFnCYhZucWOV+bPugsLp4RpD9lGAFdPuixCSZC8BBhtKEAMcwM+
         1tsUifP7B5dtovdnR8zqSgSLlcfIBDVrO+0VXotYCg/l0/ai6E3HWbDQ7fvNbmsTtUR8
         JDPgiLbk/7WI50nucrk5pcT9EDzHJII+/cXPZQslbsiRcPkOgwLlFzb4jcRTsmqTuYUy
         BwfVYg4wfBRFLhhluS1jDI86GzxJv8IMsZDl0Xgz80a0QKwEjmvBRe81ZLdBT6zp4Jwj
         NZ9ouh8x6Oo7ecbneIUh0An8zbJPWsoiF0PJ5j7KNpT4F1cnGOKKoOxjqWpkrg0gQFMK
         JSzg==
X-Forwarded-Encrypted: i=1; AFNElJ8gbtaGsknZA/darfLPDhyZgJcgLjE/ixIyHlioVoWcpIc0IoRUy3fKoLZETcHKTq9LQvDFKag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGavyadz58XeOQsEOdePgeJ7ab4Szc+56l8i0JABJJzDnHWLJ6
	TKi9eOrSLejk3+MEpR4r3A8UfHQXL+zCX6vfTUbUAR0ZcvLdjUjp/FA=
X-Gm-Gg: AeBDiesJweuA33+3xkfBFhN+DhyDc7JLRohripYiKjOCspDSrqvPjJk6Z2r24lT0ObT
	Rd75kUJbK1FwgcqKxBqJwvTtCvJIB+9/cVCInJa0ZzhO2osdujXLHjmQfpyOeL0pHFsOiC1VVcQ
	OECFUZU+WRDGP9zkXk/MITrFFiQ8O/T6pfYqAYyb0sJlZwcKSoby7FiXB1NRFbychNdiEyMvPQB
	d98oOi73Fhw4Zyl9sXCB+SEXt/RoeWkwE+g9tHAUR9E8teL+ViV69Z+IzkMo/HgVjg9aO5U7FOX
	FUd8Gt5SEKihCPV+D1iSFWnujUQqIaPV/4O0GMVey6ibCh1zs0y4knFcySOT7A3NUS14PsMRYGy
	tHluS+XhvAhwbvvLD//fXNKqLJrpUVWE9tQ5KCJAXDRRvE8kYWS4Epy8o9lC+vTxW6K6QdbkQK+
	kLy4h5rf6IwLHaRX9r
X-Received: by 2002:a05:600c:a309:b0:488:af14:f1da with SMTP id 5b1f17b1804b1-488fb74dd31mr50828305e9.7.1776455698741;
        Fri, 17 Apr 2026 12:54:58 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14104dsm66202165e9.13.2026.04.17.12.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:54:58 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: security@kernel.org,
	Steve French <smfrench@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ksmbd: use check_add_overflow() to prevent u16 DACL size overflow
Date: Fri, 17 Apr 2026 19:54:57 +0000
Message-ID: <20260417195457.395596-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238516-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,talencesecurity.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3966E41E640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 fs/smb/server/smbacl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 061a305bf9c8b..8c126c6e5fae1 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -596,6 +596,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 	struct smb_sid *sid;
 	struct smb_ace *ntace;
 	int i, j;
+	u16 ace_sz;
 
 	if (!fattr->cf_acls)
 		goto posix_default_acl;
@@ -640,8 +641,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
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
@@ -650,8 +653,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
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
@@ -691,8 +696,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
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
@@ -728,7 +735,8 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 				break;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			size += nt_ace_size;
+			if (check_add_overflow(size, nt_ace_size, &size))
+				break;
 			aces_size -= nt_ace_size;
 			ntace = (struct smb_ace *)((char *)ntace + nt_ace_size);
 			num_aces++;
-- 
2.47.3


