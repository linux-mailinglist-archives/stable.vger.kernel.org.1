Return-Path: <stable+bounces-49341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543218FECDC
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E615D1F26AD9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA721B372C;
	Thu,  6 Jun 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eueBiuyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5E1B3727;
	Thu,  6 Jun 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683418; cv=none; b=AY7fFJincg4x8K8AicpULjVrgDQjeuaBsn8u7of1ABJ2Vj1UJgHTIgWtvQtzGdnMXG7h16hBZRRVx7EvPWoXOoodlrCE/CQ44509YoerZE+lHslesxtG5+tHr/x6RC8Z+yzrCJIISDftsT3n9swxSvkAuUpZgTSIDGPyJOGs1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683418; c=relaxed/simple;
	bh=/F2SsSptVKG5ZLl+vBtDagDg6tibQvPpTNJAREYK0wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah+VeLBhEqq2WmuY2CeFSWs0K+QxwZbobxGUk3gMUQ3YkZQeK3K2z03jB3Wmb0914haXAbLf4Ubhx4/MPLcu9mRzBTiBVwFe5Th64chsoYi+jRtIbCo0EI0xouJLeEANh5j/XhAAJVsky/u0EnZP1LPsQ3HZf5Iu2v9uXWOwc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eueBiuyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3988DC32781;
	Thu,  6 Jun 2024 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683418;
	bh=/F2SsSptVKG5ZLl+vBtDagDg6tibQvPpTNJAREYK0wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eueBiuyEKyMIZOffxiiEYm+xk4/uL80E2VqpzIb7EhfLylgtFpG6qnawYha1iXx8u
	 u7LHAn2jFXJnHS739fuDM9N4MznnWUdhVmbPVuthR7veG5UqdbCB/jkZL6BQdPGbQW
	 8qj/yQKC4MFeS2CDSKDVksI5ZZkP3FeIYf7zM86o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Luis Henriques <lhenriques@suse.de>,
	Disha Goel <disgoel@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 361/744] ext4: avoid excessive credit estimate in ext4_tmpfile()
Date: Thu,  6 Jun 2024 16:00:33 +0200
Message-ID: <20240606131744.064540672@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 35a1f12f0ca857fee1d7a04ef52cbd5f1f84de13 ]

A user with minimum journal size (1024 blocks these days) complained
about the following error triggered by generic/697 test in
ext4_tmpfile():

run fstests generic/697 at 2024-02-28 05:34:46
JBD2: vfstest wants too many credits credits:260 rsv_credits:0 max:256
EXT4-fs error (device loop0) in __ext4_new_inode:1083: error 28

Indeed the credit estimate in ext4_tmpfile() is huge.
EXT4_MAXQUOTAS_INIT_BLOCKS() is 219, then 10 credits from ext4_tmpfile()
itself and then ext4_xattr_credits_for_new_inode() adds more credits
needed for security attributes and ACLs. Now the
EXT4_MAXQUOTAS_INIT_BLOCKS() is in fact unnecessary because we've
already initialized quotas with dquot_init() shortly before and so
EXT4_MAXQUOTAS_TRANS_BLOCKS() is enough (which boils down to 3 credits).

Fixes: af51a2ac36d1 ("ext4: ->tmpfile() support")
Signed-off-by: Jan Kara <jack@suse.cz>
Tested-by: Luis Henriques <lhenriques@suse.de>
Tested-by: Disha Goel <disgoel@linux.ibm.com>
Link: https://lore.kernel.org/r/20240307115320.28949-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index bbda587f76b85..a2ee882e5ebb0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2901,7 +2901,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	inode = ext4_new_inode_start_handle(idmap, dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
-			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
+			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
 			  4 + EXT4_XATTR_TRANS_BLOCKS);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
-- 
2.43.0




