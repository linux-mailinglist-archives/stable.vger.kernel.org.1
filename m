Return-Path: <stable+bounces-37557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D289C55C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F611F23336
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F07BAFF;
	Mon,  8 Apr 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCtKhq8j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6379955;
	Mon,  8 Apr 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584582; cv=none; b=sQ4GLjO8G/4c+4/IZeM2iOjmxiyyl5yU20UAyyaUIfBOd/W5T4Ql0dRASO2mc/ldXmiFHzr5CFx8h1Kh8P3lmuTLqseVg6e0vv3nfKp2nHBQRx3dchVadEUV58AsCRZlZ0CgFvx+l+UHx7peUR7aMTTfccjODjoS2xprXKQ8QOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584582; c=relaxed/simple;
	bh=uFae4jTLDBWSijdfJzKgPhoopWZal7pXlfUnjPcYH5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0tl7EnTcNJgd4nuFiciEa3WzALE6kjlsqEgm90Ajo3kshjcyYH3tsJU3oScw9sJk3MAqbvzkIZYolXYOrnhKawzpldJuoOl3ExLmIZd3cGFzoSkZNC6DfFwF4nZZJ3z00s6zgJhpS2qDQ4LIhMMv52bxou6SVGPUc14Ap0maSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCtKhq8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A758C433C7;
	Mon,  8 Apr 2024 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584582;
	bh=uFae4jTLDBWSijdfJzKgPhoopWZal7pXlfUnjPcYH5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCtKhq8j/1X5BgUAzT0g6XUkJPMtAKykeHPDXBs6uh2SpricZj0eQKrKqUe74sDsM
	 dyfvpxByg2FxpGIOS1PORs0sVbMdT0D74eI+Je7LynJySvNMVvqikal9HCmPkpoTEO
	 76kIJEu4jzmWFPrefXj/vvGynSGsNlNUoNae1hYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 457/690] fsnotify: remove unused declaration
Date: Mon,  8 Apr 2024 14:55:23 +0200
Message-ID: <20240408125416.192983292@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaosheng Cui <cuigaosheng1@huawei.com>

[ Upstream commit f847c74d6e89f10926db58649a05b99237258691 ]

fsnotify_alloc_event_holder() and fsnotify_destroy_event_holder()
has been removed since commit 7053aee26a35 ("fsnotify: do not share
events between notification groups"), so remove it.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fsnotify.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 87d8a50ee8038..fde74eb333cc9 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -76,10 +76,6 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  */
 extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
 
-/* allocate and destroy and event holder to attach events to notification/access queues */
-extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
-extern void fsnotify_destroy_event_holder(struct fsnotify_event_holder *holder);
-
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
-- 
2.43.0




