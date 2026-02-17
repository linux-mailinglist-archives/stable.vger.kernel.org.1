Return-Path: <stable+bounces-216793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGuRKUxilGlfDQIAu9opvQ
	(envelope-from <stable+bounces-216793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:42:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F8914C0E4
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6588B3004415
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55C29AB15;
	Tue, 17 Feb 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdoawdSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60291482E8
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332168; cv=none; b=coQIP8nikAjebZ8W+fOpjOPnWKeOOHvuJsR7/m8VJn/+SMbonr+OoZ+gpFgYkvC3X27RO8i8AvJSwfBcz06hvAP4PpUwsAt6Q9KUjjU8A4PJmGqMNpknAjht6QMEsJO2dsVWpMShWgMzvG2edJZo2dWgK9bdXeAoYzzco+Z7+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332168; c=relaxed/simple;
	bh=MNEBHxYt17S2+IVnuzsQNcWri0ZscAOoVVIyA6LoAgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKPB8vTSQzvCFqc13zyi7dp4UWbBfkgFePcsJvradz5UY3mimlB+pkYQEnOHqf/WeMJSeDLKbTImAsw8EWb6X9wA3eoa8UCXE/YWCuxwQ9tSgq1qP5aPXXnycQJmsGyfZONG06jPtwof5uParXl2eTrvElRpAGgs48qXWz6Z3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdoawdSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E06C4CEF7;
	Tue, 17 Feb 2026 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332167;
	bh=MNEBHxYt17S2+IVnuzsQNcWri0ZscAOoVVIyA6LoAgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdoawdSVZe3tO7AIbMeGA3eX9O1sqsDyiv6VnxHHSNwmAFr7ZDe0JRKdeg6e7HRpK
	 Hp8UKPw80AyDUgwMtd4XbA7mdmz9dwGyqxInm6oAkMtcaWyeB3KvcRH1Wa5Zmlj30E
	 ojhdoykgfAL8jb11JMzqRkSQ5TkTV0+pAmtU2NkY=
Date: Tue, 17 Feb 2026 13:42:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Bean Huo <beanhuo@micron.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH for 5.10.y 2/2] mmc: sdhci: Return true only when timeout
 exceeds capacity of the HW timer
Message-ID: <2026021714-fruit-amplifier-7e78@gregkh>
References: <1771217357-26296-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1771217357-26296-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216793-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1F8914C0E4
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 01:49:17PM +0900, Nobuhiro Iwamatsu wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> commit 9c6bb8c6a1a48608692f3c8c21be13b759ec9056 upstream.
> 
> Clean up sdhci_calc_timeout() a bit,  and let it set too_big to be true only
> when the timeout value required by the eMMC device exceeds the capability of
> the host hardware timer.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: https://lore.kernel.org/r/20210917172727.26834-2-huobean@gmail.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---

Why is this only for 5.10.y?  What about 5.15.y?  And why is this needed
at all?  What bug is this fixing?

confused,

greg k-h

