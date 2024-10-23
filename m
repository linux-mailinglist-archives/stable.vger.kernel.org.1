Return-Path: <stable+bounces-87837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498DD9ACC4E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADDA2840BF
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326B1C32E2;
	Wed, 23 Oct 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVwULmpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF731C3050;
	Wed, 23 Oct 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693817; cv=none; b=NFGJuu29M0sETbA7clId2lajkX6t3K/ZXjmJkXWYuat/Vh8uu17GbW9juAwFEGXd5Sxu1BFDaWsmf75F9Wp+B5awaNfUS37e4ScN4rSVeEqqpajinjav/4Qv+0/InSqzOC9OLnx7inAe80tWnVaqbxAmUiTALANjitGndmVSorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693817; c=relaxed/simple;
	bh=9PqVYOTv8iAR1WyhJ9c/S+sMqMPvYsS+KTvI9iVkvzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBr45nbndSPmwtn644t0cjLGqSy4PqodVr5rEnMUlmKpm+AScsWo/HQyVVV5stt4o4JYgJ4B1EXJw0ed8vK8g9F7e+W+74Q9Nps6FmcCvrNRL9JSS1qwLkIlYyPTzSO0IM8dVqLRV+p5i5pCbTovIy/1ryhNeiCqxQtlPSszIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVwULmpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6440C4CECD;
	Wed, 23 Oct 2024 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693816;
	bh=9PqVYOTv8iAR1WyhJ9c/S+sMqMPvYsS+KTvI9iVkvzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVwULmpzdypMI+gp7dXZudc3xg0eWaO3uJLYZx2XLuP9vRAi+Vny9Ega84a4CuOBF
	 E2o4cWNKuykIb0DedvpcXHw7KpZKdPFXxHMOfdnk5jGAv4i3Z6hU4fXXadKvragS/X
	 NWVZKQ5zSfvSc/0qOoiQY1WUWmXs37JYxEcngoqap/BEWpX/Sy4vngoIvKgr2N7Z3Y
	 pN51X6mmYL6ZUuAIeMg5+ylCWRuH91xh+0d5H3QI6IQNZpjMe00xrc6CFeTsZHRnz1
	 NDBWek1ZfZhQslDjemzOApLMuGaFAZFfeaozai3ItxNGlGLsPVLbrM+hhzheGlqHaT
	 p7tydiHis6BTA==
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
Subject: [PATCH AUTOSEL 6.11 02/30] 9p: Avoid creating multiple slab caches with the same name
Date: Wed, 23 Oct 2024 10:29:27 -0400
Message-ID: <20241023143012.2980728-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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
index 5cd94721d974f..9e7b9151816d6 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -979,6 +979,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
@@ -1035,15 +1036,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
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


