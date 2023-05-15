Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD192702ADA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbjEOKqO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEOKqN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 06:46:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED1B8;
        Mon, 15 May 2023 03:46:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKbXT5xcdz6J6k4;
        Mon, 15 May 2023 18:42:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:46:08 +0100
Date:   Mon, 15 May 2023 11:46:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/hdm: Use 4-byte reads to retrieve HDM decoder
 base+limit
Message-ID: <20230515114607.00004647@Huawei.com>
In-Reply-To: <168149844056.792294.8224490474529733736.stgit@dwillia2-xfh.jf.intel.com>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
        <168149844056.792294.8224490474529733736.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 14 Apr 2023 11:54:00 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The CXL specification mandates that 4-byte registers must be accessed
> with 4-byte access cycles. CXL 3.0 8.2.3 "Component Register Layout and
> Definition" states that the behavior is undefined if (2) 32-bit
> registers are accessed as an 8-byte quantity. It turns out that at least
> one hardware implementation is sensitive to this in practice. The @size
> variable results in zero with:
> 
>     size = readq(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> 
> ...and the correct size with:
> 
>     lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>     hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>     size = (hi << 32) + lo;

Hmm. Annoying that there isn't an always present split version of the
ioread64_hi_lo like there effectively is for hi_low_readq()

Mind you, why was this using the ioread64_hi_lo() variant rather
than hi_lo_readq()?  Far as I can tell that wouldn't have suffered
from this problem in the first place.

There is at least one other direct user of that function, so maybe
we should just use it here as well?

Jonathan

> 
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 35b338b716fe..6fdf7981ddc7 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> @@ -785,8 +784,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
> +	u64 size, base, skip, dpa_size, lo, hi;
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 size, base, skip, dpa_size;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
> @@ -801,8 +800,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  							which, info);
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> -	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> -	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> +	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> +	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(which));
> +	base = (hi << 32) + lo;
> +	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> +	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
> +	size = (hi << 32) + lo;
>  	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
>  	cxld->commit = cxl_decoder_commit;
>  	cxld->reset = cxl_decoder_reset;
> @@ -865,8 +868,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return rc;
>  
>  	if (!info) {
> -		target_list.value =
> -			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> +		target_list.value = (hi << 32) + lo;
>  		for (i = 0; i < cxld->interleave_ways; i++)
>  			target_map[i] = target_list.target_id[i];
>  
> @@ -883,7 +887,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			port->id, cxld->id, size, cxld->interleave_ways);
>  		return -ENXIO;
>  	}
> -	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> +	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> +	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
> +	skip = (hi << 32) + lo;
>  	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
> 

