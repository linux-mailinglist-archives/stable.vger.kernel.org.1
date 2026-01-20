Return-Path: <stable+bounces-210487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BWOBodmcGkVXwAAu9opvQ
	(envelope-from <stable+bounces-210487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:39:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E5519AE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2ED917E86BB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640E413243;
	Tue, 20 Jan 2026 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hp1wDEO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E440F8E8;
	Tue, 20 Jan 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907218; cv=none; b=SO4LB8bbunAlnWeOjROp/v4zBu0Ylv7PMpXUAzy8e4/fn3io0UdTzBM0Yu9pCLubCUsK7Sv6pKuznZ+YpC0e8jYfU5x3IKuoyXoqd9Mie7rjxX8fF9GwDRq8TpFm+ppCuRGMxovy8kr39lR1k/FH37SS09DR0dhxSSaTOmVyY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907218; c=relaxed/simple;
	bh=npLLoCnIsqczxNA9Hs/1wfDzzJn16pRKpJhKKxnWtJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRMTljiMzWFGkfd5dwjQ/wN/v8aSDSKzCayDu9PVVyQd6tibN+4DOMurP/9WebTFzoo2pyipvU7plD05R98diCG1HxG7h1/e+yvET2O4KC7vaIigwShpYhCNp/4Slbl2Yg1veIt+GRyB+8UZJkvbBhASlfu6lS/fPe4yJpPwv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hp1wDEO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34483C16AAE;
	Tue, 20 Jan 2026 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768907217;
	bh=npLLoCnIsqczxNA9Hs/1wfDzzJn16pRKpJhKKxnWtJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hp1wDEO8X6TAhp1ewNUDWF4k0xDeekv1YSWHreUYue4L9/K2vX+oRWoGyU87u9eBa
	 ecId9FhBess1qZbUMOMuO/aamvKgh8aCslabA+04x9fgodcoB2+IsbiOVYzWjARlSa
	 g99wmtVWFw0BCPWVCrN4YlSEUSKzl8LihmKWD96I=
Date: Tue, 20 Jan 2026 12:06:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Sharma <black.hawk@163.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: Re: [PATCH v6.1] drm/amd/display: Check dce_hwseq before
 dereferencing it
Message-ID: <2026012033-jelly-hunger-fed8@gregkh>
References: <20260115041919.825845-1-black.hawk@163.com>
 <2026011525-occupier-hangout-ac24@gregkh>
 <52c400f8.2ab6.19bc4bce26e.Coremail.black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c400f8.2ab6.19bc4bce26e.Coremail.black.hawk@163.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210487-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 756E5519AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 10:57:51AM +0800, Rahul Sharma wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2026-01-15 19:44:04, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Thu, Jan 15, 2026 at 12:19:19PM +0800, Rahul Sharma wrote:
> >> From: Alex Hung <alex.hung@amd.com>
> >> 
> >> [ Upstream b669507b637eb6b1aaecf347f193efccc65d756e commit ]
> >> 
> >> [WHAT]
> >> 
> >> hws was checked for null earlier in dce110_blank_stream, indicating hws
> >> can be null, and should be checked whenever it is used.
> >> 
> >> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >> Signed-off-by: Alex Hung <alex.hung@amd.com>
> >> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> (cherry picked from commit 79db43611ff61280b6de58ce1305e0b2ecf675ad)
> >> Cc: stable@vger.kernel.org
> >> [ The context change is due to the commit 8e7b3f5435b3
> >> ("drm/amd/display: Add control flag to dc_stream_state to skip eDP BL off/link off")
> >> and the commit a8728dbb4ba2 ("drm/amd/display: Refactor edp power
> >> control") and the proper adoption is done. ]
> >> Signed-off-by: Rahul Sharma <black.hawk@163.com>
> >> ---
> >>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >We need 6.6.y backport first, before we can take this one, for obvious
> >reasons (i.e. you do not want to have a regression).  Can you submit
> >that one first and then this again?
> 
> >
> Thanks Greg, I have sent out the backported patch for 6.6.y.

Great, can you resend this one as well?  It's long-gone from my mail
system.

thanks,

greg k-h

