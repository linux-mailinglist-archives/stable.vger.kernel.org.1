Return-Path: <stable+bounces-203055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B72CCF35A
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F581305B5AB
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DC2FD7BC;
	Fri, 19 Dec 2025 09:41:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8D2EC558;
	Fri, 19 Dec 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766137306; cv=none; b=ep4E+8oYxycB0SLp5vEhUjE7ViIXujNafRhK4b4g4avgJcMgyWOzWgyfLBTMbTrM0MNV0ORCdV17HDlIgHnKsRDred5i402gEtm2nlzgYvzXdcMdZJ75dgM/1Z4wF4OpCl1Eqdu20lXSTxzhD037zdn5a1gXcodA/3b1G12wIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766137306; c=relaxed/simple;
	bh=tOShqq0kJVQK8CJRv8as76qzNIFnqQtRmhnefoFcBVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiFaM3f8//lsCNBNaLLTdiqAjZmLlpYegcFFMMXTT5C1hkT4IJNA9h9BSLstNWAbCH0x0m5VsqbWTVQfEJkS33cq1dLoHlqCkdTVjOUb6DDfyuLboGKSwURONScZv6Krxvr6660ydlFPxwHTjMQW4+qibZAiaUjfPAOk/Xrqb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5E52FEC;
	Fri, 19 Dec 2025 01:41:36 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90CBE3F73F;
	Fri, 19 Dec 2025 01:41:43 -0800 (PST)
Date: Fri, 19 Dec 2025 09:41:41 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jie.gan@oss.qualcomm.com, james.clark@linaro.org,
	akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
	mike.leach@linaro.org, stable@vger.kernel.org,
	suzuki.poulose@arm.com
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
Message-ID: <20251219094141.GA9788@e132581.arm.com>
References: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
 <20251219023949.12699-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219023949.12699-1-make24@iscas.ac.cn>

Hi,

On Fri, Dec 19, 2025 at 10:39:49AM +0800, Ma Ke wrote:

[...]

> From the discussion, I note two possible fix directions:
> 
> 1. Release the initial reference in etm_setup_aux() (current v2 patch)
> 2. Modify the behavior of coresight_get_sink_by_id() itself so it 
> doesn't increase the reference count. 

The option 2 is the right way to go.

> To ensure the correctness of the v3 patch, I'd like to confirm which 
> patch is preferred. If option 2 is the consensus, I'm happy to modify 
> the implementation of coresight_get_sink_by_id() as suggested.

It is good to use a separate patch to fix
coresight_find_device_by_fwnode() mentioned by James:

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 0db64c5f4995..2b34f818ba88 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -107,14 +107,16 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 	 * platform bus.
 	 */
 	dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
-	if (dev)
-		return dev;
 
 	/*
 	 * We have a configurable component - circle through the AMBA bus
 	 * looking for the device that matches the endpoint node.
 	 */
-	return bus_find_device_by_fwnode(&amba_bustype, fwnode);
+	if (!dev)
+		dev = bus_find_device_by_fwnode(&amba_bustype, fwnode);
+
+	put_device(dev);
+	return dev;
 }
 
 /*
@@ -274,7 +276,6 @@ static int of_coresight_parse_endpoint(struct device *dev,
 
 	of_node_put(rparent);
 	of_node_put(rep);
-	put_device(rdev);
 
 	return ret;
 }

Thanks for working on this.

