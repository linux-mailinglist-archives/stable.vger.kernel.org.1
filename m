Return-Path: <stable+bounces-86364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921AD99F31C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E7F286B99
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB91F669D;
	Tue, 15 Oct 2024 16:47:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C61B21B3;
	Tue, 15 Oct 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010871; cv=none; b=t0FrS5UgN3HqWE1XqGGNaifB+RA4lz7GV/1CKMh3pzneTDOxJH3KJNEy6dZEUNTI6I9FLLp8kD1806S73GqEVptJ/nVk881hnxpR7xxCAqzn5dkwG4XJYVHxEppMBzF0X2JloMMj8w/cj4K5fxJAG2qg7OZhhbhnlf8TOuEN1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010871; c=relaxed/simple;
	bh=wQjqRYCcFhfvzyaKYgj9ni5DarplWCQKtVntqTX0oBA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN2I3PdzKKjliUCA0AjJCfXcfHjB3Tr7c/LaZmkTtfXih3gDgSohco0+auMlJ4iy/+jEJlwqH5Co5WypNFQh6dSYtR2VR1lssPXRitiPchpxk+W0lH5AtsNqe9+L+00lxOC7zyDe52VaBAvJgCGDpLmarpui7ClsrQP+OEDvpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSfzm2kWfz6L6nf;
	Wed, 16 Oct 2024 00:43:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 23D181404F5;
	Wed, 16 Oct 2024 00:47:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 18:47:44 +0200
Date: Tue, 15 Oct 2024 17:47:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <stable@vger.kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Zijun
 Hu" <zijun_hu@icloud.com>, <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <20241015174743.0000180d@Huawei.com>
In-Reply-To: <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
	<172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Oct 2024 22:34:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In support of investigating an initialization failure report [1],
> cxl_test was updated to register mock memory-devices after the mock
> root-port/bus device had been registered. That led to cxl_test crashing
> with a use-after-free bug with the following signature:
> 
>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
>     cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
> 1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
>     [..]
>     cxld_unregister: cxl decoder14.0:
>     cxl_region_decode_reset: cxl_region region3:
>     mock_decoder_reset: cxl_port port3: decoder3.0 reset
> 2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
>     cxl_endpoint_decoder_release: cxl decoder14.0:
>     [..]
>     cxld_unregister: cxl decoder7.0:
> 3)  cxl_region_decode_reset: cxl_region region3:
>     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
>     [..]
>     RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
>     [..]
>     Call Trace:
>      <TASK>
>      cxl_region_decode_reset+0x69/0x190 [cxl_core]
>      cxl_region_detach+0xe8/0x210 [cxl_core]
>      cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>      cxld_unregister+0x5d/0x60 [cxl_core]
> 
> At 1) a region has been established with 2 endpoint decoders (7.0 and
> 14.0). Those endpoints share a common switch-decoder in the topology
> (3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
> the "out of order reset case" in the switch decoder. The effect though
> is that region3 cleanup is aborted leaving it in-tact and
> referencing decoder14.0. At 3) the second attempt to teardown region3
> trips over the stale decoder14.0 object which has long since been
> deleted.
> 
> The fix here is to recognize that the CXL specification places no
> mandate on in-order shutdown of switch-decoders, the driver enforces
> in-order allocation, and hardware enforces in-order commit. So, rather
> than fail and leave objects dangling, always remove them.
> 
> In support of making cxl_region_decode_reset() always succeed,
> cxl_region_invalidate_memregion() failures are turned into warnings.
> Crashing the kernel is ok there since system integrity is at risk if
> caches cannot be managed around physical address mutation events like
> CXL region destruction.

I'm fine with this, but seems like it is worth breaking out as a precursor
where we can discuss merits of that change separate from the complexity
of the rest.

I don't mind that strongly though so if you keep this intact,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Trivial passing comment inline.



> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..223c273c0cd1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -712,7 +712,44 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> -static int cxl_decoder_reset(struct cxl_decoder *cxld)
> +static int commit_reap(struct device *dev, const void *data)
> +{
> +	struct cxl_port *port = to_cxl_port(dev->parent);
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev) && !is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(dev);
> +	if (port->commit_end == cxld->id &&
> +	    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
I'd have gone with !(cxld->flags & CXL_DECODER_F_ENABLE) but
this is consistent with exiting form, so fine as is.

> +		port->commit_end--;
> +		dev_dbg(&port->dev, "reap: %s commit_end: %d\n",
> +			dev_name(&cxld->dev), port->commit_end);
> +	}
> +
> +	return 0;
> +}


> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 90d5afd52dd0..c5bbd89b3192 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -693,26 +693,22 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> -static int mock_decoder_reset(struct cxl_decoder *cxld)
> +static void mock_decoder_reset(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	int id = cxld->id;
>  
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> -		return 0;
> +		return;
>  
>  	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
> -	if (port->commit_end != id) {
> +	if (port->commit_end == id)
> +		cxl_port_commit_reap(cxld);
> +	else
>  		dev_dbg(&port->dev,
>  			"%s: out of order reset, expected decoder%d.%d\n",
>  			dev_name(&cxld->dev), port->id, port->commit_end);
> -		return -EBUSY;
> -	}
> -
> -	port->commit_end--;
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> -
> -	return 0;
>  }
>  
>  static void default_mock_decoder(struct cxl_decoder *cxld)
> 
> 


