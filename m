Return-Path: <stable+bounces-231331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEgYAxNny2mAHQYAu9opvQ
	(envelope-from <stable+bounces-231331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:17:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C83646F8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21D373043D42
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB927FB1F;
	Tue, 31 Mar 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="XX8k8QRb"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5011F5437;
	Tue, 31 Mar 2026 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937853; cv=none; b=QPNUPN2z/COQV199U2AQWl4auHtJT2ozby3NLk2hjilJUeCnQxW5AiZM4oouIfVmdlFQIJW+SuhRil8XkxSRuzxLjAc9YJ2QxwwUCbIG4GzTump18DlDRA2kBNiKnI4HdE7MxbGxm42XT521PxvcWKGKsWuYKXrxLUA/X9VceDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937853; c=relaxed/simple;
	bh=OR8PviOQvPFrwioQJHXCEjJ2Gr/EDn7NUd04k/Sep+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+oyB8LEOaed5ULMmbOooNhJ4zqQJEh40nIRbo1QsOQiDDPbWPrn1YIheGSp0BTK4NLa0KhtEl0TKdSCK5xvkACv9JK7HS3NvMRAOx4ll1rcN30bWuduglVXPrzGzN9TFX+f5cE9agedEsu70EQVrCvUFQ5Bi3Z49eIKZuyH0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=XX8k8QRb; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XX8k8QRbqXIEZgRlcW1cUj/YbeS2EM4xl4yRB99U9a95F6o/V8xk21qNre3LCi0XxiJA3EEw/c8D8
	 FxEd2/nZMD0creav1z/t1DyhkARaP74VT2aOzzk7XCZvGdwzUofFBBl8alU4cerYuduATlmPPO0qm8
	 pJIzYUVJfjMViVqk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-17-12016 (RichMail) with SMTP id 2ef069cb660f3f8-003fd;
	Tue, 31 Mar 2026 14:13:40 +0800 (CST)
X-RM-TRANSID:2ef069cb660f3f8-003fd
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	ming.lei@redhat.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6.1.y] nvme: fix admin queue leak on controller reset
Date: Tue, 31 Mar 2026 14:13:39 +0800
Message-Id: <20260331061339.3121617-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231331-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.983];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E5C83646F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b84bb7bd913d8ca2f976ee6faf4a174f91c02b8d ]

When nvme_alloc_admin_tag_set() is called during a controller reset,
a previous admin queue may still exist. Release it properly before
allocating a new one to avoid orphaning the old queue.

This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime").

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df33b293ee3..b0c7a055cf20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5012,6 +5012,13 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
+
 	ctrl->admin_q = blk_mq_init_queue(set);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
-- 
2.34.1



