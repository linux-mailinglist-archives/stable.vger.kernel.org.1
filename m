Return-Path: <stable+bounces-205172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C02CF998E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A93F30286FD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6D23EA8A;
	Tue,  6 Jan 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tIMGgz7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04919258E;
	Tue,  6 Jan 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719822; cv=none; b=OV4guVPwm+JP8RrfZa+qblUHrkcStb44dix4WnhaGbWZLEvJB/kr5KqDzjXZkXOs8CxmkEw770DYnFT4LWf1p8wGVs8u5CZWJW9RSEc9WZpvibHo/yoROklxA7jybPIz6DR0c8gdpQ5H8asZu5AFIPMEAa9F/lp0VWT6+E5QPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719822; c=relaxed/simple;
	bh=hhyZ2KMsl3LFTWivDFwyvkzV3dSg6ozrPM+zWyn3bOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDHEmbEXX5hO2fuZNNmbJSFwVgXa+DMLMlZIXQ10xWC3i3EwdvI9ph2YiyaDfBBzH/QVVLzW3HHFP2cHThs2z4AVRbK1rBNs17raPdDBEXumvtjcH4bR0oAoWpA+duN9aQKrXeMzRyiiPCkE2Yu4r2vpOPd2Gb/Lzid7Lwycrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tIMGgz7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C079C116C6;
	Tue,  6 Jan 2026 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767719821;
	bh=hhyZ2KMsl3LFTWivDFwyvkzV3dSg6ozrPM+zWyn3bOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIMGgz7J+8zdNincY8o1aZORzGm7It7U9gSJtKraTEqgEk7oSGa8n7XpyvWSmchzr
	 lwKKgTCijAcDhRxFWGt8QezNs5yYQ1AYGpvUpYgaZxbvT8yiLg21mHP/d7+hfhh+8Z
	 6ZhZ7HC9oHxxdjwYKeF6XDUHnL3xsu7bdU12r8Qw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 033/567] btrfs: scrub: always update btrfs_scrub_progress::last_physical
Date: Tue,  6 Jan 2026 17:56:55 +0100
Message-ID: <20260106170452.566436630@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 54df8b80cc63aa0f22c4590cad11542731ed43ff ]

[BUG]
When a scrub failed immediately without any byte scrubbed, the returned
btrfs_scrub_progress::last_physical will always be 0, even if there is a
non-zero @start passed into btrfs_scrub_dev() for resume cases.

This will reset the progress and make later scrub resume start from the
beginning.

[CAUSE]
The function btrfs_scrub_dev() accepts a @progress parameter to copy its
updated progress to the caller, there are cases where we either don't
touch progress::last_physical at all or copy 0 into last_physical:

- last_physical not updated at all
  If some error happened before scrubbing any super block or chunk, we
  will not copy the progress, leaving the @last_physical untouched.

  E.g. failed to allocate @sctx, scrubbing a missing device or even
  there is already a running scrub and so on.

  All those cases won't touch @progress at all, resulting the
  last_physical untouched and will be left as 0 for most cases.

- Error out before scrubbing any bytes
  In those case we allocated @sctx, and sctx->stat.last_physical is all
  zero (initialized by kvzalloc()).
  Unfortunately some critical errors happened during
  scrub_enumerate_chunks() or scrub_supers() before any stripe is really
  scrubbed.

  In that case although we will copy sctx->stat back to @progress, since
  no byte is really scrubbed, last_physical will be overwritten to 0.

[FIX]
Make sure the parameter @progress always has its @last_physical member
updated to @start parameter inside btrfs_scrub_dev().

At the very beginning of the function, set @progress->last_physical to
@start, so that even if we error out without doing progress copying,
last_physical is still at @start.

Then after we got @sctx allocated, set sctx->stat.last_physical to
@start, this will make sure even if we didn't get any byte scrubbed, at
the progress copying stage the @last_physical is not left as zero.

This should resolve the resume progress reset problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9f811ea604f71..3cbb9f22d3944 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2943,6 +2943,10 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	unsigned int nofs_flag;
 	bool need_commit = false;
 
+	/* Set the basic fallback @last_physical before we got a sctx. */
+	if (progress)
+		progress->last_physical = start;
+
 	if (btrfs_fs_closing(fs_info))
 		return -EAGAIN;
 
@@ -2961,6 +2965,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
 	if (IS_ERR(sctx))
 		return PTR_ERR(sctx);
+	sctx->stat.last_physical = start;
 
 	ret = scrub_workers_get(fs_info);
 	if (ret)
-- 
2.51.0




