Return-Path: <stable+bounces-125351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303DEA692AC
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298BC1B828D1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4E21C160;
	Wed, 19 Mar 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxMEN5JV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFB1E5B97;
	Wed, 19 Mar 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395127; cv=none; b=tDXBo38sAzwivrXjDnxTaR4H9c7EbmUAkDVfaXBhdtFzicx5XjcYKxnkUNOxEb9TrjiAw6I/aLJphJMNt4bReqOHMo9XvPjR4mhgVtz7J4uuU4hb3Vr5CPlDf3yoWxxEDPvSQfQuJkUx9EwsZA4IQ+uawoNKw1t67OVKCABPcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395127; c=relaxed/simple;
	bh=YFBICstWxpffwNxwueTN4b5VogK/xkEWRnFFF7uJiwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt9cAJuqB4oPh7zg5GdtCrdPfyEFMMBjH/eCkvFlbYLLFHAqzZ3UHs2SCICHxcSHpzRYSk5y6wlx43zEioDrA7IeHn+Gsnt/xoMN+bj/jgUhi2itW+rK+3f8kaV8JBeQNKNKcdDOa/P2T4CLd3AqbJI5/v32YpYx+i97eQ8TjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxMEN5JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD4DC4CEE9;
	Wed, 19 Mar 2025 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395127;
	bh=YFBICstWxpffwNxwueTN4b5VogK/xkEWRnFFF7uJiwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxMEN5JVhQJCBSbz7tpIY9x6FoioYv3hjihYnd7MIST35mOplQmEJhgiky3BW/zaE
	 KDIsfPC9Lr/ijBe0C871thZ8rOnUh4qVo5zVuz8nxe04A82mDtxcb1a/ZODZkMG5ml
	 pGtojeYf4wIQByyG4XPzseLCdkHhD/GE0fE1aP4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.12 190/231] dm-flakey: Fix memory corruption in optional corrupt_bio_byte feature
Date: Wed, 19 Mar 2025 07:31:23 -0700
Message-ID: <20250319143031.532089248@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kent Overstreet <kent.overstreet@linux.dev>

commit 57e9417f69839cb10f7ffca684c38acd28ceb57b upstream.

Fix memory corruption due to incorrect parameter being passed to bio_init

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v6.5+
Fixes: 1d9a94389853 ("dm flakey: clone pages on write bio before corrupting them")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-flakey.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -426,7 +426,7 @@ static struct bio *clone_bio(struct dm_t
 	if (!clone)
 		return NULL;
 
-	bio_init(clone, fc->dev->bdev, bio->bi_inline_vecs, nr_iovecs, bio->bi_opf);
+	bio_init(clone, fc->dev->bdev, clone->bi_inline_vecs, nr_iovecs, bio->bi_opf);
 
 	clone->bi_iter.bi_sector = flakey_map_sector(ti, bio->bi_iter.bi_sector);
 	clone->bi_private = bio;



