Return-Path: <stable+bounces-214650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pm6OfzehWn4HQQAu9opvQ
	(envelope-from <stable+bounces-214650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:30:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3E5FD9BD
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 13:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1249302BE82
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A4308F3B;
	Fri,  6 Feb 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rk0vVuOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741A33B6CC;
	Fri,  6 Feb 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381047; cv=none; b=psLoyj07gnMQLRty1Cut7JbROFD/HE1xoPpu9khAD8laCkRxrW0nXSbnI+aGStwvvP4rRG7zHpWbivANT1W5elDVozeV+KCxmMSwvrRrucs16HPXbth1H1YhuLQIj3mQUZBYVPWwEQgD0qt6YoJkkrwiV4iV0M5/zArxgzhqCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381047; c=relaxed/simple;
	bh=9WHTS71miiLscPr6JhfGIdStsTFEspi/SQVyYk3RoSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+53RymJPm1Jcg3r2jRQPtX9/AUwp5WDHE0yoKCP99YS91Wp2eSNRtEegzFSs2q8TeRaqCB6er/409xJbBaOKW9oq00urcRjC/y88PBOt25G1Kaenz9TuoJ3PSbbpIxss+P+5ImoUEizlYMuh73MDATWqjNYkxWhJ5x28ic8frM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rk0vVuOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45215C116C6;
	Fri,  6 Feb 2026 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770381046;
	bh=9WHTS71miiLscPr6JhfGIdStsTFEspi/SQVyYk3RoSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rk0vVuOxBgWlqARFaSyW2/r5eaJ9gTuxdKdi9nzGQfssNdHG06DlUplNsFm6vmHoC
	 ox20YVHOii/cI02wGGF4X5cjOs4AZ+496nTRNlVDSHlGibWlXGhVEUJVLGBB/MpPBC
	 N5sTLSN+ymRKE+mobwf22bBBvTpIqqOtpJpIWEeo=
Date: Fri, 6 Feb 2026 13:30:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/160] 5.10.249-rc2 review
Message-ID: <2026020619-eccentric-retaining-86ef@gregkh>
References: <20260205143430.733102763@linuxfoundation.org>
 <CAG=yYwnDVbTB3Y+zX8yLATGRKeZzSXNu-eiU-ABReZhJ0vep3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwnDVbTB3Y+zX8yLATGRKeZzSXNu-eiU-ABReZhJ0vep3A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214650-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4D3E5FD9BD
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:49:46PM +0530, Jeffrin Thalakkottoor wrote:
>  build error  for 5.10.249-rc2
> 
> ------------------------<screenshot>-----------------------------
> make[4]: *** No rule to make target
> '/home/jeffrin/kernel/linux-stable-rc/tools/include/linux/compiler_types.h',
> needed by '/home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o'.
> Stop.
> make[3]: *** [Makefile:179:
> /home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o]
> Error 2
> make[2]: *** [Makefile:48:
> /home/jeffrin/kernel/linux-stable-rc/tools/bpf/resolve_btfids//libbpf/libbpf.a]
> Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile:71: bpf/resolve_btfids] Error 2
> make: *** [Makefile:1978: tools/bpf/resolve_btfids] Error 2
> 
> --------------------------<screenshot>---------------------------------->

What config causes this?  What target are you building, libbpf?

thanks,

greg k-h

