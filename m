Return-Path: <stable+bounces-181816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A625BA5F32
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 14:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA621B24015
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E42E0B6A;
	Sat, 27 Sep 2025 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IKXhFnQa"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157A18DB35;
	Sat, 27 Sep 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977011; cv=none; b=rPI7afSc59os/ngNO9umRYsqzdgN+EedXQ56+JcCTOS4OxHUT2ByJLz4EfiV6ppesj3KD9zLxtizwdQZv340yqrqYVj4wVUpzyBe64GeZHqv0RPmNQSES+qYwkCsGGrJwaKS03ph6KGPkQU4uuLFbIQvW3vfOoGeddZVMof9tbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977011; c=relaxed/simple;
	bh=87/zf4TpCFHQQD1/92ZIRgUFLZFNJ1HpOYFg0a/pAIo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bP5cIkAis+1rcovaWHB8YimuoLRHtoerSxlct9IKQKLNoXdWs7a4FiiSPNS0e7vao2rLPAnXKqHpBgnJ4xqVjI3s5cSuu+6kfysD1RNEP2MWo0RoItAHF5GGmKh+PNatGrJb80/ZRZYK8oMAOWieiK8ziTwm1qTI3CP9AwGlAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IKXhFnQa; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758977000; x=1759581800; i=markus.elfring@web.de;
	bh=87/zf4TpCFHQQD1/92ZIRgUFLZFNJ1HpOYFg0a/pAIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IKXhFnQai1sD1anDVBypciWR7l1Mv8hpohW106+9AQo5fQzNq14YZOIdt9ZyNGgr
	 kfB0Q+aY858a5ZeVspIkGWvTVcCdWulRB0U794ODRfwUewfFReMageKDNs75I1UKG
	 1rdIWm3T0CPrPsIvNKx9DwkM/SUKSwAGZ3dUz7VWuK3x5wTyKvOvwwfEWusHF83rY
	 y42d10tEEclqjylzC6+pGcM7/h/fH1cCBoSD+7iBrlxOMMiGvHrh1Q1zQxymi6k73
	 luGWbEwla1FM5EEKvMaehZ/4zv0UrUhIGQ5MsWA9qJf1764+V/VLxcpZmqVjI6Tpc
	 uyC8wRFESXaeaIQ93g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1uac611IxR-00ePZI; Sat, 27
 Sep 2025 14:43:20 +0200
Message-ID: <f0b0a007-599b-428b-bea6-5eafc567d757@web.de>
Date: Sat, 27 Sep 2025 14:43:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Simona Vetter <simona@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250927094741.9257-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/tegra: dc: fix reference leak in tegra_dc_couple()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250927094741.9257-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ocAKYcb1yjBwr7/isPr/RbWCbM5s1oflK85ldKkHNuTjbFghT+5
 M6ZxPS29hc83FgVTCGzn/dR03X+XB6KdB5TtKM1PX1Ua4H8Ac4wvkmEr9bqSHFgah0DOEzZ
 3+0WBeNSpz7XmElxq8JuutUSBzCeCf+WxdgJZGdPgrWbVhwocoWV7tiWT31ioZM+R3TUHfz
 ZAj9+R6JBga9o/2StczDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x+MGqKh6rKI=;NYlan4y5Lt14DNWZpOjiTdpPfaG
 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
 R

> driver_find_device() calls get_device() to increment the reference
> count once a matching device is found, but there is no put_device() to
> balance the reference count. To avoid reference count leakage, add
> put_device() to decrease the reference count.

How do you think about to increase the application of scope-based resource management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L1180

Regards,
Markus

