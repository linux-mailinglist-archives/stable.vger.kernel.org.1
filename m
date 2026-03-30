Return-Path: <stable+bounces-231058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCvGCLpBymky7AUAu9opvQ
	(envelope-from <stable+bounces-231058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:26:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAF358248
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73253021590
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923B381AF7;
	Mon, 30 Mar 2026 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcdJp4Hw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D83AF676;
	Mon, 30 Mar 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862459; cv=none; b=oSBQzTZXCGO/S6NsRlzQfqPv4RzSfg7dEUMwtNfZuM4hUHMIIXLwcvsMdkV3tbC0kk+iI8aUVzkcDe71RWsjKNj640kgcXA4+qnnPP0iAhKFVNqBra2WxklLXEek5ecJSD6+lcS7tzdXQXfTkVFwAEc0xJ8Hbxvhe0EbJg+c4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862459; c=relaxed/simple;
	bh=UO5S0C0XmrLYGRry2O1RcdGZmMut9icey3akfZRD4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAzNdamzZ41jGdXkmyACV80Ravr/1lx5CCqnK8iHhSIOG5y06l4xjQzyAYKf3WUBlw0pRXnN8xjS0h544DsIEQfSy/u3Idwxw5OZTRRmQ84MRTuxJnAq30fEzhz8swnCTnuMAsDTK13z7eJGXbw14eReboryXxfvVaWRk1p63Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcdJp4Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FF7C4CEF7;
	Mon, 30 Mar 2026 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774862458;
	bh=UO5S0C0XmrLYGRry2O1RcdGZmMut9icey3akfZRD4Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcdJp4HwQAtkGr/0LXKflVOZ5U6u0CRIRt3L72XCEO9EOeN53WlCeQ+C7C09TwwP1
	 xC7eNcTTxPWpzYjbfiO5stH+5OkhNQcykPo0SQXfJOGRGbBeWgdLqgL0PuY1W6EvLc
	 6Qk0PpDG7b1Uu1O/Mywr/MPQTdrcwHzlHWnygxMA=
Date: Mon, 30 Mar 2026 11:20:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
Message-ID: <2026033024-rebalance-preface-1e39@gregkh>
References: <20260323134525.256603107@linuxfoundation.org>
 <5f4b8e66-db6c-4477-9569-8bb097b1cf83@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4b8e66-db6c-4477-9569-8bb097b1cf83@roeck-us.net>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231058-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2EAF358248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 01:32:23AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On 3/23/26 06:39, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.167 release.
> > There are 481 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> > Anything received after that time might be too late.
> > 
> loongarch images have failed to build in 6.1.y since v6.1.163 or mid February.

That's not good :(

> Is it correct to assume that there is no interest in supporting this
> architecture in 6.1.y ?

I'm guessing that no one is running this arch on that old kernel tree if
this has been broken for that long, so let's just leave it as-is.

thanks,

greg k-h

