Return-Path: <stable+bounces-158408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E3AE67A4
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85E35A3CAF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16D2D29AA;
	Tue, 24 Jun 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azZyXKoV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854772C326D;
	Tue, 24 Jun 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773492; cv=none; b=YtwihO/+1LVNi1AtOr0fqW5Rjxj5ftCbZPB+krFYKZ1YbxskSKOFgirbuogE4q/opwOXh27hvrsFuDpI1PudS0Pym6Opxnv1JnERV4nk1Ge43YaUUh1GtiDQnIKv40RobiSTPDBktO88HKHClfpEgu8Dnu2ZeO4lq9N7BzmtmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773492; c=relaxed/simple;
	bh=OLw91X2Is9NUg8+hRFRl/+1tGGpqwE/F/LmJScfzltU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ1Xp2RVBpe1NK1OucFWy7pV7RZWo/dW1086n1Qds0Kx/S+uqzocveHK4QAVuutuPvQvnTdLtqpG7nAwFlfbqSnyt+KMR2dFQ6Zvho1dxazCmJdR12lVg2tX71lgHxpyfU0FsNw9bD/iid/ULnAn0x58fGa1qDWNv1Y+6SJt1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azZyXKoV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750773490; x=1782309490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLw91X2Is9NUg8+hRFRl/+1tGGpqwE/F/LmJScfzltU=;
  b=azZyXKoV8d6wKOupLSDVLivy1se6bywVrY0XeQxv3YEKYA/GTJPTP7ED
   JmNKpBfAqZK4zNdhFLGmP+R6MDiIXZ07WqhYRt6VKfAYm/X5FygGid6W2
   tb/IGxVvBthMWTMFGUOMnq2gjuwizEIxLF5D19Ygb3mK8QO9HTnqANjRO
   pC6+MBVVnbFh/31xHup8pziCqQ9A6he6KWEg8VVggg6H1kUPZAERgsoXm
   fmT2novqIauXKOly12QKNbFVaics/cGDXuv3fD4bCEprzVcxYGA/ecg4K
   n+MMl54Q161cqf6EgIPKV+J9NF6W7MoM6s5ftLCzmuNHflDSgYiYf1nr4
   w==;
X-CSE-ConnectionGUID: 1tP+JhaCSpCNFVOWmlH2hA==
X-CSE-MsgGUID: 1DUvPXLST5aKzFrlnD+NHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52949189"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52949189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 06:58:10 -0700
X-CSE-ConnectionGUID: 6aYS1MZYT+CDaHZJJpOeFw==
X-CSE-MsgGUID: rzZicHZZQja4VxplZOuy5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152043449"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 24 Jun 2025 06:58:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Jun 2025 16:58:06 +0300
Date: Tue, 24 Jun 2025 16:58:06 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Jos Wang <joswang@lenovo.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: displayport: Fix potential deadlock
Message-ID: <aFqu7jvCwajL2OOE@kuha.fi.intel.com>
References: <20250624133246.3936737-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624133246.3936737-1-akuchynski@chromium.org>

On Tue, Jun 24, 2025 at 01:32:46PM +0000, Andrei Kuchynski wrote:
> The deadlock can occur due to a recursive lock acquisition of
> `cros_typec_altmode_data::mutex`.
> The call chain is as follows:
> 1. cros_typec_altmode_work() acquires the mutex
> 2. typec_altmode_vdm() -> dp_altmode_vdm() ->
> 3. typec_altmode_exit() -> cros_typec_altmode_exit()
> 4. cros_typec_altmode_exit() attempts to acquire the mutex again
> 
> To prevent this, defer the `typec_altmode_exit()` call by scheduling
> it rather than calling it directly from within the mutex-protected
> context.
> 
> Cc: stable@vger.kernel.org
> Fixes: b4b38ffb38c9 ("usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index b09b58d7311d..2abbe4de3216 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -394,8 +394,7 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>  	case CMDT_RSP_NAK:
>  		switch (cmd) {
>  		case DP_CMD_STATUS_UPDATE:
> -			if (typec_altmode_exit(alt))
> -				dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
> +			dp->state = DP_STATE_EXIT;
>  			break;
>  		case DP_CMD_CONFIGURE:
>  			dp->data.conf = 0;

-- 
heikki

