Return-Path: <stable+bounces-243884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLZ+JJbR+Gm41AIAu9opvQ
	(envelope-from <stable+bounces-243884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:04:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D54C1B9D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62FD930247C5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA73E4C65;
	Mon,  4 May 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XJ7ACMUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C13E3D9C;
	Mon,  4 May 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914063; cv=none; b=YUn+a+IacCrbpznMVHy+uxNm0mE5ShDdsHwIZBZZk69OSVpHDeg7KH719011ZX23d0ll1Ms1r+qEfe2gxaOJpzG0wEXaf+swvyep79NeHYgHZcNuojDb9Km7XGQxjNYoFthb1DvPzA7HsHZJHHUVy8Nm98pWtG8KzyhEJVdYHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914063; c=relaxed/simple;
	bh=lAYBYeOeu14ggNWEnuE6Ij/ZfPo8Sdq4PY0ZwB5kwKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpfgV4DvDSadXE+P91iOBiI333xO1TS+WyjX3IrFS3Hp9Cfc9J2GlcSpPWfbqeDQ5pbnnwaN99Rydkv+VpXXyjJ2GMKiFs/CtqlSB8buv1JuZSR0v3ZWxferWf/8e1K/FSYM3Vc2FiaxjpknQWdCC9jJM908SZcs25D/ebDMMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XJ7ACMUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A74AC2BCB8;
	Mon,  4 May 2026 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777914062;
	bh=lAYBYeOeu14ggNWEnuE6Ij/ZfPo8Sdq4PY0ZwB5kwKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJ7ACMUdgipQw8K++TdwNSPa/NGFVkFYyWD0HqBC67osB216uDYiVEfHl7JgwAR5+
	 B3t33hHHLTVLXGL5cZSC2EAFZKFR/3Zoj8q7NTAoUzPGZzjRZFJr1VIs52ob8HuBaa
	 pxIsJO5idgulcen/KRvQZ6ZO6M51DyOapc5XD9Dw=
Date: Mon, 4 May 2026 19:01:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Feng Ning <feng@innora.ai>
Cc: linux-staging@lists.linux.dev, Luka Gejak <luka.gejak@linux.dev>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] staging: rtl8723bs: fix heap buffer overflow in
 cfg80211_rtw_add_key()
Message-ID: <2026050434-unpadded-sandstone-0412@gregkh>
References: <20260413113224.5201-1-feng@innora.ai>
 <2026042626-tabloid-suitor-33c5@gregkh>
 <20260427111738.33069-1-feng@innora.ai>
 <2026050417-monkhood-backless-4c3e@gregkh>
 <20260504154823.52057-1-feng@innora.ai>
 <2026050458-numbness-haven-1ae4@gregkh>
 <20260504163828.90294-1-feng@innora.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504163828.90294-1-feng@innora.ai>
X-Rspamd-Queue-Id: E16D54C1B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243884-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]

On Mon, May 04, 2026 at 04:38:35PM +0000, Feng Ning wrote:
> On Mon, May 04, 2026 at 06:03:02PM +0200, Greg KH wrote:
> > Let's fix this in a way that the code can be moved out of staging
> > someday please.
> >
> > > That said, I can see the argument for -EINVAL: it makes the contract
> > > explicit and avoids installing a key with a truncated sequence counter
> > > that could produce unexpected crypto behaviour.
> >
> > Yes, that is better.
> >
> > > Regarding hardware testing: I do not currently have a physical
> > > rtl8723bs device.
> >
> > Ideally someone can test this on the real hardware.  I'm loath to take
> > real patches for this driver without that happening.
> 
> Hi Greg,
> 
> Thank you.  I will change the silent truncation to an explicit -EINVAL
> when seq_len > sizeof(param->u.crypt.seq) for the next iteration.
> 
> Regarding testing: I do not have access to RTL8723BS/BU hardware to
> verify this, and I will not resubmit as a regular PATCH without a
> Tested-by from real hardware.
> 
> Would you prefer I send the -EINVAL revision as an RFC on
> linux-staging and linux-wireless to ask for a community tester, or
> should I drop the patch until someone with the hardware picks up the
> thread?

Submit the patch and ask for someone to test it.  I think Luka here said
they were getting a device, and I might have one somewhere around here
as well if I dig hard enough...

thanks,

greg k-h

