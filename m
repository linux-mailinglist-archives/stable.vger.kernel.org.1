Return-Path: <stable+bounces-87916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFB9ACD3F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6191F21766
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4130212643;
	Wed, 23 Oct 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGZ548WK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7D1C6F54;
	Wed, 23 Oct 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693979; cv=none; b=ph2qZ6c0a9o1069gLUByXi3ILw5ZA42PegCDSdm4NDKtiiKYt8mZTNSmwD1pASi/+GRdMQozYVw/qcY9hNVxNtfEoOn/NL0fVCvTI5+BUx3dQpG0wD/Z0f1nIAu/j5KDh9y4lU0A0O2u5npfbNWjYomlJSlD8+pQR3OKaHyMt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693979; c=relaxed/simple;
	bh=enkQkmdv7M7C6Y395F1RKfyMV0RSCCGLa+HtlUWN9E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgK7E9CzWkF9TUVOwTr4BT9pNITOqbiudyvuLaZfSL51Jozd/ttGBlwWv0xIqjiaQkBYaRF2uHELVPIFoJx2xR0qTGG/AiSq7K1tD5C9q9DEjKqav/JVNcPyIYV48NI1tGBRxUERVqDrZpIsW9MoItoIS05PEnkJEBuyb7JqsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGZ548WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1FCC4CEC6;
	Wed, 23 Oct 2024 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693979;
	bh=enkQkmdv7M7C6Y395F1RKfyMV0RSCCGLa+HtlUWN9E4=;
	h=From:To:Cc:Subject:Date:From;
	b=fGZ548WKTvEXqKJE2xJo/d8tOkaXqwkPvD9OFsX/PRdZi33LWff50GlJUeRf6b8V2
	 7UFWAiFaHQO1BOfqYQi0eo5j7F7dqXirLTx2sAyMQqwR6/A6hD9em1nlb/+1ZrqNZd
	 DmCSfyOFzY3Y/i1f7iHYNNWzRveInZLlZ25qmaLK0HbqoPBr7Ifkw6qGwjooWUKgzZ
	 PLV262dvEceBub57Qi59hoM2WDRMV+dTriWMSlywK9/PYzbm1vsMtiO0oETXaskRYf
	 o9+PWnQrEty6vaU+5RRaYDqvBurJm4nGzrVkVvDWkaI+FBUHi5CJBFCkpvB/nRkIOm
	 vLodMcIWs+A2A==
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
Subject: [PATCH AUTOSEL 5.10 1/6] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:32:48 -0400
Message-ID: <20241023143257.2982585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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
index 0fa324e8b2451..2668a1a67c8a8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1006,6 +1006,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(struct p9_client), GFP_KERNEL);
@@ -1058,15 +1059,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
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


