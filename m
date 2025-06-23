Return-Path: <stable+bounces-155869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4119EAE444F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F9D442A8E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90A253351;
	Mon, 23 Jun 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urD6ZwFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC04246BC9;
	Mon, 23 Jun 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685547; cv=none; b=QaF253d3SDPO88We4OLTcDADY+J0DrsmpHqRzH/78awI3lO4/j/SdLBBzqv0AgMGhztpO1/I0vbtCLgI/I7VEClHrDPYwP87C6/91AROLc5I6O5ZD0a89JcmzP5a4gvY/Ibx9SEhhQ4LMlHgylf2ehpL7c6yLB6IfcSXzERVO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685547; c=relaxed/simple;
	bh=T/fY7EtBzNMxf7Xwjd2fDU2JwwYuybfukW/OKMqxeOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOkZHQeOlTrU4IUyiVh5wZXMyyMltOFKK8g0zTOmbfTLi5eiK0VYajPMUUcBtxQkPgSgGZGsoxslkYbJhyTMeRTOaY0ufwDJ41qB+TxtngvYU+D/zeGl++3n2xvByAfziF3kbeVcnHUcpAgLeAFxJCGfNzlJHMrHbIbxFYNElz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urD6ZwFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC9C4CEEA;
	Mon, 23 Jun 2025 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685546;
	bh=T/fY7EtBzNMxf7Xwjd2fDU2JwwYuybfukW/OKMqxeOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urD6ZwFrNij5ZrSOGQkZFz+KkV//yFiNnnUEuOEI6fKym6/bSBE4EEI6uHUnUu0U1
	 MZn6fQHlo0bS1T2R5SGDfS1N1kl4sGY8UcxE7aRLVbAjUIv7d+6pPDrQxJGGe0dqMh
	 x/GQZKi1bjWRxLYLnmGJlPVD9/XK2yC8HfMzKvg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/508] gfs2: gfs2_create_inode error handling fix
Date: Mon, 23 Jun 2025 15:00:59 +0200
Message-ID: <20250623130645.605393162@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit af4044fd0b77e915736527dd83011e46e6415f01 ]

When gfs2_create_inode() finds a directory, make sure to return -EISDIR.

Fixes: 571a4b57975a ("GFS2: bugger off early if O_CREAT open finds a directory")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 04fc3e72a96e4..06629aeefbe6f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -631,7 +631,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR(inode)) {
 		if (S_ISDIR(inode->i_mode)) {
 			iput(inode);
-			inode = ERR_PTR(-EISDIR);
+			inode = NULL;
+			error = -EISDIR;
 			goto fail_gunlock;
 		}
 		d_instantiate(dentry, inode);
-- 
2.39.5




