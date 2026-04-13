Return-Path: <stable+bounces-237333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJWVFwci3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:04:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CE3F0A19
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C1A309430B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6E317152;
	Mon, 13 Apr 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ChWvFoUT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0709313298;
	Mon, 13 Apr 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099184; cv=none; b=VwhRbVEeNX9Fqy3P3dVKV5Fce8eQGapihYHRYZY0L8ReJzhp+hHLdHdaupOYzGhT/o3EFLjbzYZTfvmvPpFoUUP0if7Xk2xjCytFf6v4E99T6wvYkhaUALsRqK43yaCxIWnnksjH88HN6mZ3YSX2G4DteXiyB7NY8fbuRqMwD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099184; c=relaxed/simple;
	bh=sXvLldS/Ix8lFVsLzlFdW7i8fZInSGjpP+/GY4lVZnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn9Vxpf/dz1nGQUjNyKIRL0lWK52a7gI0zDoopdHBBStRgLyCJnWKVGi5chNTSDdzwGS5QF0dUXtZ1JQsG0FUOdvTcW1ixNVAtHjaJUEIc39IZbglBQ5+MqjFZTpsX0/owZXmc1iVodzSyfOjhPqJm9Fe0vi++fi7MvTfhZLPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ChWvFoUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86838C2BCB0;
	Mon, 13 Apr 2026 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099183;
	bh=sXvLldS/Ix8lFVsLzlFdW7i8fZInSGjpP+/GY4lVZnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChWvFoUTR7lt7OXx0PD9TPE3Qvd0FfHAdayAvpHsKIqtyuLatAzW8GOdDVHwqigCZ
	 bEjuv8Ef234RWdX+H0wtGoJ/z2BIZfuH5EdtaZI1rcuBWyUbZazZTDGWZX8RiU3CGN
	 XmG+vbTua+KaKSvFkWCSTiUqwt/UmBvvPgnmtvMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 241/491] nvme-pci: ensure were polling a polled queue
Date: Mon, 13 Apr 2026 17:58:06 +0200
Message-ID: <20260413155828.079754894@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237333-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: F21CE3F0A19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 166e31d7dbf6aa44829b98aa446bda5c9580f12a ]

A user can change the polled queue count at run time. There's a brief
window during a reset where a hipri task may try to poll that queue
before the block layer has updated the queue maps, which would race with
the now interrupt driven queue and may cause double completions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbf8961f69efa..03df42e613f0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1097,7 +1097,8 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	bool found;
 
-	if (!nvme_cqe_pending(nvmeq))
+	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
+	    !nvme_cqe_pending(nvmeq))
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-- 
2.51.0




