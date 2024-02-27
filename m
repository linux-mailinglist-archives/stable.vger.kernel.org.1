Return-Path: <stable+bounces-24105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B43C8692AB
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B998F28F32D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601213B7AB;
	Tue, 27 Feb 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOcEquc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AB13B295;
	Tue, 27 Feb 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041047; cv=none; b=NJM/GUaZF0nKLdqK63RhWjvwSzbHAsJlXb9KotwYSUXhsVccsAntc0scYUaBFJeL++uUh0uhjudkqu+CWTOM+9Zb8Q/iLIcX8lH+ENJ1AFnAjLvhTXVjJ7NPVgEStaYR4/YYxsf/PW8sNUHMT3P/UvZyBGkkWHyD7UmvcxA4S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041047; c=relaxed/simple;
	bh=hloI+Qoih92MsQebGRMohc8rEQDredBAZInAts08DTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhbyTh40JESKY667Ld2gY0k+9Jb9ZvT355TI+5N+VSfBlnYDaTHFwXTtOVjhjn/2GkYcf+aKFGwzfW3/PEop0LMfICqZDlQwJmm2LbTZrZKSp3/KPvN53/Drcmvtykh6ACtYjikftglxqLVbJAQU17m4DghTXtd4y1sZyeRU1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOcEquc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C05DC43399;
	Tue, 27 Feb 2024 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041046;
	bh=hloI+Qoih92MsQebGRMohc8rEQDredBAZInAts08DTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOcEquc3QiHCY9AGU63p4NMiObe70NBIOui0UMYc907aVLIYVAKiVGcCpJUWd3Ogv
	 9OCwbc+8uQKt+trfASW+JXXmASzDtCEM8lTLbV+uBnLs2/C48OUJJtRGmUN63zNU4i
	 36qZX0zfhJOayrqYtFYZr4yrwF5vA+BvTDLoruxo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sandeep Dhavale <dhavale@google.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.7 200/334] erofs: fix refcount on the metabuf used for inode lookup
Date: Tue, 27 Feb 2024 14:20:58 +0100
Message-ID: <20240227131637.180105211@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandeep Dhavale <dhavale@google.com>

commit 56ee7db31187dc36d501622cb5f1415e88e01c2a upstream.

In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
we do not assign the target metabuf. This causes the caller
erofs_namei()'s erofs_put_metabuf() at the end to be not effective
leaving the refcount on the page.
As the page from metabuf (buf->page) is never put, such page cannot be
migrated or reclaimed. Fix it now by putting the metabuf from
previous loop and assigning the current metabuf to target before
returning so caller erofs_namei() can do the final put as it was
intended.

Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
Cc: <stable@vger.kernel.org> # 5.18+
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240221210348.3667795-1-dhavale@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/namei.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -130,24 +130,24 @@ static void *erofs_find_target_block(str
 			/* string comparison without already matched prefix */
 			diff = erofs_dirnamecmp(name, &dname, &matched);
 
-			if (!diff) {
-				*_ndirents = 0;
-				goto out;
-			} else if (diff > 0) {
-				head = mid + 1;
-				startprfx = matched;
-
-				if (!IS_ERR(candidate))
-					erofs_put_metabuf(target);
-				*target = buf;
-				candidate = de;
-				*_ndirents = ndirents;
-			} else {
+			if (diff < 0) {
 				erofs_put_metabuf(&buf);
-
 				back = mid - 1;
 				endprfx = matched;
+				continue;
+			}
+
+			if (!IS_ERR(candidate))
+				erofs_put_metabuf(target);
+			*target = buf;
+			if (!diff) {
+				*_ndirents = 0;
+				return de;
 			}
+			head = mid + 1;
+			startprfx = matched;
+			candidate = de;
+			*_ndirents = ndirents;
 			continue;
 		}
 out:		/* free if the candidate is valid */



