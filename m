Return-Path: <stable+bounces-53395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016B90D172
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E44284FB5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6A91A0726;
	Tue, 18 Jun 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ILiNIlf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37B15886E;
	Tue, 18 Jun 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716198; cv=none; b=Wk4SIJ4VtWu0aI05XyzzbxHzuXaBEw9uMNqKeZijxNvdiu/qnseK79gZtlri+qjihb+8OQ8OTvBtctCBUcIej88UI7yBdTm5LF0AfmP92nt8yMDlcjzPqZL5laffhtCnB0pBDs/wEXP2V4Xy+26EXv2GBj0HWmM4MpEjgC77It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716198; c=relaxed/simple;
	bh=F2+wRh6u/sQFqEt13BciMj2WtB/UM+r4f5vHH25mBRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL8E1KnJh/w0qlKpl92n0Kapv5irxiRWsrK4eE95NJHtKJG0QhiL0nacAJc7f5oDA8rxZ0tehru/B7DtwLtdo/Fluxh4lFBQTzL2BkA1vMEzdblw8AgsHFF2+ivLfPPiXZP0MZsfbAPuy9WnlB/jDDdTi2970fGE0Rc/vE9+VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ILiNIlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59E7C3277B;
	Tue, 18 Jun 2024 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716198;
	bh=F2+wRh6u/sQFqEt13BciMj2WtB/UM+r4f5vHH25mBRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ILiNIlf+ukknrYjnB9eFv7X8ZlsFnYO2gYxZzwdGTtGxmKjzIJoNsm8YZtnsmBaH
	 KUvZfxxq3HBbF78i32LE8pZq7ul8sKbYoPvosp4pGp1GlJ2u2YAhbVW64xek1RxMtX
	 pPf9XwfjX/yEsq+iqgRSWpGz7XYGRgSsNAfBFOiw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Gao <gaoxin@cdjrlc.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 548/770] fsnotify: Fix comment typo
Date: Tue, 18 Jun 2024 14:36:41 +0200
Message-ID: <20240618123428.458520970@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Gao <gaoxin@cdjrlc.com>

[ Upstream commit feee1ce45a5666bbdb08c5bb2f5f394047b1915b ]

The double `if' is duplicated in line 104, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220722194639.18545-1-gaoxin@cdjrlc.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8687562df2e37..7974e91ffe134 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -100,7 +100,7 @@ void fsnotify_sb_delete(struct super_block *sb)
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
  * on a child we run all of our children and set a dentry flag saying that the
- * parent cares.  Thus when an event happens on a child it can quickly tell if
+ * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
 void __fsnotify_update_child_dentry_flags(struct inode *inode)
-- 
2.43.0




