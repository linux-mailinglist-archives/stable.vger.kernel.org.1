Return-Path: <stable+bounces-179949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AE3B7E299
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FEE1B26877
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9025F283CB5;
	Wed, 17 Sep 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzAH1Jcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD32337EB4;
	Wed, 17 Sep 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112901; cv=none; b=JzsVwhDb/Xgx0yEKDzzzptLkvWg4m0Plm2yfZ2KI1eEwucmtfwDEzfNh4L6PpCqaANlPxWTrBo19j9NYaG1fUuztx+Knc1XeEH+mi+yX47zCB8+YcmX7mvQvNy0mzz9IWDne9EeUb/FTlQwpMMxYSMwwrzZCzBYJykIT0zmoKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112901; c=relaxed/simple;
	bh=l04xwAA/GoXFExjgJgPH57W72p3DKBfJKSBP6yumM6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTzVh5WZlvl0rwzsprO3O4X7VbhIi5GcHeHAe+UQQPmBTRQ7VtiVgBTIiA/8YpAHPNvVfbjPAYrSMmI0wTVTkKD7+XLWmuiZkMXfdl6+4Hm4gG3NX2lF2UFjf6X8L08GSBKcq0ML6mrXjC7Yo1gYKFS6CdPBDuLwCKQrjE6wjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzAH1Jcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8845FC4CEF5;
	Wed, 17 Sep 2025 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112901;
	bh=l04xwAA/GoXFExjgJgPH57W72p3DKBfJKSBP6yumM6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzAH1JcxdDAiZSSVoxSBCQqzbRhP35mKL8DvEqKoLea9WOSbk22R4siFK8X3vr3qw
	 sLWye6ImO2pdyT3CCnPjD3F7gqvQM1pkUSi17Vdnbll4J16sZEIe23C0BpV5z/k/P+
	 qx4uwgIQihCuiJqom2ceZr5uTnvZAqh3VgYRjypo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.16 103/189] ceph: always call ceph_shift_unused_folios_left()
Date: Wed, 17 Sep 2025 14:33:33 +0200
Message-ID: <20250917123354.382040474@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max.kellermann@ionos.com>

commit cce7c15faaac79b532a07ed6ab8332280ad83762 upstream.

The function ceph_process_folio_batch() sets folio_batch entries to
NULL, which is an illegal state.  Before folio_batch_release() crashes
due to this API violation, the function ceph_shift_unused_folios_left()
is supposed to remove those NULLs from the array.

However, since commit ce80b76dd327 ("ceph: introduce
ceph_process_folio_batch() method"), this shifting doesn't happen
anymore because the "for" loop got moved to ceph_process_folio_batch(),
and now the `i` variable that remains in ceph_writepages_start()
doesn't get incremented anymore, making the shifting effectively
unreachable much of the time.

Later, commit 1551ec61dc55 ("ceph: introduce ceph_submit_write()
method") added more preconditions for doing the shift, replacing the
`i` check (with something that is still just as broken):

- if ceph_process_folio_batch() fails, shifting never happens

- if ceph_move_dirty_page_in_page_array() was never called (because
  ceph_process_folio_batch() has returned early for some of various
  reasons), shifting never happens

- if `processed_in_fbatch` is zero (because ceph_process_folio_batch()
  has returned early for some of the reasons mentioned above or
  because ceph_move_dirty_page_in_page_array() has failed), shifting
  never happens

Since those two commits, any problem in ceph_process_folio_batch()
could crash the kernel, e.g. this way:

 BUG: kernel NULL pointer dereference, address: 0000000000000034
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 172 UID: 0 PID: 2342707 Comm: kworker/u778:8 Not tainted 6.15.10-cm4all1-es #714 NONE
 Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.10 12/08/2023
 Workqueue: writeback wb_workfn (flush-ceph-1)
 RIP: 0010:folios_put_refs+0x85/0x140
 Code: 83 c5 01 39 e8 7e 76 48 63 c5 49 8b 5c c4 08 b8 01 00 00 00 4d 85 ed 74 05 41 8b 44 ad 00 48 8b 15 b0 >
 RSP: 0018:ffffb880af8db778 EFLAGS: 00010207
 RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: ffffe377cc3b0000 RSI: 0000000000000000 RDI: ffffb880af8db8c0
 RBP: 0000000000000000 R08: 000000000000007d R09: 000000000102b86f
 R10: 0000000000000001 R11: 00000000000000ac R12: ffffb880af8db8c0
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff9bd262c97000
 FS:  0000000000000000(0000) GS:ffff9c8efc303000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000034 CR3: 0000000160958004 CR4: 0000000000770ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ceph_writepages_start+0xeb9/0x1410

The crash can be reproduced easily by changing the
ceph_check_page_before_write() return value to `-E2BIG`.

(Interestingly, the crash happens only if `huge_zero_folio` has
already been allocated; without `huge_zero_folio`,
is_huge_zero_folio(NULL) returns true and folios_put_refs() skips NULL
entries instead of dereferencing them.  That makes reproducing the bug
somewhat unreliable.  See
https://lore.kernel.org/20250826231626.218675-1-max.kellermann@ionos.com
for a discussion of this detail.)

My suggestion is to move the ceph_shift_unused_folios_left() to right
after ceph_process_folio_batch() to ensure it always gets called to
fix up the illegal folio_batch state.

Cc: stable@vger.kernel.org
Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Link: https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/addr.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1687,6 +1687,7 @@ get_more_pages:
 
 process_folio_batch:
 		rc = ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
+		ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
 		if (rc)
 			goto release_folios;
 
@@ -1695,8 +1696,6 @@ process_folio_batch:
 			goto release_folios;
 
 		if (ceph_wbc.processed_in_fbatch) {
-			ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
-
 			if (folio_batch_count(&ceph_wbc.fbatch) == 0 &&
 			    ceph_wbc.locked_pages < ceph_wbc.max_pages) {
 				doutc(cl, "reached end fbatch, trying for more\n");



