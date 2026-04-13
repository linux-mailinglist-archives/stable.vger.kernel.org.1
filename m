Return-Path: <stable+bounces-236084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAFIJY7w3GmvYQkAu9opvQ
	(envelope-from <stable+bounces-236084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:33:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD13EC954
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBDD30154BC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993B03CD8A9;
	Mon, 13 Apr 2026 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJ0mhbN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA903CD8B8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087089; cv=none; b=UVf9ZEws6t5sU0IfdfGTimiLd2EvTJEjidLL82tqlMkDwQPIuq2J8ophflaNbzHqxrlmhCK1HlorKuvJmGSvaZECmuJa8cZGM2uiTjv1EOrrlA6xrcu7iIdobyo/X1pCnixZCzn/mBZ6kRVv68Eo747PgVpyOv3fFF/jOLVdMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087089; c=relaxed/simple;
	bh=NNF0oOpx6c/FbSF7aZoqGXm3gmeZfZbf1NphjvuVR20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb3g6bFHW9WxKKqBvvBdkz27AwaxhIG2z/nHBd49N+G9tXWh2qTayGWgWjH8oPDvZzt8mdFtPTaziie6oiM71T7k7NRtNlqXpygHGedtCZJa99NwEhuV4PVBirbGkyX+ZMNIAL1NaLNznIsoHDpmdfMTT37zQhdvp7Bep7Mi1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdJ0mhbN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8e0a768331cso124288785a.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087087; x=1776691887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cvX/3YS2hK9kgzlNtYASfb57GVegxtYM6rMLbYciK8=;
        b=IdJ0mhbNgApW8d+twXlzX9RhhdTPUYRTkxhGEqsnQqK8FP9UBx3LOyHzZJHEMYDG0w
         k3gANt1nMGhevjhpIVS/sKigAaZVNli9r0O8c//isB9ZeIQ4nPJdMBrsmbR4Taz1LtPG
         OP0BcxUPLqmo85rAkcKbRLVln3Rdb/1RsG2kW53+RZ/Qg5YaJVt6iww8s3RSiUDkDI3S
         AtuDNzdsWLliTUeVauHJ5Y+ebNTBoixrXAGC6ykzmA7A9fyOYZWVxx9yctNJzhiZC8Ni
         o0fHVdFpgk43q07K017vi6sOAcYx1jTH+XlUh1lQQBW4/GxBeKn5I/rybNs0LAs//5VN
         kCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087087; x=1776691887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cvX/3YS2hK9kgzlNtYASfb57GVegxtYM6rMLbYciK8=;
        b=DDLejYehHqHtmc4DHGrn3DpnIdru3Fbsy/lRnGTkQSCuaCPxU7m5rG6OJdt8WXrL+X
         EoThdzNcByWsNZDaEMy3Myp2mEFHEAnDoJsZSZSjg2ikrkY29CQ10Rl/V+5iWi8t88qc
         prc4Dem6z0vvymjFt8N3dWDQ0DeilvA/kylyAjn/UQC5eK3wUQS7WBoXKzA2q97wV5cC
         7Xw0mhdsQaxfkSCwBrSnYGHGyhoWFNcD9O3b93NqE6YFD0hjfzbG7YF7tqJdNqyRbmY5
         3isfSCtvprXUbatB59pHY2ojsFhbBd4R2UQyZPU6qa9Z4D54E3ccsr5+YCaOb9fYcFQD
         bccw==
X-Forwarded-Encrypted: i=1; AFNElJ/W0LekqT9Rc3LBD9h8+51bV9TdGmMLOFIwpBKswvD2rp6xkDGHuWv3Q4FJj7/kHPGCyzcv3A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QDu3W+cRLNmWg5LpXe/c4zhA4kcmW6F5kaDRBk3Au4MXNgsK
	wUySh2+/jnEwI9InkqefdUR0IXmyWCb/k8AAOkcqZfrTIGlzbsRgS5z9
X-Gm-Gg: AeBDieumYSnfAx9FbJvegXKKip8f9nNJfiFszeF4xA/NwiB9+u8wPvW0yNxEZkTIVF5
	Yr+LEPANj60EubUeAuIilW+SPn0GxnBZtE7NmA+22qTcqkRlqyhIt4BZoox0x1LuE97FBtUQFIt
	MW09koQ1ieAfpvozHxQhA9abbZ1N5EQDhdgGgrHv+QJYsXKdlsrIrsuDoMNFhodtn0WQ0X47RzM
	+/Zc51AYo7cHa/nVFm9AQmnmiN0KciQIgEu6jDkfTwrZkrgpGYywGKxdg4FAvbL4xSYDK1kehQn
	7tm0860Py5H+h0BOduJoAHyk0lhKQJMixaUXgn5wZ0VXjxBFTWAnXDJuHFi0RbCod+ivUrAw++O
	Zf47pwWhPkAgc5V9OIXArmPHSZnnn6MhLLfuRwxXU1Y+y8LrTLHOM9lptkqkZNLrruRqtOLeC2l
	CyWhvu5qngNz7kyYLuHhsDdISI5183J4nFvkIXOc6pibNpbmW/tT7LWRnkAeR+r82fX5qEGG8o/
	Ej8/eANfp4MuqUzO4yM
X-Received: by 2002:a05:620a:2892:b0:8d8:ed00:5a90 with SMTP id af79cd13be357-8dc45d29b5bmr2298150385a.23.1776087086763;
        Mon, 13 Apr 2026 06:31:26 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8de6553c460sm852666385a.43.2026.04.13.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:31:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: add depth limit to indx_find_buffer to prevent stack overflow
Date: Mon, 13 Apr 2026 09:31:17 -0400
Message-ID: <20260413133117.3687677-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236084-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07BD13EC954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

indx_find_buffer() recursively descends the B+ tree index with no depth
limit.  A crafted NTFS image with circular index node references causes
unbounded recursion, overflowing the kernel stack and panicking the
system.

This is reachable by mounting a malicious NTFS filesystem (e.g. from a
USB drive via desktop automount) and deleting a file whose index entry
triggers the rebalancing fallback path in indx_delete_entry().

Add a depth parameter and bail out with -EINVAL when it reaches the
fnd->nodes array bound, matching the constraint already enforced by
fnd_push() in indx_find().

The related function indx_find() was previously patched for a similar
infinite-loop issue (commit 1732053c8a6b), but indx_find_buffer() was
missed.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Found during a broader arch/um/ and filesystem security audit.
This is the same class of bug as the one fixed by commit
1732053c8a6b ("fs: ntfs3: check return value of indx_find to
avoid infinite loop"), which added a depth limit to indx_find()
but missed indx_find_buffer().

Reproduced on UML (ARCH=um) with a crafted NTFS image containing
a circular B+ tree directory index. Mounting the image and
deleting a specific file triggers indx_delete_entry() ->
indx_find_buffer() -> unbounded recursion -> stack overflow:

  Kernel panic - not syncing: Kernel tried to access user memory
    at addr 0x606128c4, ip 0x6012907e
  Call Trace:
   [<60611ec2>] ? indx_read_ra+0x0/0x677

At 168+ bytes per frame, ~97 recursions overflow the 16KB kernel
stack. Desktop automount (udisks2 + ntfs3) means a crafted USB
drive can trigger this without privilege.

Note: the pre-existing indx_node allocated by indx_read() during
the DFS is leaked when the new depth limit fires. This is a
pre-existing issue (the node was also leaked on any other error
return from indx_find_buffer); fixing it cleanly requires
restructuring the node ownership model and is left for a
follow-up patch.

Reproducer script and crafted image builder available on request.

 fs/ntfs3/index.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 97f06c26fe1a..2c43e7c27861 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2013,13 +2013,21 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 					  struct ntfs_inode *ni,
 					  const struct INDEX_ROOT *root,
-					  __le64 vbn, struct indx_node *n)
+					  __le64 vbn, struct indx_node *n,
+					  int depth)
 {
 	int err;
 	const struct NTFS_DE *e;
 	struct indx_node *r;
 	const struct INDEX_HDR *hdr = n ? &n->index->ihdr : &root->ihdr;
 
+	/*
+	 * Limit recursion depth to prevent stack overflow from crafted
+	 * images.  Use the same bound as the fnd->nodes array (20).
+	 */
+	if (depth > ARRAY_SIZE(((struct ntfs_fnd *)NULL)->nodes))
+		return ERR_PTR(-EINVAL);
+
 	/* Step 1: Scan one level. */
 	for (e = hdr_first_de(hdr);; e = hdr_next_de(hdr, e)) {
 		if (!e)
@@ -2040,7 +2048,8 @@ static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 			if (err)
 				return ERR_PTR(err);
 
-			r = indx_find_buffer(indx, ni, root, vbn, n);
+			r = indx_find_buffer(indx, ni, root, vbn, n,
+					     depth + 1);
 			if (r)
 				return r;
 		}
@@ -2446,7 +2455,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 		fnd_clear(fnd);
 
-		in = indx_find_buffer(indx, ni, root, sub_vbn, NULL);
+		in = indx_find_buffer(indx, ni, root, sub_vbn, NULL, 0);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
 			goto out;
-- 
2.53.0


