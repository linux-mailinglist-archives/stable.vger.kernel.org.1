Return-Path: <stable+bounces-219807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFlIEHNKoGkuhwQAu9opvQ
	(envelope-from <stable+bounces-219807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:28:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244B1A6901
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C79683052520
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF7326954;
	Thu, 26 Feb 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEnwdmPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335E324B17;
	Thu, 26 Feb 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112249; cv=none; b=Id/oxhWYQHP1DAnhPHNkZwxNJx59iu2V1GaUNqcKfhsBbkDaQ7YAkGuAQVuOuQ4M3YGreYlLh+N2mw/z9zbHE8p1+M3o5+CXtk7knad2RgElR+BUyX56PghSHdu9ijA+xpbr7eYLEFVDwoJl+yKypEcEOCr1eMqWnuFgzsOV63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112249; c=relaxed/simple;
	bh=V81ePgAuGbagKH3XEQaK1KD4LuOQ/zN2cLnjJuL8eKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En+SzFqhZWJkc4AF85PTx95MSN35+oYZPOtGoZpsSAwU/hVDfbzVkXy8IF1QsVlHLl7pXQ0DgoQHlAjJWxbbS7TlX75PSNLonBFrb3J2jFk9jHzfkCMjiNNjudPJBDdKBmEXkgBWZ8H0m0+OhreefiTSu0k3+9v3lHf0LHozAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEnwdmPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147C0C116C6;
	Thu, 26 Feb 2026 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772112249;
	bh=V81ePgAuGbagKH3XEQaK1KD4LuOQ/zN2cLnjJuL8eKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEnwdmPjeRqSD4W0QDHtDv1V0eCLZHktwSMw4CfpTgfjggrWInH6aV5ifHB/34CrZ
	 Pa3SMIKFXY99GuovK1ZtrnHvtfu/id52zvix8GOmeMjDrG9CHRssbrxBPz0YleY4Mw
	 9bLarrfuumy0vCmugB0GY9d/lebwNwFmNYm1PKkCqpy7b7vuCl9ZOfgnM0m+Byf1Y7
	 hI9qNUBqrbOnXZTe5NwrGXsYLJxWw9SVvtn/h3eo6oI1G/kvDp6CS3E+dp4Szsgjqi
	 L+Nr9O/kX+JWjFM68X+Oz4BFha7mwPSI84SLWqI2FBwvqPDG0zDN6GtbHmhnu0TsXF
	 iL/er81Gp++sQ==
Date: Thu, 26 Feb 2026 08:24:07 -0500
From: Sasha Levin <sashal@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.19-6.1] mmc: rtsx: reset power state on suspend
Message-ID: <aaBJd1ns_vZKzVN-@laps>
References: <20260219020422.1539798-1-sashal@kernel.org>
 <20260219020422.1539798-17-sashal@kernel.org>
 <CAPDyKFoPehkeOD1-U2CGd_1Owt2Ai6+28Epabz6wGnYVq6k=YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFoPehkeOD1-U2CGd_1Owt2Ai6+28Epabz6wGnYVq6k=YA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219807-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linux.dev:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 5244B1A6901
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:27:35AM +0100, Ulf Hansson wrote:
>On Thu, 19 Feb 2026 at 03:04, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Matthew Schwartz <matthew.schwartz@linux.dev>
>>
>> [ Upstream commit eac85fbd0867c25ac517f58fae401d65c627edff ]
>>
>> When rtsx_pci suspends, the card reader hardware powers off but the sdmmc
>> driver's prev_power_state remains as MMC_POWER_ON. This causes sd_power_on
>> to skip reinitialization on the next I/O request, leading to DMA transfer
>> timeouts and errors on resume 20% of the time.
>>
>> Add a power_off slot callback so the PCR can notify the sdmmc driver
>> during suspend. The sdmmc driver resets prev_power_state, and sd_request
>> checks this to reinitialize the card before the next I/O.
>>
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Link: https://patch.msgid.link/20260105060236.400366-2-matthew.schwartz@linux.dev
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>NAK.
>
>This patch is reverted in mainline, as it's not the proper fix.

Dropped, thanks.

-- 
Thanks,
Sasha

