Return-Path: <stable+bounces-201074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40775CBF349
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 18:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9E55301841F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC419335086;
	Mon, 15 Dec 2025 17:13:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB199336EE4
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818797; cv=none; b=Hi1Yod6rKt2nnxULwB5R8l1E0JwjIkLcGzmQfDvfLljFmnHBNmwd1mUhiAXYbQBCX9EuAvTb30caBl59J654/C1G7S/LHDZlip5JGtfijnztEeQ8sRRcxc2iOMIMBGFhaulGaisgccbbVInp8vzGUcmms7p0mR80U7vH+oMTdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818797; c=relaxed/simple;
	bh=TAWulCn+oib69ZQXIQj5+QV3eDI5WkmHr+DtRPr972U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc80M/nuq3Qf9DRg6SK6rrYcmhVp4aB2Tzodk87Rga2asOOhtueD40lXTQX6WngNk2AWB2jrK6PQ+nqut+rRLXr+27aOPRB/39vbfuaZptQqOrwYIspsJ95P6XHtT4eVtDrh7Tbup3bnyWXMlNQiUXJ3L1PhHkgYZzNhqQt5JWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14023FEC;
	Mon, 15 Dec 2025 09:13:08 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ABE03F73B;
	Mon, 15 Dec 2025 09:13:14 -0800 (PST)
Date: Mon, 15 Dec 2025 17:13:11 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Amitai Gottlieb <amitaig@hailo.ai>
Cc: <stable@vger.kernel.org>, <amitaigottlieb@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix unused notifier-block in
 unregister
Message-ID: <20251215-glossy-transparent-bullfrog-30fbac@sudeepholla>
References: <20251215163732.120102-1-amitaig@hailo.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215163732.120102-1-amitaig@hailo.ai>

Add [STABLE ONLY] in the subject please along with [PATCH] and repost
it.

Also add Greg Kroah-Hartman <gregkh@linuxfoundation.org> to cc as well.

On Mon, Dec 15, 2025 at 06:37:32PM +0200, Amitai Gottlieb wrote:
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
> scmi_devm_notifier_unregister").  It is needed for the 5.15, 6.1 and
> 6.6 kernels.
> 

I would slightly reword the commit message like below.

 | In scmi_devm_notifier_unregister(), the notifier-block argument was ignored
 | and never passed to devres_release(). As a result, the function always
 | returned -ENOENT and failed to unregister the notifier.
 |
 | Drivers that depend on this helper for teardown could therefore hit
 | unexpected failures, including kernel panics.
 |
 | Commit 264a2c520628 ("firmware: arm_scmi: Simplify scmi_devm_notifier_unregister")
 | removed the faulty code path during refactoring and hence this fix is not
 | required upstream.

(add a panic log if you have seen one, that would help)

With that you can add,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Cc: <stable@vger.kernel.org> # 5.15.x, 6.1.x, and 6.6.x
> Fixes: 5ad3d1cf7d34 ("firmware: arm_scmi: Introduce new devres notification ops")
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Amitai Gottlieb <amitaig@hailo.ai>
> ---
> 
>  drivers/firmware/arm_scmi/notify.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 0efd20cd9d69..4782b115e6ec 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1539,6 +1539,7 @@ static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
>  	dres.handle = sdev->handle;
>  	dres.proto_id = proto_id;
>  	dres.evt_id = evt_id;
> +	dres.nb = nb;
>  	if (src_id) {
>  		dres.__src_id = *src_id;
>  		dres.src_id = &dres.__src_id;
> -- 
> 2.34.1
> 

-- 
Regards,
Sudeep

