Return-Path: <stable+bounces-74485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14540972F83
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A87DB23A69
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C41172BAE;
	Tue, 10 Sep 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e67lxVX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6C224F6;
	Tue, 10 Sep 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961943; cv=none; b=q5nHfC8vb0XLXRz6OgUs/xhJWXEwmWQvvxkJK+LES4ZYP7rF/eFSYtvxXobhizvfQtouv9Eb66RdnfWAsx/jYLW9Jo6jsYkLIA0xhFy++JGGplwk/sf2FbQkrCcC7jsMNppP9cS6IUZk8KOM2RloSpUNBK+JKjJGgbEgiz/nmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961943; c=relaxed/simple;
	bh=tar3dTamXHplaWfczaNk8Yn731JL9yGwZBdYp2MYrLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQjsQO76T/YeFvYktih7rAd7AXaTc8yHrQVq5lXvTKe8ol1cL4rrJrvanqkyvm71Tw0d3AOsipaAiO1eB+6yTwmnTjre78XZFc8YMW+ndXjgSMrx2WOVSyC598G+/e0YdyMjxkzmjCUyhwMOUFVCppYETKZdACvd5BdR/VQgWtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e67lxVX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FF2C4CEC3;
	Tue, 10 Sep 2024 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961943;
	bh=tar3dTamXHplaWfczaNk8Yn731JL9yGwZBdYp2MYrLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e67lxVX5qWOkWXlbRYbTsrfW0VyydNv7fBaidKiR6t+2qIRcQhfmn8zX7l++QRFPE
	 Xg9ICKnAICNYfblKagmVDeiLebWMhBduXBfT3NWlL8R55TVbwpLteoTS3lompq6wwh
	 NoKzicv5MgLfszxgX7OdLDP51URxqU72Tz2HyHnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 241/375] btrfs: replace BUG_ON with ASSERT in walk_down_proc()
Date: Tue, 10 Sep 2024 11:30:38 +0200
Message-ID: <20240910092630.650554474@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 1f9d44c0a12730a24f8bb75c5e1102207413cc9b ]

We have a couple of areas where we check to make sure the tree block is
locked before looking up or messing with references.  This is old code
so it has this as BUG_ON().  Convert this to ASSERT() for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0effe13ae459..d107f5809eae 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5333,7 +5333,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -5357,7 +5357,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
-- 
2.43.0




