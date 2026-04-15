Return-Path: <stable+bounces-238106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDarEKx132lWTQAAu9opvQ
	(envelope-from <stable+bounces-238106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:25:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894C403BC7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 409BC3027157
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0913264E2;
	Wed, 15 Apr 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diaIpdD7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AD378D8E
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252323; cv=none; b=cb5hCitMvpGaS0kzzdo8Q8j2L5AZLAgsECfr4THhbl0h1nqkdRCWWlxyV4Z2oe/c7Ob1xa+Zxzv3mAWTbViBzzz7/MquBGtHpSLd4B14dSdvF5pITpWSBqVaVx+QbqMtZlgCW4pn85wxQ4UJ/GwsC57hUuwANNe+b+YZnKG5B7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252323; c=relaxed/simple;
	bh=U5CI1dkHZFucrf1FtoI0iIBoTcbsjPIrp1ozHF2ILDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEHFgm/57rf+QxulE2hO1SvPYI8cwhe3DW+5ujnu8b1uOVFcmpDQCE0k58n3TJs4qrwl0IkevABk0H8+Db0SIL7t1Od2VcbtbPHV+8k69EHzvC2Tq6VQmF1DXUooMtn4Xd6IzpO6dwH3ZkA1+/I9+y4JOJKugcyKA62qXEbdHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diaIpdD7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d6144877aso68437641cf.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252321; x=1776857121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ7blFUvJD3xjZodcquJvVuRqv0FWfvmqE9ECTkmuRY=;
        b=diaIpdD7PJZCVVUdkz47Bvbnl/9i6EqWNx4TEdt1M21S+sElexqNmmpSlHHbGC9212
         4rsRFEDGrsj8h1XLlighPrI0uG+0MMZ6W1wLpe9+ZBnp/nM2IaQjO4bmJFvXV+QA/BEm
         K1+mZooyELk7t6nHyUp7jHBB9bw9YrphScFzrdyNU2SaEVAIi5lNWeAEv9iQSAa+jEeQ
         kAsTxmSstf63eWc9Adf4twsFHUjI2ok+aPlnF2Fq7lz9nBJkfmC6ORd9KVn58iK4BTtf
         e5PFZ/Ci51IZUorchkyyePUeI4PAqSka7dTLHlA5yFrNfK4+3R+83B4FwW578uih/usU
         Da4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252321; x=1776857121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJ7blFUvJD3xjZodcquJvVuRqv0FWfvmqE9ECTkmuRY=;
        b=j/0kUxq0JUHzF+UDOYvV99ZDeywTrKvh5zLpooLP884ycgpMNOHQYC8OjAUDPbTHm6
         XuYrmddBTB5ZBoJ1Ult1i1N/Mtp2rmVE0kSdESopvr/7b3ekNZGiKZ2Nwny3ctbTSY1m
         8aNiQV1EriXDbmxXcJl0NeYCJ+j3OkG+QBDnEA2QciFzIwTjCzXOypmhniIt5ucG2ns0
         jWoX9qAwsIZ5TqXr2By0KCA/j6KlOtcR1wG/+7ydtBUHiRc5QTHRLzRab4RBAGI8GVbD
         BIsdHTjFjGyV72FAOW00++wn9gPAs+KGH6jrbVyED6UlN2Nzf3mZrWQZ8QjZwcESd4Z+
         7AUA==
X-Forwarded-Encrypted: i=1; AFNElJ+BkY0+X6avU/IllWAjh1yLza2RQgYYXHk5wHTh/z+avTdeclRZ4nqXK6eOc999nLegenjeiEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCO9ifgfpX/fg/W6KxTXYPS4v79s9ngUF/Cqd3MeuzvuxNIz7
	r7EulP51NVSmbrnbhiqt1RMRavBF3Y6NKRRLgIBfefzWd4B1XelGj1/O
X-Gm-Gg: AeBDieuARu66rxAKP69Kthp/OJxGAJ6OCqB2H2JMzeGPA0DZcxKY39VJ8Fw0XI3sWZJ
	onRYOipLa0AeVjkxZSV0wl/fMLm8e/UZOG0ug7gWZpDZzTM3mTu5d4ixab6H4MgrM+nIZkzAT9B
	Zcsaca8Ww5SxESAVODEPd0MmblXL7VPiCgM9/gMt+sIGBSVSNDjBuwlhHRt9LGgzXRpAgjC0ScZ
	4fRWwDZLqpp1UN5Oiz4PMn/L6vW8HAEJ+HuM2m9LSiz7CBsO0LzSlfw/GfbGKv3Vu7EaCAImVxW
	oYf2omvz70MNoC9NPAJQ5+T4Ppw20zvXgsOQA6dIxfcP1B4qIlSJsgg8QQb3LWJ2B+5dlpVHTd6
	AE9yEKUGQYPdccl4DB7NYUDJZeCkvo1Kcz0RoVTKHAB74PdqKqHL7sp4Vh9tc5q3Krv2QN/t7Qj
	3COC+n/OmP3Di60r08ex5tfujpEgudtDTCzFIlx/NoInrnqHVbwyxwdIvuDArCWl590QCL15AOr
	R8FadkpOrYhqcqCPcgjZBRQ6liAL2i14vPmVVTj4rR4ACRepwYjIQ==
X-Received: by 2002:a05:622a:a945:10b0:50b:5336:1d20 with SMTP id d75a77b69052e-50dd5beac96mr247328681cf.53.1776252321175;
        Wed, 15 Apr 2026 04:25:21 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm10621191cf.16.2026.04.15.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:25:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] ksmbd: require minimum ACE size in smb_check_perm_dacl()
Date: Wed, 15 Apr 2026 07:25:01 -0400
Message-ID: <20260415112501.116426-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415112501.116426-1-michael.bommarito@gmail.com>
References: <20260414191533.1467353-1-michael.bommarito@gmail.com> <CAKYAXd9EBFBcy9bJ3=sJiYVYHAYjKYqOqD53UCJ8zWKXF0sAeg@mail.gmail.com> <CAKYAXd8B78Gde_7+Ph0cSL998k4qqs_okB0jky0m5h8i25_AGQ@mail.gmail.com>
 <20260415112501.116426-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238106-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2894C403BC7
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


