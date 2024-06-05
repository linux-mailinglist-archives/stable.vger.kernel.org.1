Return-Path: <stable+bounces-48201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E654F8FCD9D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714B52858B3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57D1CDDBE;
	Wed,  5 Jun 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVctVR+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A41CDDB7;
	Wed,  5 Jun 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589131; cv=none; b=iZytONPbKoxCbUn81LG6M1YKm6vwA5S0lU6JUzau12vqoqnodvfQM1iifVv61M6biAP4qwb9N1rTbptEL70L5p1pr0ykve0/6+q7NOsMVvOxe31MMUJKy4FebJi0OebRJPIPE7ZW19th2E5jyR5Xiq0kFXL+WJ9lALxxeH/nQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589131; c=relaxed/simple;
	bh=doepLDQwS2z1/JoKLr3ODUteocCb6CNy0bPgcApiWFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaUb67FQ1mXzeHx15juRb73USSZhceVxxgC65LrVMlm+3rwL9gX8RjPQF70ReQ808kdzm+GTpUrdQ3yXPh0P3PvKm0Rn7YDv4c1xG+taOsheQaP6vMu4JtDnPFkuqvbbvpTuM1z0/KWqCFDvC3zcLBeITtmYsqxbVZ/CVTizsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVctVR+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1498C3277B;
	Wed,  5 Jun 2024 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589130;
	bh=doepLDQwS2z1/JoKLr3ODUteocCb6CNy0bPgcApiWFQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EVctVR+eXCl/5Vmb87Zc2qUXEFdygiJ4tC7atLDM1U3a24whOCME1v28iJMpl5md1
	 VtNT56BakRl6EXHdokX/igCoZTGdFvvdXg7O5h5MnTQp7Yc2JD7astR+efYPL7adpR
	 CZWeWKualgR7R0Kh5ejjB10hSSkA1O/jLk4Htr/XCjyZJjMIGGoxOlJwKvhiKxnlSV
	 oAMJD0ANg+TsSKKGl5X+XDdHUyVdiBU6kgjHCk6NbqsQCrIxbVVn3X7nEJVOpCvkeB
	 j/OE8AHO5ir7pHIrIp/ugtxYO8v2rM0+13MV1j8K3gYuzb4qXd9W27y/qbsm8+XDJj
	 TMaAgNxv6MHEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 01/12] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:05:11 -0400
Message-ID: <20240605120528.2967750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 73eddb67f0d24..9ddaa599a9cd0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -516,7 +516,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


