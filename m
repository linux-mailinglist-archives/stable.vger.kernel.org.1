Return-Path: <stable+bounces-227606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGuWDrWivWkM/wIAu9opvQ
	(envelope-from <stable+bounces-227606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:40:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6F2E02C8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C739230A87F3
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5C3FF886;
	Fri, 20 Mar 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Eo0WZutw"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837383FE67C;
	Fri, 20 Mar 2026 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034950; cv=none; b=uij7Rg5Xf3GL0PIKI7P4Q7jk6z1fX3peRem0ZzdJWBRfSJ+yVHtyDYSjOi6NW85e/0V+xYfC/Ua3iKYaG8i6UOxZ7MIJFmM7dKR/u5QyIX45C8uNqCHbivEaky6mUpdnqsjmBb8SlGeWKX+CWSTfjZQictggY1jDP7EjgKwHta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034950; c=relaxed/simple;
	bh=WjjO/AfJ5NydP1+z0seh9U3XwapW7iumh1O/dmiPh/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVf2mybn0yE/U7NVwFX5YGQMKzCcqvcDY0ZKbiEDvHcbYqjfI6E16DJzio3B2hgLfV0SBv2AyyZS1ZHCNasVY1zct2MToT0kmMFRVhDSnI9cwYS+J525o23xIXC+BOg58FRI6HItCs39108bviyd+d6dYBbrF0HlUelqIZWdGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Eo0WZutw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774034940;
	bh=WjjO/AfJ5NydP1+z0seh9U3XwapW7iumh1O/dmiPh/M=;
	h=From:To:Cc:Subject:Date:From;
	b=Eo0WZutwhbj8RrQneBTjFbKE4ScC5gJXoD4726/niPp97J90/+rNhIWqT9V34tbZ4
	 SUEqklYVowmTkrQmR1WO4Q2DUyYl8W5n5aaoWV937rCqWNbKSCcGoIgMahG0a88aRP
	 oQ0GSwkG+Qa+0xCyf1iGSi0U3KzXLGiPI6S5XCg3dCIfaOXxS7OgXb9LB7G6JnEs3G
	 0Jszp0WkicMlHr46V3Z9gkNzsJItA82O3tF5F4MD9cb6JT4PLr7M3ezxUeplKyLO4v
	 r1kokNgvgXAH2XZvSmBBNIQGDjzJVsQd6JLap7oP7shMUz7RuByRJi8dSlkIS7zsNg
	 IIHUOJz8HsSTg==
Received: from localhost.localdomain (unknown [84.18.237.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbeckett)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B64B17E04DC;
	Fri, 20 Mar 2026 20:29:00 +0100 (CET)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set
Date: Fri, 20 Mar 2026 19:22:08 +0000
Message-ID: <20260320192217.365936-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227606-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bob.beckett@collabora.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BEA6F2E02C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Robert Beckett <bob.beckett@collabora.com>

The NVM Command Set Identify Controller data may report a non-zero
Write Zeroes Size Limit (wzsl). When present, nvme_init_non_mdts_limits()
unconditionally overrides max_zeroes_sectors from wzsl, even if
NVME_QUIRK_DISABLE_WRITE_ZEROES previously set it to zero.

This effectively re-enables write zeroes for devices that need it
disabled, defeating the quirk. Several Kingston OM* drives rely on
this quirk to avoid firmware issues with write zeroes commands.

Check for the quirk before applying the wzsl override.

Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
Cc: stable@vger.kernel.org
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Assisted-by: claude-opus-4-6-v1
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..ce25c8a4e84b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3388,7 +3388,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	ctrl->dmrl = id->dmrl;
 	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
-	if (id->wzsl)
+	if (id->wzsl && !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
 free_data:
-- 
2.48.1


