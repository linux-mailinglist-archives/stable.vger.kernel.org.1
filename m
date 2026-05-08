Return-Path: <stable+bounces-244763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJBvI3Px/WlxlAAAu9opvQ
	(envelope-from <stable+bounces-244763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:21:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092004F7A38
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B84830143D0
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD443E3C5C;
	Fri,  8 May 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxtyF2cd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0833F5A4;
	Fri,  8 May 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250093; cv=none; b=LJCsqkhT6CVxuVXqThWd4jbq1Qi77VbEH7tD6Vfo04l0QxYiBI9a9YoVFtqqz5bp+cxukCAO9lxii6AUiyKaCbGrDeWmd9TV/G/huTGUvsafMLeYeL2fEMaS7/vWKOfrJ8olV8pLypKrtwtKc7bSWA78ANwPeRKPZTyooZBBRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250093; c=relaxed/simple;
	bh=3G0vq/OduJBpTa6zUlUjMSiQxCplTGVxMRTUp2VSJI8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p2aETfHxtdzCB5KAYRi90/9D4na4ivuV+vg3K5QmMHEE58MJ3t4yCSIgt4AS/FR4Kq2XpEoaRAsrvfsng9WrxJqvbY1qXKKkqnc/Lk03SkrQnDN0ZxIZ33souYlEw+Hv3EP9rwLpqyIIMUOt1/jO1RJcKM5yx4g5eir5+ip/bLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxtyF2cd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778250091; x=1809786091;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3G0vq/OduJBpTa6zUlUjMSiQxCplTGVxMRTUp2VSJI8=;
  b=WxtyF2cdZ81qABFS4IJbH5OQCEHwn5XgKK4QWVPOsfQ5YQzM236+JIIe
   S9PnRS2G3orCFHsSwa/8ZWMk26xq77Hqjoi4tgYmNMTF2e6oaqS4eaO9h
   nP58O+SgfMlfRPJtQdhTv47TKjEBjpkOmh5edcN/m3vcl2p2HquMgUXrb
   ja28I8iprymkzDPzbOyWYvIffYDKv+3Tc6Ao1jxUxFO1t9d97s3V/ch6G
   18zLSUd/oZiOlri3qgi9RSGIdqvabuuOKgrYojEPyNCLdMgZ58llA2/BB
   Waky1mO+zU70NZ3hh6PBsldAFpDRy2LYdZrB+dfnpL1zQ8w4S9dNLpluJ
   Q==;
X-CSE-ConnectionGUID: YMPiBfv8Tiq9Xk05Vgc56Q==
X-CSE-MsgGUID: 7/ZprEHnRwyVrZBkEx8Grg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82839532"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="82839532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:21:30 -0700
X-CSE-ConnectionGUID: Ww0ed/KETdurrQspcVKKhw==
X-CSE-MsgGUID: 0YL+1c2mSSGMCbvHJr/lVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241776245"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:21:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 May 2026 17:21:22 +0300 (EEST)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    =?ISO-8859-15?Q?N=EDcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>, 
    marshall@shzj.cc, hyacinth@shzj.cc, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v11 07/15] platform/x86: lenovo-wmi-helpers: Move gamezone
 enums to wmi-helpers
In-Reply-To: <20260507180507.912966-8-derekjohn.clark@gmail.com>
Message-ID: <0d4c9865-de40-39b3-20fb-398f8480530b@linux.intel.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com> <20260507180507.912966-8-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 092004F7A38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244763-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,squebb.ca:email,linux.intel.com:mid]
X-Rspamd-Action: no action

On Thu, 7 May 2026, Derek J. Clark wrote:

It seems there are a few nits still to address (they were too many so I'd 
want to try to do inline editing).

> In a later patch in the series the thermal mode enum will be accessed
> across three separate drivers (wmi-capdata, wmi-gamezonem and wmi-other).
> An additional patch in the series will also add a function protoype that

prototype

> needs to reference this enum in wmi-helpers.h. To avoid having all these
> drivers begin to import each others headers, and to avoid declaring an
> opaque enum to hande the second case, move the thermal mode enum to
> helpers where it can be safely accessed by everything that needs it from
> a single import.
> 
> While at it, since the gamezone_events_type enum is the only remaining
> item in the header, move that as well and remove the gamezone header
> entirely.
> 
> Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")

This change doesn't seem to exactly fix anything so it shouldn't have 
Fixes tag.

We want to only have Cc: stable in the prerequisites for some other fix 
that comes after.


My plan is to take patches 1-9 through fixes branch and then merge fixes 
to for-next and take the rest through for-next.

-- 
 i.

> Cc: stable@vger.kernel.org
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Rong Zhang <i@rong.moe>
> Tested-by: Rong Zhang <i@rong.moe>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v11:
>   - Move to earlier in the series as later patches depend on it.
> ---
>  drivers/platform/x86/lenovo/wmi-events.c   |  2 +-
>  drivers/platform/x86/lenovo/wmi-gamezone.c |  1 -
>  drivers/platform/x86/lenovo/wmi-gamezone.h | 20 --------------------
>  drivers/platform/x86/lenovo/wmi-helpers.h  | 13 +++++++++++++
>  drivers/platform/x86/lenovo/wmi-other.c    |  1 -
>  5 files changed, 14 insertions(+), 23 deletions(-)
>  delete mode 100644 drivers/platform/x86/lenovo/wmi-gamezone.h
> 
> diff --git a/drivers/platform/x86/lenovo/wmi-events.c b/drivers/platform/x86/lenovo/wmi-events.c
> index 0994cd7dd504..9e9f2e82e04d 100644
> --- a/drivers/platform/x86/lenovo/wmi-events.c
> +++ b/drivers/platform/x86/lenovo/wmi-events.c
> @@ -17,7 +17,7 @@
>  #include <linux/wmi.h>
>  
>  #include "wmi-events.h"
> -#include "wmi-gamezone.h"
> +#include "wmi-helpers.h"
>  
>  #define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
>  
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
> index a91089694727..5a8f4aee02cf 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -21,7 +21,6 @@
>  #include <linux/wmi.h>
>  
>  #include "wmi-events.h"
> -#include "wmi-gamezone.h"
>  #include "wmi-helpers.h"
>  
>  #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/drivers/platform/x86/lenovo/wmi-gamezone.h
> deleted file mode 100644
> index 6b163a5eeb95..000000000000
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -
> -/* Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com> */
> -
> -#ifndef _LENOVO_WMI_GAMEZONE_H_
> -#define _LENOVO_WMI_GAMEZONE_H_
> -
> -enum gamezone_events_type {
> -	LWMI_GZ_GET_THERMAL_MODE = 1,
> -};
> -
> -enum thermal_mode {
> -	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
> -	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
> -	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
> -	LWMI_GZ_THERMAL_MODE_EXTREME =	   0xE0, /* Ver 6+ */
> -	LWMI_GZ_THERMAL_MODE_CUSTOM =	   0xFF,
> -};
> -
> -#endif /* !_LENOVO_WMI_GAMEZONE_H_ */
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/platform/x86/lenovo/wmi-helpers.h
> index 651a039228ed..ed7db3ebba6c 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.h
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.h
> @@ -16,6 +16,19 @@ struct wmi_method_args_32 {
>  	u32 arg1;
>  };
>  
> +enum lwmi_event_type {
> +	LWMI_GZ_GET_THERMAL_MODE = 0x01,
> +};
> +
> +enum thermal_mode {
> +	LWMI_GZ_THERMAL_MODE_NONE =	   0x00,
> +	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
> +	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
> +	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
> +	LWMI_GZ_THERMAL_MODE_EXTREME =	   0xE0, /* Ver 6+ */
> +	LWMI_GZ_THERMAL_MODE_CUSTOM =	   0xFF,
> +};
> +
>  int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
>  			  unsigned char *buf, size_t size, u32 *retval);
>  
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index f63e568a4e12..b4ed7af50a24 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -46,7 +46,6 @@
>  
>  #include "wmi-capdata.h"
>  #include "wmi-events.h"
> -#include "wmi-gamezone.h"
>  #include "wmi-helpers.h"
>  #include "../firmware_attributes_class.h"
>  
> 

