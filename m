Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F217BD275
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 05:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbjJID6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 23:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbjJID6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 23:58:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB85A3
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 20:58:06 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231009035802epoutp04f62925871d98b96f566ae07e1cdb676f~MVFSq7wDB2322423224epoutp04u
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 03:58:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231009035802epoutp04f62925871d98b96f566ae07e1cdb676f~MVFSq7wDB2322423224epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696823882;
        bh=66RnzGW075jp+6jf5N9yCQS6VbcfbkyM8+NJckzV1XU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uP9hs+7+369RgeZMxGsyuiywTHPTJDLqnrXPAJlcYoQAysECrHAaAzUNRvvNhP6Ep
         tB1xIbdpN9w8f/qE13+2jSE1tmG54ztVdsFbw+THfOn85dnwpuii15DH8P9X4m14BT
         hyOOUqfoRNWjce+1ePK6GqQ0sDJ0/BnrEg/clENc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231009035801epcas5p401f28b9ac90606cea5f12dcb11d5de1f~MVFSFSqO30118601186epcas5p4R;
        Mon,  9 Oct 2023 03:58:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4S3lcT40pTz4x9Pt; Mon,  9 Oct 2023 03:58:01 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006135322epcas5p1c9acf38b04f35017181c715c706281dc~LiRPEIHz11084510845epcas5p1x;
        Fri,  6 Oct 2023 13:53:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006135322epsmtrp22c420b2d1fc904f8488b40101ff4d97f~LiRPDafSS3163131631epsmtrp2a;
        Fri,  6 Oct 2023 13:53:22 +0000 (GMT)
X-AuditID: b6c32a28-001ff700000021c9-e1-652011527c3e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.FA.08649.25110256; Fri,  6 Oct 2023 22:53:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006135320epsmtip2301b167209b42d8b4e6a5a713580c630~LiRNOFpKt1516815168epsmtip26;
        Fri,  6 Oct 2023 13:53:20 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, cpgs@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>, stable@vger.kernel.org,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Date:   Fri,  6 Oct 2023 19:17:06 +0530
Message-Id: <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG6QoEKqwecGRYs1V36zW6y+289m
        8fKQpsXK1UeZLI7+f8tmcf7tYSaLSYeuMVrMX/aU3WLd6/csFgs2PmK0eNzdwWixoU3Qgcdj
        56y77B7n721k8bh8ttRj06pONo/NS+o9dt9sYPPo27KK0ePzJrkAjigum5TUnMyy1CJ9uwSu
        jP+9agV/DSvWv3nL1sDYpNnFyMkhIWAiMW3eWuYuRi4OIYHdjBI/dz9nhUiISzRf+8EOYQtL
        rPz3HMwWEvjIKHH7v3gXIwcHm4CmxIXJpSBhEQEviXmzF7CA2MwCzxkl9uznALGFBTwk1s3t
        YASxWQRUJU7NOQxm8wpYSNxe0csCMV5eYual7+wQcUGJkzOfQM2Rl2jeOpt5AiPfLCSpWUhS
        CxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBAe6lsYOxnvz/+kdYmTiYDzEKMHB
        rCTCm94gkyrEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QD
        08a75x5otOa0zV683zUwNUc59HnCvd/SIRkWfcyhEZzrX+que3dpwc8lXW4ry2YqahXyTZxW
        HbHt01SlPcKpfLvnGt1Nb4qOfKZypVf8ns6HbebzD3EvCtqds/HkGefVP7Muv3GqVW1aX9H7
        suBU4ilP4yW1zz5/mTlT4mPLuxVbVp8WXe3gfDK3PIlDRZbB+o2dqEX2ayHTbu1/KwXuLuNv
        2c92a9uX53eOnH5SyW9548vBsvOHVCx0yj8nVZ6aZSqYmXfv8q2efZy1TvKiptWe0572Pw87
        ZVl/R2fLrg3n+iaWc7peZmkP2SzP+Pq7Xde8uJN/6p9zvrQXrH2pnMfycUXogev9k9Y81Mmf
        8EWJpTgj0VCLuag4EQC9YqOA4wIAAA==
X-CMS-MailID: 20231006135322epcas5p1c9acf38b04f35017181c715c706281dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20231006135322epcas5p1c9acf38b04f35017181c715c706281dc
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

User can specify a smaller meta buffer than what the device is
wired to update/access. Kernel makes a copy of the meta buffer into
which the device does DMA.
As a result, the device overwrites the unrelated kernel memory, causing
random kernel crashes.

Same issue is possible for extended-lba case also. When user specifies a
short unaligned buffer, the kernel makes a copy and uses that for DMA.

Detect these situations for sync/uring passthrough, and bail out.

Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device")
Cc: stable@vger.kernel.org

Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---

Changes since v2:
- Handle extended-lba case: short unaligned buffer IO
- Reduce the scope of check to only well-known commands
- Do not check early. Move it deeper so that check gets executed less
  often
- Combine two patches into one.

Changes since v1:
- Revise the check to exclude PRACT=1 case

Random crash example:

[ 6815.014478] general protection fault, probably for non-canonical address 0x70e3cdbe9133b7a6: 0000 [#1] PREEMPT SMP PTI
[ 6815.014505] CPU: 1 PID: 434 Comm: systemd-timesyn Tainted: G           OE      6.4.0-rc3+ #5
[ 6815.014516] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[ 6815.014522] RIP: 0010:__kmem_cache_alloc_node+0x100/0x440
[ 6815.014551] Code: 48 85 c0 0f 84 fb 02 00 00 41 83 ff ff 74 10 48 8b 00 48 c1 e8 36 41 39 c7 0f 85 e5 02 00 00 41 8b 45 28 49 8b 7d 00 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9d b8 00 00 00 4c 89 e0 48 0f c9 48 31 cb
[ 6815.014559] RSP: 0018:ffffb510c0577d18 EFLAGS: 00010216
[ 6815.014569] RAX: 70e3cdbe9133b7a6 RBX: ffff8a9ec1042300 RCX: 0000000000000010
[ 6815.014575] RDX: 00000000048b0001 RSI: 0000000000000dc0 RDI: 0000000000037060
[ 6815.014581] RBP: ffffb510c0577d58 R08: ffffffffb9ffa280 R09: 0000000000000000
[ 6815.014586] R10: ffff8a9ecbcab1f0 R11: 0000000000000000 R12: 70e3cdbe9133b79e
[ 6815.014591] R13: ffff8a9ec1042300 R14: 0000000000000dc0 R15: 00000000ffffffff
[ 6815.014597] FS:  00007fce590d6940(0000) GS:ffff8a9f3dd00000(0000) knlGS:0000000000000000
[ 6815.014604] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6815.014609] CR2: 00005579abbb6498 CR3: 000000000d9b0000 CR4: 00000000000006e0
[ 6815.014622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6815.014627] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6815.014632] Call Trace:
[ 6815.014650]  <TASK>
[ 6815.014655]  ? apparmor_sk_alloc_security+0x40/0x80
[ 6815.014673]  kmalloc_trace+0x2a/0xa0
[ 6815.014684]  apparmor_sk_alloc_security+0x40/0x80
[ 6815.014694]  security_sk_alloc+0x3f/0x60
[ 6815.014703]  sk_prot_alloc+0x75/0x110
[ 6815.014712]  sk_alloc+0x31/0x200
[ 6815.014721]  inet_create+0xd8/0x3a0
[ 6815.014734]  __sock_create+0x11b/0x220
[ 6815.014749]  __sys_socket_create.part.0+0x49/0x70
[ 6815.014756]  ? __secure_computing+0x94/0xf0
[ 6815.014768]  __sys_socket+0x3c/0xc0
[ 6815.014776]  __x64_sys_socket+0x1a/0x30
[ 6815.014783]  do_syscall_64+0x3b/0x90
[ 6815.014794]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 6815.014804] RIP: 0033:0x7fce59aa795b

 drivers/nvme/host/ioctl.c | 76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..8147750beff4 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -158,6 +158,67 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
+static inline bool nvme_nlb_in_cdw12(u8 opcode)
+{
+	switch (opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+	case nvme_cmd_compare:
+	case nvme_cmd_zone_append:
+		return true;
+	}
+	return false;
+}
+
+static bool nvme_validate_passthru_meta(struct nvme_ns *ns,
+					struct nvme_command *c,
+					__u32 meta_len,
+					unsigned data_len)
+{
+	/*
+	 * User may specify smaller meta-buffer with a larger data-buffer.
+	 * Driver allocated meta buffer will also be small.
+	 * Device can do larger dma into that, overwriting unrelated kernel
+	 * memory.
+	 * For extended lba case, if user provides a short unaligned buffer,
+	 * the device will corrupt kernel memory.
+	 * Avoid running into corruption in both situations.
+	 */
+	bool ext_lba = ns->features & NVME_NS_EXT_LBAS;
+	u16 nlb, control;
+	unsigned dlen, mlen;
+
+	/* Exclude commands that do not have nlb in cdw12 */
+	if (!nvme_nlb_in_cdw12(c->common.opcode))
+		return true;
+
+	control = upper_16_bits(le32_to_cpu(c->common.cdw12));
+	/* Exclude when meta transfer from/to host is not done */
+	if (control & NVME_RW_PRINFO_PRACT && ns->ms == ns->pi_size)
+		return true;
+
+	nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
+	mlen = (nlb + 1) * ns->ms;
+
+	/* sanity for interleaved buffer */
+	if (ext_lba) {
+		dlen = (nlb + 1) << ns->lba_shift;
+		if (data_len < (dlen + mlen))
+			goto out_false;
+		return true;
+	}
+	/* sanity for separate meta buffer */
+	if (meta_len < mlen)
+		goto out_false;
+
+	return true;
+
+out_false:
+	dev_err(ns->ctrl->device,
+		"%s: metadata length is small!\n", current->comm);
+	return false;
+}
+
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, void **metap, struct io_uring_cmd *ioucmd,
@@ -194,6 +255,12 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		bio_set_dev(bio, bdev);
 
 	if (bdev && meta_buffer && meta_len) {
+		if (!nvme_validate_passthru_meta(ns, nvme_req(req)->cmd,
+					meta_len, bufflen)) {
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+
 		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
 				meta_seed);
 		if (IS_ERR(meta)) {
@@ -203,6 +270,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		*metap = meta;
 	}
 
+	/* guard another case when kernel memory is being used */
+	if (bio->bi_private && ns && ns->features & NVME_NS_EXT_LBAS) {
+		if (!nvme_validate_passthru_meta(ns, nvme_req(req)->cmd,
+					meta_len, bufflen)) {
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+	}
+
 	return ret;
 
 out_unmap:
-- 
2.25.1


