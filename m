Return-Path: <stable+bounces-132267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3BA86062
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDF41B8213E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B71F7098;
	Fri, 11 Apr 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U8OmFibV"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D11F3D50;
	Fri, 11 Apr 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381066; cv=none; b=L4rsRV/3jo/uDG6iQSTY0SZg/64BrC9qjG3+AqIvmg3miNX0fjuGgzZpDSGqCDgnH36rLSXCRWKQRnyVUXyq2X+4/27sbBPWPNd/yKzLvZMtKZ5uvxwammHcGqfLNObV+yZiv9XqvkSoJwaRnD1jzzubYBdE5GsK7pjiOPBaXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381066; c=relaxed/simple;
	bh=MUxyJ6e8mDQbyfZx9BUETJLHV2q/o6GLx2i3m7D1L8k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnswRB7lYV6PQiWYBo9Yje3XLFL+CQkcSh77wHN4pLIIkjeCdH57qBRT72UCI5TOUKG6Uykb2sXaZzBGW6s4sCMLO+zvMKT/dG9BxMBhkK2WqF4LqAwmQVNuzjE5FxSzkhZ2RaUCW65rVi3N5cLeFOkIWN+pTHjbbCKfJIDBUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U8OmFibV; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BEHbl32094889
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 09:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744381057;
	bh=z1/nNUIFGXE6LFF+d4YwvIEc4Kciht20sPaPOMMio7c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=U8OmFibV6W67vclOB7974WizPyD/km+DsqSpxO3R12f6uuNAlezzoUOgyx2+QIJFW
	 u+qWAdvuZnr1QMbJtj+RQS38qsAoiNLb1KxDplErtYIto1AqW//A2mOxTqxCuA37Cv
	 9166fbnauxJi+p0moAtgLpJkizvMgtv4y/Q/n0IM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BEHb8i107722
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 09:17:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 09:17:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 09:17:37 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BEHako022556;
	Fri, 11 Apr 2025 09:17:36 -0500
Date: Fri, 11 Apr 2025 19:47:35 +0530
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
Message-ID: <475a1ac1-abb1-4c6e-b5b2-3f1a3399d5c4@ti.com>
References: <20250408103606.3679505-1-s-vadapalli@ti.com>
 <20250408103606.3679505-3-s-vadapalli@ti.com>
 <7b2f69ad-48aa-4aa9-be0e-f0edae272bdb@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b2f69ad-48aa-4aa9-be0e-f0edae272bdb@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Apr 11, 2025 at 07:31:52PM +0530, Kumar, Udit wrote:

Hello Udit,

> 
> On 4/8/2025 4:06 PM, Siddharth Vadapalli wrote:
> > Since "serdes0" and "serdes1" which are the sub-nodes of "serdes_wiz0"
> > and "serdes_wiz1" respectively, have been disabled in the SoC file already,
> > and, given that these sub-nodes will only be enabled in a board file if the
> > board utilizes any of the SERDES instances and the peripherals bound to
> > them, we end up in a situation where the board file doesn't explicitly
> > disable "serdes_wiz0" and "serdes_wiz1". As a consequence of this, the
> > following errors show up when booting Linux:
> > 
> >    wiz bus@f0000:phy@f000000: probe with driver wiz failed with error -12
> >    ...
> >    wiz bus@f0000:phy@f010000: probe with driver wiz failed with error -12
> > 
> > To not only fix the above, but also, in order to follow the convention of
> > disabling device-tree nodes in the SoC file and enabling them in the board
> > files for those boards which require them, disable "serdes_wiz0" and
> > "serdes_wiz1" device-tree nodes.
> > 
> > Fixes: 628e0a0118e6 ("arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > v1 of this patch is at:
> > https://lore.kernel.org/r/20250408060636.3413856-3-s-vadapalli@ti.com/
> > Changes since v1:
> > - Added "Fixes" tag and updated commit message accordingly.
> > 
> > Regards,
> > Siddharth.
> > 
> >   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> > index 6850f50530f1..beda9e40e931 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> > @@ -32,6 +32,8 @@ serdes_wiz0: phy@f000000 {
> >   		assigned-clocks = <&k3_clks 279 1>;
> >   		assigned-clock-parents = <&k3_clks 279 5>;
> > +		status = "disabled";
> > +
> 
> Since you are disabling parent node.
> 
> Do you still want to carry status = "disabled" in child nodes serdes0 and
> serdes1.

I could drop it, but then the patches will look something like:
1) Patch 1: Same as the first patch in this series
2) Patch 2: Current patch + Remove status = "disabled" within serdes0/1
3) Patch 3: Removed redundant status = "okay" within serdes0/1 in
            k3-j722s-evm.dts

Updated Patch 2 and the new Patch 3 mentioned above aren't necessarily a
complete "Fix" and have other changes in addition to the "Fix". For that
reason, the changes associated with the updated patch 2 and the new patch 3
could be a separate series, unless you believe that they should go
together in the current series. Please let me know.

Regards,
Siddharth.

