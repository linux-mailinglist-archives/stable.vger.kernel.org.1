Return-Path: <stable+bounces-87927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAA9ACD5D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C7AB25F64
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C71CF5ED;
	Wed, 23 Oct 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCWJQt8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787151C689D;
	Wed, 23 Oct 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694004; cv=none; b=Slulohl2UoLTLeq5rX7kNHw1pjhiLk0OcZDHn0KVKgwFRZS0zLEi4pXMxQa9WilhYN70AWqlPui2ZFSp/i88QyUwn8jZikTyVyDSep3Bf/aI5JOOe/NHhScdglXlRcHKzcik0xdep5utx7a84eotvzlbWYY5QqECKaCg+V12l68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694004; c=relaxed/simple;
	bh=Aa8Dr6HjDm0KdvVgBix0WOamC544AyPnhKWCLPFn3PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppA77IG4dE9A1wfJ5CEKXBtJuC4mOC8bgzPgbKldv3oBrZ1ZBJFta5fJrY/Jf44GwOkneuMLsIJSaRajhkYwcEOCaB99G4kidzjLgP7ScjdUDaAmewoccyJsUFt7Yy2IDKVZaC0uvCD0Yfc2HaXZr3JLF2j2mo3/TZf6MRaHdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCWJQt8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226C3C4CEC6;
	Wed, 23 Oct 2024 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694004;
	bh=Aa8Dr6HjDm0KdvVgBix0WOamC544AyPnhKWCLPFn3PQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iCWJQt8lzSxX4W2Hja7ewDWEyqJxDA3HMTw9mXiY+W0gkhMTgDc5v88ZWp/3JtkrU
	 qqaB+MqIneQiQg+NxeBXWGp063ZAPCwazg4yBAhqAjPtr7MQex8pp9BSweWc72PnDV
	 80t3AlxdGB4kB0xXSmGelpGiMkWvqMw7uFsHpvQr1XA6zx4NNJ68AIN8r4Hf/cYFkT
	 AsxXD/EhaLg6JHdtyHv2Yj/Dq/bUV6wKTnn2sBKtdQTCkspuRvpfpyJx2zjoNKbnU1
	 rViFhXra0AYWX5nNDNtr3OpR+BicRWc8GIcZNOXt1Iid0mpk8G7tewq2Glj/DAB6Ay
	 4hYlENovCfQYA==
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
Subject: [PATCH AUTOSEL 4.19 1/5] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:33:16 -0400
Message-ID: <20241023143321.2982841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index a7518e8e76265..e6eee4eecf24b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1018,6 +1018,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(struct p9_client), GFP_KERNEL);
@@ -1070,15 +1071,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
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


