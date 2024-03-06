Return-Path: <stable+bounces-26944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F28735A0
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 12:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A163B21B4A
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F247FBA8;
	Wed,  6 Mar 2024 11:31:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6C5FDDC
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724698; cv=none; b=uUVG7eyplUkGA06m/8bbHlM1u4yfBYg9rfGTOWbs0rPsyZWmenBW1/p6Y1O2OmDdDJPaFiDR9HPZvBLJ13p4lcxAVwF5QIQwp79Wd7PkeUHNdauhRgW1OJt3/YkcQoMcgJ5ZKx8u9YNWRB2J912aoZwVhWuVyrmUcf0IDCZCTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724698; c=relaxed/simple;
	bh=Opne3QTmvUw4O2TCivooWSceNde6A7Me83HChw/pCRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q35EuOXzGdaK8K0L3BKb3/PfnKmeHW+l7ZGM/M/gW4AqiQvV1d8Q8pll0Y7WisbeMnx7S0OgHOi8LszZ/UDMvOtFfSFnveGoiqDPv8S5HgOMHSoYSwegYojBCjb6+0RA++QJev7fftIy4SCvpabGsTjpv6h8Hw5kcViNUak9LvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TqVcp0Rxqz4f3jXY
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 19:31:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F86B1A016E
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 19:31:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBEOVOhlsPJ1GA--.54693S4;
	Wed, 06 Mar 2024 19:31:27 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jsperbeck@google.com,
	beanhuo@micron.com,
	hch@lst.de,
	axboe@kernel.dk,
	sashal@kernel.org,
	yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH 5.10] nvme: use nvme_cid to generate command_id in trace event
Date: Wed,  6 Mar 2024 19:25:06 +0800
Message-Id: <20240306112506.1699133-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBEOVOhlsPJ1GA--.54693S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWktr4kCFWDArykAr17GFg_yoW8WFykpF
	4rWrn09rZ7WF45t3s7Ja1DuFWUXws0vrWUGr12g3s3Xry7tFWFkr1Y9FWFvF9xZFZrury2
	vFWYqryxXa1UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
	-UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

A null-ptr-deref problem may occur since commit 706960d328f5 ("nvme: use
command_id instead of req->tag in trace_nvme_complete_rq()") tries to get
command_id by nvme_req(req)->cmd while nvme_req(req)->cmd is NULL.
The problem has been sloved since the patch has been reverted by commit
929ba86476b3. However, cmd->common.command_id is set to req->tag again
which should be ((genctl & 0xf)< 12 | req->tag).
Generating command_id by nvme_cid() in trace event instead of
nvme_req(req)->cmd->common.command_id to set it to
((genctl & 0xf)< 12 | req->tag) without trigging the null-ptr-deref
problem.

Fixes: commit 706960d328f5 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
Reported-by: John Sperbeck <jsperbeck@google.com>
Link: https://lore.kernel.org/r/20240109181722.228783-1-jsperbeck@google.com
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 700fdce2ecf1..0de057a298dd 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -98,7 +98,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->qid = nvme_req_qid(req);
-		__entry->cid = req->tag;
+		__entry->cid = nvme_cid(req);
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
-- 
2.31.1


