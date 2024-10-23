Return-Path: <stable+bounces-87889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CCD9ACCF2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEEFB2303D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034EF1CC8AC;
	Wed, 23 Oct 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAphImLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA081B4F1F;
	Wed, 23 Oct 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693925; cv=none; b=PXbPvUcGhZPyOf1Ale/2Igae4MWMq/odetmcYmlhl9d7sR/yLOaWNNKXNvTpFt6TLny768qu4DEMEqkkVFjqUMeRy7eECXW0BSnV4HU3KtLPnCQ6MgNuhBmklA4mydJsqwITg7Zn+imIBk/P+yYmC6MH9bE26IqMVCpfOSgsLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693925; c=relaxed/simple;
	bh=76f2RsbrqidExfabF95ZRI/qIYiV+foDoIZ/olRyPfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsETv3Lnzve07Uiz+7wHV1qGR6bubxEU4D0vIgv3riHHLMB7FpPVTfQW3xlIkpDMk7XCDRwdPtv2U4Z9U4N5LMOW2sXHLhatCOEZQ7Ro//GyZJ0eL2qsAwHBpyhiWd2a/zhf0VrvfWv/SNbXH+v9JqwX07vhW/5XC9KG6eO6wMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAphImLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D0EC4CEC6;
	Wed, 23 Oct 2024 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693925;
	bh=76f2RsbrqidExfabF95ZRI/qIYiV+foDoIZ/olRyPfM=;
	h=From:To:Cc:Subject:Date:From;
	b=cAphImLNmcCCmxUAm7Ews2kdmX4r4I1W5Lk/quVH7IQ6aDDI7ig1v2zXP0fizupvQ
	 XZ7MCt68q3fqyRnhl8oTq3BHVglzOSZL+NuV7mc5XRglMegOcj0JvIjzWWEicDhZ7F
	 x4PflHbYQQ+g+iVQHql0gyH9BjOjf4teg6N9Ja7N4XPXCgCk5jLPwHnS5Jr1T7YaN7
	 i10cMZAMjYWs8ih3OZr9OSXZ8wD7Dq1ybHHZGRstKPKv2MzdKIA8toIapVohMxWu/s
	 YDqFVnnIfmehQs56wNoVZguwUdLzQvZGaF/qI04fRqMpNlkl5g+XjU85xbFKXVC5m1
	 xM4+V80IkzhaQ==
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
Subject: [PATCH AUTOSEL 6.1 01/17] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:31:40 -0400
Message-ID: <20241023143202.2981992-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
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
index 0fc2d706d9c23..18db0e23e2f15 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -969,6 +969,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
@@ -1026,15 +1027,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
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


