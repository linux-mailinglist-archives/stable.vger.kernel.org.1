Return-Path: <stable+bounces-2138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29847F82EF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E403B1C24618
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1778935F1A;
	Fri, 24 Nov 2023 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pkVD6H38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821728DBB;
	Fri, 24 Nov 2023 19:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D90C433C8;
	Fri, 24 Nov 2023 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853142;
	bh=IwYHOeAC3MsEiBvt5Op/qb1vBJWCWhFjURnYRQlwbmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkVD6H38eMzEYsO9XSuDZz7hXahxyMjaWXePo/YylyWAGEak1IBx+mCsLCYqr2E97
	 2U0YJlMObQkFQ+frzeEfEXJTu1XLbgQLDA6P9dcB/iuTDLjUwWvOA8aMSuD4cUdSfV
	 xbPXJMg/NoKlBEd0Wm/cNZwrnw53zhDw5eG2KZTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 070/297] gfs2: ignore negated quota changes
Date: Fri, 24 Nov 2023 17:51:52 +0000
Message-ID: <20231124172002.697825796@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 4c6a08125f2249531ec01783a5f4317d7342add5 ]

When lots of quota changes are made, there may be cases in which an
inode's quota information is increased and then decreased, such as when
blocks are added to a file, then deleted from it. If the timing is
right, function do_qc can add pending quota changes to a transaction,
then later, another call to do_qc can negate those changes, resulting
in a net gain of 0. The quota_change information is recorded in the qc
buffer (and qd element of the inode as well). The buffer is added to the
transaction by the first call to do_qc, but a subsequent call changes
the value from non-zero back to zero. At that point it's too late to
remove the buffer_head from the transaction. Later, when the quota sync
code is called, the zero-change qd element is discovered and flagged as
an assert warning. If the fs is mounted with errors=panic, the kernel
will panic.

This is usually seen when files are truncated and the quota changes are
negated by punch_hole/truncate which uses gfs2_quota_hold and
gfs2_quota_unhold rather than block allocations that use gfs2_quota_lock
and gfs2_quota_unlock which automatically do quota sync.

This patch solves the problem by adding a check to qd_check_sync such
that net-zero quota changes already added to the transaction are no
longer deemed necessary to be synced, and skipped.

In this case references are taken for the qd and the slot from do_qc
so those need to be put. The normal sequence of events for a normal
non-zero quota change is as follows:

gfs2_quota_change
   do_qc
      qd_hold
      slot_hold

Later, when the changes are to be synced:

gfs2_quota_sync
   qd_fish
      qd_check_sync
         gets qd ref via lockref_get_not_dead
   do_sync
      do_qc(QC_SYNC)
         qd_put
	    lockref_put_or_lock
   qd_unlock
      qd_put
         lockref_put_or_lock

In the net-zero change case, we add a check to qd_check_sync so it puts
the qd and slot references acquired in gfs2_quota_change and skip the
unneeded sync.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index dc77080a82bbf..c381580095baf 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -431,6 +431,17 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	    (sync_gen && (qd->qd_sync_gen >= *sync_gen)))
 		return 0;
 
+	/*
+	 * If qd_change is 0 it means a pending quota change was negated.
+	 * We should not sync it, but we still have a qd reference and slot
+	 * reference taken by gfs2_quota_change -> do_qc that need to be put.
+	 */
+	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
+		slot_put(qd);
+		qd_put(qd);
+		return 0;
+	}
+
 	if (!lockref_get_not_dead(&qd->qd_lockref))
 		return 0;
 
-- 
2.42.0




