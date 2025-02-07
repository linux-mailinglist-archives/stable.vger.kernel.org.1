Return-Path: <stable+bounces-114291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00152A2CC86
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BD23A72EE
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BBC1A3142;
	Fri,  7 Feb 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlnR1N3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46719D072;
	Fri,  7 Feb 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956393; cv=none; b=eU2ICO8HqiZzk0fsIuKI34cur7IenZKIDCcu/m9eoUnvP4VHz/N5Nfht7rlaTc0tVAiLjaBdL/JdSGswUCTu43K/oiQWkZWm4aW2/k8zD84rrbHP2z171LtihnPzPU3uJQH2iVs34rC5GaO9XAZ9llf2kphjpkiuoJUu6u4FsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956393; c=relaxed/simple;
	bh=hyR0EhSruuSRq1Cir/Qs5wUtelxx3H+TAjU03aQ8hjs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edz1uTdqdKeQsRnwzx+cKVU/dyE+25fSrj4K+WAKwyzL1YIpg0HNQCgX0XcHOq5RLZOkEb64YL9qi612yv4r/zKtFIbicol0ccRRYNTCEfRiRFA/pI49xg1ZuzzQYjXPYxApkdj0SbwNSrk4BExmC0zY6u8lpgVKxFpzlUzBJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlnR1N3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1945C4CED1;
	Fri,  7 Feb 2025 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956393;
	bh=hyR0EhSruuSRq1Cir/Qs5wUtelxx3H+TAjU03aQ8hjs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hlnR1N3/7zyE/nHmIAyOy+VTCxjAtXMhtoTjbNQKjauAs00Y9wBbw/g19xuL7tXrU
	 doVWyoJtytBORqC0rxYzmInCLM4UZuE/ZQBC/m4BaEtotbc/EPFXZ9bZmjIJaancte
	 qRkacqcm+KM81aypWNilK75qr3nGWvcQUJ98LN4o1SOzA+iPj1JF2xXA6AUKdydoki
	 /u765JoCVHgfc8GuC9m23SF+V/i9LapZ777X4jlc+L0yNFeCu3WJEhJt7Z1mdonjpE
	 zzrUE7I9HfjGBzKcKq617c533GAB8tDYU0l+giUclzu5LUsNTd3VrJlvRUEr2B4z4y
	 NtCHTpwSBjjwA==
Date: Fri, 07 Feb 2025 11:26:33 -0800
Subject: [PATCH 01/11] xfs: avoid nested calls to __xfs_trans_commit
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: hch@lst.de, stable@vger.kernel.org
Message-ID: <173895601419.3373740.4927786739399794017.stgit@frogsfrogsfrogs>
In-Reply-To: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

commit e96c1e2f262e0993859e266e751977bfad3ca98a upstream

Currently, __xfs_trans_commit calls xfs_defer_finish_noroll, which calls
__xfs_trans_commit again on the same transaction.  In other words,
there's function recursion that has caused minor amounts of confusion in
the past.  There's no reason to keep this around, since there's only one
place where we actually want the xfs_defer_finish_noroll, and that is in
the top level xfs_trans_commit call.

Fixes: 98719051e75ccf ("xfs: refactor internal dfops initialization")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_trans.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)


diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 30e03342287a94..001d9bec4ed571 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -834,18 +834,6 @@ __xfs_trans_commit(
 
 	trace_xfs_trans_commit(tp, _RET_IP_);
 
-	/*
-	 * Finish deferred items on final commit. Only permanent transactions
-	 * should ever have deferred ops.
-	 */
-	WARN_ON_ONCE(!list_empty(&tp->t_dfops) &&
-		     !(tp->t_flags & XFS_TRANS_PERM_LOG_RES));
-	if (!regrant && (tp->t_flags & XFS_TRANS_PERM_LOG_RES)) {
-		error = xfs_defer_finish_noroll(&tp);
-		if (error)
-			goto out_unreserve;
-	}
-
 	error = xfs_trans_run_precommits(tp);
 	if (error)
 		goto out_unreserve;
@@ -924,6 +912,20 @@ int
 xfs_trans_commit(
 	struct xfs_trans	*tp)
 {
+	/*
+	 * Finish deferred items on final commit. Only permanent transactions
+	 * should ever have deferred ops.
+	 */
+	WARN_ON_ONCE(!list_empty(&tp->t_dfops) &&
+		     !(tp->t_flags & XFS_TRANS_PERM_LOG_RES));
+	if (tp->t_flags & XFS_TRANS_PERM_LOG_RES) {
+		int error = xfs_defer_finish_noroll(&tp);
+		if (error) {
+			xfs_trans_cancel(tp);
+			return error;
+		}
+	}
+
 	return __xfs_trans_commit(tp, false);
 }
 


