Return-Path: <stable+bounces-196985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98410C8919F
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2A5B4E4E0A
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477830C611;
	Wed, 26 Nov 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3MY46xl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC73090D9;
	Wed, 26 Nov 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150584; cv=none; b=S5wLKG4HoehZWApXGKLoS+pntTzR9w2uDZmyLMN0OTwZLMUq9PgOHUx4M2+JL1KI8H06FgtfIa1gAiankldhHqBqvAN0DIxdf+ZvRUBMvnS0goipefxgkuTrTINjz/PB8XuzRrs4zCJ/AlMa/GMeB8guZbNJbGrPzeFxGeaC3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150584; c=relaxed/simple;
	bh=0ifNC8xNQ6yLHtRer6D84TB0CLUiMoHaJGqG2OTVrpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tc3UfMZhgT+zfk+nctnlR8u5CUQAc6TgECclqyFB3ZIvCuSlyhT8b7LZjVBnHBTDgFLMMVJVkkJA7/hbbrLAfUDzF6LMaWCEUBTFOmx9UFdINtJ3SbNym5Lbzt1l5mWHHNEoBJMIpM95fSk/OLrfE1WMgbKv58RDzYiOmtq9z9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3MY46xl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764150582; x=1795686582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ifNC8xNQ6yLHtRer6D84TB0CLUiMoHaJGqG2OTVrpw=;
  b=j3MY46xlMQnSLhuI8GYlxlyaA/0hixJyc7dPalhn5Uh3112AitsUGO4E
   Lo9PJ1zn/54InBmgSBBNZFVzjHrvsMO8NyjeV7zOnsDjefsoRasYy+Tw5
   sMmM+wRwcpDFl1isAUnCR+DqHZ70Bgg9xOiv4QxT/QeKahDq6lY/ctu9q
   /7td+1vFrMBY5K3BCk9OjlNAjCQTOi6STPlQ6u6hourfYaQDBYgOwbYiA
   y4Z1KnV16lMZ6r1pWxA4QSn4xiEIkAaNgKZkSBOYUoeQYZf1z9jYkMDq+
   wSZ1DbFOW+5z0AxNyH5mbSkqDiJgAmEwsnjuLuLYoXh4cjt8FKa6256OB
   g==;
X-CSE-ConnectionGUID: 3J44+Dw4QzuMIcxa1/wFDQ==
X-CSE-MsgGUID: vxnx4BfVSy2mYN2/FDwZ0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83793698"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="83793698"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 01:49:41 -0800
X-CSE-ConnectionGUID: tjTmCj+/SfW+N77qTXOIAg==
X-CSE-MsgGUID: ERj465YUS2CSaSLSuGUI9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="198006216"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha) ([10.124.223.25])
  by orviesa005.jf.intel.com with SMTP; 26 Nov 2025 01:49:38 -0800
Received: by kuha (sSMTP sendmail emulation); Wed, 26 Nov 2025 11:49:32 +0200
Date: Wed, 26 Nov 2025 11:49:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	mitltlatltl@gmail.com, linux-kernel@vger.kernel.org,
	sergei.shtylyov@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: fix probe failure in
 gaokun_ucsi_probe()
Message-ID: <aSbNLLiqg0kgALTv@kuha>
References: <cover.1764065838.git.duoming@zju.edu.cn>
 <4d077d6439d728be68646bb8c8678436a3a0885e.1764065838.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d077d6439d728be68646bb8c8678436a3a0885e.1764065838.git.duoming@zju.edu.cn>

Tue, Nov 25, 2025 at 06:36:26PM +0800, Duoming Zhou kirjoitti:
> The gaokun_ucsi_probe() uses ucsi_create() to allocate a UCSI instance.
> The ucsi_create() validates whether ops->poll_cci is defined, and if not,
> it directly returns -EINVAL. However, the gaokun_ucsi_ops structure does
> not define the poll_cci, causing ucsi_create() always fail with -EINVAL.
> This issue can be observed in the kernel log with the following error:
> 
> ucsi_huawei_gaokun.ucsi huawei_gaokun_ec.ucsi.0: probe with driver
> ucsi_huawei_gaokun.ucsi failed with error -22
> 
> Fix the issue by adding the missing poll_cci callback to gaokun_ucsi_ops.
> 
> Fixes: 00327d7f2c8c ("usb: typec: ucsi: add Huawei Matebook E Go ucsi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
>   - Add cc: stable.
>   - Correct spelling mistake.
> 
>  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> index 7b5222081bb..8401ab414bd 100644
> --- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -196,6 +196,7 @@ static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
>  const struct ucsi_operations gaokun_ucsi_ops = {
>  	.read_version = gaokun_ucsi_read_version,
>  	.read_cci = gaokun_ucsi_read_cci,
> +	.poll_cci = gaokun_ucsi_read_cci,
>  	.read_message_in = gaokun_ucsi_read_message_in,
>  	.sync_control = ucsi_sync_control_common,
>  	.async_control = gaokun_ucsi_async_control,
> -- 
> 2.34.1

-- 
heikki

