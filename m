Return-Path: <stable+bounces-160019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B894DAF7B4E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C4F7B51D1
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842091FC104;
	Thu,  3 Jul 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjZ+m+Ux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117F2DE6F5;
	Thu,  3 Jul 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556110; cv=none; b=IBAqe23kQLSZ8XAbRnslPHHLdBGh6IfAzmTR3Lbz0C818S1huyuu4prZ3HkMsO9qXmtVIx+CtRjMOHNTtlNEXvJv71CUa039Oc3s279yCDlZCccZBQSFq+j2/hEv1IBHrbf++BDUsv754UYmYfZYudTiuCasoXXEz1+sueelh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556110; c=relaxed/simple;
	bh=7lV+7pqcx3zuhN6GmoDLK8syN+CJ2o3r+61RZ4/91sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc+97mKfhlOYBanaVRaABlu9RyLna4TkqeWDR0ZVT6FFe9dDqU52ECf0XCk/0vNqUzlwI1G3UWxFHZXC++u3+gH9Sx29QOfNPBEWK7J3dteiz602vJn+HReU3KXVFHIAx/ilH55BmI8A09h0ULjOeg+Th68TwxnegrXWQZVgbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjZ+m+Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C9C4CEE3;
	Thu,  3 Jul 2025 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556110;
	bh=7lV+7pqcx3zuhN6GmoDLK8syN+CJ2o3r+61RZ4/91sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjZ+m+UxrpQAhZmCbwHYP6KEkgRNUDLemuer/i9siamBUmi+SWf2ImziQntfZ61iq
	 kqHfiua++fzsmpnnRjxxaFt8kE9H83qVzqVXivjOVB7wyLG3Rjm01SRbwaLP+1HQWN
	 fzbxOR5OKQ0i4BAz93K9Ra4Zq5fhX2LpaOlf6OfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 078/132] attach_recursive_mnt(): do not lock the covering tree when sliding something under it
Date: Thu,  3 Jul 2025 16:42:47 +0200
Message-ID: <20250703143942.475396220@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit ce7df19686530920f2f6b636e71ce5eb1d9303ef ]

If we are propagating across the userns boundary, we need to lock the
mounts added there.  However, in case when something has already
been mounted there and we end up sliding a new tree under that,
the stuff that had been there before should not get locked.

IOW, lock_mnt_tree() should be called before we reparent the
preexisting tree on top of what we are adding.

Fixes: 3bd045cc9c4b ("separate copying and locking mount tree on cross-userns copies")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index aae1a77ac2d3f..67d89ebb5044e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2249,14 +2249,14 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
 		hlist_del_init(&child->mnt_hash);
-		q = __lookup_mnt(&child->mnt_parent->mnt,
-				 child->mnt_mountpoint);
-		if (q)
-			mnt_change_mountpoint(child, smp, q);
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
+		q = __lookup_mnt(&child->mnt_parent->mnt,
+				 child->mnt_mountpoint);
+		if (q)
+			mnt_change_mountpoint(child, smp, q);
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
-- 
2.39.5




