Return-Path: <stable+bounces-3657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0F800D50
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467751C20B7C
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2967219F3;
	Fri,  1 Dec 2023 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3eyAArY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA8170F;
	Fri,  1 Dec 2023 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701441417; x=1732977417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afYA1AgoCILBjnHXIm7ec+NWr7RitXHY+QgbaI2KsOI=;
  b=S3eyAArYPuG/Q5qoeFse/vYwVaLGKRilglgFYOMH0+10n2mdd4tHxFHo
   94olqBPVSUbmqivTglCjx+WciahU5Vd9/uJiWBIXPYgN7QLtR1E4nbqO5
   Ub2CUPAKVZfh4ximjKUA5AEIkV9Hx92S9pPB3L+WOQnabW56FwaWsww/B
   qRX9Wn5raQLkIVGidrPOjNhMOEVNg1RaVZrtO4DUa1ye84PFPZcYSX9WU
   Dshhw/gXEiklYdp/RqYIuWzKZhW0uPQ6FFJ9yP51Jo+/lR0jLZG1qP4ZD
   m0MtxcxqYaYexcZvKqNGpgm6cLyGeoc1fhxRA10FcmPE8pVmZxhIHGi8O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="512247"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="512247"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 06:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1017049950"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="1017049950"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga006.fm.intel.com with SMTP; 01 Dec 2023 06:36:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Dec 2023 16:36:41 +0200
Date: Fri, 1 Dec 2023 16:36:41 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, badhri@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <ZWnveURhRnndzWdF@kuha.fi.intel.com>
References: <20231129192349.1773623-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129192349.1773623-2-rdbabiera@google.com>

On Wed, Nov 29, 2023 at 07:23:50PM +0000, RD Babiera wrote:
> When typec_altmode_put_partner is called by a plug altmode upon release,
> the port altmode the plug belongs to will not remove its reference to the
> plug. The check to see if the altmode being released evaluates against the
> released altmode's partner instead of the calling altmode itself, so change
> adev in typec_altmode_put_partner to properly refer to the altmode being
> released.
> 
> typec_altmode_set_partner is not run for port altmodes, so also add a check
> in typec_altmode_release to prevent typec_altmode_put_partner() calls on
> port altmode release.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v2:
> * Moved changelog under "Signed-off-by" tag
> 
> Changes since v1:
> * Changed commit message for clarity
> * Added check to typec_altmode_release to only call put_partner if altmode
> belongs to port partner or plug
> ---
>  drivers/usb/typec/class.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 2e0451bd336e..16a670828dde 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -267,7 +267,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  	if (!partner)
>  		return;
>  
> -	adev = &partner->adev;
> +	adev = &altmode->adev;
>  
>  	if (is_typec_plug(adev->dev.parent)) {
>  		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> @@ -497,7 +497,8 @@ static void typec_altmode_release(struct device *dev)
>  {
>  	struct altmode *alt = to_altmode(to_typec_altmode(dev));
>  
> -	typec_altmode_put_partner(alt);
> +	if (!is_typec_port(dev->parent))
> +		typec_altmode_put_partner(alt);
>  
>  	altmode_id_remove(alt->adev.dev.parent, alt->id);
>  	kfree(alt);
> 
> base-commit: 24af68a0ed53629bdde7b53ef8c2be72580d293b
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog

-- 
heikki

