Return-Path: <stable+bounces-192995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA37C4962E
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9C44E38C2
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534752FF155;
	Mon, 10 Nov 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxArVH1R"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D402FC013
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809638; cv=none; b=GApGMjIdk8jM7dEmwZn7NPnL6ZOiv8IgXCXfE77BySLITdBxcWijV8n0Q4hNl5hlJ5pAI827KKLrG9DJK86+NE7lq8GgdAZMe7yo5m6VeOk2aieYXDykoRsqo2O0vIWG7iGQLb1eLB1UbFsBcOVuPe/UpOEZZNwWFfBJGwVVyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809638; c=relaxed/simple;
	bh=Z5k2H6Mp8pN+0nX2GmIS1SupFlnCEmwZ8E4Q20unqpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVHL8ZEBtSs+CFCb9hCxD8zuxpYqPkZhbON6EbRGutwYlSKiOY1k6m2G0F0EUR35wgCioh2YjZ+YaC+/IYMRbZZcHUUpC43qEDderpbpNn+lI9zQBWrWnY+QVSE2lRLA49KSgNDRDEADfRAbtNHs1KFI7pJBg05q0dSz/WiLbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxArVH1R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762809629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=561yaBU1hlykzt9dO5UJDtTCHIAhwzfRM1P5IrsbAw8=;
	b=NxArVH1RmRctPI5Jd/FEX01Rn1eY5a+yQVm1qdDi6v/auG8HMekt3bVQ5mNorb5IcyGQKH
	gd5HO97g2dKzxzNUSh9L9wdjU5MJMARbbGbycjHFxrR1HrBLKkjAoXcqi0gWmfeGtHNics
	rUmFJ5tA/ZihhbFj67eEWU4zoLpKVf0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-OevqBLYjP6idwoh6KNs-1g-1; Mon,
 10 Nov 2025 16:20:22 -0500
X-MC-Unique: OevqBLYjP6idwoh6KNs-1g-1
X-Mimecast-MFC-AGG-ID: OevqBLYjP6idwoh6KNs-1g_1762809620
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50DF0180034A;
	Mon, 10 Nov 2025 21:20:19 +0000 (UTC)
Received: from emilne-na.westford.csb (unknown [10.45.224.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78D9A19560BA;
	Mon, 10 Nov 2025 21:20:14 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com,
	james.smart@broadcom.com,
	paul.ely@broadcom.com,
	justin.tee@broadcom.com,
	sagi@grimberg.me,
	njavali@marvell.com,
	ming.lei@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()
Date: Mon, 10 Nov 2025 16:20:01 -0500
Message-ID: <20251110212001.6318-3-emilne@redhat.com>
In-Reply-To: <20251110212001.6318-1-emilne@redhat.com>
References: <20251110212001.6318-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

nvme_fc_delete_assocation() waits for pending I/O to complete before
returning, and an error can cause ->ioerr_work to be queued after
cancel_work_sync() had been called.  Move the call to cancel_work_sync() to
be after nvme_fc_delete_association() to ensure ->ioerr_work is not running
when the nvme_fc_ctrl object is freed.  Otherwise the following can occur:

[ 1135.911754] list_del corruption, ff2d24c8093f31f8->next is NULL
[ 1135.917705] ------------[ cut here ]------------
[ 1135.922336] kernel BUG at lib/list_debug.c:52!
[ 1135.926784] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1135.931851] CPU: 48 UID: 0 PID: 726 Comm: kworker/u449:23 Kdump: loaded Not tainted 6.12.0 #1 PREEMPT(voluntary)
[ 1135.943490] Hardware name: Dell Inc. PowerEdge R660/0HGTK9, BIOS 2.5.4 01/16/2025
[ 1135.950969] Workqueue:  0x0 (nvme-wq)
[ 1135.954673] RIP: 0010:__list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1135.961041] Code: c7 c7 98 68 72 94 e8 26 45 fe ff 0f 0b 48 c7 c7 70 68 72 94 e8 18 45 fe ff 0f 0b 48 89 fe 48 c7 c7 80 69 72 94 e8 07 45 fe ff <0f> 0b 48 89 d1 48 c7 c7 a0 6a 72 94 48 89 c2 e8 f3 44 fe ff 0f 0b
[ 1135.979788] RSP: 0018:ff579b19482d3e50 EFLAGS: 00010046
[ 1135.985015] RAX: 0000000000000033 RBX: ff2d24c8093f31f0 RCX: 0000000000000000
[ 1135.992148] RDX: 0000000000000000 RSI: ff2d24d6bfa1d0c0 RDI: ff2d24d6bfa1d0c0
[ 1135.999278] RBP: ff2d24c8093f31f8 R08: 0000000000000000 R09: ffffffff951e2b08
[ 1136.006413] R10: ffffffff95122ac8 R11: 0000000000000003 R12: ff2d24c78697c100
[ 1136.013546] R13: fffffffffffffff8 R14: 0000000000000000 R15: ff2d24c78697c0c0
[ 1136.020677] FS:  0000000000000000(0000) GS:ff2d24d6bfa00000(0000) knlGS:0000000000000000
[ 1136.028765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1136.034510] CR2: 00007fd207f90b80 CR3: 000000163ea22003 CR4: 0000000000f73ef0
[ 1136.041641] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1136.048776] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1136.055910] PKRU: 55555554
[ 1136.058623] Call Trace:
[ 1136.061074]  <TASK>
[ 1136.063179]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1136.067540]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1136.071898]  ? move_linked_works+0x4a/0xa0
[ 1136.075998]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.081744]  ? __die_body.cold+0x8/0x12
[ 1136.085584]  ? die+0x2e/0x50
[ 1136.088469]  ? do_trap+0xca/0x110
[ 1136.091789]  ? do_error_trap+0x65/0x80
[ 1136.095543]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.101289]  ? exc_invalid_op+0x50/0x70
[ 1136.105127]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.110874]  ? asm_exc_invalid_op+0x1a/0x20
[ 1136.115059]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.120806]  move_linked_works+0x4a/0xa0
[ 1136.124733]  worker_thread+0x216/0x3a0
[ 1136.128485]  ? __pfx_worker_thread+0x10/0x10
[ 1136.132758]  kthread+0xfa/0x240
[ 1136.135904]  ? __pfx_kthread+0x10/0x10
[ 1136.139657]  ret_from_fork+0x31/0x50
[ 1136.143236]  ? __pfx_kthread+0x10/0x10
[ 1136.146988]  ret_from_fork_asm+0x1a/0x30
[ 1136.150915]  </TASK>

Fixes: 19fce0470f05 ("nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context")
Cc: stable@vger.kernel.org
Tested-by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9e1841223e8a..bce3ea13c200 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3257,7 +3257,6 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
 	/*
@@ -3265,6 +3264,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (ctrl->ctrl.tagset)
 		nvme_remove_io_tag_set(&ctrl->ctrl);
-- 
2.43.0


