Return-Path: <stable+bounces-219864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLj4JGa/oGk1mQQAu9opvQ
	(envelope-from <stable+bounces-219864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:47:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F051B0071
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C701300680A
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C55447A0B4;
	Thu, 26 Feb 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fq1AS2DC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706753D1CA5;
	Thu, 26 Feb 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142432; cv=none; b=Vv4EPhkAXIhNY0FYAWeXtkjrnOowMdwJUwgL9DnKf93QNfyjFONmV9rxy5LZCt0BN5cqwq4WU+Tlul8931mVN1wurZuU1pREj+ixslUn8M5l9HyLogV+H3XI+ycyEL0IEbI+ExTsRywQ0xH3rHe+3gQnckMYhYjAUwSsXrBOwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142432; c=relaxed/simple;
	bh=wvao/W1n8ixelWi/yHBw/ra73ktqsrn9Enzu3HauzIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHkriinOQLL5OdN3pH2Bden6kazDFvHhC7EvYol0HY6yMOCxLAip4bbE6lhzOdw2sHFkEpxMKsCtejPefsvNO4YDskGHCpiUXcyc1CKPGVRciEqBm9JWht9/K8g5SsCq4SEg9dflzinitoRUTKAAEaqkacvQIQ1CRQMrVwLca+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fq1AS2DC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E33C116C6;
	Thu, 26 Feb 2026 21:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772142431;
	bh=wvao/W1n8ixelWi/yHBw/ra73ktqsrn9Enzu3HauzIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fq1AS2DCwz8P/rY5ZGgWg4vS6UbQ7mgI6oESy2iwEyrRL3ISkq0dZg1A13B6FpkgE
	 B791dknlD85cWFpfPbmdPPUkk/ZSFwoceTdjEDVcx9Ehlo+KuA8Q6a3rr2xYBKinrD
	 UNyL9e/s++nlJwUywb3sHo3fae3lsFk1oAzo+flw=
Date: Thu, 26 Feb 2026 13:47:03 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
	conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, lkft-triage@lists.linaro.org,
	patches@kernelci.org, patches@lists.linux.dev, pavel@nabladev.com,
	rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
Message-ID: <2026022640-ranked-resigned-83a9@gregkh>
References: <20260225155341.094945851@linuxfoundation.org>
 <20260226201056.28728-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226201056.28728-1-ojeda@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219864-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.879];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 40F051B0071
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:10:56PM +0100, Miguel Ojeda wrote:
> The drm/tyr build error (`COMMON_CLK`) is now fixed, from 6.19.1:
> 
>   https://lore.kernel.org/stable/20260215023627.56245-1-ojeda@kernel.org/
> 
> The fixes for the other build error (`COMPAT`) and the warning
> (`unwrap_or`) have not arrived yet.

So should this be backported?  If so, how far back?

thanks,

greg k-h

