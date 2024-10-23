Return-Path: <stable+bounces-87906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301999ACD20
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F21C20E7E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D341CEAA8;
	Wed, 23 Oct 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3tma4Lv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A061CCB21;
	Wed, 23 Oct 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693958; cv=none; b=g+m1zspOapd7/lL2WGi3GcwMXbnvvqH7lqMFgJFJM6X4lYnM3N/Ts7idl+05pK2RpgltUJe+EzQkwHJ0WLyvqSmK5lH2xPdemp6p2Qp3VNqnYTpcElEeiOxALDdnTvD+LOJCNrmegVXy7lguhcf62qJ78DcG1ZiHkOFt9r/X95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693958; c=relaxed/simple;
	bh=uwNLXZ/zAK/Sj8Jz0Vf9ZAnMhKukm/ZqYC9tygGgxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovGFhBmQU+4noKd9858mH/uLpYBZAaB1jrTDvnSLoTJjzSMJMu4G9tUPZkZ4sLXTrgBCkA37sbpqD/z/yVGG3D6O+vzPHkjGSLCRCvdezpDHhOQUEeeiHFN+C2YjnhiUEOFm9SvMRU9ZflFTcSBbeZ0n6owbRGUi8DgB+scw/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3tma4Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29954C4CEC6;
	Wed, 23 Oct 2024 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693958;
	bh=uwNLXZ/zAK/Sj8Jz0Vf9ZAnMhKukm/ZqYC9tygGgxT8=;
	h=From:To:Cc:Subject:Date:From;
	b=T3tma4LvZcqwHf0U1uLhSO6wThMkGF8TuKBzXJc2pL/3K6znLsGyRNixbFXe/enJd
	 vQdw2cjI5Xo0uXiEc5VHXT9Q0mApbLZw2fiADaNS7MrU330V7iMw1AZJmyZKmVJwUP
	 Zj5RsuIUab5ZYRcXYJh6hLmvPr4fT9xfDMOEdq3ZO24cGTRWVv3s7MAPRgm0j+4UZv
	 HbWXP11Neu0zi9Pju/5LzRwDNljshOI94ex4BpCQfSjKsPmCvRqlY/40MeRjpL7ebN
	 QNLOZpTs/6Zq0C5NqoZ08oj58PfTqQ6nfVkvEgajna+1ECV25PLjtx/7pqY1woi9Dd
	 83DEzVAyBfRnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
	syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 01/10] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:32:22 -0400
Message-ID: <20241023143235.2982363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
Content-Transfer-Encoding: 8bit

From: Pedro Falcato <pedro.falcato@gmail.com>

[ Upstream commit 79efebae4afc2221fa814c3cae001bede66ab259 ]

In the spirit of [1], avoid creating multiple slab caches with the same
name. Instead, add the dev_name into the mix.

[1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
Reported-by: syzbot+3c5d43e97993e1fa612b@syzkaller.appspotmail.com
Message-ID: <20240807094725.2193423-1-pedro.falcato@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/client.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index bf29462c919bb..03fb36d938c70 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1005,6 +1005,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
@@ -1057,15 +1058,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
+	if (!cache_name) {
+		err = -ENOMEM;
+		goto close_trans;
+	}
+
 	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(cache_name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
 
+	kfree(cache_name);
 	return clnt;
 
 close_trans:
-- 
2.43.0


