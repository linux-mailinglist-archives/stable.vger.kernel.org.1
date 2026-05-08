Return-Path: <stable+bounces-244770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BBGCj/1/Wn5lAAAu9opvQ
	(envelope-from <stable+bounces-244770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:37:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A34F7DC8
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE04305115F
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80F3E275D;
	Fri,  8 May 2026 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LERT9RdW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACF2F8EA9;
	Fri,  8 May 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250741; cv=none; b=RcH8lzoeBaY0LGRTIbsoP45X/PtOXTP1AKWQSnQkeVYsE/oTvsXmDQFXaWoxJ1zLeTu7WC3rpBLktPmP3KjcMasq0LNpA67WIz2Ye09svNwzrQWSpccJjAjU+J3LnTh5sGurDtNL/bwyHR7kDjyd6aNsFBHjQDpOrDQp4pKDwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250741; c=relaxed/simple;
	bh=cObl8iKbS97zS6dvJtMPG/oBbU0TpzmIQJC/42+TT7o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hkg2qrG2DAvnzhLcP/5ko4WUTkRUM6uPtTbwiWy37ad3gZwNTgLd8cnqAybtJbBHcKgRODqOkM2wTdqnpMa9ayBGQiG0ZBIqcvMKNRtnXPATXwrallhchHyRRedMNCt7Uda8X6z59vyetvYaLwZz81DqgHrL85GXLxDMGgDaFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LERT9RdW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778250739; x=1809786739;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cObl8iKbS97zS6dvJtMPG/oBbU0TpzmIQJC/42+TT7o=;
  b=LERT9RdWfreMCEtv5tLDkfaqQVU15q8Bjve9jz7bVK88ksFLDKPcd55N
   CQ47Ov/RTzk+P1bBBrRxPnfK7jWRM+M0Zdg7Ki9sj9nHrYeh4IJQ9MNc4
   MsMGgMQOEe1sPGfYjRfeHzNGMXYyKatZBMMWLasqxFzPxmcKszDcO0wS3
   8n9MePQovfqtK0YrhFLUt8VIqusQTJykUMybCK94VXSamlvdRK0HAQ352
   3Bjz2kTIS+sjSOMXSMDyF7qi5rQCL9gn7bFm0QNVrDq3HbKoJHMtSH6uI
   eeLj17zVSO074sKcrp18o0TCs6ALaiGOB7O8x0geDt6P0swHApKnhAg71
   A==;
X-CSE-ConnectionGUID: 2Rw17gBWT/C2zwWTTdhb1w==
X-CSE-MsgGUID: 3BA9aEZiQs2XwBZXr3LkFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="66747454"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="66747454"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:32:17 -0700
X-CSE-ConnectionGUID: enn+aHSzSNqosvL+b4TKyA==
X-CSE-MsgGUID: 85PIHciNR86GXz7FwUdDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="233724044"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:32:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 May 2026 17:32:08 +0300 (EEST)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    =?ISO-8859-15?Q?N=EDcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>, 
    marshall@shzj.cc, hyacinth@shzj.cc, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v11 05/15] platform/x86: lenovo-wmi-other: Fix tunable_attr_01
 struct members
In-Reply-To: <20260507180507.912966-6-derekjohn.clark@gmail.com>
Message-ID: <49827c16-8af3-d542-4fa4-9c7b27032cdd@linux.intel.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com> <20260507180507.912966-6-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A46A34F7DC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244770-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,rong.moe:email,linux.intel.com:mid]
X-Rspamd-Action: no action

On Thu, 7 May 2026, Derek J. Clark wrote:

> In struct tunable_attr_01 the capdata pointer is unused and the size of
> the id members is u32 when it should be u8. Fix these prior to adding
> additional members.
> 
> No functional change intended.
> 
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")

This too does not need fixes tag as there is no user visible bug that is 
being fixed. An unused variable isn't bug even if it's a good thing to 
maintain such cleanliness while coding.

-- 
 i.

> Cc: stable@vger.kernel.org
> Reviewed-by: Rong Zhang <i@rong.moe>
> Tested-by: Rong Zhang <i@rong.moe>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  drivers/platform/x86/lenovo/wmi-other.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index 1e06b894cfcc..50a03f5fd6ab 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -546,11 +546,10 @@ static void lwmi_om_fan_info_collect_cd_fan(struct device *dev, struct cd_list *
>  /* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
>  
>  struct tunable_attr_01 {
> -	struct capdata01 *capdata;
>  	struct device *dev;
> -	u32 feature_id;
> -	u32 device_id;
> -	u32 type_id;
> +	u8 feature_id;
> +	u8 device_id;
> +	u8 type_id;
>  };
>  
>  static struct tunable_attr_01 ppt_pl1_spl = {
> 


