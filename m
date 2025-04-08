Return-Path: <stable+bounces-129895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E02A801DF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923C81797BD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E3224AEB;
	Tue,  8 Apr 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lcvSQ+d1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCB2192F2;
	Tue,  8 Apr 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112264; cv=none; b=erHYIOFO6YLwtD3SSq1H6GSUV1SY8hnhuWhEYPt1v87C3iEgCXMGzp+NjT7Ew+oe4Wlsn9W7p9EhTM+aibrBWUeE8E2+nxMHfuiz6BmqLGwXm5CO8Sn3hAKoY7cdbgI5o0smkEkuJryrVsSRQ//ocHXMWZPdQxJJWZueguxSBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112264; c=relaxed/simple;
	bh=LaS6NqoLVIUbkFpq2TC8otRuejSOtq1+Uk+zehbXNVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBccIyswMcsSHqZMHAq8AOTgigIdquLxvCg9pmhRG3Btobpk11Juw5tW+5rXveWA2W/jcBt/tMmjImwflAgWZM1I+hB7VMAglbxx2+0vERLoFDOnKgSqfSraemzb2ex5doGbmKnR+bQm3z0kUB8cMWvtSXdXChoiu2XZhBabIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lcvSQ+d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EC6C4CEE5;
	Tue,  8 Apr 2025 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112264;
	bh=LaS6NqoLVIUbkFpq2TC8otRuejSOtq1+Uk+zehbXNVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcvSQ+d1CB1xds8Wxg+9D98X2hlPkGdDK2x6nik6+e4BiA9qL9u4UzLhZdUhlCytS
	 XcbOTsLzJP8VNOM6Jnx/8KfQCFndnnF4hJBJsLQvRp8G8Tx2hEqhzIY2yUeYUnJwGy
	 hWZMKNdmU2ksA0GULPoamr+RD0mQVF8PwgiKaB8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.14 726/731] nfsd: put dl_stid if fail to queue dl_recall
Date: Tue,  8 Apr 2025 12:50:23 +0200
Message-ID: <20250408104931.161693656@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1050,6 +1050,12 @@ static struct nfs4_ol_stateid * nfs4_all
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
@@ -5414,6 +5420,7 @@ static const struct nfsd4_callback_ops n
 
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
+	bool queued;
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -5422,7 +5429,10 @@ static void nfsd_break_one_deleg(struct
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



