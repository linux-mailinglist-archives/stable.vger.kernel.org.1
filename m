Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705B27940C5
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbjIFPwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIFPv7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 11:51:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F817BC
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 08:51:50 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230906155146epoutp020da908e52cc6e2e433a986953de9a26b~CWiC0ntuh2258022580epoutp025
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 15:51:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230906155146epoutp020da908e52cc6e2e433a986953de9a26b~CWiC0ntuh2258022580epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694015506;
        bh=sxN51W/pBg4OCNSibW/ZkoB/sWYG6d5RbZNa3rgTCHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GKIE/sf8pYxrDxtLRGOxrLQ8Uk9oiDbnWIG6mvDFKbst8DOMj4eM8U8BM4UPVgKAz
         cRJhxdwzXzEuE4WqUk9rE6YFpXqWM42FWghSCtlKUDmFRmvFdhv3Df6QW2UWOb7au7
         FtVQLwmjShgTuQ3IyOFmcMDWNo3VNBbcSTEZRyFg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230906155145epcas5p4b0bf927e41201a294f84fcf57cb51e2a~CWiCQrYNw1406514065epcas5p4M;
        Wed,  6 Sep 2023 15:51:45 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rgn1D0VK6z4x9Pt; Wed,  6 Sep
        2023 15:51:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.BE.19094.F00A8F46; Thu,  7 Sep 2023 00:51:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230906155143epcas5p1779c6552d70ec247881bdc2da9036c22~CWh-21Att0717307173epcas5p1i;
        Wed,  6 Sep 2023 15:51:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230906155143epsmtrp17573a916c5106d541c2b64bf8f36d1ec~CWh-2KTzh0673606736epsmtrp1h;
        Wed,  6 Sep 2023 15:51:43 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-e3-64f8a00f6a53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.D8.18916.E00A8F46; Thu,  7 Sep 2023 00:51:43 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230906155141epsmtip1f28a5696eaf14079a65994f0d12fdd68~CWh_R9dKp2740727407epsmtip1O;
        Wed,  6 Sep 2023 15:51:41 +0000 (GMT)
Date:   Wed, 6 Sep 2023 21:18:15 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <20230906154815.GA23984@green245>
MIME-Version: 1.0
In-Reply-To: <ZPduqCASmcNxUUep@kbusch-mbp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmhi7/gh8pBvsPWlusufKb3WL13X42
        i5sHdjJZrFx9lMni/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
        Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUdk2GamJKalFCql5yfkpmXnp
        tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
        FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM6a+vc5S8Ne64tz2j2wNjDu0
        uhg5OSQETCRa/pxl7mLk4hAS2MMoMf/LXijnE6PE1yUrWOGcvoufgBwOsJZ1S8oh4jsZJTb+
        m8AKMkpI4BmjxPEf1iA2i4CKxL/LvWwg9WwCmhIXJpeChEUElCXuzp8JNpNZ4C2jxO73r5hB
        EsICQRJL9vexg9i8AroSTY9/sUHYghInZz5hAbE5BbQkfn96zghiiwINOrDtOBPECys5JLY8
        rYGwXSSurd7JCmELS7w6voUdwpaSeNnfBmUnS1yaeQ6qt0Ti8Z6DULa9ROupfrB7mAUyJDb/
        72eFsPkken8/YYL4nVeio00IolxR4t6kp1CrxCUezlgCZXtIXF42FRqIc5gkXi+4xTiBUW4W
        kndmIVkBYVtJdH5oArI5gGxpieX/OCBMTYn1u/QXMLKuYpRKLSjOTU9NNi0w1M1LLYfHcXJ+
        7iZGcMLVCtjBuHrDX71DjEwcjIcYJTiYlUR438l/SxHiTUmsrEotyo8vKs1JLT7EaAqMn4nM
        UqLJ+cCUn1cSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA5O3X7uZ
        sc3tiSs6319ZuTL/fKRruPkTuUM8zxXCo/VWfzh/WuryPe23n261lPIfueT/kseIccOM6v08
        pkkO/tYbFs9jDjdtC7jcJHCmpKixo8efldV3p9hu5g+Kbat0dpYW71STvaVqx87PkdkqtMa2
        bApjX0jJ0STuc0xzk/sqBIIuHfqxgZNXtcHAXktHJeJk5NQ3zPPuei99lXL4i1lE1rOuqXFl
        y752VN5Qd5wt97TULvTPbX3391k1okqsr36kHOdTU8zY+Mr3sZJmDutylYCUrwpVy9kkKo6U
        Lft4Q33GjH8qxpbVzfOPu3jPcjhosSun8qD4Uk2d258f7TUu6tpcs5Q3YM+35pD9SizFGYmG
        WsxFxYkAeyytUkEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnC7/gh8pBtv3MlqsufKb3WL13X42
        i5sHdjJZrFx9lMni/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
        Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZ9/c/
        YCtYb1mx94dDA2OLRhcjB4eEgInEuiXlXYxcHEIC2xkluvauZe9i5ASKi0s0X/sBZQtLrPz3
        nB2i6AmjxMwVB8ASLAIqEv8u97KBDGIT0JS4MLkUJCwioCxxd/5MVpB6ZoG3jBK7379iBkkI
        CwRJLNnfB9bLK6Ar0fT4FxvE0AVMEjuvdrBBJAQlTs58wgJiMwuYSczb/JAZZAGzgLTE8n8c
        IGFOAS2J35+eM4LYokDLDmw7zjSBUXAWku5ZSLpnIXQvYGRexSiaWlCcm56bXGCoV5yYW1ya
        l66XnJ+7iREcOVpBOxiXrf+rd4iRiYPxEKMEB7OSCO87+W8pQrwpiZVVqUX58UWlOanFhxil
        OViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUyKN2besxW981RxWfyMdSvZ9qRkp/nzm8ma
        fTwo5vk9t+SgVBHz2cffs0W+aLLF+vT0s0970vF+0aa1F8I3SOyqfKJo/fbZ+m8R69KSd1l3
        mO00Uo9WONWzpuXH5cVsCzTvvPrxcOHt5qN/lB3fTevenLu3uLn0q+oLmUNuPfuvTXYzrAwI
        nZnlJrHx66ySK18OSDvP82XxqlK+o5SuMmfJhDiDlP/NKSnbOI3N/s9MfnZVzvukPA/D85kf
        WKJmXhYU2/Sown/Ljp9PbpQcO1YW0rhi5asv2glT959Mn8qwaA6vzsuH36a3HV/6c6/i1MUf
        hAUi1zyMYnrxpkxo3oKk12t67Q/qZch71HK8yaryVGIpzkg01GIuKk4EAAo2J4gLAwAA
X-CMS-MailID: 20230906155143epcas5p1779c6552d70ec247881bdc2da9036c22
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_c7280_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9
References: <20230814070213.161033-1-joshi.k@samsung.com>
        <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
        <20230814070213.161033-2-joshi.k@samsung.com> <ZPH5Hjsqntn7tBCh@kbusch-mbp>
        <20230905051825.GA4073@green245> <ZPduqCASmcNxUUep@kbusch-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_c7280_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Sep 05, 2023 at 12:08:40PM -0600, Keith Busch wrote:
>On Tue, Sep 05, 2023 at 10:48:25AM +0530, Kanchan Joshi wrote:
>> On Fri, Sep 01, 2023 at 10:45:50AM -0400, Keith Busch wrote:
>> > And similiar to this problem, what if the metadata is extended rather
>> > than separate, and the user's buffer is too short? That will lead to the
>> > same type of problem you're trying to fix here?
>>
>> No.
>> For extended metadata, userspace is using its own buffer. Since
>> intermediate kernel buffer does not exist, I do not have a problem to
>> solve.
>
>We still use kernel memory if the user buffer is unaligned. If the user
>space provides an short unaligned buffer, the device will corrupt kernel
>memory.

Ah yes. blk_rq_map_user_iov() does make a copy of user-buffer in that
case.

>> > My main concern, though, is forward and backward compatibility. Even
>> > when metadata is enabled, there are IO commands that don't touch it, so
>> > some tool that erroneously requested it will stop working. Or perhaps
>> > some other future opcode will have some other metadata use that doesn't
>> > match up exactly with how read/write/compare/append use it. As much as
>> > I'd like to avoid bad user commands from crashing, these kinds of checks
>> > can become problematic for maintenance.
>>
>> For forward compatibility - if we have commands that need to specify
>> metadata in a different way (than what is possible from this interface),
>> we anyway need a new passthrough command structure.
>
>Not sure about that. The existing struct is flexible enough to describe
>any possible nvme command.
>
>More specifically about compatibility is that this patch assumes an
>"nlb" field exists inside an opaque structure at DW12 offset, and that
>field defines how large the metadata buffer needs to be. Some vendor
>specific or future opcode may have DW12 mean something completely
>different, but still need to access metadata this patch may prevent from
>working.

Right. It almost had me dropping the effort.
But given the horrible bug at hand, added an untested patch [1] that
handles all the shortcomings you mentioned. Please take a look.

>> Moreover, it's really about caring _only_ for cases when kernel
>> allocates
>> memory for metadata. And those cases are specific (i.e., when
>> metadata and metalen are not zero). We don't have to think in terms of
>> opcode (existing or future), no?
>
>It looks like a little work, but I don't see why blk-integrity must use
>kernel memory. Introducing an API like 'bio_integrity_map_user()' might
>also address your concern, as long as the user buffer is aligned. It
>sounds like we're assuming user buffers are aligned, at least.

Would you really prefer to have nvme_add_user_metadata() changed to do
away with allocation and use userspace meta-buffer directly?
Even with that route, extended-lba-with-short-unaligned-buffer remains 
unhandled. That will still require similar checks that I would like
to avoid but cannnot.

So how about this -

[1]
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..d09b5691da3e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -320,6 +320,67 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
                        meta_len, lower_32_bits(io.slba), NULL, 0, 0);
 }

+static inline bool nvme_nlb_in_cdw12(u8 opcode)
+{
+       switch(opcode) {
+               case nvme_cmd_read:
+               case nvme_cmd_write:
+               case nvme_cmd_compare:
+               case nvme_cmd_zone_append:
+                       return true;
+       }
+       return false;
+}
+
+static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
+                                       struct nvme_ns *ns,
+                                       struct nvme_command *c,
+                                       __u64 meta, __u32 meta_len,
+                                       unsigned data_len)
+{
+       /*
+        * User may specify smaller meta-buffer with a larger data-buffer.
+        * Driver allocated meta buffer will also be small.
+        * Device can do larger dma into that, overwriting unrelated kernel
+        * memory.
+        */
+       if (ns && (meta_len || meta || ns->features & NVME_NS_EXT_LBAS)) {
+               u16 nlb, control;
+               unsigned dlen, mlen;
+
+               /* Exclude commands that do not have nlb in cdw12 */
+               if (!nvme_nlb_in_cdw12(c->common.opcode))
+                       return true;
+
+               control = upper_16_bits(le32_to_cpu(c->common.cdw12));
+               /* Exclude when meta transfer from/to host is not done */
+               if (control & NVME_RW_PRINFO_PRACT && ns->ms == ns->pi_size)
+                       return true;
+
+               nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
+               mlen = (nlb + 1) * ns->ms;
+
+               /* sanity for interleaved buffer */
+               if (ns->features & NVME_NS_EXT_LBAS) {
+                       dlen = (nlb + 1) << ns->lba_shift;
+                       if (data_len < (dlen + mlen))
+                               goto out_false;
+                       return true;
+               }
+               /* sanity for separate meta buffer */
+               if (meta_len < mlen)
+                       goto out_false;
+
+               return true;
+out_false:
+               dev_err(ctrl->device,
+                       "%s: metadata length is small!\n", current->comm);
+               return false;
+       }
+
+       return true;
+}
+
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
                                        struct nvme_ns *ns, __u32 nsid)
 {
@@ -364,6 +425,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
        c.common.cdw14 = cpu_to_le32(cmd.cdw14);
        c.common.cdw15 = cpu_to_le32(cmd.cdw15);

+       if (!nvme_validate_passthru_meta(ctrl, ns, &c, cmd.metadata,
+                                        cmd.metadata_len, cmd.data_len))
+               return -EINVAL;
+
        if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
                return -EACCES;

@@ -411,6 +476,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
        c.common.cdw14 = cpu_to_le32(cmd.cdw14);
        c.common.cdw15 = cpu_to_le32(cmd.cdw15);

+       if (!nvme_validate_passthru_meta(ctrl, ns, &c, cmd.metadata,
+                                        cmd.metadata_len, cmd.data_len))
+               return -EINVAL;
+
        if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
                return -EACCES;

@@ -593,6 +662,10 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
        d.metadata_len = READ_ONCE(cmd->metadata_len);
        d.timeout_ms = READ_ONCE(cmd->timeout_ms);

+       if (!nvme_validate_passthru_meta(ctrl, ns, &c, d.metadata,
+                                        d.metadata_len, d.data_len))
+               return -EINVAL;
+
        if (issue_flags & IO_URING_F_NONBLOCK) {
                rq_flags |= REQ_NOWAIT;
                blk_flags = BLK_MQ_REQ_NOWAIT;
--
2.25.1

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_c7280_
Content-Type: text/plain; charset="utf-8"


------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_c7280_--
