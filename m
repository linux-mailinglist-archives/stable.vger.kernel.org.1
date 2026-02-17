Return-Path: <stable+bounces-216794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNInJlhilGlfDQIAu9opvQ
	(envelope-from <stable+bounces-216794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:43:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2014C0EB
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42D43300443D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4973542EC;
	Tue, 17 Feb 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jC1k+gex"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5D3542D6
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332179; cv=none; b=uGDLFQ9hk9nn7MyHrGLlyYjK5Vtsob/b/gv+m+TPkXM4OJv2dPNTYXRj5E0ktltG8e2+jjqJLh2w/dVdN1VNKMWshnI5SAPW1Kzv6M16RB/foqndwlA6jZw5fzJooKiphFaMa+gZvTf6+B43JW8Bjv0CwDQ+CyiXYTy0n0FgPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332179; c=relaxed/simple;
	bh=oqseBuWT575RgWrRIixXYL8Z5xQmseGLVknc73bgEnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkmi/ohXgaoSuwJFLj+TiPf2Ida7FUErdnvodbQ0myrJ1sO+F/wmosC3MetOvLxkWmpdtrvDC3Q0O7fTttf0Pvflwy5fhSWkxXUTaSHgC5o9Zgcy0op6+wPwggfCd2W+F8MW89NgpZMwis0+x8+QkUNrMeAQ9kgZqrv1dmriEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jC1k+gex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC8C19423;
	Tue, 17 Feb 2026 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332179;
	bh=oqseBuWT575RgWrRIixXYL8Z5xQmseGLVknc73bgEnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jC1k+gexXe6W968NovMxwvIqewOwi7i+nqmNX/Gg7Q+4jTXW8OkpYW9pwHcxVzEhD
	 EwCDPjSWs0Sqr0YO657R7WYkPr6UfhgLYypYKDmYlKXhkwIzvga0bLYYdG8I7dwZxH
	 KmQ5hoISRFnITsSqxzB5uuvPddm8Rf3LZ+GYNQac=
Date: Tue, 17 Feb 2026 13:42:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Sarthak Garg <sartgarg@codeaurora.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH for 5.10.y 1/2] mmc: sdhci: Introduce max_timeout_count
 variable in sdhci_host
Message-ID: <2026021744-scalded-steadily-2085@gregkh>
References: <1771217321-26246-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1771217321-26246-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216794-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABA2014C0EB
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 01:48:41PM +0900, Nobuhiro Iwamatsu wrote:
> From: Sarthak Garg <sartgarg@codeaurora.org>
> 
> commit e30314f255117f37412d41e918f941a9ae0835f3 upstream.
> 
> Introduce max_timeout_count variable in the sdhci_host structure
> and use in timeout calculation. By default its set to 0xE
> (max timeout register value as per SDHC spec). But at the same time
> vendors drivers can update it if they support different max timeout
> register value than 0xE.
> 
> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: https://lore.kernel.org/r/1628232901-30897-2-git-send-email-sartgarg@codeaurora.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>  drivers/mmc/host/sdhci.c | 16 +++++++++-------
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 10 insertions(+), 7 deletions(-)

Why is this needed in 5.10.y at all?

thanks,

greg k-h

