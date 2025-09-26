Return-Path: <stable+bounces-181788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A7BA4F2D
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC0B1B2770D
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA41F4192;
	Fri, 26 Sep 2025 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GMjmS1D3"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677D2A1CA;
	Fri, 26 Sep 2025 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914147; cv=none; b=JWg7VJicSZEsFKpJuACoODC364f7G0pIj0MUXdPSFgi7b2w5eETcxQoaJIvlIHsdcn29H56NrMJl86px+MSJTZOrB/nOnorE8V8oE/IsDe7kODOikmASds3i++bQL0Bu+3byBYuNS5I2SEIbM/VJ+Zlx9kfc5E//6RI+4AMDtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914147; c=relaxed/simple;
	bh=/aNc3teXYyRj8ni9DWq0KsAHiheGNzF92SpFUNfa2LU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C9awTefU4PVaUvlHYNeSWpYbqZGoPr7EZD8+5IzYWevISlFGflOoF1Hs86+Pboh/dqhaPpeJIRn78qk72IVpo7Oz2arNTANPuXpYFaZbLyl8uvNLpAe7LXDGCh3ggUYO6jT55ffAvQbwPI2VTnxOu5L8oc/qPcrtv9KrvxkgP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GMjmS1D3; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758914132; x=1759518932; i=markus.elfring@web.de;
	bh=/aNc3teXYyRj8ni9DWq0KsAHiheGNzF92SpFUNfa2LU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GMjmS1D3TuXHDXQYGp9CpuGQ/R7d9HC0XVOeD3/4060a1KYUL7oAaqwUExCvo288
	 bwvsyJXTBk2TAcgFm+kQNxSPbyOYe25G1IqgRQ8rjN0/rYgEuRVbvmFfpPzEIAmz3
	 MTlgMMgE77lJh3ddfbrEIc90D0QvxGWs0c2ZgoGDhHaoAiItmZBZMDKtqSzV2Ax6x
	 ehrwLdHaR/RkP7N2vxeUwRW6xOp1tEUFJ6fur+BcYdEqjZBrW64JoCJFXFuzIfxB4
	 8QMnyX18mKL4GhQ5fdNDhoSRZQcjF3qmZbJP9SGUNstWBMFmdXhPOCHnWZ085aufU
	 PFZVEfSGPmMTfwEvrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43Kc-1v2Dum2ASW-00FDEK; Fri, 26
 Sep 2025 21:15:32 +0200
Message-ID: <bf33acbe-a9c3-46aa-affc-34e416a4b1e3@web.de>
Date: Fri, 26 Sep 2025 21:15:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, linux-amlogic@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20250926142454.5929-2-johan@kernel.org>
Subject: Re: [PATCH 1/2] soc: amlogic: canvas: fix device leak on lookup
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250926142454.5929-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7zutT7CJ+1VskfKbD0bGNLbj29yEZTSD4JnkB/k295iRRDDIN06
 lpooIXBRfdflodsh62weAFORNJPlvT8SQfJ/HjDTBcY/Uh1lgid4h9CZYWzuiPzfrffJAfR
 edrO69DTU80m0mL7lpmn57p24smZqxjDixN29Csa5EWE0S+N56AQyC5LJjzGYm/S/nzQrNy
 FL/e3Cv4JJqfsN3wPUcHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I07t/8RDwME=;SAifApDTNhX6zDPY2Rei6+mS7Kl
 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

> Make sure to drop the reference taken to the canvas platform device when
> looking up its driver data.
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L=
1180

Regards,
Markus

