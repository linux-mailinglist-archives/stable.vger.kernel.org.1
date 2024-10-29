Return-Path: <stable+bounces-89229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64869B4FF9
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739AE284AE4
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3B1D9665;
	Tue, 29 Oct 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="Kaqmlo1B"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F15C96;
	Tue, 29 Oct 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221172; cv=none; b=Q+WP3Lrvg2xM7ul3adlxm+GC/HnbAQIPgzi5LXH9NaoDOxZeTkCQWK6KobQvj0Y6bM5pS93cNdUJB0sGwtb67NfJ8keUwrFem/QvgfAPS5Rd+VD8Ke+3XPhE1D2vCwgttwrZZXsPeDOgt0wnyZSKb7DfLCZ7MJ199bmX9aBKmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221172; c=relaxed/simple;
	bh=xkjDFKEopMFw1/gKXwiPhb7Aogn2Cgx5LOdrbCbNtHk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYpPOY6DaQmNUNC6uzRz9OAal3zRJZhiSlsFSAEX4jptqg4W9So+yYqquqQYzPhFRtjrDfZObHfD9B3I4GtlkLAGp2P6R0HS89XEkB2OiM/L/oxzsgQd/l6HKcMfUO3NnEZCzm1dRF1SvW0jjnxpwW1gunQboBqAm9iYBoH35Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=Kaqmlo1B; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 29 Oct 2024 17:51:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1730220705;
	bh=xkjDFKEopMFw1/gKXwiPhb7Aogn2Cgx5LOdrbCbNtHk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=Kaqmlo1Bvv6wD1wJfblGoV/kf2gdsmFB2tpfJQnIX/uPHYvljMYuwhmW3rx3Kl8jj
	 xeMsC8t0bbPu0ReALMb6jDpdX49+sHpDg86rBtw9PF0DJWr4Jsu1LwFLEg4XKT7qn8
	 RxGFnX4FubP+c7kJevIjiEez8Dt2V50rCYp5iglzErzbrqDwcXSsPH6U2B5w6yM80x
	 iPlWYWg6vUHLE3uOo+0taR5ht50mACRc62Zq4p67YTempP51HbL+RHpJOeWLWTNJ86
	 Vt1xMBmBeOC80Hf1uDlDtwVqlzKzakc3ty/ZRRVh3O2EVboF0JlzV7LQ/zPUCPbSjs
	 /5GfEJsjsbIEw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Message-ID: <20241029165144.GA20438@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241028062312.001273460@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.

Hi Greg

6.11.6-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

