Return-Path: <stable+bounces-154492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1DADDA18
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8237C4001A5
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390D2FA62F;
	Tue, 17 Jun 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YrRZjAIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6062FA626;
	Tue, 17 Jun 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179381; cv=none; b=fwzyocp2FsNRp3PoQMGWTz3R2aTqthMEgvuYsGd9fcB+EQtJAECsQHx7Q2X4R+dqUI3MXeRdxjbpbZfBgXNEJUOcPcVEul4HYPHHpPiUdBtDgqknhjJVSkEEZUwWekqMWH0WSWUxEaVKJ+T/+Gu3gF1MuJsPJQeHdU1TqxcbNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179381; c=relaxed/simple;
	bh=6hZvnRaW5Z/WCvqFgJmnugeJh3dAagz+e3JVXK3R3Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXRqKP54CJ+e1AXH4ti0VF47+iwJBnpsLTLuo7EeD3dJKarLvnCtJ2pdkgxgFZKQ/5G+p4XDYjD+C3oSK3pOWAIOJoVESgDMbc+yPPJ2KDgbdOIMzVXGtmu3lWWHLUjK2hW6XKLZhEGccwA1oXhDdyo+V2mwRbp+zbe9GxtJKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YrRZjAIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB7AC4CEE3;
	Tue, 17 Jun 2025 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179380;
	bh=6hZvnRaW5Z/WCvqFgJmnugeJh3dAagz+e3JVXK3R3Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrRZjAIkSSvc94lO8ydP6nofMbThUm0nh2o7GvKfFUb0akItNpHVI3tcKhxb+oSXc
	 B+DRHqx1fHN28Rxh7XLTujCcENKqwYHCpZJol9YiqV8Xbm4DE+DAR02YteUH0v7RHu
	 WAh0J07UfP+FmDUNUB+ItUffi7OP9hWAHqCy0hEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 728/780] btrfs: exit after state split error at set_extent_bit()
Date: Tue, 17 Jun 2025 17:27:16 +0200
Message-ID: <20250617152521.145622349@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 41d69d4d78d8b179bf3bcdfc56d28a12b3a608d2 ]

If split_state() returned an error we call extent_io_tree_panic() which
will trigger a BUG() call. However if CONFIG_BUG is disabled, which is an
uncommon and exotic scenario, then we fallthrough and hit a use after free
when calling set_state_bits() since the extent state record which the
local variable 'prealloc' points to was freed by split_state().

So jump to the label 'out' after calling extent_io_tree_panic() and set
the 'prealloc' pointer to NULL since split_state() has already freed it
when it hit an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-io-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 92cfde37b1d33..b5b44ea91f999 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1252,8 +1252,11 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (!prealloc)
 			goto search_again;
 		ret = split_state(tree, state, prealloc, end + 1);
-		if (ret)
+		if (ret) {
 			extent_io_tree_panic(tree, state, "split", ret);
+			prealloc = NULL;
+			goto out;
+		}
 
 		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
-- 
2.39.5




