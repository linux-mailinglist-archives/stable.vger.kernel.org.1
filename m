Return-Path: <stable+bounces-234253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB8oENCd1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70B3C0B66
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A8C305AD66
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CF3AA4E4;
	Wed,  8 Apr 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i2xsWX+Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35E3ACF11;
	Wed,  8 Apr 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672380; cv=none; b=MvKmc1yh0SX1TZdjEcDc1+3u9anVlc05lqzPhyOrHBZSPliyqlKZbvz1yDr+G3nP/YVUKK44EJUBr3Gz1Rvpza6p6uFygFaUOcvpzeFIP1MXtgrINIsKrIlIHiZ5+1N+3T4BtQ9i8LlCUZk+XqiJ377gxPpegPv81LKE7HaC1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672380; c=relaxed/simple;
	bh=fqzb25czcT2Mw8RBaMHYQqmOxIL+pYvoXTkJkZybWXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufjeEVgeAZ9xGWnveUVdQJ6dhH4NYMc0kB4jk1uMxd8TnNX9CSo/qLvWSmuovw8d5Ck4ChibwpKyR1LNo1ImjUc0FP6bnVG9Q/TJ5kBKTNMLdoX7NrCFjQIalZ8mooH59oVL56QFWP+MzsinB4VHbsHJFpaXHQ3V9dP058as1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i2xsWX+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85ACC19421;
	Wed,  8 Apr 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672380;
	bh=fqzb25czcT2Mw8RBaMHYQqmOxIL+pYvoXTkJkZybWXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2xsWX+Q8QprsjVxihFfzjiu9rVVDpmHNb1ip7q5Kx8DxLEZqHZiyZJ5hZN1mqIm+
	 iPHxyLLknSP4U3zmruIFxoHjunR9Q7cy5PrGSOJb1yq67gcVnwcL9AmIeZ8XeFewQy
	 k4ZA+sQPDMYQmTO92pk6xIDkoClulbIYYyZn9bUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Maximilian Heyne <mheyne@amazon.de>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Sasha Levin <sashal@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 6.1 265/312] nvme: fix admin queue leak on controller reset
Date: Wed,  8 Apr 2026 20:03:02 +0200
Message-ID: <20260408175943.643904288@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234253-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ispras.ru:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: BA70B3C0B66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b84bb7bd913d8ca2f976ee6faf4a174f91c02b8d ]

When nvme_alloc_admin_tag_set() is called during a controller reset,
a previous admin queue may still exist. Release it properly before
allocating a new one to avoid orphaning the old queue.

This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime").

[ Have to do analogous work in nvme_pci_alloc_admin_tag_set in pci.c due
  to missing upstream commit 0da7feaa5913 ("nvme-pci: use the tagset
  alloc/free helpers") ]

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++++
 drivers/nvme/host/pci.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f17318f6c82b0..09439fa7d083a 100644
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
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a74668739919..91f3ed726e700 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1805,6 +1805,13 @@ static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
 		return -ENOMEM;
 	dev->ctrl.admin_tagset = set;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (dev->ctrl.admin_q)
+		blk_put_queue(dev->ctrl.admin_q);
+
 	dev->ctrl.admin_q = blk_mq_init_queue(set);
 	if (IS_ERR(dev->ctrl.admin_q)) {
 		blk_mq_free_tag_set(set);
-- 
2.53.0




