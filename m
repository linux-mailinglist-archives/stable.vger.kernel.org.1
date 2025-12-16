Return-Path: <stable+bounces-201155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB8CC1D6D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF4373012DD2
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275F5322B9B;
	Tue, 16 Dec 2025 09:40:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD16314B8E
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878037; cv=none; b=PlG/omiQa3Il+9KMjU2NJFbl8Y4Tu9uefpDlShUV+Zr+nweLfdM+hJC3+RZBf2cvDXMFELYTFsVoMqp+Wrsak3Ovun9MsRTLwLzs1aoSMnvOk/P93hHk0D5WlVks4+lT8PpyM3hdL/ojnuzMZZRLI9tAJKFyuMC0ZVXnnpBOKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878037; c=relaxed/simple;
	bh=7fibkRnT3uTJbI/x110mVkgIBmUgm6Y5BdYOBuTa6l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr+xcv2wjRZchOlGcYMt6+pxalNr5AzZAh/LGYAbxX4/9EvwiGlXrzjLTH2V7yDGDRCJmpCNp9ynWV0XKqOSYuUYGX05A5mN9wflvcqhQ09ROs3c6o66Jcy51sTP/p1Wq/XJ/77mxAekrQ5vSuQPpyc63f+4jBvOzH+DZKuSDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBDF5FEC;
	Tue, 16 Dec 2025 01:40:28 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9EED3F73B;
	Tue, 16 Dec 2025 01:40:34 -0800 (PST)
Date: Tue, 16 Dec 2025 09:40:31 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Amitai Gottlieb <amitaig@hailo.ai>, <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>, <amitaigottlieb@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] [STABLE ONLY] firmware: arm_scmi: Fix unused
 notifier-block in unregister
Message-ID: <20251216-quantum-amazing-giraffe-fd9dfa@sudeepholla>
References: <20251216090009.13435-1-amitaig@hailo.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216090009.13435-1-amitaig@hailo.ai>

Hi Amitai,

Not sure if you received my earlier reply as I can't find it on the list
and not in sent box as well. But I do see you have cc-ed Greg as requested
but didn't consider other requests, hence the confusion.

Hi Greg,

This is first time I am deal with such an issue which exist only in the
stable tree as the upstream fixed it in some refactoring before the issue
was reported/known. Let us know if this is correct way to add patch to
stable tree only or is there something we are missing or need to take care of.

On Tue, Dec 16, 2025 at 11:00:09AM +0200, Amitai Gottlieb wrote:
> In function `scmi_devm_notifier_unregister` the notifier-block parameter
> was unused and therefore never passed to `devres_release`. This causes
> the function to always return -ENOENT and fail to unregister the
> notifier.
> 
> In drivers that rely on this function for cleanup this causes
> unexpected failures including kernel-panic.
> 
> This is not needed upstream becaues the bug was fixed
> in a refactor by commit 264a2c520628 ("firmware: arm_scmi: Simplify
> scmi_devm_notifier_unregister").  


> It is needed for the 5.15, 6.1 and 6.6 kernels.

I had given you reworded commit message and particularly the above text
to be dropped. It makes no sense to add this say is v5.15 kernel e.g.

> 
> Cc: <stable@vger.kernel.org> # 5.15.x, 6.1.x, and 6.6.x
> Fixes: 5ad3d1cf7d34 ("firmware: arm_scmi: Introduce new devres notification ops")
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

I had also asked you to add my

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

