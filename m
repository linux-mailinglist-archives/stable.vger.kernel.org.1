Return-Path: <stable+bounces-1987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16507F8247
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1BB23A58
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA493364B7;
	Fri, 24 Nov 2023 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pxdgPcy9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5234189;
	Fri, 24 Nov 2023 19:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C999C433C8;
	Fri, 24 Nov 2023 19:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852769;
	bh=qBM8iPe989n4S22Vy/tJ5427yWtLAsZjhakQg9rvrKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxdgPcy9MszRmIJ3IDxonx0uULlKangNyVqsmFghTLQUXRav+bUwmjEnmolqDObfT
	 WGTHoW9CHM7kiGz5jYC+tn43mwGkGXmJwDcY/TaTH6cQCi54yHXyBvYyKjxgIfGpv2
	 Hqw2Ftd2vG+vxE4FEn6BidL5aWKxEJrSS4nQIlWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Lukas Loidolt <e1634039@student.tuwien.ac.at>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.10 091/193] randstruct: Fix gcc-plugin performance mode to stay in group
Date: Fri, 24 Nov 2023 17:53:38 +0000
Message-ID: <20231124171950.894665873@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 381fdb73d1e2a48244de7260550e453d1003bb8e upstream.

The performance mode of the gcc-plugin randstruct was shuffling struct
members outside of the cache-line groups. Limit the range to the
specified group indexes.

Cc: linux-hardening@vger.kernel.org
Cc: stable@vger.kernel.org
Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -209,12 +209,14 @@ static void partition_struct(tree *field
 
 static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
 {
-	unsigned long i, x;
+	unsigned long i, x, index;
 	struct partition_group size_group[length];
 	unsigned long num_groups = 0;
 	unsigned long randnum;
 
 	partition_struct(newtree, length, (struct partition_group *)&size_group, &num_groups);
+
+	/* FIXME: this group shuffle is currently a no-op. */
 	for (i = num_groups - 1; i > 0; i--) {
 		struct partition_group tmp;
 		randnum = ranval(prng_state) % (i + 1);
@@ -224,11 +226,14 @@ static void performance_shuffle(tree *ne
 	}
 
 	for (x = 0; x < num_groups; x++) {
-		for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
+		for (index = size_group[x].length - 1; index > 0; index--) {
 			tree tmp;
+
+			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
-			randnum = ranval(prng_state) % (i + 1);
+			randnum = ranval(prng_state) % (index + 1);
+			randnum += size_group[x].start;
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;



