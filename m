Return-Path: <stable+bounces-115142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B626A340CF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97D5188E95A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5DA8BEE;
	Thu, 13 Feb 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GE4T7+8b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10667CA5A;
	Thu, 13 Feb 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454803; cv=none; b=r+4Uf0qrWR1r0Q0/JRHV/+m3hN7rdQqX0RkcWIG8EYGiNy+t+FPbYuuPuI31hXLmigwu07I/x05UmvYZKtzPnAxZ99bYn5nOCEGaxW/XSSfMtD1AAIy7Y44k3agLh7NMMLuvJpH0qPxT2VS/SnzjKERZkqqhGvF03T47X5HnyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454803; c=relaxed/simple;
	bh=Wx2iSgdXWa7f/pHQJPfTiVAEMbG4KSxAtLrbFZPOZok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n26hUAp2IpnBcy9hHaL+m2+dp1SYkyJRBkqmnQYc4zB8LdcirbDDAXFigKigLdkVbXLkP2kNmrKQl8VbJ0M/MahJ+qX6avMQaHssQJ67we3KohxGzZlD1g55AWt13phUyHYMR+ceQmn3n2Aq2FR3oa7ixm0mFUUcS6YwXZSRSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GE4T7+8b; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454802; x=1770990802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wx2iSgdXWa7f/pHQJPfTiVAEMbG4KSxAtLrbFZPOZok=;
  b=GE4T7+8bDgi7Xvdfx/AC1dRMIKygcpjdDdNqvSLa8T9yzrBHIEdoUK5x
   KYMpeQJnvrcZm04nCV/3Q9ZuiCPVLqRXn4xiF5PQAD72isTwROUBwaOHr
   3PINC+Uxi9217T3nviNovw5qUL8Z91T07DeppSOXA/YrxZ+AHqOaM6ETj
   PrAw5dc4PKcZ31zPtfvk9oqUpIGu+pLDUfJ2Cs0EpAHxaG58eq5t4JVWH
   BuM++liIgP1II0xNx3RQasFI/BpDKMj3bVmvCM2OMp7Pl7yobnrxn6SNS
   7NbPK+675aIIV9ohqj/sM8ypGz3apwjV0xG7+7kmPCpTE5Rq/AyVwrNBf
   A==;
X-CSE-ConnectionGUID: qRaJ8t1vRC6IhIdVdpL7ag==
X-CSE-MsgGUID: hg8YE1yYTYqMiMzps9z4mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51554017"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51554017"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:53:21 -0800
X-CSE-ConnectionGUID: b/VAzAmPRv24AK6EEqdgMw==
X-CSE-MsgGUID: sW8wqA1PS6qBkBbIokTCdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118337964"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa005.jf.intel.com with SMTP; 13 Feb 2025 05:53:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Feb 2025 15:53:17 +0200
Date: Thu, 13 Feb 2025 15:53:17 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: joswang <joswang1221@gmail.com>
Cc: badhri@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2, 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in
 PR_Swap enters ERROR_RECOVERY
Message-ID: <Z635TXLXwOaToDAd@kuha.fi.intel.com>
References: <20250213134921.3798-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213134921.3798-1-joswang1221@gmail.com>

On Thu, Feb 13, 2025 at 09:49:21PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")，the PSSourceOffTimer is
> used by the Policy Engine in Dual-Role Power device that is currently
> acting as a Sink to timeout on a PS_RDY Message during a Power Role
> Swap sequence. This condition leads to a Hard Reset for USB Type-A and
> Type-B Plugs and Error Recovery for Type-C plugs and return to USB
> Default Operation.
> 
> Therefore, after PSSourceOffTimer timeout, the tcpm state machine should
> switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can also
> solve the test items in the USB power delivery compliance test:
> TEST.PD.PROT.SNK.12 PR_Swap – PSSourceOffTimer Timeout
> 
> [1] https://usb.org/document-library/usb-power-delivery-compliance-test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: Modify the commit message, remove unnecessary blank lines.
>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 47be450d2be3..6bf1a22c785a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB,
>  						       port->pps_data.active, 0);
>  		tcpm_set_charge(port, false);
> -		tcpm_set_state(port, hard_reset_state(port),
> -			       port->timings.ps_src_off_time);
> +		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
>  		break;
>  	case PR_SWAP_SNK_SRC_SOURCE_ON:
>  		tcpm_enable_auto_vbus_discharge(port, true);
> -- 
> 2.17.1

-- 
heikki

