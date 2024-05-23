Return-Path: <stable+bounces-45625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E824E8CCC73
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258B71C21429
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8613C69C;
	Thu, 23 May 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0ONVptH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F9EC5
	for <stable@vger.kernel.org>; Thu, 23 May 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446944; cv=none; b=BJgYdhkZPWtLiie4aCEHdlUwUUdPcPqoZeJwncFCOg68vkf/8gFJEYnUuF4UaNZfRG6DGyrdUkeOxgF9Bo2Yg916cJW583s2mTTkUIv3x72jYWFEnqs4+okvGLRieODEHOdrpnqSbw5VXiKND/KJECBHmm4FzrsqUS3TecqNXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446944; c=relaxed/simple;
	bh=YxFGJ5Mm+AadQ2nt49N106zc3IDbQ6azjmZE+PuCADI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na+KEpKiLM1hM/848R0JrldrzTMb9jZInvebLVmOjAwYVNcmIQMeuXDnQshLnncWe0+OlUE5shFSlM77lP1Ekc/rXGVr23D5LCg2/RvEWqMWyWB81pnIHbSRarbHHXJA5xTLoucos+KsCClZfSAadFh9pBAKaGQrg91XSIqgIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0ONVptH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94338C2BD10;
	Thu, 23 May 2024 06:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716446943;
	bh=YxFGJ5Mm+AadQ2nt49N106zc3IDbQ6azjmZE+PuCADI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0ONVptHqAWIQkDNpD1EIy43F/MisYXinoNsaqhOG/XFNIFQWD5TNPS2OJnE0RXYx
	 NGL2Cib6CS/bv4gKTr+TvtkXxaKdxoEl3JOMfFjMNf6F2XWZDcOmzILH38rrmidYON
	 ndjqJQ25cEKl/WyGGiHrBpSqDwsdcd12rN/HVMFo=
Date: Thu, 23 May 2024 08:49:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBiYWNrcG9ydCA=?= =?utf-8?Q?a?= patch for
 Linux kernel-5.15 kernel-6.1 kenrel-6.6 stable tree
Message-ID: <2024052329-sadden-disallow-a982@gregkh>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Thu, May 23, 2024 at 06:41:04AM +0000, Lin Gui (桂林) wrote:
> Dear @Greg KH<mailto:gregkh@linuxfoundation.org>,
> 
> 
> What is the git id of it in Linus's tree?
> [MTK]
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core/mmc.c?h=v6.9&id=77e01b49e35f24ebd1659096d5fc5c3b75975545
> 
> 
> author    Mengqi Zhang <mengqi.zhang@mediatek.com>    2023-12-25 17:38:40 +0800
> committer      Ulf Hansson <ulf.hansson@linaro.org>     2024-01-02 17:54:05 +0100
> commit   77e01b49e35f24ebd1659096d5fc5c3b75975545 (patch)
> tree 02a13063666685bc7061b46183fc45298b2dc9f4 /drivers/mmc/core/mmc.c
> parent    09f164d393a6671e5ff8342ba6b3cb7fe3f20208 (diff)
> download      linux-77e01b49e35f24ebd1659096d5fc5c3b75975545.tar.gz
> mmc: core: Add HS400 tuning in HS400es initialization
> During the initialization to HS400es stage, add a HS400 tuning flow as an
> optional process. For Mediatek IP, the HS400es mode requires a specific
> tuning to ensure the correct HS400 timing setting.
> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
> Link: https://lore.kernel.org/r/20231225093839.22931-2-mengqi.zhang@mediatek.com
> Signed-off-by: Ulf Hansson ulf.hansson@linaro.org<mailto:ulf.hansson@linaro.org>


I don't understand, why does this qualify as a stable patch?  The
changes says this is "optional", which means the device should work just
fine without it, right?

Is this a regression fix from something that previously used to work
properly?

You have read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
right?

thanks,

greg k-h

