Return-Path: <stable+bounces-198394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E4C9F9E6
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5A53012DCE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1B303A3D;
	Wed,  3 Dec 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxzY/CvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA618DDAB;
	Wed,  3 Dec 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776397; cv=none; b=EhwC3Oj1xnXprXwmdUCM7cu1FblFKmLC/W5k3EmpZvqpJUgRBlQ2dZSJVGDbxg89u3MQCdCfHmUfzBJG8zk2BZ6fLB6w43AHBLJeuY1grSnvKcOgI9M7pfZRQCaen73WnYL5L/VoQdTXpaDDNWzPXuyZGnxmBiF2NfQXX8OvzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776397; c=relaxed/simple;
	bh=ZM1LrnGkm1aHBYnTbWG9aPfLEZzsY5YtpV3IAnqyRLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjtz0KLEbdFMDuDrYHgNjUe+1jQhzRet4XFY8UBZ8XA08GuYtRAL4bw8Mdx/b8LKCWaO4AuN2aqN4h1xIufAQoHTN5J/enF3Av4LgHEt9G/qsAu8Vi3JaB1iWIGCxRfihCzAlVt1Vg97SPvQ1Xv1ozze2HGeCuvwBOhpEfMO7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxzY/CvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AD7C116B1;
	Wed,  3 Dec 2025 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776396;
	bh=ZM1LrnGkm1aHBYnTbWG9aPfLEZzsY5YtpV3IAnqyRLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxzY/CvBdWnQCYUvbI15gMrusDWXh2qHA1DEgb8/4m6dwoGSWFtrckd+4j3n39TLb
	 qVfoIRqDwx/tTTG2wJ+Ytgc7vLvEU5ZczV8oFD/ww/s8zsKfFVfXaQcvhUpnNaSCjM
	 rberBG5hLSJzc8lLMrlpPzCS++lvpDzR3KzHgQPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	chuguangqing <chuguangqing@inspur.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 137/300] fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock
Date: Wed,  3 Dec 2025 16:25:41 +0100
Message-ID: <20251203152405.689631873@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: chuguangqing <chuguangqing@inspur.com>

[ Upstream commit 1534f72dc2a11ded38b0e0268fbcc0ca24e9fd4a ]

The parent function ext4_xattr_inode_lookup_create already uses GFP_NOFS for memory alloction, so the function ext4_xattr_inode_cache_find should use same gfp_flag.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 203ffcc999400..fa8ce1c66d123 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1492,7 +1492,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	WARN_ON_ONCE(ext4_handle_valid(journal_current_handle()) &&
 		     !(current->flags & PF_MEMALLOC_NOFS));
 
-	ea_data = kvmalloc(value_len, GFP_KERNEL);
+	ea_data = kvmalloc(value_len, GFP_NOFS);
 	if (!ea_data) {
 		mb_cache_entry_put(ea_inode_cache, ce);
 		return NULL;
-- 
2.51.0




