Return-Path: <stable+bounces-227038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGKPLxiSumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:52:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CF2BB1FC
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D094A30107BC
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545D3ACA72;
	Wed, 18 Mar 2026 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AB3tpRy0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A63378D93;
	Wed, 18 Mar 2026 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834774; cv=none; b=If+8iYAQgts63xfni2uXeT1twBQMzzGFScZM3I99yv+VKeidDejNmuCC9x+jaVEVaKFyo2sbW+sncY+McRCErx1UsKInNCcffYhfoEA7CSJlEovawxZLhLymiNRMhTC6FscCrhP8+XpdIoUP1CHxnf6m+1j77dMOeeunzOOjJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834774; c=relaxed/simple;
	bh=KcKwaWlXjyH0sb+dSYxM4WaP2zjrU334iBOcDLtCOag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+yEMNEWDe4TOZhCjf2L8WhfZ3s/5XVJ6R6/q+MTd+XTMK3hD0+ygu2HUcIriKC4vnwhL9JHUG7WIykcFuovmzrMnlSvr0PcyDQpQSMSB6Ccp6QY14zglNCvuZrXmHCHE3+Rz0z6Tzk6Wabi7qEZnsv95vJPy3JF93rzNlKduk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AB3tpRy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A19CC19421;
	Wed, 18 Mar 2026 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773834774;
	bh=KcKwaWlXjyH0sb+dSYxM4WaP2zjrU334iBOcDLtCOag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AB3tpRy0TvIjKF5Gvv7xP3epK40qgygR1dKd0g8sqmQNgq6rSx1Xhg3w7k0FVEv2N
	 eJwdnvZlIUnfY7v0B3W5GxzSuO1VYR+7nVVsQsfXvJ2smsKagNUB5vowbrIhgAO9uc
	 DWWJ8XS+9Oa6ZWTnQogIDEDFq/0CycwamYO4ZLzs=
Date: Wed, 18 Mar 2026 12:52:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Franz Schnyder <franz.schnyder@toradex.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6.18 190/333] drm/bridge: ti-sn65dsi86: Enable HPD
 polling if IRQ is not used
Message-ID: <2026031844-vineyard-lingo-f78e@gregkh>
References: <20260317162959.345812316@linuxfoundation.org>
 <20260317163006.402839129@linuxfoundation.org>
 <20260318073754.GA13812@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318073754.GA13812@francesco-nb>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227038-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email,toradex.com:email]
X-Rspamd-Queue-Id: 7A2CF2BB1FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 08:37:54AM +0100, Francesco Dolcini wrote:
> Hello Greg,
> 
> On Tue, Mar 17, 2026 at 05:33:39PM +0100, Greg Kroah-Hartman wrote:
> > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> > 
> > commit 0b87d51690dd5131cbe9fbd23746b037aab89815 upstream.
> > 
> > Fallback to polling to detect hotplug events on systems without
> > interrupts.
> > 
> > On systems where the interrupt line of the bridge is not connected,
> > the bridge cannot notify hotplug events. Only add the
> > DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> > otherwise remain in polling mode.
> > 
> > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
> > Cc: stable@vger.kernel.org # 6.16: 9133bc3f0564: drm/bridge: ti-sn65dsi86: Add
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > [dianders: Adjusted Fixes/stable line based on discussion]
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Link: https://patch.msgid.link/20260206123758.374555-1-fra.schnyder@gmail.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Please queue also commit 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add
> support for DisplayPort mode with HPD"), it is a pre-requisite for this
> one.

Now queued up.

thanks,

greg k-h

