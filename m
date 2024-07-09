Return-Path: <stable+bounces-58598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA992B7CA
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C529285510
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A87156C73;
	Tue,  9 Jul 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mnytZIUF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15727713;
	Tue,  9 Jul 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524424; cv=none; b=MFY/qH0bmiemrxpb3q7b1Yi78VT832gxTd2y5Hwp2MAPHuMazzgKMwXZjbl+vAImY8n5hql1VrEUlslpkAGrke0tP+Q4xt3PUcGDVVvkcxtAs9Fq+F/HuYgSjp5lPy0MGYpjjJSNw7fkxvl5tvuFxeobH3OLr4pjcQP+5p8DQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524424; c=relaxed/simple;
	bh=76cICNvx0c7ZZfjTqiu09Tv/NpIHonpIa3qdIZJ9I7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq5hRI2tG6Y6mL7i3+8OdOC6mtLnfwpWfcP0uxoM7YPXMCBhnYYU28f5NVKiHwqnh3Et8/Ovp35wwSK4ZuaG2nOYzB3l9EFLdXbAflI9wa9SEJGFTcQ5/kynVczKuqPt28WR39JF7fhymPT4nqUn3LacEoIXLQwxtVLw+/bCKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mnytZIUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF63C3277B;
	Tue,  9 Jul 2024 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524424;
	bh=76cICNvx0c7ZZfjTqiu09Tv/NpIHonpIa3qdIZJ9I7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnytZIUFITaYKs5hj+afvRYl8T621C9yH5IpZGm5+Tfn7R2VCZCB9CYH4AcG6pikF
	 y1R4nA7doZ/kOvUO/8/Lo3cjynsn+VZ15G7AJSN+fOmDtc7Z7HsXMGDmqRO6lOvWG7
	 GPjUUIJFiRLH0/8CXsaRKFDs7fNkM8ep/wbkgyo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 178/197] nvme-multipath: find NUMA path only for online numa-node
Date: Tue,  9 Jul 2024 13:10:32 +0200
Message-ID: <20240709110715.833520692@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit d3a043733f25d743f3aa617c7f82dbcb5ee2211a ]

In current native multipath design when a shared namespace is created,
we loop through each possible numa-node, calculate the NUMA distance of
that node from each nvme controller and then cache the optimal IO path
for future reference while sending IO. The issue with this design is that
we may refer to the NUMA distance table for an offline node which may not
be populated at the time and so we may inadvertently end up finding and
caching a non-optimal path for IO. Then latter when the corresponding
numa-node becomes online and hence the NUMA distance table entry for that
node is created, ideally we should re-calculate the multipath node distance
for the newly added node however that doesn't happen unless we rescan/reset
the controller. So essentially, we may keep using non-optimal IO path for a
node which is made online after namespace is created.
This patch helps fix this issue ensuring that when a shared namespace is
created, we calculate the multipath node distance for each online numa-node
instead of each possible numa-node. Then latter when a node becomes online
and we receive any IO on that newly added node, we would calculate the
multipath node distance for newly added node but this time NUMA distance
table would have been already populated for newly added node. Hence we
would be able to correctly calculate the multipath node distance and choose
the optimal path for the IO.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a4e46eb20be63..1bee176fd850e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -596,7 +596,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0




