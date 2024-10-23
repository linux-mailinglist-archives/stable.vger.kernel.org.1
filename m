Return-Path: <stable+bounces-87922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B29ACD4E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50A01F24CCB
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391A2170C8;
	Wed, 23 Oct 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di/zw5ll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89E1CF29D;
	Wed, 23 Oct 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693993; cv=none; b=FOdS1GVmqXl1CRFprTv4n6gHeO4+rMFiHkSPOKwEv6M1e6boXgtB7QVtk8s7TXBZRPJr7PSarP6SzXbzsr+aanfR/ghCIGkpai2Oahjqpqf4G8Q/uxCmHJiSOq3d5cbuTzg2QJIhCpiZbq/9+Fvs2QJ4DyPV8lcFzvbWejkeNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693993; c=relaxed/simple;
	bh=tnAxfdLlsYd/NzPcFyFwcVhnWu+PsTFCFWIROjh7ztM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akVq2apxs7NhdBvVECMge3rox7hB0qasLLPObMRaE9WNXiy96UvAjfbRnTtnj/3BFob9L6IHwqtRf6CpXHjMvW8b+C3eJls76e+DdjPha+B54XU9O9IMP7M7IL+HwIJMnfb9Ui917ucLpv8r6x6vO9qaLEYqvisdQf5nF4nXH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di/zw5ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14141C4CEE4;
	Wed, 23 Oct 2024 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693993;
	bh=tnAxfdLlsYd/NzPcFyFwcVhnWu+PsTFCFWIROjh7ztM=;
	h=From:To:Cc:Subject:Date:From;
	b=di/zw5llbl/ajXiC6yXy/83CE1BgFO7DdC9MYVgXNFxQ1fkWJWCqoge93sK48fkyE
	 Gizaj/Q2U0qWCYPPMnlIIUbV5r5MFDDpTZGgjTypT7kGXFxwuOqfvMXmv+GEExw3uP
	 VhJg9xQEFEeXV7wNsMq3WMyzXc7vyvzueGu2rU4Jr313T/FqG/4QIZQBRmtkcu3h1M
	 B9R1RUFEnZFUL9B/AsUX0rnB6BhpuTep3xklzEcB7EAn23ZOI9sFS7u4Pp1m2Kd/1u
	 gjgNbpVu2nkRqg/YCWNRH2/EaCTQkAoOetnq4c6MZFL1oLzBNWy+DGAuLO/jEKqTmp
	 EZ2PEJSSZfHyA==
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
Subject: [PATCH AUTOSEL 5.4 1/5] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:33:04 -0400
Message-ID: <20241023143310.2982725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 2b54f1cef2b0d..0f5db1f414be1 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1003,6 +1003,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	err = 0;
 	clnt = kmalloc(sizeof(struct p9_client), GFP_KERNEL);
@@ -1055,15 +1056,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
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


