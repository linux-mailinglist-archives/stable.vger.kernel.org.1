Return-Path: <stable+bounces-53343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65290D137
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FB71C23F74
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8519F469;
	Tue, 18 Jun 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTwGUE0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4931581F6;
	Tue, 18 Jun 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716047; cv=none; b=HBpUNk38FBRHSU3Hx6QP/mwJTdW6ZSDln4WfKhaDjKQygUn4AeeXGqEgsC2zJdVxmuCEbIMCenFHBRwMTZn0WnVZGYk4n4QQfwGqA5n5eherfTd82OdZ0mSdrRos+w+l7tZsYaD/PYWGie/U5GN/QSrS54kGjV10Hwmx5TENlL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716047; c=relaxed/simple;
	bh=q1Cmz+PY3R3mpqK1BZOFQWJtRboS7LEp+oB3HxD3jA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7BCL13ANKgcsOxBN+DalGKtj2BDfJJVkpwySCrioEw1eIT1dsYU3uEJIf4zKKp8IQ2uU8GbxP5OXNg5sU4rvPApODO+UmNwHhxmcz7zQElaxNjSVNj8eh7UB/RQerQq90ABBr/8H5ZgrxnP7WStfTG5tBzPc8oV9wcvjt0HinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTwGUE0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B6CC3277B;
	Tue, 18 Jun 2024 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716047;
	bh=q1Cmz+PY3R3mpqK1BZOFQWJtRboS7LEp+oB3HxD3jA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTwGUE0KwEFdf/2XG11SP0Z+L2Xqnh+dXqwmrxqs5KLbnoLNDSKT89ogXAKO4Uya1
	 SW2qjOcBFHKFLvS6RmTs2jPNwnvQ76hO1N/MP7wxXHevBcXtZUi7u8prp3BmHNCQvy
	 Rn/jRWK5FZkik3JSapWmpDN5fvcs3rDvPPAb8Xac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 483/770] NFSD: Clean up _lm_ operation names
Date: Tue, 18 Jun 2024 14:35:36 +0200
Message-ID: <20240618123425.960876052@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 35aff0678f99b0623bb72d50112de9e163a19559 ]

The common practice is to name function instances the same as the
method names, but with a uniquifying prefix. Commit aef9583b234a
("NFSD: Get reference of lockowner when coping file_lock") missed
this -- the new function names should both have been of the form
"nfsd4_lm_*".

Before more lock manager operations are added in NFSD, rename these
two functions for consistency.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 60d5d1cb2cc65..0170aaf318ea2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6566,7 +6566,7 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 }
 
 static fl_owner_t
-nfsd4_fl_get_owner(fl_owner_t owner)
+nfsd4_lm_get_owner(fl_owner_t owner)
 {
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
@@ -6575,7 +6575,7 @@ nfsd4_fl_get_owner(fl_owner_t owner)
 }
 
 static void
-nfsd4_fl_put_owner(fl_owner_t owner)
+nfsd4_lm_put_owner(fl_owner_t owner)
 {
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
@@ -6610,8 +6610,8 @@ nfsd4_lm_notify(struct file_lock *fl)
 
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
-	.lm_get_owner = nfsd4_fl_get_owner,
-	.lm_put_owner = nfsd4_fl_put_owner,
+	.lm_get_owner = nfsd4_lm_get_owner,
+	.lm_put_owner = nfsd4_lm_put_owner,
 };
 
 static inline void
-- 
2.43.0




