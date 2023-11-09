Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5007E6C5A
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 15:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjKIOXi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 09:23:38 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC02D77
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 06:23:35 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SR3yF0k6Gz1P84k;
        Thu,  9 Nov 2023 22:20:21 +0800 (CST)
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 22:23:32 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
CC:     Dongli Zhang <dongli.zhang@oracle.com>, <kvmarm@lists.linux.dev>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [stable-4.19 PATCH] scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids
Date:   Thu, 9 Nov 2023 22:23:28 +0800
Message-ID: <20231109142328.1460-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit 1978f30a87732d4d9072a20abeded9fe17884f1b ]

When tag_set->nr_maps is 1, the block layer limits the number of hw queues
by nr_cpu_ids. No matter how many hw queues are used by virtio-scsi, as it
has (tag_set->nr_maps == 1), it can use at most nr_cpu_ids hw queues.

In addition, specifically for pci scenario, when the 'num_queues' specified
by qemu is more than maxcpus, virtio-scsi would not be able to allocate
more than maxcpus vectors in order to have a vector for each queue. As a
result, it falls back into MSI-X with one vector for config and one shared
for queues.

Considering above reasons, this patch limits the number of hw queues used
by virtio-scsi by nr_cpu_ids.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/scsi/virtio_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 50e87823baab..0b45424e7ca5 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -853,6 +853,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 
 	/* We need to know how many queues before we allocate. */
 	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
+	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
 
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 
-- 
2.33.0

