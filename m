Return-Path: <stable+bounces-173187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38866B35BAC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462C23A843E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA966284B5B;
	Tue, 26 Aug 2025 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JjRS5Rst"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871C2BE03C;
	Tue, 26 Aug 2025 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207596; cv=none; b=ewa5n5IjulyKH81wwjK1vMRBfGe1mQwwPHSjAYJ/yMzVZpJXk2arxi5aCvwGSqFlfLxPHzBdKi2T1cpN76JTf+vvpUeArOKY3cXZELc+YqLZGuWaoWH06Jov1eeAuNZHW3709sLc2OhW/FJn98w/6/xZ0AIyZvx4qjmfFaUuLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207596; c=relaxed/simple;
	bh=5nSW2E5JhAU1NzCeUaO2HBpqqHJk7N4Vs0gaFUWwRuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6KI8mh4s9Tg7qfFWeBHrK/aVkQkuC5TJgufkd/R4OvhXApcxL/UITvZTNKbho8HXkSYCbMt5z3ci3ZuVSqMpOlihvayRvESR4urHfppQCBdTRJql9dVZ667wgZ9fSTXyD0JeSWVMoWayMrM5FuibcpHsybkNpBn2uvkov2CaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JjRS5Rst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F3C4CEF1;
	Tue, 26 Aug 2025 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207596;
	bh=5nSW2E5JhAU1NzCeUaO2HBpqqHJk7N4Vs0gaFUWwRuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjRS5RstYvBdE/kfxG18pBbyQSZbPrnTMaQNdpTlXGkc5bTQ2eTAoHZrvUrdeaHpt
	 wK8gWje4nmHDwkdOgPphySgeseaBBFmnY8Gc/KEPSJfKyqO5cg4fTgbM6XC3OR1hYF
	 5qBNTgiXjzrhi7+tYvWYA6jAcDZOY6HGmS6nTjzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 216/457] btrfs: add comment for optimization in free_extent_buffer()
Date: Tue, 26 Aug 2025 13:08:20 +0200
Message-ID: <20250826110942.702075942@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 2697b6159744e5afae0f7715da9f830ba6f9e45a ]

There's this special atomic compare and exchange logic which serves to
avoid locking the extent buffers refs_lock spinlock and therefore reduce
lock contention, so add a comment to make it more obvious.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3493,6 +3493,7 @@ void free_extent_buffer(struct extent_bu
 			break;
 		}
 
+		/* Optimization to avoid locking eb->refs_lock. */
 		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
 			return;
 	}



