Return-Path: <stable+bounces-52559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432390B592
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416D8B3631F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C505715ECC4;
	Mon, 17 Jun 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/RJHWfF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EA15E5DE;
	Mon, 17 Jun 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635298; cv=none; b=JKmaPozO8jO3KrLViF3enCw8nKGk0H7R9bw97/NbbkboqE4c/BcFRpqj0T6uJP0A7YmqvEUirPcWxjhx9tllYDqYqS9sq2zFlC9va6HiVu72/0yHkRcvOSZ5YOzVttrAwxRm46Y7sMHRvBAFUIVBhA7bt1I6oY1Dac3eaxVlC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635298; c=relaxed/simple;
	bh=FyWrXdXjckoc0z50AFEwR9w92vG/cvPD3T0yDH7WBvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV0efFoIGEcyYF9+eQlzthXEmaJeMtWXvfVq93b6OlUK8oibc+S3RLA185uUsqs0GOKiKfEX+7uhQrjZzpcys2mWhoSlTvOnG+CobiQHQCeTFxhwp1Epco4ZhELpOCSZUr6zL1RFIzJovXnt513Od5znAwlOaSSSSJsEEKK9pjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/RJHWfF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718635297; x=1750171297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FyWrXdXjckoc0z50AFEwR9w92vG/cvPD3T0yDH7WBvQ=;
  b=g/RJHWfFAfu/kyMrsGlrOy7zZGMmU4PzUTrGw9D3uBpoMm7awoxPJixm
   dakdQWWXvkV7MBEPDCyIz+ZZhAA05dxOlunRdPeZfZwj2TsLN40pQp1O9
   lDcyZOO3f/VrlNK1eUcqSO5rIUtRsEJ/B5u+9C3d68oFnDD/0vqESpyW1
   QEIoL6ptLC+1FwTiwLeMWKdzAeRS8l1YZeT5qcJ6Nw6Ut6gvptbWl6F2A
   VOK0MIpTIEU52BZUnQ6vygixh3P3/FC+5mAYAot34OXLsGFePIhxk9QO7
   PI/IyKKG4VvBd93mTofP6RmO3vDiEmI1IaRS9TaqHZbRfpkG3Lksub9sR
   g==;
X-CSE-ConnectionGUID: 6tW5+gjxQKK02LBReq6R+g==
X-CSE-MsgGUID: JIE+7mvtTI+KcxR3v0Eb4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15179865"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15179865"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 07:41:36 -0700
X-CSE-ConnectionGUID: XRIBTruCQAK1dCALWT0eWA==
X-CSE-MsgGUID: jNSuDk0rR3u54hagyJvdiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41915717"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa007.jf.intel.com with SMTP; 17 Jun 2024 07:41:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Jun 2024 17:41:32 +0300
Date: Mon, 17 Jun 2024 17:41:32 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: glink: fix child node release in probe
 function
Message-ID: <ZnBLHFA4PjxwYWr+@kuha.fi.intel.com>
References: <20240613-ucsi-glink-release-node-v1-1-f7629a56f70a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-ucsi-glink-release-node-v1-1-f7629a56f70a@gmail.com>

On Thu, Jun 13, 2024 at 02:14:48PM +0200, Javier Carrasco wrote:
> The device_for_each_child_node() macro requires explicit calls to
> fwnode_handle_put() in all early exits of the loop if the child node is
> not required outside. Otherwise, the child node's refcount is not
> decremented and the resource is not released.
> 
> The current implementation of pmic_glink_ucsi_probe() makes use of the
> device_for_each_child_node(), but does not release the child node on
> early returns. Add the missing calls to fwnode_handle_put().
> 
> Cc: stable@vger.kernel.org
> Fixes: c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> This case would be a great opportunity for the recently introduced
> device_for_each_child_node_scoped(), but given that it has not been
> released yet, the traditional approach has been used to account for
> stable kernels (bug introduced with v6.7). A second patch to clean
> this up with that macro is ready to be sent once this fix is applied,
> so this kind of problem does not arise if more early returns are added.
> 
> This issue has been found while analyzing the code and not tested with
> hardware, only compiled and checked with static analysis tools. Any
> tests with real hardware are always welcome.
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index f7546bb488c3..41375e0f9280 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -372,6 +372,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  		ret = fwnode_property_read_u32(fwnode, "reg", &port);
>  		if (ret < 0) {
>  			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> +			fwnode_handle_put(fwnode);
>  			return ret;
>  		}
>  
> @@ -386,9 +387,11 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  		if (!desc)
>  			continue;
>  
> -		if (IS_ERR(desc))
> +		if (IS_ERR(desc)) {
> +			fwnode_handle_put(fwnode);
>  			return dev_err_probe(dev, PTR_ERR(desc),
>  					     "unable to acquire orientation gpio\n");
> +		}
>  		ucsi->port_orientation[port] = desc;
>  	}
>  
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240613-ucsi-glink-release-node-9fc09d81e138
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>

-- 
heikki

