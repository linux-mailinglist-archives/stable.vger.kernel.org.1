Return-Path: <stable+bounces-21399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7985C8BB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36CC282A30
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995514F9DA;
	Tue, 20 Feb 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjGDSj/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E914F9C8;
	Tue, 20 Feb 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464301; cv=none; b=TiG3UcKFSVoCwMsFPgsxNFAj6FbOV7ZFloMw762cM2t4w76xKWxJuMGFpPMSAFqRe9eFKSbqXI5mZIE0Lha/1O4ZTYrT/M3H7VxjGVnd3uTRcOnUHq3SwrxYNpGOMepGcxTaCyIgkICpfslpSIrSB1SB6Hny0WTTELQ5td0ZcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464301; c=relaxed/simple;
	bh=I6w0RkbZZwdHW31SfYbPO1SsqKZRnb7sigfKy9EXq1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLTIc5ZQGvPGPEQ4uxcIaFo+z3CncVSUqF28eEhvqDUFHnX5sFdlBFP0xcOJ/ga/DKyICRJ1L9cznrBU/2stKdYwIaOvNTWO1E/IkyJyt6g30V6MN+XY6K6RTo1kAv4vdBeDM7rBB4+8uLp8EVyI7CLcu89SDjiQKWoadVwgqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjGDSj/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD65C433C7;
	Tue, 20 Feb 2024 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464301;
	bh=I6w0RkbZZwdHW31SfYbPO1SsqKZRnb7sigfKy9EXq1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjGDSj/1sEb/fuODOXF1A6XxU04ycB9mhBmyxAf1S+Qz4ez2frw0mw8AWAYEmy6cH
	 zIa41o6cTVG+uk51PosNAMtRaNoKZbl8IpSZbCltyNykhTel6Qt3cYXt0XXhWFYp/B
	 goqQOZ6UskoSUzkAexxrOxJpUJXpZpjh7TGtJpog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 315/331] nfsd: dont take fi_lock in nfsd_break_deleg_cb()
Date: Tue, 20 Feb 2024 21:57:11 +0100
Message-ID: <20240220205648.111382070@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

commit 5ea9a7c5fe4149f165f0e3b624fe08df02b6c301 upstream.

A recent change to check_for_locks() changed it to take ->flc_lock while
holding ->fi_lock.  This creates a lock inversion (reported by lockdep)
because there is a case where ->fi_lock is taken while holding
->flc_lock.

->flc_lock is held across ->fl_lmops callbacks, and
nfsd_break_deleg_cb() is one of those and does take ->fi_lock.  However
it doesn't need to.

Prior to v4.17-rc1~110^2~22 ("nfsd: create a separate lease for each
delegation") nfsd_break_deleg_cb() would walk the ->fi_delegations list
and so needed the lock.  Since then it doesn't walk the list and doesn't
need the lock.

Two actions are performed under the lock.  One is to call
nfsd_break_one_deleg which calls nfsd4_run_cb().  These doesn't act on
the nfs4_file at all, so don't need the lock.

The other is to set ->fi_had_conflict which is in the nfs4_file.
This field is only ever set here (except when initialised to false)
so there is no possible problem will multiple threads racing when
setting it.

The field is tested twice in nfs4_set_delegation().  The first test does
not hold a lock and is documented as an opportunistic optimisation, so
it doesn't impose any need to hold ->fi_lock while setting
->fi_had_conflict.

The second test in nfs4_set_delegation() *is* make under ->fi_lock, so
removing the locking when ->fi_had_conflict is set could make a change.
The change could only be interesting if ->fi_had_conflict tested as
false even though nfsd_break_one_deleg() ran before ->fi_lock was
unlocked.  i.e. while hash_delegation_locked() was running.
As hash_delegation_lock() doesn't interact in any way with nfs4_run_cb()
there can be no importance to this interaction.

So this patch removes the locking from nfsd_break_one_deleg() and moves
the final test on ->fi_had_conflict out of the locked region to make it
clear that locking isn't important to the test.  It is still tested
*after* vfs_setlease() has succeeded.  This might be significant and as
vfs_setlease() takes ->flc_lock, and nfsd_break_one_deleg() is called
under ->flc_lock this "after" is a true ordering provided by a spinlock.

Fixes: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4944,10 +4944,8 @@ nfsd_break_deleg_cb(struct file_lock *fl
 	 */
 	fl->fl_break_time = 0;
 
-	spin_lock(&fp->fi_lock);
 	fp->fi_had_conflict = true;
 	nfsd_break_one_deleg(dp);
-	spin_unlock(&fp->fi_lock);
 	return false;
 }
 
@@ -5556,12 +5554,13 @@ nfs4_set_delegation(struct nfsd4_open *o
 	if (status)
 		goto out_unlock;
 
+	status = -EAGAIN;
+	if (fp->fi_had_conflict)
+		goto out_unlock;
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
-	if (fp->fi_had_conflict)
-		status = -EAGAIN;
-	else
-		status = hash_delegation_locked(dp, fp);
+	status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&state_lock);
 



