Return-Path: <stable+bounces-150350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D8ACB7DB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23562942216
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F622B8A1;
	Mon,  2 Jun 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyKMYHAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36622AE76;
	Mon,  2 Jun 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876843; cv=none; b=CA4XuO+2rxAZz//1HwIrNo/AjOBAl9K25bCh2vFU4YgBdz8y7iCYcbmjoBH30Ve88PayulpdWj5XNKxk5rYP2hvCn4ldC4ATPwIoG2KTb+XBRNvKbdeni/6VxjakRDwRRJJ16f0U3WAvGM2auB+jRgkd+3x9ORBJTfCZjj/7w7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876843; c=relaxed/simple;
	bh=e1EdoC+Qo7i0v/HZUcuI+m8irGwu5qIf0APZZQqnaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJZ+BCxrj/Md3/Ln1Q1rYC+BpA5aE6JKUCjY+t+7iylItWfPAsAQlXHC2JHxzFPm8Jn7UUnMWyGD+W+uY/RP96LkfJiC3AvuThxCw+sVcEOHf0Ywt7SQHgYBG3VOzshBsplnqSiOtw5EOcrmN1bZ1rofCUtAJQhjGccdndrs4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyKMYHAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD568C4CEEB;
	Mon,  2 Jun 2025 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876843;
	bh=e1EdoC+Qo7i0v/HZUcuI+m8irGwu5qIf0APZZQqnaPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyKMYHAQEsUgZAw1PpLNUDwcrqk3+JjXJxpXRqc7m435/SytDGPPseK70XFb5sb5V
	 Hyyi+xJfEfEq3IdllG8wuqAddRJn/2M93MZW3/YJJGEIHTK5P+lUzKCUVIKpG8nLne
	 VVA53Zcnl4MbiNYzJVhRvKAZKs5tYx2RiCYC163Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/325] net/smc: use the correct ndev to find pnetid by pnetid table
Date: Mon,  2 Jun 2025 15:45:50 +0200
Message-ID: <20250602134322.792726326@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit bfc6c67ec2d64d0ca4e5cc3e1ac84298a10b8d62 ]

When using smc_pnet in SMC, it will only search the pnetid in the
base_ndev of the netdev hierarchy(both HW PNETID and User-defined
sw pnetid). This may not work for some scenarios when using SMC in
container on cloud environment.
In container, there have choices of different container network,
such as directly using host network, virtual network IPVLAN, veth,
etc. Different choices of container network have different netdev
hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
in host below is the netdev directly related to the physical device).
            _______________________________
           |   _________________           |
           |  |POD              |          |
           |  |                 |          |
           |  | eth0_________   |          |
           |  |____|         |__|          |
           |       |         |             |
           |       |         |             |
           |   eth1|base_ndev| eth0_______ |
           |       |         |    | RDMA  ||
           | host  |_________|    |_______||
           ---------------------------------
     netdev hierarchy if directly using host network
           ________________________________
           |   _________________           |
           |  |POD  __________  |          |
           |  |    |upper_ndev| |          |
           |  |eth0|__________| |          |
           |  |_______|_________|          |
           |          |lower netdev        |
           |        __|______              |
           |   eth1|         | eth0_______ |
           |       |base_ndev|    | RDMA  ||
           | host  |_________|    |_______||
           ---------------------------------
            netdev hierarchy if using IPVLAN
            _______________________________
           |   _____________________       |
           |  |POD        _________ |      |
           |  |          |base_ndev||      |
           |  |eth0(veth)|_________||      |
           |  |____________|________|      |
           |               |pairs          |
           |        _______|_              |
           |       |         | eth0_______ |
           |   veth|base_ndev|    | RDMA  ||
           |       |_________|    |_______||
           |        _________              |
           |   eth1|base_ndev|             |
           | host  |_________|             |
           ---------------------------------
             netdev hierarchy if using veth
Due to some reasons, the eth1 in host is not RDMA attached netdevice,
pnetid is needed to map the eth1(in host) with RDMA device so that POD
can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
as Terway, network management plugin in container environment), and in
cloud environment the eth(in host) can dynamically be inserted by CNI
when POD create and dynamically be removed by CNI when POD destroy and
no POD related to the eth(in host) anymore. It is hard to config the
pnetid to the eth1(in host). But it is easy to config the pnetid to the
netdevice which can be seen in POD. When do SMC-R, both the container
directly using host network and the container using veth network can
successfully match the RDMA device, because the configured pnetid netdev
is a base_ndev. But the container using IPVLAN can not successfully
match the RDMA device and 0x03030000 fallback happens, because the
configured pnetid netdev is not a base_ndev. Additionally, if config
pnetid to the eth1(in host) also can not work for matching RDMA device
when using veth network and doing SMC-R in POD.

To resolve the problems list above, this patch extends to search user
-defined sw pnetid in the clc handshake ndev when no pnetid can be found
in the base_ndev, and the base_ndev take precedence over ndev for backward
compatibility. This patch also can unify the pnetid setup of different
network choices list above in container(Config user-defined sw pnetid in
the netdevice can be seen in POD).

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_pnet.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 399314cfab90a..af12e02152740 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1080,14 +1080,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 					 struct smc_init_info *ini)
 {
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
+	struct net_device *base_ndev;
 	struct net *net;
 
-	ndev = pnet_find_base_ndev(ndev);
+	base_ndev = pnet_find_base_ndev(ndev);
 	net = dev_net(ndev);
-	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
+	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
 				   ndev_pnetid) &&
+	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
-		smc_pnet_find_rdma_dev(ndev, ini);
+		smc_pnet_find_rdma_dev(base_ndev, ini);
 		return; /* pnetid could not be determined */
 	}
 	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
-- 
2.39.5




