Return-Path: <stable+bounces-254516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PfdBVmvFmokogcAu9opvQ
	(envelope-from <stable+bounces-254516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:46:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7F5E1478
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 215B8300788D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4963E2AC9;
	Wed, 27 May 2026 08:46:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A83E2AB1;
	Wed, 27 May 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871573; cv=none; b=hzyPAK5NOejGOtOdVKz301EI6VuPMfa1VabtBJNM2bdpl+ia+SguGMdB+m/H1nj0JtU3UyC8oDBBdoc5HTBCucpJ65FSOzHW+NJkzhCfBper7IWLSpZivcpn/top6kQz30YRiT3tj2L0cqrW31dzuVYz1OuSrfIlWufTvpu5lgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871573; c=relaxed/simple;
	bh=azqs1r/kz47VaBUv8SMKNdIGYWY8aPWYBAx9Q9TIzEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eeke8rU1e+Zxy+03ODAoHY94+ss2gKC5sRIBKqHtgjmAWxVEbPT6OsvnJyeaLZlrHROo2IcTKBqhwc+9n/gtPsTGwHYwT6ClZaVSdKRMFwbRJlxK72xhPedBMBKXYOWMefsg9o3ykrkZ0i8xtflRnEsVDBNOttKjY6lR4zfQ1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.3])
	by APP-05 (Coremail) with SMTP id zQCowABXq85IrxZqD1KKEQ--.417S2;
	Wed, 27 May 2026 16:46:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvme: target: rdma: fix ndev refcount leak on queue connect
Date: Wed, 27 May 2026 08:45:44 +0000
Message-Id: <20260527084544.864221-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXq85IrxZqD1KKEQ--.417S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtr1kXrW5Xr4rKw4fWF4DJwb_yoW8JF1rp3
	y8Wry2k397KFW0kw13Za1UXa45Aw4ru3y8C3s2k34kZFyaqFZaqayUK3WjvF1FkF9rWFWf
	JF4UAr15C3WftFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMqcUUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgAA2oWidmovAAAs-
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: B2A7F5E1478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nvmet_rdma_queue_connect() calls nvmet_rdma_find_get_device() which
acquires a reference on the returned ndev via kref_get(). On the path
where the host queue backlog is exceeded and the function returns
NVME_SC_CONNECT_CTRL_BUSY, reference of ndev is not released, leaking
the kref.

Fix this by adding a goto to the existing put_device label before the
early return.

Fixes: 31deaeb11ba7 ("nvmet-rdma: avoid circular locking dependency on install_queue()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvme/target/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e6e2c3f9afdf..ac26f4f774c4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1598,8 +1598,10 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 				pending++;
 		}
 		mutex_unlock(&nvmet_rdma_queue_mutex);
-		if (pending > NVMET_RDMA_BACKLOG)
-			return NVME_SC_CONNECT_CTRL_BUSY;
+		if (pending > NVMET_RDMA_BACKLOG) {
+			ret = NVME_SC_CONNECT_CTRL_BUSY;
+			goto put_device;
+		}
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
-- 
2.34.1


