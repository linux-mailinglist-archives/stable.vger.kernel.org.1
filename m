Return-Path: <stable+bounces-48187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008568FCD7B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1887B1C23CDB
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D51CAB7D;
	Wed,  5 Jun 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0lCkUmj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A51CAB98;
	Wed,  5 Jun 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589097; cv=none; b=egvZ2bWaU5lcU4RGeq3W5GmYB3sisLxsvJRHracbJ8qc80POQulXfkLDb1sVl1ezwhrTp/9JTkUdj7BiPwPQ6c7yzWU8Q9yplsfshSSY13zj//5izH+YD5J4WdNoTATIzc5mv8R4Xglxjd3HU/t538QRjqzsilgChoMQT6qG7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589097; c=relaxed/simple;
	bh=Lmhh63CniRz7dCHgOoa4jJKSV5NqmaSY2UWwpsyRO/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iu7sACbwemOSovHKeE3IvCrM1ccoEAHOivucMGsQRdxujDLVXyKdoz8pzTDiJZv0XyPs3gAB+o99r75QBtcTNLtwJzGzSMZeLLn8OY7fRjlwN6YcUAV6Y5eFAeZTDRETopq/sdxdqRNtYMMEQPi2sgeZ21mtQh0aViBWib6UhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0lCkUmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC0BC3277B;
	Wed,  5 Jun 2024 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589096;
	bh=Lmhh63CniRz7dCHgOoa4jJKSV5NqmaSY2UWwpsyRO/A=;
	h=From:To:Cc:Subject:Date:From;
	b=P0lCkUmjbvMsZkviWDnsFdlkiu9GDL7kb/FDCZEvtcNdunnVq/cWPlAae1GNLt5vY
	 0BbGaZhZ3XQsyhOjia+BdwmyCKUsyqkj4lnffTRkXJwKnZkiz2d/KzC2vJlYQK+iye
	 GqknQMgW34XbRcMP8W4TsrgG8O+OUHS9A9QMQWHUzFaeN5HZ24Ui+7jT5DG8xu0qeo
	 yBT3IcNhEOldoW1KXRZQEvShrRvyPre/YoSrA/RPR01prTu85dSRZUI1CILuIBLnvB
	 r4wduJKS36W3z9MsK5ha4WiRgLwWYvQo1b8wlpMxNuowUZbHRq6/ouUuRo2QZ2cbfr
	 mfUQHmCaQL82w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/14] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:04:34 -0400
Message-ID: <20240605120455.2967445-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

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
index f96d330d39641..ead42a81cb352 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -558,7 +558,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


