Return-Path: <stable+bounces-67057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4A94F3B3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8811F21012
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71D186E38;
	Mon, 12 Aug 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lM8sYUqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40229CA;
	Mon, 12 Aug 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479661; cv=none; b=NxY8LrrR+qNPrTgdLcF19Bmaphi4AJCUqTt0XwFnCwLs++I0vST94bsL1Ci44ZBodTNuUOyDtvxsvb3tf5YkmaW9lWzFw8ci9zX3AfzGzM19nZrr4F2J7VU01+Ew2z04uXqEgsIQgApSv051vhCXA1EeagiwkrymEn0qLMagAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479661; c=relaxed/simple;
	bh=tGfHVzMXRMmzqNRm3hiBUp5ceD3A0yfZErdgAp2fkrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCEUqOIBK693aOXthH++jI4P8JgR5ze1FQatpQzva0GfmVV8YGhYmC96LhXnAd0g+Y75z5LSPoH/nfaw6/l3dEEmxl4oBgAMWoalD431BHFElhF27ujeueDPnYet/nuk3yz/r0zim9Gnr7TxpEhCQv4ctxsoxbyGkAfRAnq7iYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lM8sYUqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A90C32782;
	Mon, 12 Aug 2024 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479661;
	bh=tGfHVzMXRMmzqNRm3hiBUp5ceD3A0yfZErdgAp2fkrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM8sYUqkxYboEf6GPhK5XPfz3eephjcaO70FhbyMH/rh+6//TCJ104vuwfFGPo6V5
	 zShHYDIW6viV6y3f4tPjg3EW8ZS3CGZ9Q2rqf4z/19geNIWMufLJIZWLJM9RBiyzCF
	 hb0311EDxdZi7JhUMwpCVUjYWfyHY5ynbTblm6VE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam James <sam@gentoo.org>,
	Alejandro Colomar <alx@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 154/189] btrfs: avoid using fixed char array size for tree names
Date: Mon, 12 Aug 2024 18:03:30 +0200
Message-ID: <20240812160138.069338661@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 12653ec36112ab55fa06c01db7c4432653d30a8d upstream.

[BUG]
There is a bug report that using the latest trunk GCC 15, btrfs would cause
unterminated-string-initialization warning:

  linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE"      },
      |
      ^~~~~~~~~~~~~~~~~~

[CAUSE]
To print tree names we have an array of root_name_map structure, which
uses "char name[16];" to store the name string of a tree.

But the following trees have names exactly at 16 chars length:
- "BLOCK_GROUP_TREE"
- "RAID_STRIPE_TREE"

This means we will have no space for the terminating '\0', and can lead
to unexpected access when printing the name.

[FIX]
Instead of "char name[16];" use "const char *" instead.

Since the name strings are all read-only data, and are all NULL
terminated by default, there is not much need to bother the length at
all.

Reported-by: Sam James <sam@gentoo.org>
Reported-by: Alejandro Colomar <alx@kernel.org>
Fixes: edde81f1abf29 ("btrfs: add raid stripe tree pretty printer")
Fixes: 9c54e80ddc6bd ("btrfs: add code to support the block group root")
CC: stable@vger.kernel.org # 6.1+
Suggested-by: Alejandro Colomar <alx@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/print-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -12,7 +12,7 @@
 
 struct root_name_map {
 	u64 id;
-	char name[16];
+	const char *name;
 };
 
 static const struct root_name_map root_map[] = {



