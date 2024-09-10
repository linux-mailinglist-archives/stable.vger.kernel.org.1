Return-Path: <stable+bounces-74705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFC9730E3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508221C24B7D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B518DF73;
	Tue, 10 Sep 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2xBfmsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EB18787E;
	Tue, 10 Sep 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962585; cv=none; b=Fq5RwFcZD3xYOecydiFm2naleyUueod1G171vXg42ffoY2o2YYP1n/00VL7JWQlqyKIpZRlgXXq+tkF4QvD3AzQyA9UgeRPkj3IHdr4WnKyRd2PdKKC38DR86WenuhcmksBm+ZqYOu8EGAJJhYTb2EIV/9lNVDvmd0K0GtIrk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962585; c=relaxed/simple;
	bh=fwUhhzOpko19LD6G0IedDXbnZgqrgc69xDPtcSz0/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+nfD/glDOW8cA1ckIbrNnl/P2jY3j4dEq7l9CfCOQ46U4GP2J6+YzrNXWtwFpOZMVCUtlmutCejxwc2tqroZQ0esOEJ5IqSd6yhZQfU4DuGuJfA3WTGf1yk3cxCrpnNfICilZmZL2/NvlSf4i9rQ/UXb8YTnNO86UmX7Pp3A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2xBfmsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E10BC4CEC3;
	Tue, 10 Sep 2024 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962585;
	bh=fwUhhzOpko19LD6G0IedDXbnZgqrgc69xDPtcSz0/gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2xBfmsqEp/yTdXwIUZkMndisMHyWsMbdJ8jdPgXGcyx0ahPGft405kGSXRsCuRYi
	 IjTl9IoiL1B/gaFxC/1HAZKfygXvGXg71TwLl5JBc2EmqHDEr0r/0+uNGV2gpk8nld
	 Iyovj9txGGYZUGTSjKcEpBMZB2vCTTQfWE3i6KOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 083/121] btrfs: replace BUG_ON with ASSERT in walk_down_proc()
Date: Tue, 10 Sep 2024 11:32:38 +0200
Message-ID: <20240910092549.841793370@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index a28b0eafb65a..202e6b6e2add 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4743,7 +4743,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -4767,7 +4767,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
-- 
2.43.0




