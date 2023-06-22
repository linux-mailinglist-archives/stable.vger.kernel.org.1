Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAFC739D4A
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjFVJdA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFVJbW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:31:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70014EF3;
        Thu, 22 Jun 2023 02:23:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qmvwc2Hmcz6GCX1;
        Thu, 22 Jun 2023 17:20:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 10:22:59 +0100
Date:   Thu, 22 Jun 2023 10:22:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH] Revert "cxl/port: Enable the HDM decoder capability for
 switch ports"
Message-ID: <20230622102258.00004475@Huawei.com>
In-Reply-To: <76058d75-65c5-f5bf-eeb6-ff8585530af7@intel.com>
References: <168685882012.3475336.16733084892658264991.stgit@dwillia2-xfh.jf.intel.com>
        <76058d75-65c5-f5bf-eeb6-ff8585530af7@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 15 Jun 2023 16:37:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/15/23 12:53, Dan Williams wrote:
> > commit eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")
> > 
> > ...was added on the observation of CXL memory not being accessible after
> > setting up a region on a "cold-plugged" device. A "cold-plugged" CXL
> > device is one that was not present at boot, so platform-firmware/BIOS
> > has no chance to set it up.
> > 
> > While it is true that the debug found the enable bit clear in the
> > host-bridge's instance of the global control register (CXL 3.0
> > 8.2.4.19.2 CXL HDM Decoder Global Control Register), that bit is
> > described as:
> > 
> > "This bit is only applicable to CXL.mem devices and shall
> > return 0 on CXL Host Bridges and Upstream Switch Ports."
> > 
> > So it is meant to be zero, and further testing confirmed that this "fix"
> > had no effect on the failure. Revert it, and be more vigilant about
> > proposed fixes in the future. Since the original copied stable@, flag
> > this revert for stable@ as well.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note we also dropped the 'fix' from the QEMU emulation.

Thanks,

Jonathan

> > ---
> >   drivers/cxl/core/pci.c        |   27 ++++-----------------------
> >   drivers/cxl/cxl.h             |    1 -
> >   drivers/cxl/port.c            |   14 +++++---------
> >   tools/testing/cxl/Kbuild      |    1 -
> >   tools/testing/cxl/test/mock.c |   15 ---------------
> >   5 files changed, 9 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 7440f84be6c8..552203c13b39 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -308,36 +308,17 @@ static void disable_hdm(void *_cxlhdm)
> >   	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> >   }
> >   
> > -int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
> > +static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
> >   {
> > -	void __iomem *hdm;
> > +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> >   	u32 global_ctrl;
> >   
> > -	/*
> > -	 * If the hdm capability was not mapped there is nothing to enable and
> > -	 * the caller is responsible for what happens next.  For example,
> > -	 * emulate a passthrough decoder.
> > -	 */
> > -	if (IS_ERR(cxlhdm))
> > -		return 0;
> > -
> > -	hdm = cxlhdm->regs.hdm_decoder;
> >   	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> > -
> > -	/*
> > -	 * If the HDM decoder capability was enabled on entry, skip
> > -	 * registering disable_hdm() since this decode capability may be
> > -	 * owned by platform firmware.
> > -	 */
> > -	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
> > -		return 0;
> > -
> >   	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> >   	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> >   
> > -	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
> > +	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
> >   }
> > -EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
> >   
> >   int cxl_dvsec_rr_decode(struct device *dev, int d,
> >   			struct cxl_endpoint_dvsec_info *info)
> > @@ -511,7 +492,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >   	if (info->mem_enabled)
> >   		return 0;
> >   
> > -	rc = devm_cxl_enable_hdm(port, cxlhdm);
> > +	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> >   	if (rc)
> >   		return rc;
> >   
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 74548f8f5f4c..d743df66a582 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -717,7 +717,6 @@ struct cxl_endpoint_dvsec_info {
> >   struct cxl_hdm;
> >   struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> >   				   struct cxl_endpoint_dvsec_info *info);
> > -int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
> >   int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >   				struct cxl_endpoint_dvsec_info *info);
> >   int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 5ffe3c7d2f5e..43718d0396d7 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -60,17 +60,13 @@ static int discover_region(struct device *dev, void *root)
> >   static int cxl_switch_port_probe(struct cxl_port *port)
> >   {
> >   	struct cxl_hdm *cxlhdm;
> > -	int rc, nr_dports;
> > -
> > -	nr_dports = devm_cxl_port_enumerate_dports(port);
> > -	if (nr_dports < 0)
> > -		return nr_dports;
> > +	int rc;
> >   
> > -	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> > -	rc = devm_cxl_enable_hdm(port, cxlhdm);
> > -	if (rc)
> > +	rc = devm_cxl_port_enumerate_dports(port);
> > +	if (rc < 0)
> >   		return rc;
> >   
> > +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> >   	if (!IS_ERR(cxlhdm))
> >   		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> >   
> > @@ -79,7 +75,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
> >   		return PTR_ERR(cxlhdm);
> >   	}
> >   
> > -	if (nr_dports == 1) {
> > +	if (rc == 1) {
> >   		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> >   		return devm_cxl_add_passthrough_decoder(port);
> >   	}
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index 6f9347ade82c..fba7bec96acd 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -6,7 +6,6 @@ ldflags-y += --wrap=acpi_pci_find_root
> >   ldflags-y += --wrap=nvdimm_bus_register
> >   ldflags-y += --wrap=devm_cxl_port_enumerate_dports
> >   ldflags-y += --wrap=devm_cxl_setup_hdm
> > -ldflags-y += --wrap=devm_cxl_enable_hdm
> >   ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
> >   ldflags-y += --wrap=devm_cxl_enumerate_decoders
> >   ldflags-y += --wrap=cxl_await_media_ready
> > diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> > index 284416527644..de3933a776fd 100644
> > --- a/tools/testing/cxl/test/mock.c
> > +++ b/tools/testing/cxl/test/mock.c
> > @@ -149,21 +149,6 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
> >   }
> >   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
> >   
> > -int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
> > -{
> > -	int index, rc;
> > -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> > -
> > -	if (ops && ops->is_mock_port(port->uport))
> > -		rc = 0;
> > -	else
> > -		rc = devm_cxl_enable_hdm(port, cxlhdm);
> > -	put_cxl_mock_ops(index);
> > -
> > -	return rc;
> > -}
> > -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enable_hdm, CXL);
> > -
> >   int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> >   {
> >   	int rc, index;
> >   

