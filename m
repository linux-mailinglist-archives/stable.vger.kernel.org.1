Return-Path: <stable+bounces-210772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dRMMEacBcWlCbQAAu9opvQ
	(envelope-from <stable+bounces-210772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:41:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E86FC5A0A6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D571E72E0FC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0613F0757;
	Wed, 21 Jan 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DX8Gx26P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A34D8DAF
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007364; cv=none; b=IogCe6tf445rv+vpwCRPzZkj7h1HiMNM5+Avhr9zKnz56m69VxEiFSS+bl6AdYEgdR7bePTG3j/vBIdb/KrQVvMKwQv8iEo8UKVojpwf1jvOMA0VPabqHzM2ZhxQAZ+Q/EM2qZWccT/EegX87wY216hODEnb0IYmi86l2b1hau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007364; c=relaxed/simple;
	bh=6zOGxj0qNNeJtOr9V/Ple6jN2OAa23xg6H/XdcZlr8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V50WMQuXgy6yiTMwANsP8lkiCoUfIg9FPUZmNjrCeldU4HNAMrHbzVcM9fYe+ofkkO9y/nq02iS/e6pkSklAwlftnh3usnbb5xfOryq+YKBcIrYGBnj4IKdgg/Sd7GFI2Wd7riDhj78PNz2jTmboLV4WjeTZEvB4/MMhYB2kK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DX8Gx26P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3205AC19421;
	Wed, 21 Jan 2026 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769007364;
	bh=6zOGxj0qNNeJtOr9V/Ple6jN2OAa23xg6H/XdcZlr8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DX8Gx26PHXGrq9jnUG2U15SgXvwbf29lrusepDh73s6E6wfLfEB3wOPXBQ6Of59++
	 fBYs2roC64iZD2UV2O4YZhl6c71w95nNfJvD9OI9B58eAXO1/ww98YUZ7TQkFZBt6+
	 d5MyGlqF6kCuuqnoS+8vQR1ll1+ZvfWUZsC2INw8=
Date: Wed, 21 Jan 2026 15:56:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] v6.6.120: i3c crash caused by commit 82a09b9965ed
Message-ID: <2026012139-fidgeting-comic-916c@gregkh>
References: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-210772-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E86FC5A0A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:04:03PM +0900, Kunihiko Hayashi wrote:
> Dear stable maintainers,
> 
> After updating from v6.6.119 to v6.6.120, I noticed a kernel crash
> when I3C was enabled.
> 
> This regression is caused by:
> 
>     commit 82a09b9965ed ("i3c: fix refcount inconsistency in i3c_master_register")
> 
> The issue is resolved when the following upstream fix commit is applied:
> 
>     commit 3502cea99c7c ("i3c: Move device name assignment after i3c_bus_init")

That does not seem to be a valid git id, where did it come from?

thanks,

greg k-h

