Return-Path: <stable+bounces-225498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEmiMFZ5t2k9RgEAu9opvQ
	(envelope-from <stable+bounces-225498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 04:30:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C242946A7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 04:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD503011867
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BA63597B;
	Mon, 16 Mar 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="sCDYvCrI"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D420ED
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631826; cv=none; b=IaJf+bXlnMCJn/M7K6vM1NM9RcowqtiVooq5qtvWHn+oFOBYo+7g4qEuSoY2MLLcdofhaKkFVTcZKeQuvWHP1AaGyChyXV9YwKhUS3LDgtkY5lAAqmZfE87NjnaxmODxzqpovqhSlf8DfHMz57NVX7/gY+ZBjFahYh/YWgXBb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631826; c=relaxed/simple;
	bh=MudBcZXjkh+vbCwy5P5AerbJ8b+pJaKdThSeJbCjHOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c33DA3EgYhCv86NfQrJvMXP9gVigcZ8voswVHrGOOvEXqkyQxES4Y6bvM0CuAqIuxI91F70it622v8jhe3eBhnmneLRix6DEE0lPnVqNg/TxBjAMqJuHu/f1431E28BvM5iKpTGEucHHd/ok+KT7LLpEXKEVohQ3w2CZjexcmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=sCDYvCrI; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=sCDYvCrILdlfSFo5PWpAfUMmVMs9+JT7DLYWP3wU49fS55kcA+UbTcvHymiSDNPj+a90bNa6wVs7F
	 BYYJPatJIYK/yViFcfBnqNhjjc3W1BOPdGe6y4qudOvuZIeQ2fj+LjLdDyKpKVfpp8FLPkR390E3vE
	 hkGMzu2miSWa9nbA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.40.137])
	by rmsmtp-lg-appmail-16-12015 (RichMail) with SMTP id 2eef69b7788b43e-2421d;
	Mon, 16 Mar 2026 11:27:08 +0800 (CST)
X-RM-TRANSID:2eef69b7788b43e-2421d
From: Leon Chen <leonchen.oss@139.com>
To: dwagner@suse.de,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] nvmet: always initialize cqe.result
Date: Mon, 16 Mar 2026 11:27:06 +0800
Message-Id: <20260316032706.2924-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225498-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	NEURAL_SPAM(0.00)[0.729];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,139.com:email,139.com:mid,suse.de:email,lst.de:email]
X-Rspamd-Queue-Id: 71C242946A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit cd0c1b8e045a8d2785342b385cb2684d9b48e426 ]

The spec doesn't mandate that the first two double words (aka results)
for the command queue entry need to be set to 0 when they are not
used (not specified). Though, the target implemention returns 0 for TCP
and FC but not for RDMA.

Let's make RDMA behave the same and thus explicitly initializing the
result field. This prevents leaking any data from the stack.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Ignored the fabrics-cmd-auth.c, it was introduced in commit:db1312dd9548
("nvmet: implement basic In-Band Authentication") ]
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 drivers/nvme/target/core.c        | 1 +
 drivers/nvme/target/fabrics-cmd.c | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ef2e500bccfd..65bc1efa33d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -932,6 +932,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
 	req->metadata_len = 0;
+	req->cqe->result.u64 = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index e5ee3d3ce164..a12f80869d6f 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -187,9 +187,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
@@ -255,9 +252,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-- 
2.35.3



