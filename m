Return-Path: <stable+bounces-310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52097F78C4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FBD2810B7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D133CE8;
	Fri, 24 Nov 2023 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDt22oQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2D33CE2;
	Fri, 24 Nov 2023 16:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD71C433C8;
	Fri, 24 Nov 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842741;
	bh=CEV7NAR5P1IEKIo7VE/OV4UHEH/9vFQ5XlpsJWnIDAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDt22oQ4NnvkfTOMZwj19/fd/1D3bToLigf3b0JIOQlqPwpexWA/Ctdlzj9xXiQVr
	 U4YM5Iv9kdKkdQzNeeHIVdPM/xFpr1G7ls5pDovwGOjQvqV8WuAgAw6j1e2RIGOvFU
	 oZylt9SmZRcuo548M/AdQoDWJsdd3GLFv7M8Hubg=
Date: Fri, 24 Nov 2023 16:18:59 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Stable <stable@vger.kernel.org>,
	Linux USB <linux-usb@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Fwd: dwc3: regression in USB DWC3 driver in kernel 5.15 branch
Message-ID: <2023112424-escalate-saga-2b01@gregkh>
References: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
 <635eb180-0dea-4dc7-a092-be453bf80023@leemhuis.info>
 <f7d315b1-f43d-4573-81f0-a4014f3ac0bb@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d315b1-f43d-4573-81f0-a4014f3ac0bb@leemhuis.info>

On Tue, Nov 21, 2023 at 04:25:30PM +0100, Thorsten Leemhuis wrote:
> Hi. Top-posting for once, to make this easily accessible to everyone.
> 
> To Greg and everyone that might care: apparently Tomasz lost interest in
> fixing this 5.15.y regression. Kinda sad, as the patches are mostly
> there, but lack a S-o-b tag -- which means we are stuck here, unless
> somebody else attempts a backport.
> 
> https://lore.kernel.org/all/20230904071432.32309-1-tomasz.rostanski@thalesgroup.com/
> 
> I'll thus stop tracking this regression.

Thanks, I'll wait for a working backport for those using the 5.15.y tree
and this driver as it's not anything that I am capable of doing at this
point in time.

greg k-h

