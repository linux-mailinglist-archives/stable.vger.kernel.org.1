Return-Path: <stable+bounces-171699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC74B2B5C1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E255419621FF
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442B1922FD;
	Tue, 19 Aug 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmPVLTBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329333F3
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566135; cv=none; b=E3kr050iuAKgcq7jdp3A239KZh8uBM71gr5qKeAhbzMjxtkW3BdZF7kZy7WLmJVS7YhIYmVmhiw/znSb/ZDD3FXKvMzdspHZxHLX5IGBqO6wCZkUu+BVGLF1O+OHSn1kVJVW1/BSkjqpDklrg8OQH/tN3Wf3Bz++aNkVKEcnFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566135; c=relaxed/simple;
	bh=cj3uzMere4UcnswI6Fi2EHvAFWLFaJzEbwXh6OqrvZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOc/dFCFAcuGn/su3uHEqVsMjrXbKCG6pfOFTue5DIMnt0vhp/bxANxXBavsa6Ha0LAsw0cClCC8BQawJf0CulJ2DX8A7LRYwPafKbj0pwjtKrMc6/q9wQeWD84JrgUJRCUmhMuieH0EsbC5Rr2ojtKK7pvB5sUrCbSvxPP+TI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmPVLTBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33891C4CEEB;
	Tue, 19 Aug 2025 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566133;
	bh=cj3uzMere4UcnswI6Fi2EHvAFWLFaJzEbwXh6OqrvZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmPVLTBAdRLKP1yULJRf5WTyvyOk6SzfcOtYQqWuPr6P16EfpdT36womHOe3/Hm5m
	 tn1dGd4qZKdBZBkq4YoqNQeNg+4n2ZM+7RQ4rM8bqkR5t9AROz09Y59+xI8AKJfPfI
	 diZg0SpOBuWhF+iN8UxIXn8U1p3FJ4YM19EKVO11N1Hb6EAGf5V5qzT0dVD4qKcqjg
	 pdvNC+lTGyW52p9WZSyriENABvotdxoDfxAZIMxIT48NDciE/CuGID5UD3RT3XHpt5
	 75hB53j5XI6lL7A+5MYCOu/d8yPKwsxwmXRNthFbqyAz7y8TKlk1JwBnetveGB23Zo
	 5TVp0mtwUltlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/4] btrfs: reorganize logic at free_extent_buffer() for better readability
Date: Mon, 18 Aug 2025 21:15:28 -0400
Message-ID: <20250819011531.242846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081814-monsoon-supermom-44bb@gregkh>
References: <2025081814-monsoon-supermom-44bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 71c086b30d4373a01bd5627f54516a72891a026a ]

It's hard to read the logic to break out of the while loop since it's a
very long expression consisting of a logical or of two composite
expressions, each one composed by a logical and. Further each one is also
testing for the EXTENT_BUFFER_UNMAPPED bit, making it more verbose than
necessary.

So change from this:

    if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
        || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
            refs == 1))
       break;

To this:

    if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
        if (refs == 1)
            break;
    } else if (refs <= 3) {
            break;
    }

At least on x86_64 using gcc 9.3.0, this doesn't change the object size.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1dc931c4937f..8590f8a4a139 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3486,10 +3486,13 @@ void free_extent_buffer(struct extent_buffer *eb)
 
 	refs = atomic_read(&eb->refs);
 	while (1) {
-		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
-		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
-			refs == 1))
+		if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
+			if (refs == 1)
+				break;
+		} else if (refs <= 3) {
 			break;
+		}
+
 		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
 			return;
 	}
-- 
2.50.1


