Return-Path: <stable+bounces-249088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEF0JQnICWropQQAu9opvQ
	(envelope-from <stable+bounces-249088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D45614AE
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A76300A632
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210A26B973;
	Sun, 17 May 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUUQAtmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1925D215
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025927; cv=none; b=ms1QcIqZ68gDcJnvCKq0vcgq/UynQEBuh/udo0nvmFFIvWjXvQsV+6hYvDSJJExDkRVw1spwrfe71InFOdXOYWg7eUZevQd5UKi9xtoUAoxQ5E4mI7odozLGciISj9KN3m1G1G6TsXp7do2opE+5KSVRLrcRvCU+F3lZ+MARz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025927; c=relaxed/simple;
	bh=DcjxMC+WXVdhqkomv16w8TsMBvWJOxUUj8eGz5duNNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItbvqUvpG/JENkl+6KLnxPX6K/j1DU1YFSm0A2i81pLCmUHTJci+Ys2Euy+8mgo38Nhc1rJnvUEUziLEGdBy+ZIWPnp4aN89SxX5pqa+5CmSYRtaK0fjzR7AJ0ifCtbT9GIBpJqAL0+S2Gsz7r0RFc51SpMwRAJ0ZJv1+iI2SSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUUQAtmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E61C2BCB0;
	Sun, 17 May 2026 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779025926;
	bh=DcjxMC+WXVdhqkomv16w8TsMBvWJOxUUj8eGz5duNNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUUQAtmbwikFQH2hwmylCUariiB7f8XIaDM/dj0FAtYDEaBQkSDHVboUfg//MqZCx
	 ulzscMNOSv/K7fH9g4xJmWmwuK9ZqstPlaU5QhDv8Hm8+IRpg2htWgKrpi/qkFl9cU
	 JYF4S194eJ4pWGkPj2eLmfVPq5Wv6G3w8LsrtTOhhkzvAmxS0/jF7KcqsJK8FH6BQO
	 AGR/yPlPTprPTK+rwr3y/OcacFSOmTZo41JyS90+IEuZkvq9ya5VuNzVoJeHFAggdm
	 vnFnGITLvKaKBn0RNT0w32+iIKl/rUTb5UUmsAYGaPrQ062AR73nwZq7JgmomHxJ86
	 /uoYTyHO4tZyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] btrfs: use inode already stored in local variable at btrfs_rmdir()
Date: Sun, 17 May 2026 09:52:02 -0400
Message-ID: <20260517135204.148250-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051232-runner-cornhusk-38cf@gregkh>
References: <2026051232-runner-cornhusk-38cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F7D45614AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249088-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9f82a4ed34d870b5719f9b95f7da4f74d3325a6f ]

There's no need to call d_inode(dentry) when calling btrfs_unlink_inode()
since we have already stored that in a local inode variable. So just use
the local variable to make the code less verbose.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 999757231c49 ("btrfs: fix missing last_unlink_trans update when removing a directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46df425ab7bae..65fb689f8d6ab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4681,8 +4681,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	/* now the directory is empty */
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
-				 &fname.disk_name);
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), &fname.disk_name);
 	if (!ret)
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 out:
-- 
2.53.0


