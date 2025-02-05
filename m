Return-Path: <stable+bounces-113959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A2A29A4A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 20:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4120188A477
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7F207E0E;
	Wed,  5 Feb 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gEriVhBj"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C261FF1B3;
	Wed,  5 Feb 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784359; cv=none; b=Wp2wN6ya3Dgjie0dnTtDlC+KtsZsGVlmec3xzN+vBHvlfI3qhEb0l50E7TxXupAlXGL9npjKSa0NEJqlATw51758jyHKmSAZvxnkeBdfX4hmNbKdsBdfQkNeq7jk+2MidISEol6TILxzoPVIv32Uo7Myd/TvpIJHPwVwnUwF1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784359; c=relaxed/simple;
	bh=zKOiOlHpbUp4kXpTzvoyfe5HyGDtgYP/N9y2FM6xobo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C8aAHBLOAhR33NXFuhmIigO8NhXnJ1+PgbiX5POzBhfmzm49n41PqNNZCP8xXRviLMI9H7Mo0iqQjn0dwpPNh5cbfN9xlEUnDXSEBqFd07lRzHqF1AZCYNRgn33uHnmUPX7kBgJrcdt+WzrnHlBQXqlGYdddTx6GZL+o4YSSrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gEriVhBj; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515Jd8GQ3413358
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 13:39:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738784348;
	bh=ZyjPaBbnb1ioUY1aZ/qbMWRhtW3CaVcbfAm0oTsy96M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gEriVhBjDKj6EJRF31VLgY0WLSgAG1iIbPaw4ULEj3TnywsHi2f5SKEE7UmorA8LL
	 04aBEDy+Dw09lYoaLUJZb/ZCSG4ZHWkL8kaEPqw8yuHnjsSo5G9qIwgldrq1HX/fr7
	 FzbYUnYqWr8ED1NhbtbB/hLfaR0OaeYv9CmmgWGI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 515Jd8r0056138
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Feb 2025 13:39:08 -0600
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 13:39:08 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 5 Feb
 2025 13:39:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 13:39:07 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515Jd8Bk032794;
	Wed, 5 Feb 2025 13:39:08 -0600
Message-ID: <93d7e958-be62-45b3-ba8f-d3e4cf2839bf@ti.com>
Date: Wed, 5 Feb 2025 13:39:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
To: Josua Mayer <josua@solid-run.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rabeeh@solid-run.com>, <jon@solid-run.com>, <stable@vger.kernel.org>
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

On 1/27/25 2:12 PM, Josua Mayer wrote:
> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
> 
> This commit uses presence of device-tree properties vmmc-supply and
> vqmmc-supply for deciding whether to enable a quirk affecting timing of
> clock and data.
> The intention was to address issues observed with eMMC and SD on AM62
> platforms.
> 
> This new quirk is however also enabled for AM64 breaking microSD access
> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
> causing a regression. During boot microSD initialization now fails with
> the error below:
> 
> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.115348] mmc1: error -110 whilst initialising SD card
> 
> The heuristics for enabling the quirk are clearly not correct as they
> break at least one but potentially many existing boards.
> 
> Revert the change and restore original behaviour until a more
> appropriate method of selecting the quirk is derived.


Somehow I missed these emails, apologies.

Thanks for reporting this issue Josua.

We do need this patch for am62x devices since it fixes timing issues
with a variety of SD cards on those boards, but if there is a
regression, too bad, patch had to be reverted.

I will look again into how to implement this quirk, I think using the
voltage regulator nodes to discover if we need this quirk might not have
been a good idea, based on your explanation. I believe I did test the
patch on am64x SK and am64x EVM boards and saw no boot issue there,
so the issue seems related to the voltage regulator nodes existing in DT
(the heuristics for enabling the quirk) as you call it.

Again, thanks for reporting, will look into fixing this issue for am62x
again soon.

~ Judith



