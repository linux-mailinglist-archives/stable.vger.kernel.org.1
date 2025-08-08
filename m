Return-Path: <stable+bounces-166839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC644B1E91E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2547ACE04
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC727C84B;
	Fri,  8 Aug 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPXgVpUk"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72C2797A9;
	Fri,  8 Aug 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659514; cv=none; b=Ac6i+y7OaNXQUYkJ2A4WGTGt/Ln8cnqiRh6yY4XsigSUS8stQD8+/NE8Cnlkyj5S0czZMDgwTBc+pLNNErZNlz5JEWv07OXFpYYk3amMAWk3oe4I9I6Zx+CvdoH+t7V0VtLo9IhSQ5l4S9vTJ/G9u45OT0IsCF7BCPTMGtdpbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659514; c=relaxed/simple;
	bh=uki83tZpcn/OHTl3GX/EsCmOHM2028MHeLf0f+1lBZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fsMRuHUN/ewzMB0dHpIr7Pya3NtvWqwgU2nWnhVlp1mQXNN80kBDZ5yIVLhCS/zsMb7s0/Gl6msPtNf+hmQh62iSufDz2I8lWzKw/C+ODWa5Oo5thpqmMv1GVIH+Zk8tO2kyYdVp6j6saXKY3opzR7b8GTuXneI1i0bzwNcCqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oPXgVpUk; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578DOWEo602038;
	Fri, 8 Aug 2025 08:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754659472;
	bh=i5QrXCqm+pifeK6qyJpbRjapusOqLRIsZv1SdbjtFgM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oPXgVpUky4MiMEuzV1gaxhmE2P+CcZTLHNyN2yEibVfjZ/F5eY7MQ2SGoxsMEMgws
	 CDyKh2OOKPW2sGr69AInzj4bQcGNAFUnX+p0uOROD4gmIoO7VqqklFxjDyxJgsHdUF
	 6fXLAC6SNg3YueNO8Qt6voOsWnMUjzmbCnldmJ0M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578DOVfQ1612002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 08:24:31 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 08:24:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 08:24:30 -0500
Received: from [10.249.145.16] ([10.249.145.16])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578DONpB3102888;
	Fri, 8 Aug 2025 08:24:23 -0500
Message-ID: <19dd9aa9-43c6-4483-9cdf-f297e41ecdec@ti.com>
Date: Fri, 8 Aug 2025 18:54:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/tidss: Fixes data edge sampling
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Louis Chauvet
	<louis.chauvet@bootlin.com>
CC: <thomas.petazzoni@bootlin.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ti.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Benoit Parrot
	<bparrot@ti.com>, Lee Jones <lee@kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <s-jain1@ti.com>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <1951ecfe-d080-464c-8441-f5400f535495@ideasonboard.com>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <1951ecfe-d080-464c-8441-f5400f535495@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi, Louis,

On 07/08/25 18:51, Tomi Valkeinen wrote:
> Hi,
> 
> On 30/07/2025 20:02, Louis Chauvet wrote:
>> Currently the driver only configure the data edge sampling partially. The 
>> AM62 require it to be configured in two distincts registers: one in tidss 
>> and one in the general device registers.
>>
>> Introduce a new dt property to link the proper syscon node from the main 
>> device registers into the tidss driver.
>>
>> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
>> ---
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> I understand why you call this a fix, but I think this is not really a
> fix. From looking at the patches, my understanding is that for DPI
> outputs we have always only supported certain clock/data edge.

I don't think driver makes a distinction between supported/unsupported
or errors out in case it is run with "different" clock/data edge panel
(for e.g  DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE is set per the panel
configuration). Instead it tries to program the VP registers per the
DRM_BUS_FLAG* getting passed by framework per the connected panel and
gives an incorrect behavior if those are different than defaults since
those settings are not sufficient for these displays and instead extra
MMR register settings are also required.

 So this
> series is adding a new feature to the driver.
> 

I think it is a bug due to above mentioned behavior, and good to have a
Fixes tag.

Regards
Devarsh


