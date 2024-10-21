Return-Path: <stable+bounces-87568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA29A6AB1
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A181C22E1C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC51F8EF8;
	Mon, 21 Oct 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRcTcsiY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769611F1306;
	Mon, 21 Oct 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518155; cv=none; b=hsvICLbXY/CFhf2lCYE2+lnycPrN98Ww+kGOrRa1odm5JEXi7FnkxdpoHbf+doUQne0oCi9Kcg27x2YNK6cY9xlXwnqpcJFG4csza2Xq9/ANfwM/ncMPLz6iA3Y1dRXKBpGFd8lVKai4BlGiMULd9Pcl0SEf6lnYeBwIWqviUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518155; c=relaxed/simple;
	bh=f1wKySXtN87V3ZPmmJCMAziu7lYQ0PPXMvrCdpfKp3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL/YkAo8mHOa7dPjq0cFvVEX3RfPpxwijOCJmjGJuKKTdJsDu+4b0vwzMnjiGUXUn3J6J6ecvCkS2QFBEJoKraJAdjhmeHMUdo4lBgtZEwhGc5S9MKxGXsSQ6l20F7OtFMdU0yKXNB4ManNbvEzcHeTI+9zGiiipHOhSDCCYXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRcTcsiY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729518154; x=1761054154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f1wKySXtN87V3ZPmmJCMAziu7lYQ0PPXMvrCdpfKp3E=;
  b=BRcTcsiYKHgISOf/A5yEL0eLF6Fq/X2RA7QHRPclY0fMDjGfWfHuKdKf
   5rmgoVEf/hzq7yyC1aoM3AwTA27odUAzaWmL9nrhXlLBuIgbDRKXv9lAu
   uJAeCAVz8ui1o5QtJiClKh8hkZ1D/WZTeYB9wO7zTw+PjeebLILOM1u+p
   zWiE+MXogmoCRsArvnN89vxJgZ33t5MfYmmzSaik/+8mkd/xhSw+xZZYA
   etjuscN0G8357J6PeZn37a7dsL48CecdxPaennh55o2+U/mWx9owKqgF1
   gfaifJDbvNPsj2XJpCqDQXVvvgK6yJQEMLpWP6UDj189X4zErj8iEl3sN
   w==;
X-CSE-ConnectionGUID: psbNWhJPQ/epPOWY8Pflyw==
X-CSE-MsgGUID: 9l1EWkE1R4Se1NE+lWGfVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29120315"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29120315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:42:33 -0700
X-CSE-ConnectionGUID: 8V/BoEvuRdit+DUzt9jjag==
X-CSE-MsgGUID: Z/TYtL1SSquClVsnk16fAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79932133"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 21 Oct 2024 06:42:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Oct 2024 16:42:29 +0300
Date: Mon, 21 Oct 2024 16:42:29 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
Message-ID: <ZxZaRUmZS4upPvv8@kuha.fi.intel.com>
References: <20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com>
 <ZxZPS7jt4mI1TUG-@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZPS7jt4mI1TUG-@kuha.fi.intel.com>

Hi,

On Mon, Oct 21, 2024 at 03:55:43PM +0300, Heikki Krogerus wrote:
> On Sat, Oct 19, 2024 at 10:40:19PM +0200, Javier Carrasco wrote:
> > The 'altmodes_node' fwnode_handle is never released after it is no
> > longer required, which leaks the resource.
> > 
> > Add the required call to fwnode_handle_put() when 'altmodes_node' is no
> > longer required.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> > ---
> >  drivers/usb/typec/class.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index d61b4c74648d..1eb240604cf6 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
> >  		altmodes[index] = alt;
> >  		index++;
> >  	}
> > +	fwnode_handle_put(altmodes_node);
> >  }
> >  EXPORT_SYMBOL_GPL(typec_port_register_altmodes);

Sorry to go back to this, but I guess we should actually use those
scope based helpers with fwnodes in this case. So instead of a
dedicated fwnode_handle_put() call like that, just introduce
altmodes_node like this:

        ...
        struct fwnode_handle *altmodes_node __free(fwnode_handle) =
                device_get_named_child_node(&port->dev, "altmodes");

        if (IS_ERR(altmodes_node))
                return;

        fwnode_for_each_child_node(altmodes_node, child) {
        ...

thanks,

-- 
heikki

