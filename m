Return-Path: <stable+bounces-197989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E863C992D2
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 22:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17E7934509A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB8285C89;
	Mon,  1 Dec 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOM/prtQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F9284880
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624570; cv=none; b=iJlBpcyVwylkMDHAvLXpNuH3zio3YjbW0iFb+dQ7+0xNdH2v1Bs/IpVIw4JKpsaTaftgMT+OnZnzPNsgFV4NxX3haYfx0JL3JG4mNPG0MlCCefHQWcpd931g8vSHFqbBNkfnwezlST/nq0rmsg104RfoVS2J/7z+5VrVNr8FAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624570; c=relaxed/simple;
	bh=lSvg/K7yPsKUCFTcfSOcZg9VsOKeNcGmYT1edmcLv+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUKr1vV0OZfXEgfg8wZzDYlNYpq/1u/hLeMsl3MnI6A5+lI0bSnPBV5H9LnFwE4BfQUk3NYckJye8138mw9L0R9eS2K5Dy9OdeyZ0NV58HRShtDK8TGMERjH9F5jE3EahKgY/BgaZ7Bh1DNSct+qkLqcxElPujBGGobmoXZafTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOM/prtQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-641697cbc8aso717127a12.1
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 13:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764624567; x=1765229367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Yn63rsGsd4Hj7X1d2hk85Oe6NspbG2sX3h25PNq3o=;
        b=eOM/prtQzCQkC3h2dB0feks+lWNJnMfgWJmuVHWXl6qTGv7Vmsizgz10yBKuH7+4Ek
         U08BtSGDiDI3VFnNy68nUFLLkZvg6m27DIlitsimj8YV5a2R2Fcq3cJC9H5OlMiw1XBA
         4gDEdsg5udlNMRl2n8bWiRrUs9hXvCygKAxIijfPm6ZhP/U2SZUIhbP9QJGl/Reg5twr
         IKl3/yMI1ga1/EtaOWRV0D4jTi7ttgqvSnOq74eFwzXGS9bHNKkkYBKps8Vp0EPabH5m
         AxIlYKN7WqFBjeEQo/katzZ+qjOdI4Kz+6jzGqB7QDFdLQN+w36Z2H6nAJiIMtoW57iE
         3ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764624567; x=1765229367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0Yn63rsGsd4Hj7X1d2hk85Oe6NspbG2sX3h25PNq3o=;
        b=pmZ3kPPfT7gcGGHJE9Zakq8WQBIrbq4uz6TVvrs5jf44KW0Y86kgYtZENre73FoodD
         V92BsVA4i7MX1pqOnnF14lhjnD+jkgSou8REJ8zsoM7qh/8dVaqJlt0uh6BndKjX/gqX
         o0jD7x2JcQLUF5vyN85rfmj9NqTxJNqTq/FQQjNbMzRjyU+G6L0t+ipOgq2+170ekiPQ
         LV+kvYhjuql5LSHf5qGs8sNtdxPK70racaYrF84TcqUDicaq85kG7G+Z/c6AzqP2wMri
         nJqKR4rHSJc0rkm6DQsYD0veVmWIyk8+cpPpj5ZxpVVcpl1gGLSkpRuCS4xhMQzaDbZa
         xWDA==
X-Forwarded-Encrypted: i=1; AJvYcCXK670SoEiGxLaH867jJtxEVE9n1hDEG5UjTGl/0nRTg195CuWDlyOLwuOvgB3q1B8JRPvOHoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzk+xFHXuAAop/T2LPBBSpSMHJ90K2kZMI4JgJFjpTXW9FPnX
	cm7Re+VruF65qyXpe85K5nefxIMYHB/Rm3pg/0dd/fmfz9kHipzjZzzg
X-Gm-Gg: ASbGncvR2mTBC9LH375DQlbMOjgAzp9KF5lNU1NqgFlSEH1uybmLyOulLpeRVtmZ+6g
	MfF0TIEdxauGBWTawdBzdhb50iz9DMhw6w+gk2l/C6YT5l2efDhewmLGq5nJERMou/lKd4/KZvm
	e/zcv4yb571LgzgFuI2RMb73lJNlA5s5DobrnKe3s7JUOUahAt79djsFl7AeAAqGzYUTIbYMIG7
	gfsFwcZXKFxfuD+MYn5Bc3fAjk+uAeL7hoP1TLgP66piX33jnB4rNRdIv5Fie+iJDKZmKQ0zZGi
	N+HI0rKajGgJgWK5nyC7NXOeU3gIuc37QAwBNT0etwK8Osy2/tnfjXZtVT+4N1tLOHteUbt6L7B
	SAGCiLHJunirbmfEZqC9O3r+yYNkK/ubNnbNmYauCadIo4GeBDUPxj60WA3yE8kW0aFadyA9FDw
	djK1ApxT/ASOBwtw==
X-Google-Smtp-Source: AGHT+IGu1SlFFpvIYvIrQ+apMAxrKVb7zxXr0S8Sxm9iSmu6U7ZmdNyqWZGcEobHLqob2qXQsUOdtQ==
X-Received: by 2002:a05:6402:5190:b0:645:e986:682f with SMTP id 4fb4d7f45d1cf-645e98668camr14681838a12.8.1764624566404;
        Mon, 01 Dec 2025 13:29:26 -0800 (PST)
Received: from bhk ([165.50.39.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6475104fd7asm13519497a12.23.2025.12.01.13.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:29:26 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	jack@suse.cz,
	sandeen@redhat.com,
	brauner@kernel.org,
	Slava.Dubeyko@ibm.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] hfsplus: ensure sb->s_fs_info is always cleaned up
Date: Mon,  1 Dec 2025 23:23:07 +0100
Message-ID: <20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hfsplus was converted to the new mount api a bug was introduced by
changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
fails after a new superblock has been allocated by sget_fc(), but before
hfsplus_fill_super() takes ownership of the filesystem-specific s_fs_info
data it was leaked.

Fix this by freeing sb->s_fs_info in hfsplus_kill_super().

Cc: stable@vger.kernel.org
Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount api")
Reported-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> 
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 fs/hfsplus/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 16bc4abc67e0..8734520f6419 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -328,8 +328,6 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	call_rcu(&sbi->rcu, delayed_free);
-
 	hfs_dbg("finished\n");
 }
 
@@ -629,7 +627,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 out_unload_nls:
 	unload_nls(sbi->nls);
 	unload_nls(nls);
-	kfree(sbi);
 	return err;
 }
 
@@ -688,10 +685,18 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfsplus_kill_super(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+
+	kill_block_super(sb);
+	call_rcu(&sbi->rcu, delayed_free);
+}
+
 static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfsplus_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfsplus_init_fs_context,
 };
-- 
2.52.0


