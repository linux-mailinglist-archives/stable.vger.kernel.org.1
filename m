Return-Path: <stable+bounces-85112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1599E2EC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B251F227C3
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFD1DDC08;
	Tue, 15 Oct 2024 09:38:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547B13BACC
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985110; cv=none; b=O7fubpY99f4TVvIQrtP/lP8yejqict8B58T4h2k1wHz3lz1WqBjNNOUmT6EPgOFnQWivT3jS3d7XGYWm/4A7F/mMZC0K9tE64l8R64J/iXU4AcyPnIdjulMc9+d4AatI8GSaJcDKB9ZJ37jfPBNlGWGh/nAW1mcpA1mShqEoM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985110; c=relaxed/simple;
	bh=WkFsvszqVPTGJ45zScx2bg3QTySV+PQBpCxtr/kUBMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu2kmF6+cINPyh4pK/7goIkURDZfIolbeRs7YnjlC8IDIn1STUWZ2NTK2Ilve5JOW9ZHd2tNdAL33SqOzYZhueU/8eO/RRTb+TUN6gQqdCLSe9fqNVw2shrH5BFXAUgjqn3ojfP5MpdrFrx2p4uFRIdb7w2LU9547Xys6p3xPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t0e0D-0007sj-GF; Tue, 15 Oct 2024 11:38:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1t0e0B-00202n-UO; Tue, 15 Oct 2024 11:38:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t0e0B-00CdCJ-2g;
	Tue, 15 Oct 2024 11:38:03 +0200
Date: Tue, 15 Oct 2024 11:38:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
Message-ID: <Zw43-8oV-vSeyj5D@pengutronix.de>
References: <20241014141217.941104064@linuxfoundation.org>
 <3ab1938a-6f6a-4664-9991-d196e684974d@nvidia.com>
 <CAMuHMdVHLiB7PWji9uRLZNWqFa1r7NiTv9MWCCAg=3-924M7tA@mail.gmail.com>
 <CAMuHMdVcE1Wvi+g5P5CEe5RFEuBfSCmR+7HFVfiC1rG6bHdesA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVcE1Wvi+g5P5CEe5RFEuBfSCmR+7HFVfiC1rG6bHdesA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi all,

On Tue, Oct 15, 2024 at 09:07:14AM +0200, Geert Uytterhoeven wrote:
> CC Oleksij
> 
> On Tue, Oct 15, 2024 at 9:06 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Oct 15, 2024 at 7:32 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > On 14/10/2024 15:09, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.113 release.
> > > > There are 798 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc1.gz
> > > > or in the git tree and branch at:
> > > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > > -------------
> > > > Pseudo-Shortlog of commits:
> > >
> > > ...
> > >
> > > > Oleksij Rempel <linux@rempel-privat.de>
> > > >      clk: imx6ul: add ethernet refclock mux support
> > >
> > >
> > > I am seeing the following build issue for ARM multi_v7_defconfig and
> > > bisect is point to the commit ...
> > >
> > > drivers/clk/imx/clk-imx6ul.c: In function ‘imx6ul_clocks_init’:
> > > drivers/clk/imx/clk-imx6ul.c:487:34: error: implicit declaration of function ‘imx_obtain_fixed_of_clock’; did you mean ‘imx_obtain_fixed_clock’? [-Werror=implicit-function-declaration]
> > >    hws[IMX6UL_CLK_ENET1_REF_PAD] = imx_obtain_fixed_of_clock(ccm_node, "enet1_ref_pad", 0);
> > >                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >                                    imx_obtain_fixed_clock
> > > drivers/clk/imx/clk-imx6ul.c:487:32: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> > >    hws[IMX6UL_CLK_ENET1_REF_PAD] = imx_obtain_fixed_of_clock(ccm_node, "enet1_ref_pad", 0);
> > >                                  ^
> > > drivers/clk/imx/clk-imx6ul.c:489:34: error: implicit declaration of function ‘imx_clk_gpr_mux’; did you mean ‘imx_clk_hw_mux’? [-Werror=implicit-function-declaration]
> > >    hws[IMX6UL_CLK_ENET1_REF_SEL] = imx_clk_gpr_mux("enet1_ref_sel", "fsl,imx6ul-iomuxc-gpr",
> > >                                    ^~~~~~~~~~~~~~~
> > >                                    imx_clk_hw_mux
> > > drivers/clk/imx/clk-imx6ul.c:489:32: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> > >    hws[IMX6UL_CLK_ENET1_REF_SEL] = imx_clk_gpr_mux("enet1_ref_sel", "fsl,imx6ul-iomuxc-gpr",
> > >                                  ^
> > > drivers/clk/imx/clk-imx6ul.c:492:32: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> > >    hws[IMX6UL_CLK_ENET2_REF_PAD] = imx_obtain_fixed_of_clock(ccm_node, "enet2_ref_pad", 0);
> > >                                  ^
> > > drivers/clk/imx/clk-imx6ul.c:494:32: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> > >    hws[IMX6UL_CLK_ENET2_REF_SEL] = imx_clk_gpr_mux("enet2_ref_sel", "fsl,imx6ul-iomuxc-gpr",
> >
> > Missing backports of the other clock-related patches in the original
> > series[1]?
> > imx_obtain_fixed_clock() was introduced in commit 7757731053406dd0
> > ("clk: imx: add imx_obtain_fixed_of_clock()"), but some of the other
> > patches from that series may be needed, too?
> >
> > [1] https://lore.kernel.org/all/20230131084642.709385-1-o.rempel@pengutronix.de/

Yes, I agree, at least commit 7757731053406dd0 is missing. Other patches
in [1] series are only interesting if corresponding device trees was
upstream.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

