Return-Path: <stable+bounces-70009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6595CF25
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8635281183
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C11199FB9;
	Fri, 23 Aug 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxvNGgho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F1199EAF;
	Fri, 23 Aug 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421836; cv=none; b=nzxaMl135wz1hAStL45NGPlwkVPF4o6GVbu1kuDiFus/lPxWV2pYnC/KYCgTWkRTVjD1dOyhUfB4I/H78khcJ25PNS05i/2EJNuYp3DkNnRE/D0qB1PF1UuEpdeMJMMFchb4eiX0YsCMBicy5Kznuy6SCkxLoaHwHKdxFRUhABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421836; c=relaxed/simple;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtt4MyGAqjWRQ9ARnS19QULFdzUdenj/mfrW7X6UmQuAgxKstmk+VYFiHgiQnzHYanNL85IATQtF/wWlOYJow6+z2R0OMSXfpvG1LZMwzPMj2bVb1FNTyygfqgIgWVrC/BKLZ4s/m+Jq96JjK68vAEghzaBB9921hqAMX1N3ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxvNGgho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D56C4AF0B;
	Fri, 23 Aug 2024 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421836;
	bh=UiqWGB4fidTn7hEicA8WF8H3Yu5kNYzn7AfdgvBKixA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxvNGghobk6RaFiXFE6qolrrWdwqbe93uHpwQiQtxkRZGNCPmyaz+NIKFLxU/d6lo
	 23HGBCfqKi7n9TVQiA5F5JEgidR+caHLNJmtSfR7EkxgPUO71Vo9rbBVsuOv/3xnD0
	 gqhJkyRVOY85afT0eqeV5AFTx2Pf3qdxfXRdYyxW6R6ppmWSbfq7Rh/w02hppZ2oNb
	 AXjug2UqncbtoMhTxiZkTtV/IrgxWoJc3/ij8O+WOmWNFXsZfessZj4bktUBR7/N2W
	 +d7E767hTiUCFp7DodsWC4TP3nNqtBHX4Byi7ONHz+LSE4uAlxb48Me9JLfOGwkxdB
	 VgpU/oX6rFmKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 18/20] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Fri, 23 Aug 2024 10:02:32 -0400
Message-ID: <20240823140309.1974696-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@linux.dev>

[ Upstream commit b2f11c6f3e1fc60742673b8675c95b78447f3dae ]

If we need to increase the tree depth, allocate a new node, and then
race with another thread that increased the tree depth before us, we'll
still have a preallocated node that might be used later.

If we then use that node for a new non-root node, it'll still have a
pointer to the old root instead of being zeroed - fix this by zeroing it
in the cmpxchg failure path.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/generic-radix-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 7dfa88282b006..78f081d695d0b 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -131,6 +131,8 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
 			v = new_root;
 			new_node = NULL;
+		} else {
+			new_node->children[0] = NULL;
 		}
 	}
 
-- 
2.43.0


