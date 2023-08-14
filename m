Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E095C77B209
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 09:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjHNHGH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjHNHF5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 03:05:57 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8EE65
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 00:05:54 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230814070551epoutp018153faafb05307432432f296f8d38a5b~7LhTM1VRg0130501305epoutp01O
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 07:05:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230814070551epoutp018153faafb05307432432f296f8d38a5b~7LhTM1VRg0130501305epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691996751;
        bh=o9N27HS0IKGas7IN3ghJxg+CtlGoLVttaBdOjLYjBKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrJZY7/RrMkOYtVXoQFDyP7davLV90eqIpAvDfnM57fFBXnNfErxm0kbRnZKtHi1R
         zTv6kETQhE3vlnUVKTLDsMpjZlkx5tUdkLcxJhyjUajd3/JCDSKykMIrIjGF3a0cgU
         KzQs1XgwDlsFkRp1uMdBg2LRskRr8WupQNCJgADk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230814070550epcas5p43cc1ac4f20933a49cb79bcdb1f0bd522~7LhSRHQAG3085130851epcas5p4T;
        Mon, 14 Aug 2023 07:05:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RPQR11Fvqz4x9Pr; Mon, 14 Aug
        2023 07:05:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.51.44250.D42D9D46; Mon, 14 Aug 2023 16:05:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9~7LhQP3j270297102971epcas5p3d;
        Mon, 14 Aug 2023 07:05:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814070548epsmtrp1d8289a85b241ec2398873d0a8a94cd21~7LhQPCu1H0038000380epsmtrp1k;
        Mon, 14 Aug 2023 07:05:48 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-1a-64d9d24d5f00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.B8.64355.C42D9D46; Mon, 14 Aug 2023 16:05:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814070546epsmtip2ae149f0c4361375a786eba8fd2232b56~7LhOdlut12323723237epsmtip29;
        Mon, 14 Aug 2023 07:05:46 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>, stable@vger.kernel.org,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH v2 1/2] nvme: fix memory corruption for passthrough metadata
Date:   Mon, 14 Aug 2023 12:32:12 +0530
Message-Id: <20230814070213.161033-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814070213.161033-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmpq7vpZspBqeusFmsufKb3WL13X42
        i5sHdjJZrFx9lMni6P+3bBbn3x5msph06BqjxfxlT9kt1r1+z2KxYOMjRovH3R2MFhvaBB14
        PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j74tqxg9Pm+SC+CIyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsaA9o6BTqOJT91Tm
        BsbbfF2MnBwSAiYSb9aeYuli5OIQEtjNKNG9+T0bhPOJUWLPtGtMcM65w7fYYFqO7+2DSuxk
        lLh44gyU85lRou1vP9AwDg42AU2JC5NLQRpEBFwkGv69YQSpYRZ4zCixo/ceE0hCWMBHYtX7
        FmYQm0VAVeLUqeusIDavgKXEwd1PWSG2yUvMvPSdHcTmFLCSeLJkKwtEjaDEyZlPwGxmoJrm
        rbOZQRZICEzlkLi05hzUqS4Sb99tYIGwhSVeHd/CDmFLSbzsb4OykyUuzTzHBGGXSDzecxDK
        tpdoPdXPDPIMM9Az63fpQ+zik+j9/YQJJCwhwCvR0SYEUa0ocW8SzMniEg9nLIGyPSQuL5vK
        DAmfXkaJJ9vfM01glJ+F5IVZSF6YhbBtASPzKkbJ1ILi3PTUYtMCo7zUcnjEJufnbmIEJ1kt
        rx2MDx980DvEyMTBeIhRgoNZSYT3lvu1FCHelMTKqtSi/Pii0pzU4kOMpsAwnsgsJZqcD0zz
        eSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MK2R1O9o89c0tZji
        Ile8gyHkzP7oswcVnVgk5lxTvC41z3Xduw12K/cH3vnk/NF9Q4+OsKxay4uPBS4z5MT9o28z
        /F4tLsmhuyT8RPcFCd4D4j9Cm81LbTNPu5nmCbnc+53CrCSslcx81ZabZ3515ZWVO/s/6Xjv
        1exbtjDKtfNlxM9jfT9UOHO8//VovHC4IJHmKnov7/JtJbkn1/Tsp4e+zin+tFYvW+LSRufL
        SVd0Nu0vVKwIWiC0c1Um21b+faY/jHZyHwgNfOSyb8enWL9JfCZqpr28jvbb8zsZuL0aN+gk
        R9h3Z3nOUJ/12LQgbD+PVv7fZb4zGXbU9+q9iZw3SVbDQSJVIkZJuEOJpTgj0VCLuag4EQAb
        8ugzOwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvK7PpZspBoe/KlmsufKb3WL13X42
        i5sHdjJZrFx9lMni6P+3bBbn3x5msph06BqjxfxlT9kt1r1+z2KxYOMjRovH3R2MFhvaBB14
        PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL
        4MpY0J5R0ClU8al7KnMD422+LkZODgkBE4nje/uYQGwhge2MEhevpEDExSWar/1gh7CFJVb+
        e84OUfORUeLQbKsuRg4ONgFNiQuTS0HCIgJeEvNmL2DpYuTiYBZ4zSixo387I0hCWMBHYtX7
        FmYQm0VAVeLUqeusIDavgKXEwd1PWSHmy0vMvPQdbD6ngJXEkyVbWSB2WUqs3/aGEaJeUOLk
        zCdgcWag+uats5knMArMQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwTGgF
        7WBctv6v3iFGJg7GQ4wSHMxKIry33K+lCPGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJI
        TyxJzU5NLUgtgskycXBKNTBlrvWZmxkmOIPN3tdRtuFLneEhp0+f1s981VLSH6Y35esUtaWf
        hDnftCQZGMqF++gfOVG6Z80a3tTdrlv7V8X+tHe/PHfdrA8Rhfuyz9WKFEn37Ew5dqgs/0Wm
        7Hppti2yc8obtW89bPrhovD185QH/S6vXfyTN4vkSU61ie1X3t7RtmlqLS/XBkULntfms2o8
        +BUFnri7pyVqHZ1vf8Lj6rep31b83z3R1njOsos//f+XWb3SPCAYHsPj2OCykzH1T9/a5u72
        t18fr5UPunmY8b/Whdh5sqEZ06ocLMX4Vt864Z209fs8yVb7TEe/vgMSLOvUW78nPvO4X2Tu
        m3j6g+jPstlS5SaeUVLX+JRYijMSDbWYi4oTAY4y7E74AgAA
X-CMS-MailID: 20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9
References: <20230814070213.161033-1-joshi.k@samsung.com>
        <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
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
wired to update/access.
This may lead to Device doing a larger DMA operation, overwriting
unrelated kernel memory.

Detect this situation for uring passthrough, and bail out.

Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device")
Cc: stable@vger.kernel.org

Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 19a5177bc360..717c7effaf8a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -320,6 +320,35 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			meta_len, lower_32_bits(io.slba), NULL, 0, 0);
 }
 
+static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
+					struct nvme_ns *ns,
+					struct nvme_command *c,
+					__u64 meta, __u32 meta_len)
+{
+	/*
+	 * User may specify smaller meta-buffer with a larger data-buffer.
+	 * Driver allocated meta buffer will also be small.
+	 * Device can do larger dma into that, overwriting unrelated kernel
+	 * memory.
+	 */
+	if (ns && (meta_len || meta)) {
+		u16 nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
+		u16 control = upper_16_bits(le32_to_cpu(c->common.cdw12));
+
+		/* meta transfer from/to host is not done */
+		if (control & NVME_RW_PRINFO_PRACT && ns->ms == ns->pi_size)
+			return true;
+
+		if (meta_len != (nlb + 1) * ns->ms) {
+			dev_err(ctrl->device,
+			"%s: metadata length does not match!\n", current->comm);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 					struct nvme_ns *ns, __u32 nsid)
 {
@@ -593,6 +622,10 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	d.metadata_len = READ_ONCE(cmd->metadata_len);
 	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
 
+	if (!nvme_validate_passthru_meta(ctrl, ns, &c, d.metadata,
+					 d.metadata_len))
+		return -EINVAL;
+
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
-- 
2.25.1

