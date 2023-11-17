Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D283E7EF38C
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 14:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbjKQNLr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 08:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjKQNLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 08:11:47 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99072D5D
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 05:11:43 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77891c236fcso119456085a.3
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700226702; x=1700831502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaNYB3Xe940CPqgg93YxvAASpaQANrmQi+eqY/SUT/0=;
        b=Bk7PSZp4ttkAnDpGZ3+qY6tqP17+Wmkzs798NGMxeV/1bgUsi8ZwkpYqgas0QomKDb
         VqJ2+4lwvMbpFCGUY+BY+rjdsmT3eOP278jfX8V/w5HRWk/cgY3+sX0u8Bo0K+msTv5O
         /YUWBxZjPpCONeIJ+Zws6prN0AbL3x9IlYEcnG3Puq4luKCp5EOkuFfq9k3LaUnq7rb0
         btkzwM6isrn0u2Ot9jpNT25WxIeq4SFdeOBjCq89ZPm0gYG4DG8a0jJnL4m+40rB1YM3
         R12UdeQjTZSpmK6MAm/Cl25CkWvE8ObAhESOodFViGfxLsIJCKq7gFmDP8kLqvA/gJE0
         FYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226702; x=1700831502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaNYB3Xe940CPqgg93YxvAASpaQANrmQi+eqY/SUT/0=;
        b=IVs9l3hHTqKxtORrLPvVAN68cwof+fgtpR5Qsi//S5cmU5AsoNzYIXpMvHBdxt3JXa
         tkS0S9/ad0RVuQiSEN3V780SX+/A+gQpprVCoztjrjVhbl9KF8rWyIhW1vTssqTFbx1R
         41x129jqF145jzRDiDKLz9sGYYjRdCirp7G7beK0hq3HKo5YOJLdReZKWmqrpySJWVFi
         wveeTzGRzfVsnvywaMHDjpFifwZTs6RlzqKkZDPPy0/K2WdzWBWH/Z6h2yqcNYfOgzz9
         i4CtgkczB6vA6lNuVfNESngIie6zGllrUrrDEzigd7BR8lNHDOMKomVo45ubJ04p6hh9
         doPw==
X-Gm-Message-State: AOJu0YwTE1lz6snoLGt3ZSQ9mmYxXy/SfjIKMiI+5TCKjRzi/OV/gjTS
        e/Q60v/NZupFUGZbtS/ZXEAgZQ==
X-Google-Smtp-Source: AGHT+IGnZW5/wrO7PBGh/UpKLxTkpqN/y74D3x1ti+8qQ4KoF7Qk5FiMI0mhwyrX+gXo9OA7upo0zA==
X-Received: by 2002:a05:620a:269a:b0:77a:1d5b:2ccb with SMTP id c26-20020a05620a269a00b0077a1d5b2ccbmr13000584qkp.6.1700226702773;
        Fri, 17 Nov 2023 05:11:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id x10-20020ae9f80a000000b00767d8e12ce3sm589893qkh.49.2023.11.17.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:11:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r3ydJ-0001jP-R1;
        Fri, 17 Nov 2023 09:11:41 -0400
Date:   Fri, 17 Nov 2023 09:11:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Luo Yuzhang <yuzhang.luo@intel.com>,
        Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Message-ID: <20231117131141.GB6501@ziepe.ca>
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117090933.75267-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 17, 2023 at 05:09:33PM +0800, Lu Baolu wrote:
> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
> invalidating TLBs") moved the secondary TLB invalidations into the TLB
> invalidation functions to ensure that all secondary TLB invalidations
> happen at the same time as the CPU invalidation and added a flush-all
> type of secondary TLB invalidation for the batched mode, where a range
> of [0, -1UL) is used to indicates that the range extends to the end of
> the address space.
> 
> However, using an end address of -1UL caused an overflow in the Intel
> IOMMU driver, where the end address was rounded up to the next page.
> As a result, both the IOTLB and device ATC were not invalidated correctly.
> 
> Add a flush all helper function and call it when the invalidation range
> is from 0 to -1UL, ensuring that the entire caches are invalidated
> correctly.
> 
> Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")
> Cc: stable@vger.kernel.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Tested-by: Luo Yuzhang <yuzhang.luo@intel.com> # QAT
> Tested-by: Tony Zhu <tony.zhu@intel.com> # DSA
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should go to -rc

Jason
