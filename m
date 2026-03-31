Return-Path: <stable+bounces-232289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDkrKyz/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:06:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F436DE56
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1279130C14A5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309AB425CD6;
	Tue, 31 Mar 2026 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSAm72jI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7791423A9B;
	Tue, 31 Mar 2026 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976365; cv=none; b=tnMhMlKetzde52Moa9WeEmi77ksvosugcht7/F7Hb4DPXop/0V0fbEUkO2k2hIiPNypSfQ/hP58LH+57G80PXePyB7D78vJsvwrw35VvKzcWH4Wuy6rB/WSdDxrIa/8U+UL91nKRRzlE9a8ez3T4CTnxa3mkbU/Xt4qARoYgALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976365; c=relaxed/simple;
	bh=iMT3rwbCNcoleWwrLLbYHTrKTPy8nsn7RhJ37ochWD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+/O3YppFEEvSdTLn7Hps5Aofwwb69FP0djNvGTJT70hZ/IgHlFxeZCuJx0bjNY9aY2pyqgFxCO8NLTeEVrmOjXGR+Lzjmk1FDR2VTW1l5+35BWRlf5GgWesh2M9A4Ivvcjo5YFWZQqJvI306Sn2a6KZ69V5u7CGEKNiuTX5JV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CSAm72jI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F072C19423;
	Tue, 31 Mar 2026 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976364;
	bh=iMT3rwbCNcoleWwrLLbYHTrKTPy8nsn7RhJ37ochWD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSAm72jItbyoyWT8WcSsBtnOWEznWEoHKHAM1p8aSv6EJbiQsX/0JPK5oEJQ6FEgs
	 +qSQ5eF0vutXy1J7oSS8/d99nWARCoMTUSXWocLM4seqdtRbwKqXgAbh710iq9MtUx
	 FHdr9vyg3TRd5TS1UL6+K8+/cM5NjpSP8bu/6vQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 021/309] nvme-pci: cap queue creation to used queues
Date: Tue, 31 Mar 2026 18:18:44 +0200
Message-ID: <20260331161754.259839133@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-232289-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 528F436DE56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4735b510a00fb2d4ac9e8d21a8c9552cb281f585 ]

If the user reduces the special queue count at runtime and resets the
controller, we need to reduce the number of queues and interrupts
requested accordingly rather than start with the pre-allocated queue
count.

Tested-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9987b711091f0..4459687eb7bb6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2707,7 +2707,13 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 
-	nr_io_queues = dev->nr_allocated_queues - 1;
+	/*
+	 * The initial number of allocated queue slots may be too large if the
+	 * user reduced the special queue parameters. Cap the value to the
+	 * number we need for this round.
+	 */
+	nr_io_queues = min(nvme_max_io_queues(dev),
+			   dev->nr_allocated_queues - 1);
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.51.0




