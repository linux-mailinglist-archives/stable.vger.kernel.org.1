Return-Path: <stable+bounces-128730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC1A7EB55
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F7517AEB4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011826E15B;
	Mon,  7 Apr 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi/gTt/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72A26E152;
	Mon,  7 Apr 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049810; cv=none; b=MpmNf19UXk2CPYIw8Rk96PjuWi9KFiLABkTYeBK3QPI4eSnEPE5p9RvGCVZ6Kfbhj9Hju8ii9cXbzdPuBUdtauv6txEVeNJ1Cv3WN9j5ESo10XLT5n/V8V8LyCdiEavq6IOvmQ3frfrugiFbKfFsNiX/9ojvZDnAiPlnFLpxZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049810; c=relaxed/simple;
	bh=fzKtl3d3oE77n9RfVMXCK6v216JhpG64+bOr7f0w/dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDXNPS5karxccTA27PPUiXpe63sR4FW06K3b3akJHlBp7aSlsPuoh+RLS9sp4ZkvMmX4MNVhbril5YphvbVWAc68SA6rGfXWZOy9xmoaRqKU7PqXwurQefpefi3yt+ZtDmjMNiVN52YkscdoSlOt5Rqm8Ij4aXkQA0NB2njnLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi/gTt/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9A2C4CEF3;
	Mon,  7 Apr 2025 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049810;
	bh=fzKtl3d3oE77n9RfVMXCK6v216JhpG64+bOr7f0w/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mi/gTt/sn64TkItffc0k2GuVXODpMkRqmd/R0L/QehtwJ+hHkurHQ5salcgrLgrFb
	 mAygMr9ItKuTEtXXlHaIklNblLtxQnWXS16XGlBVa3N5gYym0eQbQVWUblhYn3ORKb
	 odmIkn555NcQbCcwYmEqgTux/h5vXohiPwxC8KdinKerr2OvsFFeGnjJwD6pdYT86C
	 zMsDcW4qRW4+tB50ehWiUemLxqjdRpifmFK40GhWT1Bqmh5H9br6KHe20Q9UfVEAMy
	 I4Ou3dq9tpRhNmKWdFoNutz6NMcHS8k06MXoQvQVc5hi1NG5bcPHGvzYEdYF5323Mg
	 kB6DV72pR3Y5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>,
	syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com,
	syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 6/9] 9p/trans_fd: mark concurrent read and writes to p9_conn->err
Date: Mon,  7 Apr 2025 14:16:32 -0400
Message-Id: <20250407181635.3184105-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181635.3184105-1-sashal@kernel.org>
References: <20250407181635.3184105-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Ignacio Encinas <ignacio@iencinas.com>

[ Upstream commit fbc0283fbeae27b88448c90305e738991457fee2 ]

Writes for the error value of a connection are spinlock-protected inside
p9_conn_cancel, but lockless reads are present elsewhere to avoid
performing unnecessary work after an error has been met.

Mark the write and lockless reads to make KCSAN happy. Mark the write as
exclusive following the recommendation in "Lock-Protected Writes with
Lockless Reads" in tools/memory-model/Documentation/access-marking.txt
while we are at it.

Mark p9_fd_request and p9_conn_cancel m->err reads despite the fact that
they do not race with concurrent writes for stylistic reasons.

Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com
Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
Message-ID: <20250318-p9_conn_err_benign_data_race-v3-1-290bb18335cc@iencinas.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138a..791e4868f2d4e 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -191,12 +191,13 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err) {
+	if (READ_ONCE(m->err)) {
 		spin_unlock(&m->req_lock);
 		return;
 	}
 
-	m->err = err;
+	WRITE_ONCE(m->err, err);
+	ASSERT_EXCLUSIVE_WRITER(m->err);
 
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
@@ -283,7 +284,7 @@ static void p9_read_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, rq);
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	p9_debug(P9_DEBUG_TRANS, "start mux %p pos %zd\n", m, m->rc.offset);
@@ -450,7 +451,7 @@ static void p9_write_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, wq);
 
-	if (m->err < 0) {
+	if (READ_ONCE(m->err) < 0) {
 		clear_bit(Wworksched, &m->wsched);
 		return;
 	}
@@ -622,7 +623,7 @@ static void p9_poll_mux(struct p9_conn *m)
 	__poll_t n;
 	int err = -ECONNRESET;
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	n = p9_fd_poll(m->client, NULL, &err);
@@ -665,6 +666,7 @@ static void p9_poll_mux(struct p9_conn *m)
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
 	__poll_t n;
+	int err;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
 
@@ -673,9 +675,10 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err < 0) {
+	err = READ_ONCE(m->err);
+	if (err < 0) {
 		spin_unlock(&m->req_lock);
-		return m->err;
+		return err;
 	}
 
 	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);
-- 
2.39.5


