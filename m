Return-Path: <stable+bounces-237821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPmZAUgl3mmMoAkAu9opvQ
	(envelope-from <stable+bounces-237821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D633F95DF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E90163015305
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E43DB621;
	Tue, 14 Apr 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9QpkSDE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7613D9DB0;
	Tue, 14 Apr 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166196; cv=none; b=qDW7sXm6bE8y21x5TqsIGBtJUcghWH12m+StcgqaiaNiIkEdIdVFSryaOZ1WyPq9XZ//HY+IQeuqaWaZZROXR48V13oJMQHiH6imrj933njSYsqmYZ7ln+pz16HAyQGcXRchdYXQcnta8VXYqqAvUuJW1eLJgg4twArc9WQztY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166196; c=relaxed/simple;
	bh=y5RqzwqGCOp6MOPA0v+0gXwKnYP7j3g4YU/R6L65eU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV4A9j4p19gMJYk15vvT95yKNvwRzuHvaEuMiSJbGBe7zSSynEJ1T06P/mkuqqNEoinbVicj9FYj/X4rjGXRtQkuVPMew8fSjB2IcNAb7dEg1b82XUWPDv8YuzCFiBDuh15dv5Z6w/GvRX5mWFcrQI+By2eBSrjcVPGRC7lqlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9QpkSDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF9C19425;
	Tue, 14 Apr 2026 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776166195;
	bh=y5RqzwqGCOp6MOPA0v+0gXwKnYP7j3g4YU/R6L65eU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9QpkSDELOlqTiY4srJXIcyld3VzkskOLRoQFO6cIOU4AKQOOvzR4OBjGEqbAfDv1
	 uqABgHlLIwhJPSckFu6dToCTmNoLnjOA/o1E5rOTp9GBrXAgik24dcayvHIISrsK1E
	 EfBBXLcYYOTHYGpbcsWDnY7oiFUMi/1qRLEtN3Ho89J3PTPbKvHTkhu+xIdF9tp0At
	 fB/8Hfotc/WmvQFhlkttpk2k1rgjN+aXzQ2OO1x4qApIb1bgOauEJDQ6FmsH9+RrS2
	 QiUVWTR2cUcN2G0wO2jx4saC5RYAVyVum5/q+SeODCpLDISIqhv25hUQJQX6ugTDXB
	 jXJbM+vqcZd2g==
Date: Tue, 14 Apr 2026 12:29:51 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kangzheng Gu <xiaoguai0992@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, kees@kernel.org,
	thorsten.blum@linux.dev, arnd@arndb.de,
	sjur.brandeland@stericsson.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
Message-ID: <20260414112951.GD469338@kernel.org>
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com>
 <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,linux.dev,arndb.de,stericsson.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-237821-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[utility.name:url]
X-Rspamd-Queue-Id: 06D633F95DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:30:53AM +0200, Paolo Abeni wrote:
> On 4/12/26 3:57 PM, Simon Horman wrote:
> > I am wondering if it would be best to follow the pattern for
> > writing linkparam.u.utility.name elsewhere in this function.
> > That:
> > 1. Uses a somewhat more succinct loop control structure
> > 2. Silently truncates input without updating cmdrsp if overrun would occur
> > 
> > Something like this (compile tested only!):
> > 
> > diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> > index c6cc2bfed65d..ba184c11386e 100644
> > --- a/net/caif/cfctrl.c
> > +++ b/net/caif/cfctrl.c
> > @@ -15,6 +15,7 @@
> >  #include <net/caif/cfctrl.h>
> >  
> >  #define container_obj(layr) container_of(layr, struct cfctrl, serv.layer)
> > +#define RFM_VOLUME_LEN 20
> >  #define UTILITY_NAME_LENGTH 16
> >  #define CFPKT_CTRL_PKT_LEN 20
> >  
> > @@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
> >  		 */
> >  		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
> >  		cp = (u8 *) linkparam.u.rfm.volume;
> > -		for (tmp = cfpkt_extr_head_u8(pkt);
> > -		     cfpkt_more(pkt) && tmp != '\0';
> > -		     tmp = cfpkt_extr_head_u8(pkt))
> > +		caif_assert(sizeof(linkparam.u.rfm.volume) >= RFM_VOLUME_LEN);
> > +		for(i = 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i++) {
> > +			tmp = cfpkt_extr_head_u8(pkt);
> >  			*cp++ = tmp;
> > +		}
> >  		*cp = '\0';
> >  
> >  		if (CFCTRL_ERR_BIT & cmdrsp)
> 
> I agree that the code suggested by Simon is clearer. Note that AFAICS it
> lacks an additional `tmp!= '\0'` check to break the loop, but even with
> that added it should be preferable.

Sorry, I left out the `tmp!= '\0' check.
That was unintentional and I agree it should be there.

