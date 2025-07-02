Return-Path: <stable+bounces-159204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D47AF0D7C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2741C24261
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0D231C9C;
	Wed,  2 Jul 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hW5G4EOO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC962236E8
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443704; cv=none; b=HNUcc6ZstEgG9BGokSQRokCrk3QpMmQ5Qp/K0VZabYRxWNYsTj/iH2fl2+HtX0Bh3s7yd3ZeXtqCZ+4G1bE2NSws7NsyaEXA7IgcEk4CpCkdSOOqDZ5IXtxqLpt8371STe3OUcKN+GvxSB7DijHeom4EqVLJhldJADS8o2urU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443704; c=relaxed/simple;
	bh=Pni272GDogdEnqfOxMqs5DZ+tPUurtNfIbpMfigc16M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tawa0H9hgMGeohICXTmFV+HgXz85fkqzEnaU+kMLniZPXZSCUubWA9I/G8bSTDDGKI8A/Syq939KVO73YcS/xsGMG4yWMJGj7aZgPvNX0dyNx+xKQ3Ld80i3GRcBIv5q3BY/xeK/Lf1s6JrslxnFvfMOP9IDkGY657qSHP8H+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hW5G4EOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B020FC4CEED;
	Wed,  2 Jul 2025 08:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751443704;
	bh=Pni272GDogdEnqfOxMqs5DZ+tPUurtNfIbpMfigc16M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hW5G4EOOEdqE0rOT8JwdmSER1CAM70h/MGC27oTKWBHZ0UhqjuUOOg3G7OuHw/uHm
	 KDqeSepneJkASB67xgWRvDKvvNg+CTqRURd3znRyohVVFkRfVecVWV0WLnQA4DVY+f
	 4KxFx57K/6CDP6tlN+8DVMKycUKXGlz77u1CL13U=
Date: Wed, 2 Jul 2025 10:08:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Stable <stable@vger.kernel.org>, Long Li <longli@microsoft.com>
Subject: Re: Please cherry-pick this commit to v5.15.y, 5.10.y and 5.4.y:
 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time")
Message-ID: <2025070245-monogamy-taekwondo-3c95@gregkh>
References: <BL1PR21MB31155E1FE608F61CFC279B2DBF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR21MB31155E1FE608F61CFC279B2DBF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>

On Wed, Jun 25, 2025 at 06:05:26AM +0000, Dexuan Cui wrote:
> Hi, 
> The commit has been in v6.1.y for 3+ years (but not in the 5.x stable branches):
>         23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot time")
> 
> The commit can be cherry-picked cleanly to the latest 5.x stable branches, i.e. 5.15.185, 5.10.238 and 5.4.294.

It adds a new build warning on 5.4.y, so I will not apply it there,
sorry.  Will go apply it to 5.10.y and 5.15.y for now.

thanks,

greg k-h

