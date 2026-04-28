Return-Path: <stable+bounces-241709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EaZiCdDe8GmLagEAu9opvQ
	(envelope-from <stable+bounces-241709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:22:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE94488C5F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C13D30BEE14
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8C44BCBB;
	Tue, 28 Apr 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF8o9uXw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4544BC82
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392503; cv=none; b=bBmbwZsrHBPOpT2gVFtynKVb+19zkRkkp/IwwQQ6DH3XKOy+NNTPWUWZIzEfUSxAKZXtTFgZBoEk6KWva1Z6codoNMipLSRvayC5SeVDVOi+LOUqsh3mhhJjnkbp0dHUpyjHlLrr5tnxLAW/o6hB4NHLziuYsOIIGcPbA7If+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392503; c=relaxed/simple;
	bh=8qx2DRUX1B48lgDcMV0H/JoKZ5REdvkIb7aId73YRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsYj3/5nhq4GnDKusSzs7juopZc4EuY8fKTISLwbxRHGB/e1oVUe5CxCjhLWhOXAXS3t96XknfG7IrcNofLpNf5oQbTSP8Y1VwGDqQj5tcNSOTLaNe6g/Pj0Sxi6bMEkYD2otKJl11QTwGSRlBFycowPUQbyRMMd8C6G53o6jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF8o9uXw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b23fcf90b2so110900375ad.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777392501; x=1777997301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMpfJfDPYLUjScq5XH3LfedUkhoimyWrZal8ssI+6ww=;
        b=QF8o9uXwTNB6iqsDHqVB2oAVGPmUvmiQ27OsnWe3YCOZoikJdJgbsOFBGVVaHIpwBQ
         xcP3sJ2Z04SM28XEbj5irhEKHN6GmjtLNFyIJQIZcbzkyFiUgwzGF+4v9E5B9xUKPYuS
         iBCaOPMzRTX3MMy7jXNTS0NWbwCnBVkY3/ywGrb8xkSU5aWzlYiR+BprkfiHjSIYNYlF
         c2pMUs8M7FUCsc+TPk4csacEsNX8N3+IrCqrneYYKqgrxwkdKT1bJ2+IRbpBJBXH+q8l
         jctJ/VxG16DrpifgEQdAJpcUhAYrf9QARtZQzdqzsfUBKr/YZQb29CaMcD/7c/dhiDPq
         RzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392501; x=1777997301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMpfJfDPYLUjScq5XH3LfedUkhoimyWrZal8ssI+6ww=;
        b=glz7+DfOzf8weI1UBQ0fBz7MsMfCXChXm/8+AoB7UVOmsnJTYkupXjEKlQm5uMzTBB
         mCk2dHcbSjlhtsOaCMEpbR6Ej7c4wf1InxzTGq0kJBzHVjsl3A/F9x2zKVu+0p2Ma/3l
         HUjFkNJpHjJY0Y/gqhFWlwnVS+SOYkRzPJh2ByXZLlLDOgKVh4mWFWihqqFzQjIavezr
         ld+DHmy3yjHzo+708xWbF5vXmBnul6tSFMWuU1UXSGRc6KuZZqwpUJ7Ij0ytkfoGWbM8
         WTjprx0XKq4HKUClhhKHDKi40xkcFfSK9b0Me7GlG1ux5lKjCuZQUzwYTmrOmZ2RSKtX
         I9vQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AmA2iRqgutJsVQdXAZG6cK8Ksys/S+pAi3Wh+8difBPJ5qHg6/j//i8MV/wx7cL4Xu0GrKOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQG8W3lVV/nexQKNqXJlrBFgrOBY/Frip7JZVfOu7eLW1c8crU
	ZoATv2nCFkwfqgepjNnbav3HLjtwNQaoyoSmQX2ERxkBkPHX8EyiPslA
X-Gm-Gg: AeBDievorNG7TkswVd/8FfiUMLIcUpoxnKRjphQ3S8cV4OurF2K1jsA48JQaCwt0hxd
	dlrLWMmSZr7ZshdtK4TK4wjENqWkDD7J0qM+PWiuu2+pWGIaC29Vjm77PoNE5GR/QAJfhWyqSez
	Bj8eKHiMoTStOwh3EEGt5MGyyn63tfkCIRU42uXAzpjSS99zEUGbJo3XnzVKw+gNbspsuCWSPnK
	ML+MVVc1pn12hhoKcxjpAyddNhlwlRiqOd3HCxfiSWgkmm9x3+AXCWuhiiBrTjDFF4OX3BGlYM1
	Ft9Tap0f4WSjTQbyTfwcfQqL7Tn6S8XPPRkzkX52rHE08o34V1+aDSZ0CUEewrbbVyh3e21jkXw
	kiJjyE9M2w1+CRz4Xj+kx4wuCFFSUWuEFkZWGpGQQekyRp2LtMjf028iolrtu0NtOqXccVbzdYU
	fInKSOnw5sAMDagfV1yn6Lr1a2Mp4ImttZZcxxYri+1+iC0pvlQ+uTxTWTSeaipRtO
X-Received: by 2002:a17:902:f550:b0:2b2:5491:e32b with SMTP id d9443c01a7336-2b97c462246mr39487505ad.23.1777392501215;
        Tue, 28 Apr 2026 09:08:21 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac7894csm30864465ad.50.2026.04.28.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:08:20 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 02/19] cifs: abort open_cached_dir if we don't request leases
Date: Tue, 28 Apr 2026 21:37:47 +0530
Message-ID: <20260428160804.281745-2-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428160804.281745-1-sprasad@microsoft.com>
References: <20260428160804.281745-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AE94488C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241709-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Shyam Prasad N <sprasad@microsoft.com>

It is possible that SMB2_open_init may not set lease context based
on the requested oplock level. This can happen when leases have been
temporarily or permanently disabled. When this happens, we will have
open_cached_dir making an open without lease context and the response
will anyway be rejected by open_cached_dir (thereby forcing a close to
discard this open). That's unnecessary two round-trips to the server.

This change adds a check before making the open request to the server
to make sure that SMB2_open_init did add the expected lease context
to the open in open_cached_dir.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/cached_dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 04bb95091f498..64e22c064fa0a 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -286,6 +286,14 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
+
+	if (oplock != SMB2_OPLOCK_LEVEL_II) {
+		rc = -EINVAL;
+		cifs_dbg(FYI, "%s: Oplock level %d not suitable for cached directory\n",
+			 __func__, oplock);
+		goto oshr_free;
+	}
+
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));
-- 
2.43.0


