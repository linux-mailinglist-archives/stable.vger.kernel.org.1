Return-Path: <stable+bounces-176578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A0B39711
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CD31C2588F
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A192DE1FE;
	Thu, 28 Aug 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyyTYTzq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC530CD9D;
	Thu, 28 Aug 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370051; cv=none; b=n+LGO+d821EFSKt9JUgPdxpz6PHhCYr07DIeOM6XzsqLEyp09WFmyMNavUCv3GlnAiPPcXUVuDw86FzdEVZJjgIguZqxyuqFHvYl1U6gtkGkdxSK6L+uGLQBEqnO5R8pIHm5SWYZidz3gf4Ee7go9WOJlNXRYb+u3OpcoiMGT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370051; c=relaxed/simple;
	bh=8HmpHFhHTNfshBY9JwHVC2R52Ib2bdwN468Mgko7xlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ellaVnFuzFoc7gy8I2SkspNhGSy+xpBIGiIJJ++NCe6u2iLNt7iklPv/ZZ46HmzZtFpHPXOES/gSJKlyksGXgvovCHM8mIRoekL1XLVMTZqYGQ7Rasj+pbpQViD2OwKvFIWcDKptaoZomeF3Qs0pUnkUaMChNEvPPYcJSxVBGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyyTYTzq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756370049; x=1787906049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8HmpHFhHTNfshBY9JwHVC2R52Ib2bdwN468Mgko7xlM=;
  b=kyyTYTzq2Zh4kCI4WYr2zZUfc97wZjVqMJRU/VcWNkG1dpel6lE1y2nC
   Qbj27OODQROq8274Is/gtyQ+K7WGSHfTz2b7s3wFOUTcLy+XlyAWa+Xlt
   nEo+kw+xX4OReAgzvoYOucGQvFwAuMjuvVagaP1KR9+6P0QPm0gqXlZyL
   xIoCCwqokJCczL1dkknG5vSg1IPKA3H+c2b8wQZgeXHjdInSQiJQCl99A
   6kEmAjutKU09xLnuJ5LkJ3vv8M6Ffa1n6CbND9mlBEwTJVOgN57g+zgzV
   ojcDLam2asXSSBW/xE2i6+ZWrqis8t1guOxOId+HssnGnsbCGPu54RmBq
   g==;
X-CSE-ConnectionGUID: PMFiri8bRiyMTY1l7R/l4g==
X-CSE-MsgGUID: WM6T/jTYRlCLS1trbH/d+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58731887"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58731887"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:34:07 -0700
X-CSE-ConnectionGUID: RnGBfZyVRMCqFvpEWHGfGg==
X-CSE-MsgGUID: xPHdGeujRsqdDRMbEoeytg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170225345"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 28 Aug 2025 01:34:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Aug 2025 11:34:02 +0300
Date: Thu, 28 Aug 2025 11:34:02 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: properly deliver cable vdms to
 altmode drivers
Message-ID: <aLAUetrP3zKg9kg6@kuha.fi.intel.com>
References: <20250821203759.1720841-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821203759.1720841-2-rdbabiera@google.com>

On Thu, Aug 21, 2025 at 08:37:57PM +0000, RD Babiera wrote:
> tcpm_handle_vdm_request delivers messages to the partner altmode or the
> cable altmode depending on the SVDM response type, which is incorrect.
> The partner or cable should be chosen based on the received message type
> instead.
> 
> Also add this filter to ADEV_NOTIFY_USB_AND_QUEUE_VDM, which is used when
> the Enter Mode command is responded to by a NAK on SOP or SOP' and when
> the Exit Mode command is responded to by an ACK on SOP.
> 
> Fixes: 7e7877c55eb1 ("usb: typec: tcpm: add alt mode enter/exit/vdm support for sop'")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1f6fdfaa34bf..b2a568a5bc9b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2426,17 +2426,21 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  		case ADEV_NONE:
>  			break;
>  		case ADEV_NOTIFY_USB_AND_QUEUE_VDM:
> -			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
> -			typec_altmode_vdm(adev, p[0], &p[1], cnt);
> +			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
> +			} else {
> +				WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
> +				typec_altmode_vdm(adev, p[0], &p[1], cnt);
> +			}
>  			break;
>  		case ADEV_QUEUE_VDM:
> -			if (response_tx_sop_type == TCPC_TX_SOP_PRIME)
> +			if (rx_sop_type == TCPC_TX_SOP_PRIME)
>  				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
>  			else
>  				typec_altmode_vdm(adev, p[0], &p[1], cnt);
>  			break;
>  		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
> -			if (response_tx_sop_type == TCPC_TX_SOP_PRIME) {
> +			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
>  				if (typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P,
>  							    p[0], &p[1], cnt)) {
>  					int svdm_version = typec_get_cable_svdm_version(
> 
> base-commit: 956606bafb5fc6e5968aadcda86fc0037e1d7548
> -- 
> 2.51.0.261.g7ce5a0a67e-goog

-- 
heikki

