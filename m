Return-Path: <stable+bounces-237960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKqHLiKT3mnZFwAAu9opvQ
	(envelope-from <stable+bounces-237960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:18:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397363FDF9C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D537930547CC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F482DCBF4;
	Tue, 14 Apr 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWSEAA78"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7352248BE
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194142; cv=none; b=cO8Som7qjMUm5xbetl+22rI2pdNSk3p1O7dGpXFgbgY4WiuifkuOHXhlIX2RzA11PL8PpilaQFElD6gQVz5jO122QfHl0lSPEGZ1f5lP1Jv591S+Qq0t5PX2pYwbw477qr/vjrklJponuzAr079RkbeqbgHzezaJnlItFDBJlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194142; c=relaxed/simple;
	bh=0V678CI/bTL105QQk2LrBJXTTCkcQ43Nj6FSGsr09bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlY+blTIt/JJGX4jhCl1ra6vrYV8axyDd4fjJfR9Na7M+4g+0aR/uhMQdI4bJI/mKFLVC45zobCIQMDtA3fG2MQJ7nhhYH84JShpUitV9F15rs9uaaqUo0TpV02tclwweWYaZwKzLGWyWvLb0EHWkr7/7gPMrslQ2Y/7nLqcrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWSEAA78; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfdac74050so617026985a.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194140; x=1776798940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgctrOw+fTa9HS4kEjyzcX1BTeKi0lvTfjC5zn/MPTk=;
        b=AWSEAA78E2dCwd1o8hO9Bo4k1B4oIc8Prs8JJWJb/K/mniBK91sPSoijbdL4n2WQJ+
         r3K2kRTOF4/CDgJfPNqssh+2D1ESD2jy0ldN2Knp7fD5kBwYLddtYGLd7yT8SUo+aLXr
         yDjQr8SfvI7m/zHLUr0GkBjtltihdVl4bBLCnHX/Lpm7RYbFh6KRdkHLbWHxLwVJGEFl
         nGnlJFBF7g8BlUceLvKco1to8Cad1uN9wa4zh1cWdj1WHwGn5321p/BZB5NauMF3Z4Fv
         dQL48ZiLpMCWAY+Al3iPIWoBssVquHmogFve/0Bk/KbjLoekyY36jkKTeipREqV18Zfc
         F21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194140; x=1776798940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AgctrOw+fTa9HS4kEjyzcX1BTeKi0lvTfjC5zn/MPTk=;
        b=SELalqfD+4KLRaCIYW4J4ujnwCRmuHEAtlHq6eOdY9NoL6kM76wr/9fZkIPp6JIkg+
         Ro7JraBy2+DtkBmP1jm3HNmIybqUEREa/LciLXt7cL9OwldYtFeX780I1mD8+j06Q5vv
         1L2TSElEoDIhSmyRewX5D0bu8QXK3Z/eiN/CLYATpthAGEKuVGNOiQegveCUK5iedu7g
         LI+EwZzvpR1lPs5Rnx7LTRdzdWyReb8vuvTRWjNxv6UKEEQYHgX4Ev7DVhk4786nDZFi
         krKeAdpMxtk8Az7kxEFjaCIkI55UcUqx/gFSuzLr/eWZ30gCq1DWvLDQEIrbXNLGQSln
         xzlg==
X-Forwarded-Encrypted: i=1; AFNElJ9xA2JZG9baeDETT6YK/G02SYOqDo3mR3aMOM2ZPPrdhZ0QathIBTz0JYeXjuJeuhQ9ZUHadpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+zdXbrOmbQkLWOuIMdCNi+r5GcGTCqz5cIhyPYUmCnJkxbRo
	rneDjoqzMt8NzOoL3a9BBWx2HD7lgGio9guwY7073lKzz/5JITtzh/4g
X-Gm-Gg: AeBDieuI1dhRdqum2wvPnQNnwBiIY6mXVgkDESBgprvQu+nYXr4OS5uRd+yzpqWnecv
	Chr8v9ai6yGGxS1uIb5lFNBF7/ueFjlqnaxNcORaEuDTXBAVG72VYspkmuEa0Wey4hLTYS9IdzW
	6zKFyojb0XFK3lo+H6+dYPbH+yqACBQNB2Plme1rPWmFa5Kt86cT9cLS3f9h/89yTWJZItxKAeh
	GQxBn0Yob23v8DTl/6Qm74dwocpTtjWpwdeiK6FzUbIAqbA0gb47W6bUmEj0zotq0fQzU23lXZN
	DF7efJarPlqLcSpqWIos0JUEkT97kxM/1xEutvDrdIHRiyhbtPwRXv3FNsesqSi6+xdlqyc0YOq
	EqYT2QXLCgjC6s8f/pJrlpJH/ExPq33dV8iziRs4fLQeaR4RVC8g3l8sICOHVe9e60EbxM/QHYA
	bDRwswA2ij73bhLEX3vttmEVp2R9umV7QsUGe/CPH0l96Mizdm7CNTIb+IKGehHCb9VEmpMkEhZ
	Fk79pNorFZ6P9Ikxa3E4a+OA5/ArvU=
X-Received: by 2002:a05:6214:4c8f:b0:8a6:1545:41ae with SMTP id 6a1803df08f44-8ac860ef7b0mr284828526d6.15.1776194139885;
        Tue, 14 Apr 2026 12:15:39 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca478a70csm77229126d6.27.2026.04.14.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:15:39 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ksmbd: require minimum ACE size in smb_check_perm_dacl()
Date: Tue, 14 Apr 2026 15:15:33 -0400
Message-ID: <20260414191533.1467353-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414191533.1467353-1-michael.bommarito@gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237960-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 397363FDF9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both ACE-walk loops in smb_check_perm_dacl() only guard against an
under-sized remaining buffer, not against an ACE whose declared
`ace->size` is smaller than the struct it claims to describe:

  if (offsetof(struct smb_ace, access_req) > aces_size)
      break;
  ace_size = le16_to_cpu(ace->size);
  if (ace_size > aces_size)
      break;

The first check only requires the 4-byte ACE header to be in bounds;
it does not require access_req (4 bytes at offset 4) to be readable.
An attacker who has set a crafted DACL on a file they own can declare
ace->size == 4 with aces_size == 4, pass both checks, and then

  granted |= le32_to_cpu(ace->access_req);               /* upper loop */
  compare_sids(&sid, &ace->sid);                         /* lower loop */

reads access_req at offset 4 (OOB by up to 4 bytes) and ace->sid at
offset 8 (OOB by up to CIFS_SID_BASE_SIZE + SID_MAX_SUB_AUTHORITIES
* 4 bytes).

Tighten both loops to require

  ace_size >= offsetof(struct smb_ace, sid) + CIFS_SID_BASE_SIZE

which is the smallest valid on-wire ACE layout (4-byte header +
4-byte access_req + 8-byte sid base with zero sub-auths).  Also
reject ACEs whose sid.num_subauth exceeds SID_MAX_SUB_AUTHORITIES
before letting compare_sids() dereference sub_auth[] entries.

parse_sec_desc() already enforces an equivalent check (lines 441-448);
smb_check_perm_dacl() simply grew weaker validation over time.

Reachability: authenticated SMB client with permission to set an ACL
on a file.  On a subsequent CREATE against that file, the kernel
walks the stored DACL via smb_check_perm_dacl() and triggers the
OOB read.  Not pre-auth, and the OOB read is not reflected to the
attacker, but KASAN reports and kernel state corruption are
possible.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

fs/smb/server/smbacl.c | 17 +++++++++++++----
1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c30d01877c41..d5943256c071 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1341,10 +1341,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, access_req) > aces_size)
+			if (offsetof(struct smb_ace, sid) +
+			    CIFS_SID_BASE_SIZE > aces_size)
 				break;
 			ace_size = le16_to_cpu(ace->size);
-			if (ace_size > aces_size)
+			if (ace_size > aces_size ||
+			    ace_size < offsetof(struct smb_ace, sid) +
+				       CIFS_SID_BASE_SIZE)
 				break;
 			aces_size -= ace_size;
 			granted |= le32_to_cpu(ace->access_req);
@@ -1359,13 +1362,19 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE > aces_size)
 			break;
 		ace_size = le16_to_cpu(ace->size);
-		if (ace_size > aces_size)
+		if (ace_size > aces_size ||
+		    ace_size < offsetof(struct smb_ace, sid) +
+			       CIFS_SID_BASE_SIZE)
 			break;
 		aces_size -= ace_size;
 
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+			break;
+
 		if (!compare_sids(&sid, &ace->sid) ||
 		    !compare_sids(&sid_unix_NFS_mode, &ace->sid)) {
 			found = 1;
--
2.53.0

