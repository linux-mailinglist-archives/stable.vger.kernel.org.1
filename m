Return-Path: <stable+bounces-83684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DDD99BEA0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C71C23C19
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4815ADAF;
	Mon, 14 Oct 2024 03:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezZuomG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857515A85A;
	Mon, 14 Oct 2024 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878304; cv=none; b=i3dIS8NnpTEYMfWIF2oF24eiHmhovCtyYbVvyI1+dRMwkqCyiDbxAlZtXv1RHerHFv+HjdQYU0WWWOnCDxoXC7RNk69xMXiSqUHJwb6km4DloiBaI6pF8C89o8c3tY0UkoQMka7lfseXflpjpnps1dsFjwHRvRJ/6pLijzgFeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878304; c=relaxed/simple;
	bh=+DLjy5zr30ApfX/Te+rSfNG/ToYFt3ghpUVvNI3SPEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFOJ0DYW/rlBzlkVvPuG+nRbKYm6Sc7KqOO+b3ztf4w2cDZA0URbylj8fTtSS7lw3ZzeprIiR9SPzkLZbAZBmzZMiTBSU6URLGGIBzSC46dOxWBbntrxGlxjqeMizAMjTmUY1zNLzbJbCGPnX7EJzlw9i34gL8a/YuqmG8PNdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezZuomG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5452C4CEC3;
	Mon, 14 Oct 2024 03:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878303;
	bh=+DLjy5zr30ApfX/Te+rSfNG/ToYFt3ghpUVvNI3SPEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezZuomG61tW680UkUWN4HSGJK3qGabKMEtm6gkdUDk+VtLwKJ0ZFNmGtV8ppWEIHb
	 Cxuip+JXvSVyU0hzhgSf0le/Cn5hB0XHdXua88OvvfF2U8gy5m9qMQVNYXpkTCyf08
	 XS0DliVo3RP9XqsSLZSfdmFN+x3/A8Ds+6inBBJermgi3reKV9U/Bk5e8WLa89JT9G
	 yM6BEjevU7FdOUQ/EIa5gCYUyrYndZ63T05DlFzpLb5bmdOnBraqibuQ4RfSh8Xu+P
	 +xxgNW2UGgcd1PQ4Omfa1cZCBxtly7Zq740tA0X9kougGBt6cJjaPmuljDv52MqKGH
	 U8+cSO8vizKeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 06/17] fs/ntfs3: Fix possible deadlock in mi_read
Date: Sun, 13 Oct 2024 23:57:56 -0400
Message-ID: <20241014035815.2247153-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 03b097099eef255fbf85ea6a786ae3c91b11f041 ]

Mutex lock with another subclass used in ni_lock_dir().

Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b5687d74b4495..a086694973b29 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -81,7 +81,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
-- 
2.43.0


