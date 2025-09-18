Return-Path: <stable+bounces-180076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B6B7E8E5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59145207DC
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32431BC93;
	Wed, 17 Sep 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgRBNzgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BDF3090EC;
	Wed, 17 Sep 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113305; cv=none; b=LUIfmx+9giERbu5yLN7CRHVBdKtTdmzkN7zNFb6j7GwJqsSIsYUBV9pgL7e9Ii8BbtdboqIJMbaJnAgqEk8loVGMBUuz0jD7T0p+EglbCMQlL985WzgaFEiESIQKkY29wWeGS47FiPf6kzvPaHt4Sej4HDnP9ng+6w+5u9gfTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113305; c=relaxed/simple;
	bh=HfpJjjTTWnUO3n4C3qOFvR7gMm83FB54XwXjit7Vfpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dL7WGnmECrbOLZteAMmnQ4REpupB1jP8fPwJfxgve03SFTNrcoFYCGvHphkDOcOiVuTXwBjWXT7bLYY61cujM0ensYwrKMQv0YMK5FhnlqtYBUMzgVWfyhOOweT5PL53vOYHccPSXapbz3OWGIhaIbliasEXlmjgshDHKO9cTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgRBNzgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC369C4CEF0;
	Wed, 17 Sep 2025 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113305;
	bh=HfpJjjTTWnUO3n4C3qOFvR7gMm83FB54XwXjit7Vfpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgRBNzgKWsgckshiD9w193XNqG/fRWAt27G3K1mIsYmx/tZ5o0zexLQz4Y8uXHmLX
	 Ox52+TfPw5rhJzhOuIP7bL19ila8r0x79T5oXeJH1WTFcGY8SydGMU0LuYbIXvFmQX
	 2itIQe5iBHFjsOfRlkdvHtyGs3JInG5dXesIkOoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangzijie <wangzijie1@honor.com>,
	Brad Spengler <spender@grsecurity.net>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 046/140] proc: fix type confusion in pde_set_flags()
Date: Wed, 17 Sep 2025 14:33:38 +0200
Message-ID: <20250917123345.427181264@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangzijie <wangzijie1@honor.com>

[ Upstream commit 0ce9398aa0830f15f92bbed73853f9861c3e74ff ]

Commit 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc
files") missed a key part in the definition of proc_dir_entry:

union {
	const struct proc_ops *proc_ops;
	const struct file_operations *proc_dir_ops;
};

So dereference of ->proc_ops assumes it is a proc_ops structure results in
type confusion and make NULL check for 'proc_ops' not work for proc dir.

Add !S_ISDIR(dp->mode) test before calling pde_set_flags() to fix it.

Link: https://lkml.kernel.org/r/20250904135715.3972782-1-wangzijie1@honor.com
Fixes: 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")
Signed-off-by: wangzijie <wangzijie1@honor.com>
Reported-by: Brad Spengler <spender@grsecurity.net>
Closes: https://lore.kernel.org/all/20250903065758.3678537-1-wangzijie1@honor.com/
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a87a9404e0d0c..eb49beff69bcb 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -388,7 +388,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
-	pde_set_flags(dp);
+	if (!S_ISDIR(dp->mode))
+		pde_set_flags(dp);
 
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
-- 
2.51.0




