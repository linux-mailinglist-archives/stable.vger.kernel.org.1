Return-Path: <stable+bounces-3216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D337F7FF024
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CFBB20E34
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307847A67;
	Thu, 30 Nov 2023 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hslrFgjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF93B7BC
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F57C433C8;
	Thu, 30 Nov 2023 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351027;
	bh=MRJA5G7POlv2mylQPc8QYBFgazahG9wgBQWudUA79nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hslrFgjo+OAuLY+6iDxgUx4w8t18Kocha5MeZVbNPnQU8c1U2nBEdJZAL/JFrwuc0
	 KhNCnW9M5+KTytgrCI4abi2GerDvrbqESDT3fwdFQ/IOk/BOQ3NoJf5Q8A4G1OgpbY
	 XcqdDKb+hgBVQ2uuTIVTHXhjLKUgdbmWonMR1Cec=
Date: Thu, 30 Nov 2023 13:30:25 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5YWz5paH5rab?= <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	hildawu <hildawu@realtek.com>
Subject: Re: [Re V2]:Patch "Bluetooth: btusb: Add 0bda:b85b for Fn-Link
 RTL8852BE" has been added to the 5.10-stable tree
Message-ID: <2023113015-justifier-nastiness-3c66@gregkh>
References: <20231124043548.86153-1-sashal@kernel.org>
 <tencent_27789A681229CCB77BE3E186@qq.com>
 <tencent_13CC3606408C86A21D09FB05@qq.com>
 <2023112442-glitzy-rocking-4a8a@gregkh>
 <tencent_429FA9BD3B6671BC788386A6@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_429FA9BD3B6671BC788386A6@qq.com>

On Sat, Nov 25, 2023 at 12:56:34AM +0800, 关文涛 wrote:
> Hello Greg:
>     I thiink that the most clean thing that backport to v6.1 lts tree,
> because it has "Add support for RTL8852B" commit link [1]:
> 
>     In v5.15 lts tree,it miss patch [1].
>     In v5.10 lts tree,it miss "Add support for RTL8852A"[2] so "git am"
> command not simply work,but without the patch RTL8852B works.
>     In v5.4 lts tree,it miss more ids,need more efforts to do.If someone
> need,need to backport their own pid/vid pairs.
>     In v4.19 lts tree,it miss patch [3],so firmware download will failed.
> 
>     For backport patches[4][5][6][7][8],
>     they miss "Add support for RTL8852C"[9] in v5.15 and v5.10 lts tree.
>     Otherwise,I also found that in v5.10 lts tree path file:
>     root/drivers/bluetooth/btusb.c
>     MT7922 id [10] [11] add without its dependency [12] [13]
>     AX210 id [14] add without its dependency [15]
>     Sorry for maybe I miss some device id.How do other people think the 
> situation where some BT ids backports are done without dependencies?

Can you provide just a list of git ids, without footnotes or links, as
that is a pain to attempt to cut-paste from?

Better yet, can you provide backported patch series of the needed
commits like is sent all the time to the stable mailing list (so you can
see examples) and we can take them that way?  That way you get credit
for the backporting and testing as you will have added your
signed-off-by to the commits.

thanks,

greg k-h

