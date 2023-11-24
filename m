Return-Path: <stable+bounces-298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B27F775C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5441C20A13
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD932AF14;
	Fri, 24 Nov 2023 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tnoky2Mu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16642E645
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 15:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01163C433D9;
	Fri, 24 Nov 2023 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700838731;
	bh=HiSegQzopZU/KSBGFIMYRTGdA1VW/LsJm2oDAij8K9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tnoky2MumLgE+6LF+BxlLuhuRrK3uTFovl6/XqkJ4S7a7hMhmU7TBgwT1xYKGsZ/j
	 C+NsUvXHn90ssm3RwNuayp/dxrl0sda6wBcZ+NYYjBE7uksdG0CT7MD257d66P42MQ
	 lvZrc2TyhHMiDWs7i7p5SYMz97xORMg1jNdnnakI=
Date: Fri, 24 Nov 2023 15:12:09 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5YWz5paH5rab?= <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits <stable-commits@vger.kernel.org>,
	stable <stable@vger.kernel.org>, marcel <marcel@holtmann.org>,
	"luiz.dentz" <luiz.dentz@gmail.com>, hildawu <hildawu@realtek.com>
Subject: Re: [Re V2]:Patch "Bluetooth: btusb: Add 0bda:b85b for Fn-Link
 RTL8852BE" has been added to the 5.10-stable tree
Message-ID: <2023112442-glitzy-rocking-4a8a@gregkh>
References: <20231124043548.86153-1-sashal@kernel.org>
 <tencent_27789A681229CCB77BE3E186@qq.com>
 <tencent_13CC3606408C86A21D09FB05@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_13CC3606408C86A21D09FB05@qq.com>

On Fri, Nov 24, 2023 at 02:59:15PM +0000, 关文涛 wrote:
> Hello Levin:
> 
>     Apologize for my HTML format past.I discovered that the backport patches also have dependency in 5.10 lts tree:
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.201&id=75742ffc3630203e95844c72c7144f507e2a557d
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.201&id=40e2e7f1bf0301d1ed7437b10d9e1c92cb51bf81
> [3]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.201&id=9c45bb363e26e86ebaf20f6d2009bedf19fc0d39
> [4]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.201&id=3a292cb18132cb7af3a146613f1c9a47ef6f8463
> [5]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.201&id=1a2a2e34569cf85cad743ee8095d07c3cba5473b
> 
>     and update version 2 depend patches link:
> 
> [1] RTL8852AE: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d484db60fc0c5f8848939a61004c6fa01fad61a
> [2] RTL8852BE: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18e8055c88142d8f6e23ebdc38c126ec37844e5d 
> [3] RTL8852CE: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b1d66b50437b65ef109f32270bd936ca5437a83
> [4] FW: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf0d9a705d81a0f581865cefe0880f29589dd06f

I'm sorry, but I do not understand what we need to do here.

What git ids need to go to what tree and in what order?

>   I would like to express my gratitude for you efforts,and I want to provide you with the backport tip when kernel <=5.10 :
> the RTL8852{A,B,C} BT chip series depend patches in that patch [1](v5.11) and load new firmware need that patch [2](v5.4).
> Apologize for my pool English.

Your english is great, but I really don't understand what is to be done
here.  Can you just list the ids in the order which you want them
applied and to what tree(s)?

thanks,

greg k-h

