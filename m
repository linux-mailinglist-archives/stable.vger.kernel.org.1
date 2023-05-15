Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AABB702AB2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbjEOKiS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEOKiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 06:38:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD219D;
        Mon, 15 May 2023 03:38:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKbQ510GYz67lhG;
        Mon, 15 May 2023 18:36:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:38:14 +0100
Date:   Mon, 15 May 2023 11:38:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/hdm: Fail upon detecting 0-sized decoders
Message-ID: <20230515113813.00003eb1@Huawei.com>
In-Reply-To: <168149843516.792294.11872242648319572632.stgit@dwillia2-xfh.jf.intel.com>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
        <168149843516.792294.11872242648319572632.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Fri, 14 Apr 2023 11:53:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Decoders committed with 0-size lead to later crashes on shutdown as
> __cxl_dpa_release() assumes a 'struct resource' has been established in
> the in 'cxlds->dpa_res'. Just fail the driver load in this instance
> since there are deeper problems with the enumeration or the setup when
> this happens.
> 
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

What happened to these?  Seem not to have gone upstream yet.

This seems reasonable to me as well

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 02cc2c38b44b..35b338b716fe 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -269,8 +269,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
> -	if (!len)
> -		goto success;
> +	if (!len) {
> +		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
> +			 port->id, cxled->cxld.id);
> +		return -EINVAL;
> +	}
>  
>  	if (cxled->dpa_res) {
>  		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
> @@ -323,7 +326,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		cxled->mode = CXL_DECODER_MIXED;
>  	}
>  
> -success:
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
>  	return 0;
> @@ -833,6 +835,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  				 port->id, cxld->id);
>  			return -ENXIO;
>  		}
> +
> +		if (size == 0) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Committed with zero size\n",
> +				 port->id, cxld->id);
> +			return -ENXIO;
> +		}
>  		port->commit_end = cxld->id;
>  	} else {
>  		/* unless / until type-2 drivers arrive, assume type-3 */
> 

