Return-Path: <stable+bounces-203081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8539CCFCBE
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0165E30F1976
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B26D31B810;
	Fri, 19 Dec 2025 12:18:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712132C938;
	Fri, 19 Dec 2025 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146683; cv=none; b=fJWEMbELB0nlS3YBNHvqytejIdvsnqQNhG7EIQ5UvLU7wrUlCX5s68JcAVoYwjvpX6eByQ0r71VBhmbudVzRqU/xExlVTDQu3lnStZHJ2OhqOMZ8c/zcIZZYAwJdmYnsN6lk80cZxoLrwTJUezyozCMDPzFRUVoWxpjnceNWQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146683; c=relaxed/simple;
	bh=mxlpcegnH9EK0DVihwhCFa28uB/m9uhFeIQXkHbq59Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWQXFdkHDgs4r6fFkvKghFn7l//VwqvObopqJ6Me+kl05aGfL5niml2d8SyzapHDUV7G0Uy5bwoNWIdQSCFddVlbkX1jxrisNJE60m2toKS86t6WdWDnNpsl3H6/Eo3X8cFcZVq16mz9xpB2p4Dc7suoWtJBj8kJmFBJwH7zDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB76FEC;
	Fri, 19 Dec 2025 04:17:50 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C433F5CA;
	Fri, 19 Dec 2025 04:17:56 -0800 (PST)
Date: Fri, 19 Dec 2025 12:17:54 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jie.gan@oss.qualcomm.com,
	james.clark@linaro.org, akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mathieu.poirier@linaro.org, mike.leach@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
Message-ID: <20251219121754.GD9788@e132581.arm.com>
References: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
 <20251219023949.12699-1-make24@iscas.ac.cn>
 <20251219094141.GA9788@e132581.arm.com>
 <d4946831-fc8c-4727-abec-3edd92e357d1@arm.com>
 <20251219113803.GC9788@e132581.arm.com>
 <5a967265-b527-4ca0-bf63-f5f7cf9013a3@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a967265-b527-4ca0-bf63-f5f7cf9013a3@arm.com>

On Fri, Dec 19, 2025 at 11:48:35AM +0000, Suzuki K Poulose wrote:

[...]

> > My understanding is we don't grab a device from
> > coresight_find_device_by_fwnode().  The callers only check whether the
> > device is present on the bus; if it isn't, the driver defers probe.
> > 
> > This is similiar to coresight_find_csdev_by_fwnode(), which calls
> > put_device(dev) to release refcnt immediately.  This is why I
> > suggested the change, so the two functions behave consistently.
> > 
> 
> I see, sorry. I saw some other uses of the device, but clearly I was wrong.
> May be we should simply re-structure the function to :

No worries and thanks for confirmation.

> bool coresight_fwnode_device_present(fwnode)
> {
> 
> 	// find and drop the ref if required.
> 	return true/false;
> }
> 
> The name "find_device_by_fwnode" and returning a freed reference doesn't
> look good to me.

Renaming is good.  Maybe use a separate patch to rename:

  coresight_find_csdev_by_fwnode() -> coresight_fwnode_csdev_present()

Thanks,
Leo

