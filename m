Return-Path: <stable+bounces-188000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC3BF0131
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1F94EA00C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7C2E8B76;
	Mon, 20 Oct 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYAnnr9D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D291DF26E;
	Mon, 20 Oct 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950938; cv=none; b=GrRpN1562oodRlQCLOQ2xd/ZCQvh6BYRBFtHKwBSoq4vDP4PbdMDHjE089krtdmb2D99eUGZ0CTUEFS/I5K6gA4HppGr8Z/KzqD49fXWsl47SLhCLLiwVqxUKCcfBgpQdtpnSFQBVtsYk5OPrfvM8x6AI1EF4gzHDlek2C1CKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950938; c=relaxed/simple;
	bh=ezcFUr+LQe4OMTnbeAg5YTOtTsWfMeeIN46IscDdMVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj63VVUMZ4n5wQUH26McKLiPJoME7nqPiZXng8sq6dJ+clVfW1rrqePyITMHJ5r+QqULEtYprZnlM4ZiGC3ItEFBB+K0TaiRqQAx/7+Ls1mpASlON6hmYLLSfgtKfhaEVto51E+wrw2/Bcuxvorh0HqqWlkraJLDFH7ANanRxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYAnnr9D; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760950936; x=1792486936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ezcFUr+LQe4OMTnbeAg5YTOtTsWfMeeIN46IscDdMVU=;
  b=DYAnnr9DCHZ1OLq7tC0cT+nRly7h7gYd2KnxZof719rO68x3G41VjdbM
   Svc6q73QGaRrBAxk6FRPaKkpP36ZCd00P0fjVr1cPxRMo9NwYI1IoV+tH
   4w7YVXdDs6jkIW6I/QW4kcAcJFoF0BcBZ62j5U2PbAlFXXb2Ng1dSJAvG
   BEC0e10fqCfPW/NcaaZOVVON9U6kFokAZ0A71CaP/1Ph+1eRr5wFKcptA
   6BnQeT52/sHINw1Vg8t46dPhks5kOqCBanuyHwYOaEfcz1H+ta7YNJYKK
   +sCQGYd41C5ws9OXAWB2RAugRlLvDwhyZmc6f93XKtjkEfRuKrIm+rmNy
   g==;
X-CSE-ConnectionGUID: SxwuxAXGRXmJkBS64sbbBQ==
X-CSE-MsgGUID: vjmrzHlfStGdwMoJswUWNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63105866"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63105866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:02:15 -0700
X-CSE-ConnectionGUID: Zp35cNExTaC4y3fHINJaGQ==
X-CSE-MsgGUID: 9WfhUskZQvSfWEjJPOkPFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="220429504"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by orviesa001.jf.intel.com with SMTP; 20 Oct 2025 02:02:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:02:10 +0300
Date: Mon, 20 Oct 2025 12:02:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tcpm: switch check for role_sw device with fw_node
Message-ID: <aPX6kuSgsPS8L2k6@kuha.fi.intel.com>
References: <20251013-b4-ml-topic-tcpm-v2-1-63c9b2ab8a0b@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-b4-ml-topic-tcpm-v2-1-63c9b2ab8a0b@pengutronix.de>

On Mon, Oct 13, 2025 at 11:43:40AM +0200, Michael Grzeschik wrote:
> When there is no port entry in the tcpci entry itself, the driver will
> trigger an error message "OF: graph: no port node found in /...../typec" .
> 
> It is documented that the dts node should contain an connector entry
> with ports and several port pointing to devices with usb-role-switch
> property set. Only when those connector entry is missing, it should
> check for port entries in the main node.
> 
> We switch the search order for looking after ports, which will avoid the
> failure message while there are explicit connector entries.
> 
> Fixes: d56de8c9a17d ("usb: typec: tcpm: try to get role switch from tcpc fwnode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - fixed typos in the description
> - added fixes tag
> - added Cc: stable@vger.kernel.org
> - Link to v1: https://lore.kernel.org/r/20251003-b4-ml-topic-tcpm-v1-1-3cdd05588acb@pengutronix.de
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b2a568a5bc9b0ba5c50b7031d8e21ee09cefa349..cc78770509dbc6460d75816f544173d6ab4ef873 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7876,9 +7876,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  
>  	port->partner_desc.identity = &port->partner_ident;
>  
> -	port->role_sw = usb_role_switch_get(port->dev);
> +	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
>  	if (!port->role_sw)
> -		port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
> +		port->role_sw = usb_role_switch_get(port->dev);
>  	if (IS_ERR(port->role_sw)) {
>  		err = PTR_ERR(port->role_sw);
>  		goto out_destroy_wq;
> 

-- 
heikki

