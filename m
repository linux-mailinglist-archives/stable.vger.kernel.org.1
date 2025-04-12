Return-Path: <stable+bounces-132313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A26A86B10
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 07:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098163AC78D
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 05:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FA1885A1;
	Sat, 12 Apr 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CIC8k86K"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8C73176;
	Sat, 12 Apr 2025 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744436026; cv=none; b=EGYfCvxmrplumjkHGcicryBvh0X0sIhg9BZXpz4NdVQviRkN43c47OL5ly4uxKqDlTZ3KFFe0o1zXlyXfZwCasZibxI9R6fTtBcDoL1SnwHr5d6Dl9rhfHZcpTKvcg6PzB/1t+dgI/FwpACQOXlj2yGGWVoGC3XImWQNZF6ztGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744436026; c=relaxed/simple;
	bh=cLD7jAJ87R+FYIqblGG4tPh3QkWnbkDjxYPKBxls3JI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd9/r5jymezaTuhwm53r795PTUzlhkd+ja8x3kY3FvYynwVqMbRtPC2+fx2T4Bh3Ed+4ULUyRnnX7vK6PwpMKoaq3EfmD6A9ublxY9Qdb/pudoqLp4z2MV9Ihb86LHlFcV7AMZ5Ymp0P254pvYWUeW5cAg7wtrGb1PfCBaF5iM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CIC8k86K; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53C5XclW1614445
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 00:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744436018;
	bh=HL7rKUTQWHzPt0OWlfsDjec/OxS1CHnG4JHuLvAXp+E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CIC8k86K9V57lJlP9m9TPMXaJOizCeEcSt9p7TaAMpvpCtQdqdp+2PAbezOYSrqSX
	 hxJAOwFztUYQaSuYI8OxtR2xaDIN6EQGcq6av6CziDKdL2c4bfvCtf8z3OIeDdiCYs
	 EoknYeAmSVVgs64A4azQRGZoiNViczkzzzTfWx2c=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53C5XcKQ111783
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 12 Apr 2025 00:33:38 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Apr 2025 00:33:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Apr 2025 00:33:37 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53C5XaW3128327;
	Sat, 12 Apr 2025 00:33:37 -0500
Date: Sat, 12 Apr 2025 11:03:36 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j722s-main: Disable
 "serdes_wiz0" and "serdes_wiz1"
Message-ID: <4d9746fb-5145-4195-94ce-f4b40bc19d0a@ti.com>
References: <20250408103606.3679505-1-s-vadapalli@ti.com>
 <20250408103606.3679505-3-s-vadapalli@ti.com>
 <7b2f69ad-48aa-4aa9-be0e-f0edae272bdb@ti.com>
 <475a1ac1-abb1-4c6e-b5b2-3f1a3399d5c4@ti.com>
 <28f1e0b7-9947-43f3-9a47-f3c6ecd69b91@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28f1e0b7-9947-43f3-9a47-f3c6ecd69b91@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Apr 11, 2025 at 09:22:00PM +0530, Kumar, Udit wrote:
> Hi
> 
> On 4/11/2025 7:47 PM, Siddharth Vadapalli wrote:
> > On Fri, Apr 11, 2025 at 07:31:52PM +0530, Kumar, Udit wrote:

[...]

> > > Since you are disabling parent node.
> > > 
> > > Do you still want to carry status = "disabled" in child nodes serdes0 and
> > > serdes1.
> > I could drop it, but then the patches will look something like:
> > 1) Patch 1: Same as the first patch in this series
> > 2) Patch 2: Current patch + Remove status = "disabled" within serdes0/1
> > 3) Patch 3: Removed redundant status = "okay" within serdes0/1 in
> >              k3-j722s-evm.dts
> > 
> > Updated Patch 2 and the new Patch 3 mentioned above aren't necessarily a
> > complete "Fix" and have other changes in addition to the "Fix". For that
> > reason, the changes associated with the updated patch 2 and the new patch 3
> > could be a separate series, unless you believe that they should go
> > together in the current series. Please let me know.
> 
> I don't see any use case where serdes_wiz0 is enabled and serdes0 is
> disabled.
> 
> So your comment 3) is valid. you can take this clean up in other series
> 
> 
> For now
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>

I have posted the cleanup series at:
https://lore.kernel.org/r/20250412052712.927626-1-s-vadapalli@ti.com/
The cleanup series applies on top of the current series.

Regards,
Siddharth.

