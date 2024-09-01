Return-Path: <stable+bounces-72295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB64967A0E
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FAC1C20892
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217BE17CA1F;
	Sun,  1 Sep 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vVPlysP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283D1C68C;
	Sun,  1 Sep 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209461; cv=none; b=ZNrKuI3fIumZvp6aIqIra5ng3YRZIVZnNMCXaCTQ5O6zk5/uM+FzNXpS7y1IzzImcKh5UvS78uGu5YBdVbXCU10o6kCYTtsmfWaMUHRBzSxR4u0cLhA3joqRMcw3ZzfTbzYBHMUa5zdXHAsWqSkhX7Ov/zMM7poF0lzOk+HaMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209461; c=relaxed/simple;
	bh=VvXuXwTjJsutn4cg5Jr7s3vfJpjj6dQnmX5LtVke4ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHs6U2IP65mdpuIU0dOi4cpH5UG8MFxN6Yls7oVUgciLrXc4O5DUKpmlB5rbaSZHwxz2t8rwftEP3+N1zn6Ht32vIfeJRzJz7drDnyQtaC6HZqCjhZ/zJswYcUH/2XMgKmSedKmYqas514is4Hk1ZqfC0TVOh5W8bxQE+cI070o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVPlysP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A83C4CEC3;
	Sun,  1 Sep 2024 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209461;
	bh=VvXuXwTjJsutn4cg5Jr7s3vfJpjj6dQnmX5LtVke4ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vVPlysP3U2eNxn50KctIo97aYo3aJGATNf1N3BQnGatfSZ7BH04Sk53Wy1k+0Kesj
	 223g4otlpjXFguNsQvUxkWAYd0IJyjCrKnCNuDLm/ZbT7CLVkilbg0pt7Swc3XUbkd
	 QgoKOyRVgFB1nx8NJgxWtXKrNPi4VUh4XMeSgROE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 044/151] gfs2: setattr_chown: Add missing initialization
Date: Sun,  1 Sep 2024 18:16:44 +0200
Message-ID: <20240901160815.765832490@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 2d8d7990619878a848b1d916c2f936d3012ee17d ]

Add a missing initialization of variable ap in setattr_chown().
Without, chown() may be able to bypass quotas.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index d75d56d9ea0ca..22905a076a6a2 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1905,7 +1905,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
 	kuid_t ouid, nuid;
 	kgid_t ogid, ngid;
 	int error;
-	struct gfs2_alloc_parms ap;
+	struct gfs2_alloc_parms ap = {};
 
 	ouid = inode->i_uid;
 	ogid = inode->i_gid;
-- 
2.43.0




