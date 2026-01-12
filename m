Return-Path: <stable+bounces-208132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFFD137E9
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7396301145F
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934901E4AF;
	Mon, 12 Jan 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRCudvQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574052BE62B
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229382; cv=none; b=q8/DBnV5a2hppXQ6RUfbHGqvOm7qh7nEPMa78UwsWS+gYb2B+7wU1gfjU27thGnA7atQqufwMHTkto8N0/7sJLcQ1PUyAYLawiSyK+4++vH4+fWhl1md/wEjvTSqIsdpC+i0y3612lyYBmKvnmhojG7MlxOPdcfxFWSaf9/0Kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229382; c=relaxed/simple;
	bh=viKfekOqMFULzRwcGUu0rT/B89xSJvALGBme0IWd4AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsT1zOu/DvadW8xdd1daQc69me5SDq4KI2edrFy3snDc2Ia+BVVczIzt/txL/orL2OY0aq18OSAUa6V3XsN23WfgUemUGsmjJrb1VPQ38Q3+k//oWAcRZRdWJZijHO28UcNb2ajxzH0f1FkZ1fBfd2SVojwVaIeDkMmsaOeeaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRCudvQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A6EC16AAE;
	Mon, 12 Jan 2026 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229382;
	bh=viKfekOqMFULzRwcGUu0rT/B89xSJvALGBme0IWd4AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRCudvQR7OifU5+36lVhfIPc2RINYGuulIHShuDuXK5BYdA3NzWHXEqVYxOXYZdE9
	 mpUXEc95htfV2SRaz/Rikl8XkptsBGIux1XZU5rqKFZZAQ9HtZzNoYI6/39tLEqsz1
	 d5ZhCbliCIDW4wgwiznWpknoT3/K3pkrJTZ1eqw53o3CuKl/93JpkE4kRPMkSSqFby
	 mntJpbOIjmj0bDVVvkBTwA+Dydc2l9N40EXWOw5vMENlsMeWvRbSLCHlcE68Y8XrGH
	 bZSZeqouKdNhE1i2+bZmX+GuXXK0CkLOx2WDEFSqdpRpdsM5CooRKw9p/2mnGjX6jW
	 8VyRWVmkJnIsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] NFS: trace: show TIMEDOUT instead of 0x6e
Date: Mon, 12 Jan 2026 09:49:37 -0500
Message-ID: <20260112144939.718289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011223-capitol-diploma-75b9@gregkh>
References: <2026011223-capitol-diploma-75b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Hanxiao <chenhx.fnst@fujitsu.com>

[ Upstream commit cef48236dfe55fa266d505e8a497963a7bc5ef2a ]

__nfs_revalidate_inode may return ETIMEDOUT.

print symbol of ETIMEDOUT in nfs trace:

before:
cat-5191 [005] 119.331127: nfs_revalidate_inode_exit: error=-110 (0x6e)

after:
cat-1738 [004] 44.365509: nfs_revalidate_inode_exit: error=-110 (TIMEDOUT)

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: c6c209ceb87f ("NFSD: Remove NFSERR_EAGAIN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/misc/nfs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 0d9d48dca38a8..5b6c36fe9cdfe 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -52,6 +52,7 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_IO,			"IO" }, \
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
+		{ ETIMEDOUT,			"TIMEDOUT" }, \
 		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
-- 
2.51.0


