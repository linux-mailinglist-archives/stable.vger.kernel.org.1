Return-Path: <stable+bounces-257710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCeqCNcdG2qV/QgAu9opvQ
	(envelope-from <stable+bounces-257710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00C60FADE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEE9E300FA9F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C41D33E36A;
	Sat, 30 May 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SLMhKnwo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8533F8B4;
	Sat, 30 May 2026 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161913; cv=none; b=q/cJmlZMNjEUSbNOBgo63Vm3GK2a7Ai9nqkZ9FvLh3ZRgFzYo5RETg0HoQ7vZJGKQLLXNc0Ujf0BIrNJxkmQv8xk+q2GOgoix1UipSuOl6uurT6+wgltK30BAQk+dhse6ojtZ0gX9vb5abdzrFxfwNVG6CicFr5rQw18KB5WeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161913; c=relaxed/simple;
	bh=aw+obntB1e6T8DrnuRZ4rwn0OkDg1t0iviqTVSjxXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU5Fna8hBvIcY5ZrjCU+Bd7d0FpmNOSedWIrrhxJlbnMYDlxJQD3YLSTDlKk4vTOzu0nHkhMsLFPWdc27RCZBY6BURH1enzU7Dcw6RQUQ1StmtVbYshz6xdizujS9If/oivR7shhs5H59sxLpTwv7o9Ox74R4FaW9J4PTrgTO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SLMhKnwo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC21F00893;
	Sat, 30 May 2026 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161912;
	bh=KvHgZ7b0upB/yAW458R1GcXyg2J18i0yI44K5vnyJg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLMhKnwoCmbMUayV3gjXSuHZyUdq5kIwu9nQ/SK/aOOko/fPnuzl+nkGmSOeRQnMd
	 t9mMVO02gk0knWinVygj0SmvQ8QzzLzd6X3TcFWj/8q5pGxAu7o6l7H/yHwIOE9hDb
	 ysVsl1/pnjIAqWFIn9mhrxRGGUXjHLxbj1AL+wkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 735/969] nvme-pci: fix missed admin queue sq doorbell write
Date: Sat, 30 May 2026 18:04:19 +0200
Message-ID: <20260530160320.846389394@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257710-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BD00C60FADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 1cc4cdae2a3b7730d462d69e30f213fd2efe7807 ]

We can batch admin commands submitted through io_uring_cmd passthrough,
which means bd->last may be false and skips the doorbell write to
aggregate multiple commands per write. If a subsequent command can't be
dispatched for whatever reason, we have to provide the blk-mq ops'
commit_rqs callback in order to ensure we properly update the doorbell.

Fixes: 58e5bdeb9c2b ("nvme: enable uring-passthrough for admin commands")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 394673a7f75cb..660e8fbb18136 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1756,6 +1756,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
+	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_admin_init_hctx,
 	.init_request	= nvme_pci_init_request,
 	.timeout	= nvme_timeout,
-- 
2.53.0




