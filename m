Return-Path: <stable+bounces-196922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7DDC85F82
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D6194E1B86
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3425A321;
	Tue, 25 Nov 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciH82Bhm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04C238176;
	Tue, 25 Nov 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087959; cv=none; b=DKw6lwjvlUrcRVVcgRVd5GpjGWESq+ftfyPabFED3odfI4qFvnBGT5br5g6SFy5Wz16s3aY7ON1x680Je6d3i1wtHsnVTfmGwD3Rs5vtpYUooCxthkuyv5Wqo1JjIbC0rtksjHCVY8CuG+BIRwWGx63Bv7r5qXcj1WUI81/8qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087959; c=relaxed/simple;
	bh=uMec6g1JFYeX09IAIUXFgg9sclzlNEbw6PBIPA7cTuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXh9kER3jitxwc+DI4arRV6xHVRiRUxsUnY9QA18IK3Mr+QziP4QiTOQw+g1dJugGRISoutv09FGb2J1xhja6Zzi6PITwcNg8sx4oy80Y8Np7qM/O2lHmXvY4j9f2XS2f9RUC9BMNuYuyUvbCf09eka9kXZ/JlgU62dvvfiaIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciH82Bhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F35C4CEF1;
	Tue, 25 Nov 2025 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764087957;
	bh=uMec6g1JFYeX09IAIUXFgg9sclzlNEbw6PBIPA7cTuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciH82Bhmw65HQ27oGQcKleAsRya4o2CHUwALkhIg8ITpL9z3cdXfEfqwKXVduwZUL
	 fiEnGA/xzRAkf/JFidRD86QKLChzMcabNQISllIHjwx5xl/fuvfYkY1ivT6Dcr2S8W
	 s+awbE3lDipZ4s15yZy8ctdDz+pM/zookQN0Wz3eO6l9DOVw8aNqGQFTsbAd4GvvWj
	 54AFxboUQ4uCXYCYoRnubuOabtYpN/chn/CtjVSXN/tKoVE78JoTcyb7+1YncmF3tl
	 NnMGx0aHwUiA18EaSVBHeFS1x8usbQzCzIV3z/aGYwfG9Q90AYhGRJfLsm5yQJR4Jo
	 ThX9fEzR+Kbtw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vNvra-000000003s2-2cxa;
	Tue, 25 Nov 2025 17:25:58 +0100
Date: Tue, 25 Nov 2025 17:25:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] USB: serial: option: add Telit Cinterion FE910C04
 new compositions
Message-ID: <aSXYlqai4Q7CQCT5@hovoldconsulting.com>
References: <cover.1764084304.git.fabio.porcedda@gmail.com>
 <3ef9bdaa5f76595d0a39b8fc1b1cebe29f69709c.1764084304.git.fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef9bdaa5f76595d0a39b8fc1b1cebe29f69709c.1764084304.git.fabio.porcedda@gmail.com>

On Tue, Nov 25, 2025 at 04:27:33PM +0100, Fabio Porcedda wrote:
> Add the following Telit Cinterion new compositions:
 
> 0x10cb: RNDIS + tty (AT) + tty (diag) + DPL (Data Packet Logging) + adb
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh=16
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0002 Rev=06.18
> S:  Manufacturer=Linux 6.18.0-rc3-usb+ xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:00:14.0
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=11 Cnt=01 Dev#=  7 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=413c ProdID=2003 Rev=03.01
> S:  Manufacturer=Dell
> S:  Product=Dell USB Keyboard
> C:  #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=70mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=24ms
> 
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=10000 MxCh=10
> D:  Ver= 3.10 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
> P:  Vendor=1d6b ProdID=0003 Rev=06.18
> S:  Manufacturer=Linux 6.18.0-rc3-usb+ xhci-hcd
> S:  Product=xHCI Host Controller
> S:  SerialNumber=0000:00:14.0
> C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

Looks like something went wrong when you generated the usb-devices
output for the above composition.

Johan

