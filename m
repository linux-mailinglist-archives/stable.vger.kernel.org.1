Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45B7C8646
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJMM77 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjJMM76 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 08:59:58 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4780091
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 05:59:55 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231013125951epoutp015fb4323365e50d2505ee3e3982ea1010~NrDgQ7crS0542705427epoutp01d
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 12:59:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231013125951epoutp015fb4323365e50d2505ee3e3982ea1010~NrDgQ7crS0542705427epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697201991;
        bh=TKIiPUmyywZhEsW5y0fQlovn9ZFouy9MMT4n7zbYVBI=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=RyPzw0lyihz2jalWcH1yTD+J7cxTziWTc8vcPKPujpU3jM/ZhhrIYwp2BTJx0KPwN
         7D2AYHaJxuNG5A+AuugZstU5+C++m/kWyTap9YpOwtHZEahs6HNbptOTPvbxRLsEwy
         /JnPBm6qe4vrXsRCTNls0HVK4DObDAVCaybwy/rQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231013125950epcas5p176abba3a7a097477a4e0d0857d98c833~NrDfN363k1189111891epcas5p1W;
        Fri, 13 Oct 2023 12:59:50 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S6RRm2qxQz4x9Pw; Fri, 13 Oct
        2023 12:59:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.B8.09023.44F39256; Fri, 13 Oct 2023 21:59:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231013125948epcas5p3de28d9567c76e2154ce2b3ec541bde70~NrDdIGYfg1321613216epcas5p3z;
        Fri, 13 Oct 2023 12:59:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231013125948epsmtrp2a30e33caf6650bc6134c5311e31f3661~NrDdHYSUo0786007860epsmtrp2W;
        Fri, 13 Oct 2023 12:59:48 +0000 (GMT)
X-AuditID: b6c32a44-a21ff7000000233f-a7-65293f449ded
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.BD.08788.34F39256; Fri, 13 Oct 2023 21:59:47 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231013125946epsmtip2cca18da36be9384753a75f032d6217f3~NrDbowFKe0987809878epsmtip2-;
        Fri, 13 Oct 2023 12:59:46 +0000 (GMT)
Message-ID: <f8b41c49-5e1d-3ffc-3d13-214d4b191a30@samsung.com>
Date:   Fri, 13 Oct 2023 18:29:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Content-Language: en-US
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
In-Reply-To: <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmuq6LvWaqQd8dIYs1V36zW6y+289m
        sXL1USaL828PM1lMOnSN0WL+sqfsFutev2exWLDxEaPF4+4ORosNbYIOXB47Z91l9zh/byOL
        x+WzpR6bVnWyeWxeUu+x+2YDm0ffllWMHp83yQVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzvi08T5LwQTpin0nz7M1MO4V6mLk5JAQ
        MJF4tvcdSxcjF4eQwG5GiUkdk5lBEkICnxgl9pwXhkh8Y5R42z+REabjyZxLbBCJvYwS/290
        sUI4bxklHi26xg5SxStgJ7HxWz8riM0ioCrxf/YqJoi4oMTJmU9YQGxRgSSJX1fngE0VFnCT
        mLJ6CdhqZgFxiVtP5gPVc3CwCWhKXJhcChIWEVCSePrqLCNEyT1GiYW3zUFKOAXsJe6tFIII
        y0tsfzuHGeQcCYEtHBJPug8yQRztIrH6cy8zhC0s8er4FnYIW0ri87u9bBB2ssSlmeeg6ksk
        Hu+B6bWXaD3VzwyyixnonPW79CF28Un0/n4CdqWEAK9ERxs0QBUl7k16ygphi0s8nLEEyvaQ
        2LH5NjSgHzBK7Ht2mmkCo8IspECZheT5WUjemYWweQEjyypGydSC4tz01GTTAsO81HJ4dCfn
        525iBCdfLZcdjDfm/9M7xMjEwXiIUYKDWUmEd3acRqoQb0piZVVqUX58UWlOavEhRlNg7Exk
        lhJNzgem/7ySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGphSlyVV
        +VsGrhaYvPL13sAmc4+Oe/8q7j7qz6tVOKD5/eKD9MntD0XW2mxxSwr/rFShnrno98v6afYz
        /vErdVROkL7PoKp+5NmZ4ll/q6stHK7x3Hzx9mVI9gJjvcw1OhaWk5P5J+b0yWzK3VV680Ff
        U7iDv9OUvYd+y6bUTzA5+fDXxuIdW5S3JuquE7vOG7PO1OMxo+DGv/c5P7z78+3/Zv6zl/a9
        u3TE87d46YRDOZ8/N148JleSNC3g+KkjK9t3/73xsXvlZkVZo0PVbB4LK0Lv8rV6Lkjrfnos
        KPnCoUtqWpw8Eb/EP59imeakydBu8j6C8aJnS72y5ZKO2bvm/C60OCbwt2C7SsLifTZXlFiK
        MxINtZiLihMBGu3GZkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK6zvWaqwfrPphZrrvxmt1h9t5/N
        YuXqo0wW598eZrKYdOgao8X8ZU/ZLda9fs9isWDjI0aLx90djBYb2gQduDx2zrrL7nH+3kYW
        j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+LTxPkvBBOmK
        fSfPszUw7hXqYuTkkBAwkXgy5xJbFyMXh5DAbkaJXdMPs0MkxCWar/2AsoUlVv57zg5R9JpR
        YuWck0wgCV4BO4mN3/pZQWwWAVWJ/7NXQcUFJU7OfMICYosKJEnsud8IFhcWcJOYsnoJM4jN
        DLTg1pP5QHEODjYBTYkLk0tBwiICShJPX51lBNnFLHCPUeLul51Qix8wSmz6eoYNpIFTwF7i
        3kohiDlmEl1buxghbHmJ7W/nME9gFJqF5IxZSNbNQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp
        5XrFibnFpXnpesn5uZsYwdGmpbWDcc+qD3qHGJk4GA8xSnAwK4nwzo7TSBXiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFMlomDU6qBqf5xqMbWvC935k9Zzr5ywvLl
        yQ/er5Iuc7v4+laQf+aLM8sumkaqTrXzfqtanRyz4M9VBivDham+S6J7GrneLc6ZrlgRcCf8
        yV2OxzGhX+4LZbjl/Dz0K+ScB0d7sHNCSpKz0xM2IQY7gz931i56FnVWRCHxRufyOUvrJ9pd
        YU0Natd1X+W4TCyBXXjdsXfvBPnkApbFH1HkeOu4Krovn+vAi1f1nGXz/x1yb4wKmBHBzBN/
        KMHuN+cRYytR4+DeRw75/7pk7x/YtXHq4vlGBdOOPtzx0OWc4s/oWcllnpvaPzkk3FlsInvO
        WHL7x6k3pVb+Cyiw/b3W9zSHWIwMm6fTue5j0l7PVdyvPnk3VYmlOCPRUIu5qDgRAGOve4Ql
        AwAA
X-CMS-MailID: 20231013125948epcas5p3de28d9567c76e2154ce2b3ec541bde70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
        <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
        <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/13/2023 3:44 PM, Kanchan Joshi wrote:
> On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
>> On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
>>> Changes since v3:
>>> - Block only unprivileged user
>>
>> That's not really what at least I had in mind.  I'd much rather
>> completely disable unprivileged passthrough for now as an easy
>> backportable patch.  And then only re-enable it later in a way
>> where it does require using SGLs for all data transfers.
>>
> 
> I did not get how forcing SGLs can solve the issue at hand.
> The problem happened because (i) user specified short buffer/len, and
> (ii) kernel allocated buffer. Whether the buffer is fed to device using
> PRP or SGL does not seem to solve the large DMA problem.
> 

FWIW, this is the test-patch I wrote to force passthrough to use SGL.

---
  drivers/nvme/host/ioctl.c | 2 ++
  drivers/nvme/host/nvme.h  | 1 +
  drivers/nvme/host/pci.c   | 8 +++++---
  3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..508a813b349e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -202,6 +202,8 @@ static int nvme_map_user_request(struct request 
*req, u64 ubuffer,
                 }
                 *metap = meta;
         }
+       /* force sgl for data transfer */
+       nvme_req(req)->flags |= NVME_REQ_FORCE_SGL;

         return ret;

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..9fe91d25cfdd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -184,6 +184,7 @@ enum {
         NVME_REQ_CANCELLED              = (1 << 0),
         NVME_REQ_USERCMD                = (1 << 1),
         NVME_MPATH_IO_STATS             = (1 << 2),
+       NVME_REQ_FORCE_SGL              = (1 << 3),
  };

  static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60a08dfe8d75..e28d3b7b14ef 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -772,18 +772,20 @@ static blk_status_t nvme_map_data(struct nvme_dev 
*dev, struct request *req,
         struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
         blk_status_t ret = BLK_STS_RESOURCE;
         int rc;
+       bool force_sgl = nvme_req(req)->flags & NVME_REQ_FORCE_SGL;

         if (blk_rq_nr_phys_segments(req) == 1) {
                 struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
                 struct bio_vec bv = req_bvec(req);

                 if (!is_pci_p2pdma_page(bv.bv_page)) {
-                       if (bv.bv_offset + bv.bv_len <= 
NVME_CTRL_PAGE_SIZE * 2)
+                       if (!force_sgl &&
+                           bv.bv_offset + bv.bv_len <= 
NVME_CTRL_PAGE_SIZE * 2)
                                 return nvme_setup_prp_simple(dev, req,
                                                              &cmnd->rw, 
&bv);

-                       if (nvmeq->qid && sgl_threshold &&
-                           nvme_ctrl_sgl_supported(&dev->ctrl))
+                       if (nvmeq->qid && 
nvme_ctrl_sgl_supported(&dev->ctrl)
+                           && (sgl_threshold || force_sgl))
                                 return nvme_setup_sgl_simple(dev, req,
                                                              &cmnd->rw, 
&bv);
                 }

