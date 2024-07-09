Return-Path: <stable+bounces-58931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7892C3A7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E77F1F236F3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00914D6E9;
	Tue,  9 Jul 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="qgvw2HF8"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E791DFCF;
	Tue,  9 Jul 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551865; cv=none; b=mbMQ7YpDqyQky4g7Mr5ORCmQmj4EgharbQGcGXMl+xcf7sXAn38+uEK0o0Mkv2WXUulk3qcRrNrZOD1wRfv0pmYdyUu/BzGbWlP+tHHtmJlbSyYOzkApqll29OcHmpgXDz3ySPtJm0h1d/udCbczl2I+ZWdv+Udt9JewTPXS/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551865; c=relaxed/simple;
	bh=HF0/7o5KU2/pP2+2T1ocFVX77ZJpeIK7POsT/4QwOKg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdxJibSy48DpVLNs6ZN4fDJoJtc0bCyP8jvPttmUX9z2V9ilQm2hAcRMtKCNsVn4v6KQijD4IMBF9maTwfioV9/UlGSvsdzZhs+zchPU/G2BvnFXYBZ0uXf7h+RAbE+ji2d21OtePwZIooE7ZrIE8FHXTv7oSgqHBgvMyJFGO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=qgvw2HF8; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 9 Jul 2024 20:58:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1720551531;
	bh=HF0/7o5KU2/pP2+2T1ocFVX77ZJpeIK7POsT/4QwOKg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=qgvw2HF84pTyXd3NuO2iOgRTxyQT2IoKuD1kR5i7udEhZhDKH14JRRl0hlrci0M31
	 tNRYNNCrvdxFACPbgHgXlxuAsP4qheO3hiRGuuNtGgIraGOE6lUr4TOT03NIRI1IWw
	 UDdODgfi99wVEM76vw74ygpIJ1IeWwmS/iV7W6Kq2t6vgAFTXPpvo7CQwxvkABLSiO
	 B2nTi7ArmP0LXJyp5nHIy00dORrS9OwfjLCC9Vvno948OkXWze+fCl9RkYYqQY1/qa
	 NYajxlXfQiIY3j+0EvFyATN5nAKp05+LHSkGY8xVCtCd6aYKMq5eqe4XAh8ywQI3w5
	 gkIWHLlFGQjBw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
Message-ID: <20240709185850.GA2524@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709110708.903245467@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.9.9 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.

Hi Greg

6.9.9-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

