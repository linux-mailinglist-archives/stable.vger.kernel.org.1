Return-Path: <stable+bounces-87219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D09A63D2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B781C2203B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6821E885B;
	Mon, 21 Oct 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmH5YZUl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A139FD6;
	Mon, 21 Oct 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506950; cv=none; b=kxB2scfSbKx/M65Ev0ZyUgRIJ4eskgqBUehG1tjbvOqScqZO6v/RxpfFoL3KXznH0MMWHCkl6RrRorOYb7twjmWg4CddvBim/LcX7vsSMQtJ3xWIjIo7vA8RA62fKjHa1gDIgOAYFUjaw4qMOzxbCe9jOSj/q48F76uYFTArMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506950; c=relaxed/simple;
	bh=PRbtMBbjxPeLYyxKkbiso+HLSnnRfNOqQmcRG3VfboI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLsynsBx1ou+6/xkpPTwWe9JJyreSrobpQHcCGAfQU6iEREMpA+AuuMq08nNQf4I7o1XwUSaiTW3Y8dETZSoFddCgJj3xEBQgx2aWQw18vrGcRGruoNonx4RI9IPnV3FUfld5M4I5jMtSy1WKar2gFZ7T/yZtL3Pp2VEIN5U6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmH5YZUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D8AC4CEC3;
	Mon, 21 Oct 2024 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506950;
	bh=PRbtMBbjxPeLYyxKkbiso+HLSnnRfNOqQmcRG3VfboI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmH5YZUlX1rg5wcYUOx3sWe+njqf71j2nEdixHjF7T8NmdQkN78L6cfBnTjzaQmFh
	 Y1dWJo3aaQCXMH2VcrY324HLZ0xcGiUFZbxZQcUZ6UEr4uQcd2nK80dvjmaKVmCayy
	 e/KozrcIAk0XT8Tul2ILZbuPY2uwxWb0elVx/4xc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Xu <weixugc@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 022/124] mm/mglru: only clear kswapd_failures if reclaimable
Date: Mon, 21 Oct 2024 12:23:46 +0200
Message-ID: <20241021102257.582667771@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Xu <weixugc@google.com>

commit b130ba4a6259f6b64d8af15e9e7ab1e912bcb7ad upstream.

lru_gen_shrink_node() unconditionally clears kswapd_failures, which can
prevent kswapd from sleeping and cause 100% kswapd cpu usage even when
kswapd repeatedly fails to make progress in reclaim.

Only clear kswap_failures in lru_gen_shrink_node() if reclaim makes some
progress, similar to shrink_node().

I happened to run into this problem in one of my tests recently.  It
requires a combination of several conditions: The allocator needs to
allocate a right amount of pages such that it can wake up kswapd
without itself being OOM killed; there is no memory for kswapd to
reclaim (My test disables swap and cleans page cache first); no other
process frees enough memory at the same time.

Link: https://lkml.kernel.org/r/20241014221211.832591-1-weixugc@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Wei Xu <weixugc@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Jan Alexander Steffens <heftig@archlinux.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5603,8 +5603,8 @@ static void lru_gen_shrink_node(struct p
 
 	blk_finish_plug(&plug);
 done:
-	/* kswapd should never fail */
-	pgdat->kswapd_failures = 0;
+	if (sc->nr_reclaimed > reclaimed)
+		pgdat->kswapd_failures = 0;
 }
 
 /******************************************************************************



