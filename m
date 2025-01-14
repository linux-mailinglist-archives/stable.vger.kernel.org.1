Return-Path: <stable+bounces-108567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DABC5A0FF00
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 04:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56596167D96
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E21922FE17;
	Tue, 14 Jan 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcfKbyqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4194347B4;
	Tue, 14 Jan 2025 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736823868; cv=none; b=N6THbp5NLjBHw0+bi/xlOUkfE8yW43Tz+4XRwATaB3Tlcp23ZZMMPNfEKsS8+tFrvLDRtaZTFhJPYDXRS3kUyODLRUrrWpl69/Lh4HcX1mHO8QTbTug77LMFMKnieIl/2pXIyrB+i7ALbISIrHwnkDicxvvBUxyp8FzUNMwZeEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736823868; c=relaxed/simple;
	bh=jSE4Yrmltb3q8Vn0xJplLkkDCzvbQRSRMsKHF3UqTZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJNsGWhmI2LcRDiBZo4woo6skiYzJtUb7iCS/4YvmH/dXVsJpmc7CNZElKgXLY7KfaEctQ8sJT9DHy041vOrsiuioW1oF0+t8hi0pj9vRC/9IcEc5DjXm9ILG9l+H4PQRPb3vu3hE0LJuOG6b5a1MExTklobwimQkm1+CYLdckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcfKbyqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697E9C4CED6;
	Tue, 14 Jan 2025 03:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736823865;
	bh=jSE4Yrmltb3q8Vn0xJplLkkDCzvbQRSRMsKHF3UqTZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kcfKbyqR878JMHoXTtm6nqLz7eCxW1G9uUvPX2WubYt3eFh6cpt2BMUKdtPY+ChA7
	 1EBVuuyvzOt+9x48EUlAPkmRbQiKnl1s5nmT43/nhAIDRgQbBORjhYe4ypqobd7bS0
	 J8hb6pEgBs84HNylbPrBTnyDUGza66RWySMNJjxHWfYcxHrRzTYhe2xC/x826Wcu7Z
	 wAY5jZwPH/O1AyAtHI/C4k7boieTnJZSeXctUQQIKohtp3EVVyJGCuFU3yLGZ+EFca
	 vHDBvMBVKZwwx02/l7lZ3pXFBKf2n1bPzBS9uN5YkZMU9qPisFM3g8FoV9AVa+LJTH
	 UZa6Vp8PaPTdA==
Date: Mon, 13 Jan 2025 19:04:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Paul Fertser <fercerpav@gmail.com>, "Potin Lai (=?UTF-8?B?6LO05p+P5bu3?=
 )" <Potin.Lai@quantatw.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Cosmo Chou (
 =?UTF-8?B?5ZGo5qW35Z+5?=)" <Cosmo.Chou@quantatw.com>, "patrick@stwcx.xyz"
 <patrick@stwcx.xyz>, Cosmo Chou <chou.cosmo@gmail.com>
Subject: Re: =?UTF-8?B?5Zue6KaGOg==?= [External] Re: [PATCH] net/ncsi: fix
 locking in Get MAC Address handling
Message-ID: <20250113190422.7671789c@kernel.org>
In-Reply-To: <CAGfYmwXKyWrWm5z1Lra0_wX8iVfT8p9BHd3SWZPSvkZ1qfKqLA@mail.gmail.com>
References: <20250108192346.2646627-1-kuba@kernel.org>
	<20250109145054.30925-1-fercerpav@gmail.com>
	<20250109083311.20f5f802@kernel.org>
	<TYSPR04MB7868EA6003981521C1B2FDAB8E1C2@TYSPR04MB7868.apcprd04.prod.outlook.com>
	<20250110181841.61a5bb33@kernel.org>
	<CAGfYmwVECrisZMhWAddmnczcLqFfNZ2boNAD5=p2HHuOhLy75w@mail.gmail.com>
	<20250113131934.5566be67@kernel.org>
	<CAGfYmwXKyWrWm5z1Lra0_wX8iVfT8p9BHd3SWZPSvkZ1qfKqLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 09:56:13 +0800 Potin Lai wrote:
> > Also one thing you have not done is to provide the Tested-by: tag
> > on Paul's patch :)  
> 
> Tested-by: Potin Lai <potin.lai.pt@gmail.com>

Thanks!

