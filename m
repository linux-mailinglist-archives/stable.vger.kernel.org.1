Return-Path: <stable+bounces-224042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOvPMsb8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966924A1FD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BC983035AA5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973823859EA;
	Tue, 10 Mar 2026 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhNXiBTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE292BF3E2;
	Tue, 10 Mar 2026 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141176; cv=none; b=jXMgElRVhrKxkFgRxtjccBZQC2j66BkU/xgoIty7i3B2h0hi6qkTbeFQ8DPGr9aLB2MyNf2UlfNH0k1lgcbe3b+559tkYUAIS3EqIfUCS5600daLDzv5k2WK/+epPwCgilYC2USH5CELPBREdR7mmQZqp9GxRvGkoP8Gk+qGNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141176; c=relaxed/simple;
	bh=5hp4d0IrKTGxDfCEc1npvmCtsztniXVnIfz7lvKm1uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuJqnCFerpcDGbYDBrOTQ89UTMWAIfof3jsrP93fzhFKMisFGx3iN0xcbLfMZsurXu7ykznJ+2lqtHRGGav9dVYLO3RWKbzO4ATMc4D5a5eIEDZsdD5tpoZWDDTbJzFutJEe1LZadWPqgUfA3ou2P96RSfRFYJQUquD564ucJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhNXiBTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCD4C19423;
	Tue, 10 Mar 2026 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141176;
	bh=5hp4d0IrKTGxDfCEc1npvmCtsztniXVnIfz7lvKm1uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhNXiBTDZ8rKGwSF6QkQdMCPfVN7U2vujCaz71SLZrKdqjs/2GHoUZ3iyZJE96A7F
	 tgpNKGaPRw1lMSwgapp9pRyH0SoimWMu8ke7bgOPdF9wM0jQn0VjQI3ClKdF7Rkhln
	 Yg4eYcLti95dLBJi+9n7r4FfNBJdacAeGRfLeHwNHk31c+VKfX9NyKknCaqu9JhhU3
	 xgc6LIr5PEfL4xRhJ5K8VCytfgJtl8AM0tRfiBJ+AM7G39UQy6EB46qoOu3cFCZ5k4
	 dB9aEFFTmsCXD9ILOZF9WkQI6iw0k97g+Mkbv4v602i3XzNC8GDrUXIVPlArQnxkjH
	 M98KuQB9BMKcw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 177/311] nvme: fix admin queue leak on controller reset
Date: Tue, 10 Mar 2026 07:03:44 -0400
Message-ID: <074c904577b441255c435bca66e3e0f146d3e632.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6966924A1FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224042-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f..3fdcd73b95468 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4864,6 +4864,13 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
+
 	ctrl->admin_q = blk_mq_alloc_queue(set, &lim, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
-- 
2.51.0


