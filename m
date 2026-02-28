Return-Path: <stable+bounces-220874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHxkMXlao2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:13:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284131C8DD5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D06133AC6FE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFD941FDE0;
	Sat, 28 Feb 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcpK7tLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF94963DA;
	Sat, 28 Feb 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300761; cv=none; b=O/P1qlLfxMVmJQ9fOARG7eDnhWu3bIjNh5JUCOPcvAqz6G/2IYtKCcvogy7xvSrU4ljPLyj6xCTzWzhbb0ytcOAwNCpvuAfmnX3ioQRGpx/gvNoc2yG9PqmUzJ3lDH8ehFMHtkJQ5bVQ5SSdS3oFjei/BTLoNDhJ9hMZyYTILPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300761; c=relaxed/simple;
	bh=Lf6er7hIUYoGNxI8zjtR1nY1T9ukD1O6DpoqieGl/Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K98Y+cFil5SzTlJUbVd9Gi1cvMav2WWeWAWyN90z0CBPEgISp6kEv3qfiq94QcmWuYoLLzGujS7AqUOK5q+DybfhecnUKvh4mmyo3veaiA6hfyuuaonWdrytO92T0IS0fpKMDY7GZUkftdWTYUGQxWOLHloeQKINo/QonXpyDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcpK7tLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4619FC19425;
	Sat, 28 Feb 2026 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300761;
	bh=Lf6er7hIUYoGNxI8zjtR1nY1T9ukD1O6DpoqieGl/Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcpK7tLRzfZwIZNmMMYaRm8qwU73riS3wPP1Lvsbaj46DyEfVwOKUexkD6SoPNmF/
	 wUcjKZAJ3+nXz3uqgskOTojJxZlQowF9/x2AdjDk6bAqwL7ZxS00FQNrgroGZD3Hih
	 UPXkcQCcTohIkXnJ/DsYJSmc4lS9QVXm7HyhRyGo3MhIwDbVTzn9xKnQJoir+fRuew
	 l8Se+dYsiiw4Ttg0xRNMOiPj/AFfafJW3mgsxw/Bw+tJ4mTCsrhj/YYRTQ4OUROtmN
	 wl+RpjtHW286a9XWgAGBxB0FMipQXFpWjqg0DDjpYUJBrCM0qmQ7oTsoRDpvfGKZmY
	 F+UidbH1ti7ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Ruikai Peng <ruikai@pwno.io>,
	Thomas Gleixner <tglx@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 795/844] procfs: fix possible double mmput() in do_procmap_query()
Date: Sat, 28 Feb 2026 12:31:48 -0500
Message-ID: <20260228173244.1509663-796-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220874-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable,237b5b985b78c1da9600];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,linux.dev:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 284131C8DD5
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 61dc9f776705d6db6847c101b98fa4f0e9eb6fa3 ]

When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY
we return with -ENAMETOOLONG error.  After recent changes this condition
happens later, after we unlocked mmap_lock/per-VMA lock and did mmput(),
so original goto out is now wrong and will double-mmput() mm_struct.  Fix
by jumping further to clean up only vm_file and name_buf.

Link: https://lkml.kernel.org/r/20260210192738.3041609-1-andrii@kernel.org
Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reported-by: Ruikai Peng <ruikai@pwno.io>
Reported-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Cc: Ruikai Peng <ruikai@pwno.io>
Closes: https://lkml.kernel.org/r/CAFD3drOJANTZPuyiqMdqpiRwOKnHwv5QgMNZghCDr-WxdiHvMg@mail.gmail.com
Closes: https://lore.kernel.org/all/698aaf3c.050a0220.3b3015.0088.GAE@google.com/T/#u
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 26188a4ad1abd..2f55efc368162 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -780,7 +780,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		} else {
 			if (karg.build_id_size < build_id_sz) {
 				err = -ENAMETOOLONG;
-				goto out;
+				goto out_file;
 			}
 			karg.build_id_size = build_id_sz;
 		}
@@ -808,6 +808,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+out_file:
 	if (vm_file)
 		fput(vm_file);
 	kfree(name_buf);
-- 
2.51.0


