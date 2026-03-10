Return-Path: <stable+bounces-224454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI9qLMsCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107124B316
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3A4831C4E1D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A57425CF4;
	Tue, 10 Mar 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEiPQ+Cg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84368425CE1;
	Tue, 10 Mar 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142186; cv=none; b=TH+gUAokdQw07gkDWW6eRYIMy0tuX/lKSuArmfUzPySogdU/c7ikguinizTeVz46HVA/IifT5rMUh6/txt+4FebIF/InPJF0rFN8NkVj57tBNMg0I29bSru8ytmdCifRtckZxdLoTin2dh+8KmSbCEfBr3mrx7+JyBsj+tlj6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142186; c=relaxed/simple;
	bh=SSqM5fT6f6XfxbAZe2g4WzfsVDhomXBV9dQy8wEEOoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBo2S5jBCaAT91R4btyAYWP03psIXDMbLUDNpEqR59tw04aRALidm6bOo0jao23x9LnFB4LPa9G8fEf16PRG0a7d/IivVylJqxDwpTtugYI7aaTh2u/7Ye2x3z2psXdZMtNmC9tSR+JNQqh2qyBMkiF7jwBUUYGHQ4D4bkAFHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEiPQ+Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC55C19423;
	Tue, 10 Mar 2026 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142186;
	bh=SSqM5fT6f6XfxbAZe2g4WzfsVDhomXBV9dQy8wEEOoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEiPQ+Cgrkk4hAXseacBkiKB7peke3ROC8emwabU0XFuu/AL8e8yF6hXJ1P9bBfcT
	 vrtvNjleFwn2uXREDmEKdjUspuCq+qkcG0JkQHsqxV0AhZ1zkaipZ5xxdP7eCIbEYR
	 ClZD93fJtEcmBiGI5snjwZzeHWYWgEy09vlw8Jn/y2irJq1X/+5B2fxCoZo6lieTe1
	 r2c7oWPlLnUhsy81ZbAsOKbl6N3jFGCHXtoKw/z0ohUNKAVjwco6h/NEH91gL+Ls5H
	 +PPzqCr6fKsRkkZDVqyhybERIXxSL0+zAUoqimEEYaBHPBEKO8GMtaU1gjvj9RhC5x
	 G77MppSYGxpeQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 275/314] nvme: reject invalid pr_read_keys() num_keys values
Date: Tue, 10 Mar 2026 07:18:54 -0400
Message-ID: <588dabd39c9f25f5a4f69c65678b8a88be562e5d.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2107124B316
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224454-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,oracle.com:email,lst.de:email,kernel.dk:email]
X-Rspamd-Action: no action

From: Stefan Hajnoczi <stefanha@redhat.com>

[ Upstream commit 38ec8469f39e0e96e7dd9b76f05e0f8eb78be681 ]

The pr_read_keys() interface has a u32 num_keys parameter. The NVMe
Reservation Report command has a u32 maximum length. Reject num_keys
values that are too large to fit.

This will become important when pr_read_keys() is exposed to untrusted
userspace via an <linux/pr.h> ioctl.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3320153769f ("nvme: fix memory allocation in nvme_pr_read_keys()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b139..ad2ecc2f49a97 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -228,7 +228,8 @@ static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 static int nvme_pr_read_keys(struct block_device *bdev,
 		struct pr_keys *keys_info)
 {
-	u32 rse_len, num_keys = keys_info->num_keys;
+	size_t rse_len;
+	u32 num_keys = keys_info->num_keys;
 	struct nvme_reservation_status_ext *rse;
 	int ret, i;
 	bool eds;
@@ -238,6 +239,9 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	 * enough to get enough keys to fill the return keys buffer.
 	 */
 	rse_len = struct_size(rse, regctl_eds, num_keys);
+	if (rse_len > U32_MAX)
+		return -EINVAL;
+
 	rse = kzalloc(rse_len, GFP_KERNEL);
 	if (!rse)
 		return -ENOMEM;
-- 
2.51.0


