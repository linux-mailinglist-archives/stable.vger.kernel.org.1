Return-Path: <stable+bounces-73689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F896E705
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 02:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EC61F23D42
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 00:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFBD1401B;
	Fri,  6 Sep 2024 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YevAsn90"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A55186A
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584244; cv=none; b=l0j2SD/XD9gnra3+WQFKU+F2/XbxQhMDOX0LNWqnE7P9pzyw/afZvGDkhFVr+mOiuHgSBe7pKv3KCSBBTdHISLkFaMZaNaN7GlZv+iAJCl4tWIibX5mLzMut+vC1KcZ+R89+Mkn7nmjeeR0bUprWZ2w9WD9W1BS4geOPlfZ3U38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584244; c=relaxed/simple;
	bh=toZstqqK87m2FLu8Pp5V+KYuQhVDyEXiWPZ6WJL02IA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r+LLDKuB7fbR/u3nPPpZySZMSmxWy4nNf4ShA0i+v65lS59b50qIxhIQNLOnDgEV278ThS2LNEgl4/nS95PQkz3Uzc01KMDlv3LyCVAD8UJlYCbzZqOS7u+LzezPyMpXajyp5cqsrMXA3tBo6rCPz2KnmJX4HhkyVCdlEESQbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YevAsn90; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-778702b9f8fso1420203a12.1
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725584243; x=1726189043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hSQySbAHS79IchRxafu6R5Bf0yJ1J5KozeW0dAh/sH0=;
        b=YevAsn90H3yw1TFFntO8fGYlbuTI2EXEqLfYhbZuOb8Q8+Ev+8ZlIf4xkxlF3o6Dm0
         l074AZoj4OeooiJ5y61/8wmpyRlNGq0+MhYs26pCCAlhqwObc07oNqLScDJrxQgiwlUv
         oBjeEgQaDRQ3jXuMPsfqIZbP6PDqkxgxYa2zDyh89+pObXiVYHBmqA9e80+4CHNqPTZc
         lXFw+1momPtJk5yt/W8Cdok0XQfxJddRerUHuCi/paQeCIKrZYCxnwjLYN+67nWho/X8
         BeGDJMyJewpfoNLKUsHSpE4fKmnoif0LtSaLQQdUDbI6YJaMKgDja9GxtwN6DC/LZhM/
         lDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584243; x=1726189043;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSQySbAHS79IchRxafu6R5Bf0yJ1J5KozeW0dAh/sH0=;
        b=bmYU0MJpIsIayBl4hUkODjMMI5G7JRb4SuSVuW18j4PDeDEgnAuCL5Rv5iVmrp6VeO
         1qpDAQYCIA0sty9tloT54IXnbmWXJpyBdgNC7nnNmm4bhgTODUh8L3XhP/wQWrctC8QK
         Tp8kuif1851fbjrFcBphfCPQg9ku7LbL2ysykJTWbmnqW+rSU6uZHxKdOgb5mcprjtyp
         Gt4Qsf3aBna8D2A+M1OMMMO1YLJ2Oqj3xY8QGOENV5g1iRubCgLcMkGVCfQLD1Nydj9k
         uhQZH8W03AAUHD5m2BiBtprxqhxu2lAcIE27GCFqOcS8ECyZuyRLtbxvefh05i/0hKVB
         XA3g==
X-Forwarded-Encrypted: i=1; AJvYcCULFkK6IgRCImSl0wx6TGnk0f1V17cY282NEViA8UD5g3HdZPJcAN0LsEBLYkiTF9nZ/yBigLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Hqsu2H3gDmAkHbz9ml1hEHPMrbiOVwBk+Om0QwKA49rQ5+mI
	g9Ryn9J0ozfZ+2fH9wvO6vWpAkFurEib6ho5xE3q5ve9JAOTIPI1ZcSanCo3GY6hBw==
X-Google-Smtp-Source: AGHT+IF7KVW73VMyJ1qpY1r9ZWwNVHvThscqvrrNVotPUdK/hHIvHJLy3iGn6yGZQLi1fBDmoW4ZO+E=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a63:8c15:0:b0:7cd:7682:e7c with SMTP id
 41be03b00d2f7-7d79f8ebc45mr5168a12.4.1725584242469; Thu, 05 Sep 2024 17:57:22
 -0700 (PDT)
Date: Fri, 06 Sep 2024 00:57:18 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG1T2mYC/x2MWwqAIBAArxL73YI9sa4SfZhutVQaWhFEd0/6n
 IGZBwJ5pgBt8oCniwM7GyFLE9CzshMhm8iQi7wUjajRjgE3d9oDDSmzOr3gyDdWlc7KoZAkpIQ Y756i/sdd/74fXAZptGgAAAA=
X-Developer-Key: i=ovt@google.com; a=ed25519; pk=HTpF23xI+jZf9amJE+xfTRAPYN+VnG6QbPd+8nM0Fps=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725584240; l=1787;
 i=ovt@google.com; s=20240521; h=from:subject:message-id; bh=toZstqqK87m2FLu8Pp5V+KYuQhVDyEXiWPZ6WJL02IA=;
 b=pDSNYps3EE7GvCdTUBJYVTZQHP+xrlObwmzLhPIdZDZqNcIwQagewoAm0I2MFS+UASG0s7OJp 5NUjNCqKlNBCV/yWIcq6yCTgqv6Gj7q3LPIx5ws3ITvqqVt1c4KrRSj
X-Mailer: b4 0.13.0
Message-ID: <20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c@google.com>
Subject: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
From: Oleksandr Tymoshenko <ovt@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, jbongio@google.com, stable@vger.kernel.org, 
	Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="utf-8"

nfs41_init_clientid does not signal a failure condition from
nfs4_proc_exchange_id and nfs4_proc_create_session to a client which may
lead to mount syscall indefinitely blocked in the following stack trace:
  nfs_wait_client_init_complete
  nfs41_discover_server_trunking
  nfs4_discover_server_trunking
  nfs4_init_client
  nfs4_set_client
  nfs4_create_server
  nfs4_try_get_tree
  vfs_get_tree
  do_new_mount
  __se_sys_mount

and the client stuck in uninitialized state.

In addition to this all subsequent mount calls would also get blocked in
nfs_match_client waiting for the uninitialized client to finish
initialization:
  nfs_wait_client_init_complete
  nfs_match_client
  nfs_get_client
  nfs4_set_client
  nfs4_create_server
  nfs4_try_get_tree
  vfs_get_tree
  do_new_mount
  __se_sys_mount

To avoid this situation propagate error condition to the mount thread
and let mount syscall fail properly.

Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 877f682b45f2..54ad3440ad2b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -335,8 +335,8 @@ int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
 		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
-	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
+	nfs_mark_client_ready(clp, status == 0 ? NFS_CS_READY : status);
 	return status;
 }
 

---
base-commit: ad618736883b8970f66af799e34007475fe33a68
change-id: 20240906-nfs-mount-deadlock-fix-55c14b38e088

Best regards,
-- 
Oleksandr Tymoshenko <ovt@google.com>


