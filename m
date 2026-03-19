Return-Path: <stable+bounces-227257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIdWIovSu2k4owIAu9opvQ
	(envelope-from <stable+bounces-227257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:40:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254072C9993
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36B8C3028508
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BE3C3442;
	Thu, 19 Mar 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIcJcJzD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8A3C278B
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916804; cv=none; b=YtQlLaPixZyGQcsnsP4/yWXo5PuYK1Bp4R4FKxMmkwSK/wGo3LLLnMx2banS729TR6jPhJ4f2Aze5oRsu31/4d1caHguoLSv5vcjoy2lbQV/eT8JXgiibfb28bQaWEmxNGsLWSGWkqUCA+xKknqjXUfiP2bbSStik8BwMiCRaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916804; c=relaxed/simple;
	bh=o7H2aBAVNi/fLNoA1lhen/I9PzzDLSyUWnSNFrDr9H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhq45l6XPrmxG5uqcGaSnk1Uy3Ggod6v0SrPwYod8AkBWOYhzx0GyQiQ1dBw1wTmgxpGEKQHT22Hs+6v4toP1kJ2COCDJ+XxJ56RzMsxjKSkDjANhXLYhrq6wWutStNVzHl7i/m0zAT7B5Yukwf6Xj+zCBa3AZpw393Yolpbw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIcJcJzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D25C19424;
	Thu, 19 Mar 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773916803;
	bh=o7H2aBAVNi/fLNoA1lhen/I9PzzDLSyUWnSNFrDr9H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIcJcJzDUUKsbqH4KX/miA3HLqOO/DBsXyYbLgswPhDUZjpCa8L8d6yt1TfwOzH3l
	 nWn+jGxRc39/5pwQlYg4R8csTHhFIUlWeBXgVnRj1joKdBNoOSTE/TTSOYmwxXQLDD
	 tsUgIkDW8HpikveY/rK82aWG0WAsSVw6VkDma4jQ=
Date: Thu, 19 Mar 2026 11:40:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>
Cc: stable@vger.kernel.org, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 6.18.y 1/3] drm/i915/dsc: Add Selective Update register
 definitions
Message-ID: <2026031943-outcome-cupcake-bdbe@gregkh>
References: <2026031759-ravine-derived-5582@gregkh>
 <20260318132412.1117060-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318132412.1117060-1-jouni.hogander@intel.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227257-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 254072C9993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 03:24:10PM +0200, Jouni Högander wrote:
> commit c2c79c6d5b939ae8a42ddb884f576bddae685672 upstream.
> 
> Add definitions for DSC_SU_PARAMETER_SET_0_DSC0 and
> DSC_SU_PARAMETER_SET_0_DSC1 registers. These are for Selective Update Early
> Transport configuration.
> 
> Bspec: 71709
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Link: https://patch.msgid.link/20260304113011.626542-3-jouni.hogander@intel.com
> (cherry picked from commit 24f96d903daf3dcf8fafe84d3d22b80ef47ba493)
> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
> (cherry picked from commit c2c79c6d5b939ae8a42ddb884f576bddae685672)
> ---
>  drivers/gpu/drm/i915/display/intel_vdsc_regs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

We need a 6.19.y version of this before we can take older versions :(

