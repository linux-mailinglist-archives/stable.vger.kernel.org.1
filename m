Return-Path: <stable+bounces-210661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNMOBoVAcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:57:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B5501B2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7410884A49
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56834107C;
	Wed, 21 Jan 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOVrrf6c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859633DEC2
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964222; cv=none; b=LC89EfOmksz4iWbEJgz4cyi2IGLR7aKcXVcGV7Nm++oe1vmls7UFYZGemu2o/LaSdm3LsjLjlin8YZS4fzLupLsBgV8b0gvJPfKnPhZ2zUTvMxmVdEpgZhKHxWZzfEPs64/VMNu7viQJxzbagNIbCj0MHsP5wv0VYHtJ7cQunko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964222; c=relaxed/simple;
	bh=aiNj0AZh8WCaxxOjsqqV8Dijc0tcH06PSPM89RMsw3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4m3mX69DwP//fZ5g+Y3GzFC4Q5x0ckKuA/lDwDcLdwfmVlGYiQ2F4FHKXVs0GTW8TUhd5zNYjjHA8NDC5FLkp5glLPyCyYp7VPm1GiDUgbsKIIfTBa8MBbs2NMniJS0biWCMv+L9Q3k7xaIiKeCrPzvZ5sFNO/AsVfEI73kfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOVrrf6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AEAC16AAE;
	Wed, 21 Jan 2026 02:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964221;
	bh=aiNj0AZh8WCaxxOjsqqV8Dijc0tcH06PSPM89RMsw3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOVrrf6cZCdRHqj4KYfTQwybVOOm6P1ig9fvL9bOdUQelYFFaZOHvsrOrVFkbncne
	 +z89HbyupMzaUos3m/cLIAHVu7KzJcN5HwtH4jdjxmL4A0JzdUjHIc8/CnGenqNtXT
	 GH4CgVXWKWpMG+IC4Pb0r98I34RLJ+Z3UHbmNQu/kA79CQePKpQClTZVac7Cj2k8cT
	 IiZkDKjzYD44e7qG++kNE1LYJ3PSDgab9eTxwvC+SA0QXr4QljM7RokK1DZqhaw1nB
	 tBgOWA0fe+N4JznREPzKojlvV5F7Gjd/zSUD+vYaMjehEWvfQfx9XFB5+nAu8z6Cfl
	 jqQGhdzlJlkSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] nvme-fc: rename free_ctrl callback to match name pattern
Date: Tue, 20 Jan 2026 21:56:57 -0500
Message-ID: <20260121025659.1157002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012012-catalyst-renewable-6c83@gregkh>
References: <2026012012-catalyst-renewable-6c83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210661-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,lst.de:email,grimberg.me:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 936B5501B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 205fb5fa6fde1b5b426015eb1ff69f2ff25ef5bb ]

Rename nvme_fc_nvme_ctrl_freed to nvme_fc_free_ctrl to match the name
pattern for the callback.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 0edb475ac0a7 ("nvme: fix PCIe subsystem reset controller state transition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 87a9801ac9f2f..71e22617c2874 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2417,7 +2417,7 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
  * controller. Called after last nvme_put_ctrl() call
  */
 static void
-nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
+nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
@@ -3362,7 +3362,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
+	.free_ctrl		= nvme_fc_free_ctrl,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
-- 
2.51.0


