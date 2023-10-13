Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7FE7C7D14
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 07:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJMFhy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 01:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMFhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 01:37:54 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C5AB7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:37:51 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231013053749epoutp046daeb0280a746e0879d2d3b2b8e0d6b2~NlBj-f4zM0866908669epoutp044
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 05:37:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231013053749epoutp046daeb0280a746e0879d2d3b2b8e0d6b2~NlBj-f4zM0866908669epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697175469;
        bh=KFKMEg2XvMXKK/E1o39l+C0+QC+Wp+czd9E2G8mf2k4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=SGklsgosiGYw0zTITkTbAIEPYhdpAcUzvArtCnv+z29QU67Q3+FOb4fnSVdFwKmYW
         C6bcI5BIWo3BxpN8bEaPalzS/j47+Y/g/h24ILfqLdjyWNdsDgkixjpt5IbyNo2I1f
         EgDlmCP85mBA2de5Zfm2GPQ1ezx9yppxhZRY/meY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231013053748epcas5p4c579089351a52bcca5f6f19fbca62f52~NlBjKmMYR3091430914epcas5p4B;
        Fri, 13 Oct 2023 05:37:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S6Fdl0c3Mz4x9QF; Fri, 13 Oct
        2023 05:37:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.C6.09635.AA7D8256; Fri, 13 Oct 2023 14:37:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231013053746epcas5p346f83c8f2f5360fb24016203488f0d93~NlBhQheci2512425124epcas5p3-;
        Fri, 13 Oct 2023 05:37:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231013053746epsmtrp23d6557ad0989eedf81042ed6b6b01b4a~NlBhPPmv01860218602epsmtrp28;
        Fri, 13 Oct 2023 05:37:46 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-f2-6528d7aa3a88
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.69.08788.AA7D8256; Fri, 13 Oct 2023 14:37:46 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231013053744epsmtip11757947b0611679a48617ddb63693022~NlBfQIhCj2323823238epsmtip1a;
        Fri, 13 Oct 2023 05:37:44 +0000 (GMT)
Message-ID: <7f576621-7288-1b06-9694-8bc0b6ad1813@samsung.com>
Date:   Fri, 13 Oct 2023 11:07:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231013052612.GA6423@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmlu7q6xqpBr3HGS3WXPnNbrH6bj+b
        xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7FYsHGR4wWj7s7GC02tAk6cHnsnHWX3eP8vY0s
        HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PDgTtsBSeYK6bdusnWwPiSqYuRk0NC
        wETi2Lm17F2MXBxCArsZJXZ2XGaFcD4xSsya3sIE4XxjlDh44xMbTMuTfd8ZIRJ7GSX2Tu5i
        hnDeMkocaT3FCFLFK2AnMX/aZxYQm0VAVWL+wZ9sEHFBiZMzn4DFRQWSJH5dnQNWLyzgJjFl
        9RJmEJtZQFzi1pP5YAeKCChJPH11lhEifo9RYuFt8y5GDg42AU2JC5NLQcKcAtoSu3e/Y4Eo
        kZfY/nYO2D0SAls4JF5f+sMOUi8h4CLRti4C4gFhiVfHt7BD2FISn9/thXosWeLSzHPQcCmR
        eLznIJRtL9F6qp8ZZAwz0Nr1u/QhVvFJ9P5+wgQxnVeio00IolpR4t6kp6wQtrjEwxlLoGwP
        iR2bb7NAQmo1o8SiFauZJzAqzEIKlFlInp+F5JtZCJsXMLKsYpRMLSjOTU8tNi0wzksth8d3
        cn7uJkZw+tXy3sH46MEHvUOMTByMhxglOJiVRHhnx2mkCvGmJFZWpRblxxeV5qQWH2I0BcbO
        RGYp0eR8YAbIK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBKbLm
        tHtZCVfPxp1FvFu3HBQ5bsJhe+xe1ySBua3fDML09rwSCDDl3BDLbDSxZsmT+KUSJjPiurVa
        f28u/n/yAc/qsN8LS1n+uLSkCTFkH/hj4X9kTYQWG6f051n3v6auTe+wDNuuvrjquqH2V4M/
        L8RbBRcnX5BL3cRmz8Pht/Zi7prCvm0yGX197p6n5xX+j954oMSO0fazt8GkeR+3fZbS/WPW
        HNI6K5eTTfVtZ/2lPUwvAqa63xVw/mXUa9v0KWCrZpDVTv4JgQUyBXfWGtavL/EO/PNo3g/7
        Oa9TNB+6e75ofrXwjV9GzsO6X6EsjAbropIdTLc4cbB+KpM35tsbfpLzQ+2X9Nernq5QYinO
        SDTUYi4qTgQAKKJCkkgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO6q6xqpBj/OqVusufKb3WL13X42
        i5WrjzJZnH97mMli0qFrjBbzlz1lt1j3+j2LxYKNjxgtHnd3MFpsaBN04PLYOesuu8f5extZ
        PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr48OBO2wFJ5gr
        pt26ydbA+JKpi5GTQ0LAROLJvu+MXYxcHEICuxklLq/5ygKREJdovvaDHcIWllj57zk7RNFr
        Rokdn1+wgSR4Bewk5k/7DNbAIqAqMf/gT6i4oMTJmU/A4qICSRJ77jeCbRMWcJOYsnoJM4jN
        DLTg1pP5YHERASWJp6/Ogl3BLHCPUeLul51Q21YzStyZ9wtoEgcHm4CmxIXJpSANnALaErt3
        v2OBGGQm0bW1ixHClpfY/nYO8wRGoVlI7piFZN8sJC2zkLQsYGRZxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHG9aWjsY96z6oHeIkYmD8RCjBAezkgjv7DiNVCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqYdLJWLPZiP3NgG8OGtBPOmreE
        5p23Oh0d88l0z0Ojo0IGPQrcM/dXWFzN2/c1zGNTbpPKvBjr99l7Pkr99Mlaa3CKVebDN2tT
        r18iisWsNk8XPzw1u+fvszg1Ya0Gxhcn/+252ZJ86fPyW+VnvuwKNuIxTV3Rnv6eT3GtFFt+
        vVuZiuX2nfGBde5fZld4ek2e93PLjSr7K3kSZhLW4t6zmaoe/BbaU+bDf8ZBsKN21+PVk51P
        HMzvevrV8uHaa1v0OdkaTx/fcWLx5GkaMm+DGErOpJSejgpl74+ReHCp8bscz4e8XofifUFe
        bkYlhQankyT1zpzatjlq9gqxAzICzOvKVmvFaDIGlyzd03RViaU4I9FQi7moOBEA1gxYNCYD
        AAA=
X-CMS-MailID: 20231013053746epcas5p346f83c8f2f5360fb24016203488f0d93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
        <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
> On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
>> Changes since v3:
>> - Block only unprivileged user
> 
> That's not really what at least I had in mind.  I'd much rather
> completely disable unprivileged passthrough for now as an easy
> backportable patch.  

As you deem fit, but I think even this will be bakported upto the patch 
that introduced unprivileged passthrough.

