Return-Path: <stable+bounces-145295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D5ABDB31
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5EC8A628F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305F242913;
	Tue, 20 May 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrPTDZRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A7EEDE;
	Tue, 20 May 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749752; cv=none; b=kPRPMWyU4TBuL8ygaGWUanDU2JJn2RIG7EIkt8M6nNsioXKNM4moCc9WlYbh+mV/7ABMhYNk1DBN/896tdsCIh+hPlCHdRR+k9zulYXku6Jg6SFQikzXmHLrFj05p1bSs7kQq2bRigS/7EHC1naQsqtSgsMMRCnuByc+XnmhFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749752; c=relaxed/simple;
	bh=dNHw/LRCQEVZRR7XDYi5S+kl4CHfBJoPsxEXnlKRUmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxaiRVgKolW4hSBcxb+piJJPXqNBYTqy/ZFSWbPF1IhfE/9yEOFUw/88PGKWcauHQx5IEzjQcrPgPQvRZqpcbUVQ2dO56dfZK4zz80QDavG52uXQFEjPqxGeFvYx83Cu5oCrbe4K6ottspn5KUQnGUbFtlWpygUKmFh6O8k33mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrPTDZRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D375CC4CEE9;
	Tue, 20 May 2025 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749752;
	bh=dNHw/LRCQEVZRR7XDYi5S+kl4CHfBJoPsxEXnlKRUmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrPTDZRWG74lSHg7bD6dwjPJJU0OGEH6Ra26gDiiUO2gOcCdoPFBWEZrONjMgnm5c
	 saBt3tamoHRFRpyMKB4J8Vla9FO/Pc5SSqT3LgZSKuYSh16lEjgBdTUWf9uxnlun8t
	 YVbcmfdQj8W/qvFGUNFT+PLgpudIYhGjymxjBH94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <wagi@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 047/117] nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable
Date: Tue, 20 May 2025 15:50:12 +0200
Message-ID: <20250520125805.858361024@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 3d8932133dcecbd9bef1559533c1089601006f45 ]

We need to lock this queue for that condition because the timeout work
executes per-namespace and can poll the poll CQ.

Reported-by: Hannes Reinecke <hare@kernel.org>
Closes: https://lore.kernel.org/all/20240902130728.1999-1-hare@kernel.org/
Fixes: a0fa9647a54e ("NVMe: add blk polling support")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 08280bd65d03d..1e5c8220e365c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1107,7 +1107,9 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	spin_lock(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
+	spin_unlock(&nvmeq->cq_poll_lock);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
-- 
2.39.5




