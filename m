Return-Path: <stable+bounces-28383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F159B87F00F
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA9E2832D7
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF056442;
	Mon, 18 Mar 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vVdgQkqQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D484779F
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788394; cv=none; b=G7lxk6xlytweRPbXaHMAIgPGbH5cN1zbLrThg/BNJootvZ2YntgQtojVfdrI0ktwqde735pJEFCnDaYXuswSeY7uigu2gOKX7AokRcd0gnjpnx5+NdSYj8WHiq0ZA8Ykm/ex0j2/6Bos+PBlrIymX0p6xZrCy7OzWPDF4kAAO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788394; c=relaxed/simple;
	bh=3yOoA+l/m4xoo2DxXapAnApiX39TsEiJ428KTR4ahjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRoE5HfypGgN0GGbeEUAb9XuzEsKfJcRtaqEfkdQT73cmQCMFqiGSBfGkibRFWae+2s5ooOzrud+1V7lgr8dDrShYrG52Y+EKueCfp80seKoh0KJ2t5G1D0ogFkyjsegk2JBpbV42tSbTmCkE87UZ3rlObjRPPqteYtan3b0/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVdgQkqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB29C433C7;
	Mon, 18 Mar 2024 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710788393;
	bh=3yOoA+l/m4xoo2DxXapAnApiX39TsEiJ428KTR4ahjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vVdgQkqQBd2bqrTmq94T5toyQjbw1kCZG4Ze5qpR21LJW2rIbe9pxRGXhKonOxmN9
	 Vk7nWL1k1G5BSmc9bqiO9tdN0jvurEcmlGynYiS1+jPDeW2KkMfzvXYcGoa1WmjMfq
	 WsOeNJk2LS3LM1YJ3rCbbCs6t+20Y9/uGKx+z9iw=
Date: Mon, 18 Mar 2024 19:59:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= backport a patch for Linux
 kernel-5.10 and 6.6 stable tree
Message-ID: <2024031818-fifteen-endpoint-4733@gregkh>
References: <PSAPR03MB5653FFA63E972A80A6A2F4AF952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <ZfVkmm5-Ja8ub-i8@sashalap>
 <PSAPR03MB565334F399C37B0711F0ACB4952D2@PSAPR03MB5653.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PSAPR03MB565334F399C37B0711F0ACB4952D2@PSAPR03MB5653.apcprd03.prod.outlook.com>

On Mon, Mar 18, 2024 at 07:46:15AM +0000, Lin Gui (桂林) wrote:
> Dear mailto:sashal@kernel.org,
> 
> This patch is not a bug fix.
> This patch is to add the sysfs node of mmc: write protection related, 
> the detailed description is as follows:

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for what is allowed for stable kernel releasaes.

thanks,

greg k-h

