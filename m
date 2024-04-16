Return-Path: <stable+bounces-40041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BB8A7592
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 22:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEAF28227F
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39713A247;
	Tue, 16 Apr 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YqOe4wcl"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829641386B3;
	Tue, 16 Apr 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299377; cv=none; b=kWu1R0FzLXtvyFY85dFPCeA5gm9H1yiQN4sPyn6NCjqCjI6CIsFUS+6lvoQFWOX09kmUGUeyGDmlkMGJDok9x46/rLeRjyz5kZpPJbUBBnqhyAihM4vi6cVMIohvIMc0NCRbEhuE7LIn4zPXNepJ3tuHLW730GvJnoJNV68kC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299377; c=relaxed/simple;
	bh=6HEyKo5kYiZdTNIX2x7F5vCVAgpWMKUXk3egaK3++qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nXRpGGOp1YSJktI0lxsmaaCkPsEHnZ6VNau7oPxtuE7Ir98/j/hYZL2z3p3GfG1Bja7G2EKZ9xRcDnb5Q5U1ftE23izHYIgvJn4lHplhKzE/T/0y0UoaEpytaMknBmq+f5nS4L8GJmB7aGSoVpZF/YTf7GAjNueCMN7Yg5ym5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YqOe4wcl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=sPGwBRQWRFRHvSklFGqm1QGyqC8ZPElQNUgAaD314Nw=; b=YqOe4wclWS3JbHyZ7COM1M6eTj
	F8wAx+o54pfUFxnEI+ubSOBBIqAzVq37pgxB5DqAAsbCXnRA33IGwTU2deot6kUpYaCvqbKGWh8JW
	HyhomG1yAU4RCBji1N88kC2c0HLYm51wrVTSZ8jPnuZgh95HTaUV+uGgNGsIGa6eXDrtj7U3RXr5U
	mEekgJcmX3wzjurUXHmg0WEc0FhDg82ibHD/PqJ1LsnFCT7auLTCB9CLedTurK7unbnBKBdo41/Y/
	W6fQvUr3sPKjp2/PEtlFYFr/jXROEJq018QHXBP4jTGflfSNRSkTGrVwX41xusQv5NGyBrc/RfjTC
	lwUfX48Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1rwpQU-006b1s-NS; Tue, 16 Apr 2024 20:29:12 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6A96BBE2EE8; Tue, 16 Apr 2024 22:29:09 +0200 (CEST)
Date: Tue, 16 Apr 2024 22:29:09 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	roland@debian.org, stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Herb Wei <weihao.bj@ieisystem.com>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [Regression] USB ethernet AX88179 broken usb ethernet names
Message-ID: <Zh7flXvNdDfattD9@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: carnil

Hi,

Roland Rosenfeld reported in Debian a regression after the update to
the 6.1.85 based kernel, with his USB ethernet device not anymore
able to use the usb ethernet names.

https://bugs.debian.org/1069082

it is somehow linked to the already reported regression
https://lore.kernel.org/regressions/ZhFl6xueHnuVHKdp@nuc/ but has
another aspect. I'm quoting his original report:

> Dear Maintainer,
> 
> when upgrading from 6.1.76-1 to 6.1.85-1 my USB ethernet device
>  ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
> is no longer named enx00249bXXXXXX but eth0.
> 
> I see the following in dmsg:
> 
> [    1.484345] usb 4-5: Manufacturer: ASIX Elec. Corp.
> [    1.484661] usb 4-5: SerialNumber: 0000249BXXXXXX
> [    1.496312] ax88179_178a 4-5:1.0 eth0: register 'ax88179_178a' at usb-0000:00:14.0-5, ASIX AX88179 USB 3.0 Gigabit Ethernet, d2:60:4c:YY:YY:YY
> [    1.497746] usbcore: registered new interface driver ax88179_178a
> 
> Unplugging and plugging again does not solve the issue, but the
> interface still is named eth0.
> 
> Maybe it has to do with the following commit from
> https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.85
> 
> commit fc77240f6316d17fc58a8881927c3732b1d75d51
> Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Date:   Wed Apr 3 15:21:58 2024 +0200
> 
>     net: usb: ax88179_178a: avoid the interface always configured as random address
> 
>     commit 2e91bb99b9d4f756e92e83c4453f894dda220f09 upstream.
> 
>     After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
>     consecutive device resets"), reset is not executed from bind operation and
>     mac address is not read from the device registers or the devicetree at that
>     moment. Since the check to configure if the assigned mac address is random
>     or not for the interface, happens after the bind operation from
>     usbnet_probe, the interface keeps configured as random address, although the
>     address is correctly read and set during open operation (the only reset
>     now).
> 
>     In order to keep only one reset for the device and to avoid the interface
>     always configured as random address, after reset, configure correctly the
>     suitable field from the driver, if the mac address is read successfully from
>     the device registers or the devicetree. Take into account if a locally
>     administered address (random) was previously stored.
> 
>     cc: stable@vger.kernel.org # 6.6+
>     Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
>     Reported-by: Dave Stevenson  <dave.stevenson@raspberrypi.com>
>     Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>     Reviewed-by: Simon Horman <horms@kernel.org>
>     Link: https://lore.kernel.org/r/20240403132158.344838-1-jtornosm@redhat.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Seems, that I'm not alone with this issue, there are also reports in
> https://www.reddit.com/r/debian/comments/1c304xn/linuximageamd64_61851_usb_link_interface_names/
> and https://infosec.space/@topher/112276500329020316
> 
> 
> All other (pci based) network interfaces still use there static names
> (enp0s25, enp2s0, enp3s0), only the usb ethernet name is broken with
> the new kernel.
> 
> Greetings
> Roland

Roland confirmed that reverting both fc77240f6316 ("net: usb:
ax88179_178a: avoid the interface always configured as random
address") and 5c4cbec5106d ("net: usb: ax88179_178a: avoid two
consecutive device resets") fixes the problem.

Confirmation: https://bugs.debian.org/1069082#27

Regards,
Salvatore

