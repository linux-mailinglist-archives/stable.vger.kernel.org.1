Return-Path: <stable+bounces-201018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311ABCBD481
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38DE301738D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB8315772;
	Mon, 15 Dec 2025 09:51:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE328CF6F;
	Mon, 15 Dec 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792271; cv=none; b=OWRA4OUj6AlvZuBzdbf/F2/o/IqSjb9qN1z84J2lOtybLi8OM1FhoLwMdZ+p+bPlFk9aLMEa0xqmEYWghZaXGRytIRAMxrimEFnSR5qnUd1ppSw4DAZA/0Dazo8zHVZeUXF0CDQyGQ8KFQXh8RVXYhpg6WcDe443bT6vkFAQMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792271; c=relaxed/simple;
	bh=q+bjhxV4pqLJ1KqRRLBJ2cI6eu4UtZeN5ZHbM5J8ASw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKH+2weEbSZ27CBefk+4EIbVgmtD0xJo7DpmHHnhZM6kwetuWH3T+ZGbOUEmUPu41MtYYt6EMoG3XBmuukPCDMgoVsfcg0d7qdAF0bZJBglJXkBBTf1E4kQeqWrZj6LCqSa6a/6H/veVe7zzYBCuUXbJR9cDLT7s3rT7BVw5im4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF5A497;
	Mon, 15 Dec 2025 01:50:58 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 997013F73B;
	Mon, 15 Dec 2025 01:51:05 -0800 (PST)
Date: Mon, 15 Dec 2025 09:51:03 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Ma Ke <make24@iscas.ac.cn>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org,
	suzuki.poulose@arm.com, mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
Message-ID: <20251215095103.GA681384@e132581.arm.com>
References: <20251215022709.17220-1-make24@iscas.ac.cn>
 <c698d581-da15-42bf-9612-62f1bad66615@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c698d581-da15-42bf-9612-62f1bad66615@linaro.org>

On Mon, Dec 15, 2025 at 11:02:08AM +0200, James Clark wrote:
> 
> 
> On 15/12/2025 04:27, Ma Ke wrote:
> > In etm_setup_aux(), when a user sink is obtained via
> > coresight_get_sink_by_id(), it increments the reference count of the
> > sink device. However, if the sink is used in path building, the path
> > holds a reference, but the initial reference from
> > coresight_get_sink_by_id() is not released, causing a reference count
> > leak. We should release the initial reference after the path is built.
> > 
> > Found by code review.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> > Changes in v2:
> > - modified the patch as suggestions.
> 
> I think Leo's comment on the previous v2 is still unaddressed. But releasing
> it in coresight_get_sink_by_id() would make it consistent with
> coresight_find_csdev_by_fwnode() and prevent further mistakes.

The point is the coresight core layer uses coresight_grab_device() to
increase the device's refcnt.  This is why we don't need to grab a
device when setup AUX.

> It also leads me to see that users of coresight_find_device_by_fwnode()
> should also release it, but only one out of two appears to.

Good finding!

Thanks,
Leo

