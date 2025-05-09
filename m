Return-Path: <stable+bounces-143049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A9AB15C7
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 15:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7795C5077AC
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B029208B;
	Fri,  9 May 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mzwDzuFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BD292080
	for <stable@vger.kernel.org>; Fri,  9 May 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798432; cv=none; b=UqK8PQrdXT8E7vl/hZcpp4DSRDvAqQ90/JriPGl1qLfKQRK8WoflajtD9TA7F4MrbQEyU0kJ7+UbBy2IHLStP5CdRe5HZHk7xt40KZwoVLg3Esh5AQ60VsjeMR54sPVvjWeiDS+gleHIYLm5q0SmtF5Kct+YC6xPuWZe4ufOQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798432; c=relaxed/simple;
	bh=LaCm6wXxUgmio7r/RYFaP0DqkzCiu1YzYIhR18UZhE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsIoQse6yGh+LHOLmR8kEIjAzVHU6uEI9rj2QZrhAnLVlbiqPsF1Rj7UaydRTV7gerHPhWx9ldimowkUjBQSHs/GvEj9l58EfXO11iV/RXy+vIlYDmOPz5gl7MQyzN8HPou65QuVYbZsMDFJI47+aRfvMBWP+tVmRWlZpWdLwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mzwDzuFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D36C4CEE4;
	Fri,  9 May 2025 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746798432;
	bh=LaCm6wXxUgmio7r/RYFaP0DqkzCiu1YzYIhR18UZhE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzwDzuFsgqoultBZyPI59rCVNtXhYkLVTgVeP+Mnh0ZtF0tQZCizG9Vxq1ggMlBr9
	 lZqTfbb+6D4sPCVJssWkdVN0O8VB0MQWHuKiRh9eQCU9AduxXxmBknCoDHeV03K1vE
	 vUDhwPQNqQb/LKrcu6wFy7yUO2NbD/7mMFxQW538=
Date: Fri, 9 May 2025 15:45:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] firmware: arm_scmi: Add missing definition of info
 reference
Message-ID: <2025050920-aide-squire-5a2e@gregkh>
References: <2025050930-scuba-spending-0eb9@gregkh>
 <20250509114422.982089-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509114422.982089-1-cristian.marussi@arm.com>

On Fri, May 09, 2025 at 12:44:22PM +0100, Cristian Marussi wrote:
> Add the missing definition that caused a build break.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 609fbf4563ff..3f3701ed196e 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1044,6 +1044,8 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
>  		 */
>  		if (!desc->sync_cmds_completed_on_ret) {
>  			bool ooo = false;
> +			struct scmi_info *info =
> +				handle_to_scmi_info(cinfo->handle);
>  
>  			/*
>  			 * Poll on xfer using transport provided .poll_done();
> -- 
> 2.39.5
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

