Return-Path: <stable+bounces-188273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B93BBF4248
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BAD4254EF
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCEF1CDFCA;
	Tue, 21 Oct 2025 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1kiP3/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF582EAC7
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006303; cv=none; b=KC3cjJd4N2at5ho2UKWpFrpLRLSNyxi/GZI+q0Txm/i1a/T8no2YpQzrv5i8JS8WntMD4BDhcKIyfOHZ2FBTW5oF121uhZQjUJeX5ZkLTET1dukBMaaNOX7OmVa4LcuOSAgXqTMFZypRYllumVbXO7GWKZfJ8Ek3FQT73v4sTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006303; c=relaxed/simple;
	bh=2iBKbHuliLEBPFw/9yTt3FIJI/m6A23n5k0XMK+E5Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4CIUAMu+vkhfUEi+A6A8LGFgNgdOFHbiNcNFRiGgs1oElKP9XBpcg/b4pQOGdHdjr9A/o5iZfz50POuQrebp9O4Aemy8joLL1W2cKVJwZMoYbh/R1vJ/7vu09DVVt8Sh/B5tWGqytKv8EBBFMyE68sbX8G/SsC6JocisiRa+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1kiP3/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F4C4CEFB;
	Tue, 21 Oct 2025 00:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761006301;
	bh=2iBKbHuliLEBPFw/9yTt3FIJI/m6A23n5k0XMK+E5Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1kiP3/qE6fuLrknK5p5U2D6AtzNWDkbwBmPQqlQAghYSx3fNp0wtcUKFhn5M1jcV
	 sPr3azDMyAeXM8OFekwq2T+FRcn3MTLUrSeDMtNDILnEluP1RbNzcs5VHc9wT9V5Fs
	 svIcLiGuKy2zp/Pv7BNcHxIQVX1qHKqXhxrnp473JerpoWvfChjyOHDV13Q7nwjwdg
	 4dpO2t2zi+ithoPsmaDRyE/YtEaxLO+piYOiHTOZwU8OJqzX9G3GZMpXGoWVr3aZsh
	 mxNYGWCMNSmKOUFvqx+XNhF593jkiRwH0RdVbT6DIk2hqEiB2Q43xrTIFhbdILPzDt
	 S1SMxigvCoYyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vfs: Don't leak disconnected dentries on umount
Date: Mon, 20 Oct 2025 20:24:58 -0400
Message-ID: <20251021002458.1948943-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102039-unmasking-zero-2258@gregkh>
References: <2025102039-unmasking-zero-2258@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 56094ad3eaa21e6621396cc33811d8f72847a834 ]

When user calls open_by_handle_at() on some inode that is not cached, we
will create disconnected dentry for it. If such dentry is a directory,
exportfs_decode_fh_raw() will then try to connect this dentry to the
dentry tree through reconnect_path(). It may happen for various reasons
(such as corrupted fs or race with rename) that the call to
lookup_one_unlocked() in reconnect_one() will fail to find the dentry we
are trying to reconnect and instead create a new dentry under the
parent. Now this dentry will not be marked as disconnected although the
parent still may well be disconnected (at least in case this
inconsistency happened because the fs is corrupted and .. doesn't point
to the real parent directory). This creates inconsistency in
disconnected flags but AFAICS it was mostly harmless. At least until
commit f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
which removed adding of most disconnected dentries to sb->s_anon list.
Thus after this commit cleanup of disconnected dentries implicitely
relies on the fact that dput() will immediately reclaim such dentries.
However when some leaf dentry isn't marked as disconnected, as in the
scenario described above, the reclaim doesn't happen and the dentries
are "leaked". Memory reclaim can eventually reclaim them but otherwise
they stay in memory and if umount comes first, we hit infamous "Busy
inodes after unmount" bug. Make sure all dentries created under a
disconnected parent are marked as disconnected as well.

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Fixes: f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ relocated DCACHE_DISCONNECTED propagation from d_alloc_parallel() to d_alloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 49461353ac37b..15fba39b89192 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1862,6 +1862,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		dentry->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
-- 
2.51.0


