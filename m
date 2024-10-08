Return-Path: <stable+bounces-81500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A8993C60
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 03:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153212813A2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF3914A82;
	Tue,  8 Oct 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tDKu7nOp"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D31E519
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351743; cv=none; b=XtuXS3/Sj9BZYZ8U2/V5OKuRlkoy0H6ULRBa4qloY8a5L907iwPdJg2GGedaRlAsib5yK+dZBHI/xCquDO0jOBIqH4APWCMdOi9FL3SeBOAaYCrqBfv9S/N1AhBEdLmednL9PrEwIwjXD5iwdTweIQAeijaR/8D9u3PgyTOcOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351743; c=relaxed/simple;
	bh=5pA89Rg7oaz4Ibt7dpsZdwCutHczCehf1ctyBjleX+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=l9iVoNat91IHGKDxx4LpWuChjtK3eU+KTNtgWaL3XdiKZjaxKUMeNzVohCAellu2KsnCJlTkUbRSbKeDErN5PV2GMrfPfrHTJKL/8WXD8MJn+ovnAuiIVPWQRcrfG+kWiyfL5vIK9uGGRVTrGnAPBLSbk7RiGs5Tv/fxQcPFgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tDKu7nOp; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <602fc890-8924-4ff4-904c-8bc561745b46@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728351342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYecW2RugHf1zIKNu6odX8I/6lKZT9Sm5v53GOCmkKo=;
	b=tDKu7nOpG6XyhaCh0gDLjeIj+a4lT430twPnFYc7R5XWBIqL38YjvU9kVQYACxvnWXsyIB
	XLDUHuaRGvj5kJ3unzswqn+ZODkv0qAVQAC4LYEW/+RxqGwCD/uKXCCBmIXASEhSx4h4Jm
	vtzgzBsglC3PaklberdbAv3wX98jtLX2Wg+6BZk+IkmF5FvrTcKaOS74cS3RItRQfAfDeJ
	r2xxVbL5C7F6Ao4+qiWyHxI+kQWFHaYxo947sdlKpZ/J4SVZceJmL1IWTyQHpLlkChPmra
	D1Wrm1J+Qq1M4vVhbw3aQJOIb6mUAnYb+uT0q5GKqWzyo2k1GAGYJEv3lTpeSA==
Date: Tue, 8 Oct 2024 08:35:33 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Regression in 6.11.2
To: Mario Limonciello <mario.limonciello@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <d75e0922-ec80-4ef1-880a-fba98a67ffe5@amd.com>
Content-Language: en-US
Cc: 'Roman Gilg' <romangg@manjaro.org>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <d75e0922-ec80-4ef1-880a-fba98a67ffe5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 8/10/24 03:33, Mario Limonciello wrote:
> Hi,
> 
> commit 872b8f14d772 ("drm/amd/display: Validate backlight caps are 
> sane") was added to stable trees to fix a brightness problem on one 
> laptop on a buggy firmware but with how aggressive it was it caused a 
> problem on another.
> 
> Fortunately the problem on the other was already fixed in 6.12 though!
> 
> commit 87d749a6aab7 ("drm/amd/display: Allow backlight to go below 
> `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`")
> 
> Can that commit please be brought everywhere that 872b8f14d772 went?
> 
> Thanks!

So far commit 872b8f14d772 got added to 6.11.2, 6.10.13 and 6.6.54.
It is also queued up for upcoming 6.1.113 and 5.15.168.

-- 
Best, Philip

