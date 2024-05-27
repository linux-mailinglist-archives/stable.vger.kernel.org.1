Return-Path: <stable+bounces-47451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34A8D0E0A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C068B1C21731
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474216130B;
	Mon, 27 May 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8vDV7Rw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B549160887;
	Mon, 27 May 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838583; cv=none; b=QoxtuHYkIu2tBMn8uTrVShEiOAF/xLSsRs662ppGi+xrmq5IdMS6137kXsXy8Gt6JPJ86Sb6EzCnvEuxo5V2OlkIQOqrg9bJJw2hJYcTOlQjFMwpZaa1FM7VoiXsi+ORrHcOi3BxaUu0/qYkdaXrBqXcWfM1Ngt2ZnC5IDk0tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838583; c=relaxed/simple;
	bh=XmgH8GCLo5+6Hvp3alsI5NDggmWE7vdx9pKBtkG2jaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SipJq91SDtTNxECcWgp1trY1ODkJDy6nT9lKTRijaSBGkXg8IpJFa/1M+CSDwnOJ3cLLqahJdAoSs9qQIAvg1+4BZ51IBIcMTsICzmFpQZEYKPr4frXKV6DZufJ4Tikdyl6m8S5NKWzWpeUdrzI8ogmmCBlSzwa7jKT4/fhTqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8vDV7Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1469CC32782;
	Mon, 27 May 2024 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838583;
	bh=XmgH8GCLo5+6Hvp3alsI5NDggmWE7vdx9pKBtkG2jaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8vDV7RwncQ78+8VUX7xx/XYuLW5hte0Rzlllw+V7GJTI35AETzUOK+cDRcyVBqGF
	 uecgqJOBbCaaZl7Z/G7cvoYoLOiEinZ2xqs40Ejear5/Ar4bYlljE5WdfudGRJhj+N
	 iCMp8qB1l8/bNoUX3jYAfo9CqFAQfPh1JJcvclWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Luis Henriques <lhenriques@suse.de>,
	Disha Goel <disgoel@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 450/493] ext4: avoid excessive credit estimate in ext4_tmpfile()
Date: Mon, 27 May 2024 20:57:32 +0200
Message-ID: <20240527185644.949451985@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

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
index 05b647e6bc195..58fee3c6febcb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2898,7 +2898,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
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




