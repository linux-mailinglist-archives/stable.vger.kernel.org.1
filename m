Return-Path: <stable+bounces-131737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C889A80B9D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C371BC5BB7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6AB280A28;
	Tue,  8 Apr 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EczQPOw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2F27F4F3;
	Tue,  8 Apr 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117197; cv=none; b=erJ7DLV7Lo/p8k2blEroPT2EVLBJDSHnexkKgzzcRfo5s1wjcoMHwP+nD2N/P/CSL1LtrKJHK+Uo0vCEb9L9bZ/ZVritvrEjiV6ukgffZT98ESuiYV6+pTXMdm/Y8qD94yK0ZUPxhNmKkFiUttfYvHSfVXQUYM80GHcM4ylHVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117197; c=relaxed/simple;
	bh=B5cBnsTyFlPxzNLJ3ejgnUtlE3/6QKyORf7UchYy5lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9+Ih41A3SFgl0ipKhGLuFWWZ/riNXO3XT4+HAd1kYITMd2q8JTGfGw0Zcywf8KEMGRzgFAYDnLQ05TONIb5JfpOHjtzKjX0Qf/t0ApawkQqnjMOmjCdTvClnWV0Ei6grYYh931zOSIrjQVvF4EfasYY8PmJCFL0YWbcsIYW1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EczQPOw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11017C4CEEC;
	Tue,  8 Apr 2025 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744117197;
	bh=B5cBnsTyFlPxzNLJ3ejgnUtlE3/6QKyORf7UchYy5lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EczQPOw6YTUJCAH3hdhpuHEgG8fveULrf81dKSPLUWR7rnp+Ec89RFOIFiQxjm4H6
	 34Ab0WyLKYIESYnBRVTT0AStn3ZRUcdO6mvGYtogpTHNOfKWhqU3IgoXqrvmoHlC74
	 vsUD8iWGZPcKH0efRQd2wRA8uyBFyB3GJTYKF00U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 419/423] nfsd: put dl_stid if fail to queue dl_recall
Date: Tue,  8 Apr 2025 12:52:25 +0200
Message-ID: <20250408104855.689860711@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Lingfeng <lilingfeng3@huawei.com>

commit 230ca758453c63bd38e4d9f4a21db698f7abada8 upstream.

Before calling nfsd4_run_cb to queue dl_recall to the callback_wq, we
increment the reference count of dl_stid.
We expect that after the corresponding work_struct is processed, the
reference count of dl_stid will be decremented through the callback
function nfsd4_cb_recall_release.
However, if the call to nfsd4_run_cb fails, the incremented reference
count of dl_stid will not be decremented correspondingly, leading to the
following nfs4_stid leak:
unreferenced object 0xffff88812067b578 (size 344):
  comm "nfsd", pid 2761, jiffies 4295044002 (age 5541.241s)
  hex dump (first 32 bytes):
    01 00 00 00 6b 6b 6b 6b b8 02 c0 e2 81 88 ff ff  ....kkkk........
    00 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  .kkkkkkk.....N..
  backtrace:
    kmem_cache_alloc+0x4b9/0x700
    nfsd4_process_open1+0x34/0x300
    nfsd4_open+0x2d1/0x9d0
    nfsd4_proc_compound+0x7a2/0xe30
    nfsd_dispatch+0x241/0x3e0
    svc_process_common+0x5d3/0xcc0
    svc_process+0x2a3/0x320
    nfsd+0x180/0x2e0
    kthread+0x199/0x1d0
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1b/0x30
unreferenced object 0xffff8881499f4d28 (size 368):
  comm "nfsd", pid 2761, jiffies 4295044005 (age 5541.239s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 30 4d 9f 49 81 88 ff ff  ........0M.I....
    30 4d 9f 49 81 88 ff ff 20 00 00 00 01 00 00 00  0M.I.... .......
  backtrace:
    kmem_cache_alloc+0x4b9/0x700
    nfs4_alloc_stid+0x29/0x210
    alloc_init_deleg+0x92/0x2e0
    nfs4_set_delegation+0x284/0xc00
    nfs4_open_delegation+0x216/0x3f0
    nfsd4_process_open2+0x2b3/0xee0
    nfsd4_open+0x770/0x9d0
    nfsd4_proc_compound+0x7a2/0xe30
    nfsd_dispatch+0x241/0x3e0
    svc_process_common+0x5d3/0xcc0
    svc_process+0x2a3/0x320
    nfsd+0x180/0x2e0
    kthread+0x199/0x1d0
    ret_from_fork+0x30/0x50
    ret_from_fork_asm+0x1b/0x30
Fix it by checking the result of nfsd4_run_cb and call nfs4_put_stid if
fail to queue dl_recall.

Cc: stable@vger.kernel.org
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1057,6 +1057,12 @@ static struct nfs4_ol_stateid * nfs4_all
 	return openlockstateid(stid);
 }
 
+/*
+ * As the sc_free callback of deleg, this may be called by nfs4_put_stid
+ * in nfsd_break_one_deleg.
+ * Considering nfsd_break_one_deleg is called with the flc->flc_lock held,
+ * this function mustn't ever sleep.
+ */
 static void nfs4_free_deleg(struct nfs4_stid *stid)
 {
 	struct nfs4_delegation *dp = delegstateid(stid);
@@ -5269,6 +5275,7 @@ static const struct nfsd4_callback_ops n
 
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
+	bool queued;
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -5277,7 +5284,10 @@ static void nfsd_break_one_deleg(struct
 	 * we know it's safe to take a reference.
 	 */
 	refcount_inc(&dp->dl_stid.sc_count);
-	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
+	queued = nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!queued);
+	if (!queued)
+		nfs4_put_stid(&dp->dl_stid);
 }
 
 /* Called from break_lease() with flc_lock held. */



