Return-Path: <stable+bounces-226976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFWaGm9Wumm8UQIAu9opvQ
	(envelope-from <stable+bounces-226976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:38:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 761CD2B710A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B10D30131B3
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D735CB6B;
	Wed, 18 Mar 2026 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YKKh0Zp4"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAF368279
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819490; cv=none; b=DPfj6uaKdg2fAQ15usKjS1cO4D/WZgmMG4achiDjhpwUjdDv6n+Omc8BbEwJ2748N67Vk5xRcisaxrltdv3i2NKJyta2GrmdoEp1JPk3lkONMR/TMRsaXw3c/1m4bg/EdFHHsYBvTvlEbj3udLsVekiW6RA8bEj6u1f9RUzoivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819490; c=relaxed/simple;
	bh=JfTkFXIQ5WGeAo/AofWhbulGErDJTUUtQC20R781hJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDyeOYW8eaKDqEiCT9iEs9jmHEd9pJv1JPasfHIKTeOagf4+BLqtxfr0JveLECf9GjZf7MyMs1Kyw2P3ASdUZirH4axJCZInW74SCW2P/AF4O9WtF2Bqzzh2ug2ShMOrKfXlhCIT7LzLWbhFvVeje0+dXDHTxQ1+5P0IFjBSnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YKKh0Zp4; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-33-2-132.ip42.fastwebnet.it [93.33.2.132])
	by mail11.truemail.it (Postfix) with ESMTPA id 92A8723F74;
	Wed, 18 Mar 2026 08:37:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773819479;
	bh=lZbrfKSUBZ3lZubyaklH+7B9Co6uqKT7/tKcqtr1ovA=; h=From:To:Subject;
	b=YKKh0Zp4DAWzAoJTAdNEdv2kO9e4Gv/4hlLKXsvcMZiHlixAysSDutuQgh9ssdQHc
	 xdp+VEJ/ZdREOWTkQu4/gy+217fgZHRj7i+LR/UL0G//10UL0O7z67wFqN6huBgW/D
	 /bECS0TYlIzQA7CdbPIVFn12yBmXLm3ILJTCeE5o888CAWD9TvzhhVdZZHT5Cm4F/N
	 GJ9zWNlaeEHPpX3SUyJTpZfW1Vy6/AXd8pqLLdmvjQXHu9vf/LQ6YiYcLmXhkapfrr
	 kjW9Jv+bxUta84VWSaTRI2ucGBv5xWiNUneuh5rIFea/G5JbVwEbz42Sztbg3CfEUE
	 5F5vufUxAkWAA==
Date: Wed, 18 Mar 2026 08:37:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Franz Schnyder <franz.schnyder@toradex.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6.18 190/333] drm/bridge: ti-sn65dsi86: Enable HPD
 polling if IRQ is not used
Message-ID: <20260318073754.GA13812@francesco-nb>
References: <20260317162959.345812316@linuxfoundation.org>
 <20260317163006.402839129@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317163006.402839129@linuxfoundation.org>
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226976-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dolcini.it:?];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DMARC_DNSFAIL(0.00)[dolcini.it : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.969];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[dolcini.it:s=default];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toradex.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 761CD2B710A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Greg,

On Tue, Mar 17, 2026 at 05:33:39PM +0100, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Franz Schnyder <franz.schnyder@toradex.com>
> 
> commit 0b87d51690dd5131cbe9fbd23746b037aab89815 upstream.
> 
> Fallback to polling to detect hotplug events on systems without
> interrupts.
> 
> On systems where the interrupt line of the bridge is not connected,
> the bridge cannot notify hotplug events. Only add the
> DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> otherwise remain in polling mode.
> 
> Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
> Cc: stable@vger.kernel.org # 6.16: 9133bc3f0564: drm/bridge: ti-sn65dsi86: Add
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> [dianders: Adjusted Fixes/stable line based on discussion]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Link: https://patch.msgid.link/20260206123758.374555-1-fra.schnyder@gmail.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please queue also commit 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add
support for DisplayPort mode with HPD"), it is a pre-requisite for this
one.

Francesco


