Return-Path: <stable+bounces-242557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJFAB/029WkeJgIAu9opvQ
	(envelope-from <stable+bounces-242557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:27:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7494B0491
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5C3A300DCEB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597737F75A;
	Fri,  1 May 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1hYrbF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8B37EFF4
	for <stable@vger.kernel.org>; Fri,  1 May 2026 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678067; cv=none; b=EcB3UTmQngDontpHoyde+kAOaaypnRH+Nq2uBUzCDLLiKoRX0GKRKljmUsH0GOiQoYyiJgbxlPe5t7ixs8cwVPzC44DKOJp2LhMoUSAtMzkBRQHcjvzP0KuhRUWaKW9bPIqIp5obz3r5aHOdioZsuVDlxW7f9TESDTRi4YCMGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678067; c=relaxed/simple;
	bh=OYgvjTfox/Vm9bBAITuXcXNCC5dhadTkIWMXFbeYvl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ+g/k2R5lYo7vo5oTPgozRRzCD8va/5qaAnjUZGG+SnSRYgE0wQ8PzKnox1hUMDPUIPeqT+m33hRwYVgsxY7BVW85bjvHmLMVJeXhhFqFrTo29+83Bhj3RQLKWPvS55dfkYVva7Y33RFlL67/3mKGLTqjta7M85jw9UPm6QSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1hYrbF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3C9C2BCB4;
	Fri,  1 May 2026 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678066;
	bh=OYgvjTfox/Vm9bBAITuXcXNCC5dhadTkIWMXFbeYvl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1hYrbF3u5hlBqrCSyfpsHn/feI1ZrCpMJjTIlygHraHDHKGYMbmudH9anqezwvvv
	 UZQhyazUo3F5VlUM/+o8zTzHwp2N6J4bq+8SscUWUDlEFA7ny90feWEEM6y9nkyM5z
	 JdFZVS6L2h4C4wpIjBD9Iy7yWqcLvCbyZSmZUJ3vDv+PR565PzXk8gOZiemPMbcM+d
	 EPZNOdvm1mCxd5nFo6R2q4INqY20eSZXXQD62pZuUEyUhofVxxIfNsGB1hOi2yjW4J
	 28wKd+qvZiXsH2ClyGMLxq1ue5ZMMvSohThTWgPe3UiASchsEkGunKhywOxAo1UsRw
	 lg6PnYGWELg1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Yan <tom.ty89@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] nvme: fix interpretation of DMRSL
Date: Fri,  1 May 2026 19:27:43 -0400
Message-ID: <20260501232744.4102493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050133-dipped-hedge-8292@gregkh>
References: <2026050133-dipped-hedge-8292@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE7494B0491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lst.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242557-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Tom Yan <tom.ty89@gmail.com>

[ Upstream commit 1a86924e4f464757546d7f7bdc469be237918395 ]

DMRSLl is in the unit of logical blocks, while max_discard_sectors is
in the unit of "linux sector".

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 40f0496b617b ("nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3071bd11fdd3..1e0a7baa77f56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1736,6 +1736,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
+		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
+
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
@@ -2948,8 +2951,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
-	if (id->dmrsl)
-		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
+	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c6cd3d65065c8..1a394ab8098ad 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -299,6 +299,7 @@ struct nvme_ctrl {
 #endif
 	u16 crdt[3];
 	u16 oncs;
+	u32 dmrsl;
 	u16 oacs;
 	u16 nssa;
 	u16 nr_streams;
-- 
2.53.0


