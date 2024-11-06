Return-Path: <stable+bounces-91667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD59BF188
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9DB235EA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173302036EB;
	Wed,  6 Nov 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="DsQnJREY"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E51DF738;
	Wed,  6 Nov 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906670; cv=none; b=FQoRju9p81MI5k+O/ewmUNBBNMR9F9R8iz3+HrqlWfrxWYHqo7XGfPM7WmKyTPZsTXt7kBKJwEefA7Miiw44Wm8Snz0zERN63GGm/bz8BQ8bZbKPRMf6990jXu27/HEq+KJzcpbGXYhUZs6veTYVsB1TRyi/Vq6fSAvLxLJa07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906670; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=A4MKGPvPZIbKpw/w4oFuMdJ9M0twXuClZkd9yWkPARJNmTEnNjH3rEidl2uHw5piIdIjUEi02iTagrxmN3PVkej5fjh1kgOm/y4v8Rt8Iy+8jr2Y424uPmhKlV2UcQWCh/MrghkrDwcDGTDLsuK8FMIC8illXMUzBjY1sQqO+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=DsQnJREY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730906664; x=1731511464; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DsQnJREYxnlHSr7bsdV2W29Yoqhl53xbUfjhc7l0yQL26A/Ct7SSYLYZdFsOFtda
	 vAUd7o+dX82PhPU7/7yJXXfxa04WJRAAJV9dyua7EkoStbmGbtS0VCijtAPj2bUB3
	 cMwRYabRUNjyCbirIjsI8ny+gnobL8hG5oaB8MA1D5h4/FRHHDtMp/j6XGoCfsb8c
	 8TQwD1fnUG+k4YrHQoc0zt7WRhtoNGQn44vG26OWIu69r91+VBUtZa/LHP+dsitW6
	 swRBOwfad0OKq9znW8jXpRqNJI2Wyhw4wx4tE6ZRf9zXILjQH/0/BwJ9yaZ8/0Ofr
	 CZjq7PWiW3QTSdOwHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.34.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1twfuk34Ju-017BTn; Wed, 06
 Nov 2024 16:24:24 +0100
Message-ID: <024966d6-4ca2-488d-b6b8-3bce03ff567a@gmx.de>
Date: Wed, 6 Nov 2024 16:24:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.11 000/245] 6.11.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VRABcj8Yvhk3vepw3MIVukLoM5h8lUmffN3inXaZwaFH4F66Fsn
 94sGlhRc4h7gzRn4OgtxUWpviVE5GPV6e6sJiRKqJI6x+qtIguluuYYFhS15+uLA9pCoDAw
 hITMQ9KylE1wSJlIzB5D5QmYMI0wwIvoFjyM4dKsHvJG54OftEg16CHP3HWzhzBvrZIGoGR
 mfDkTXH5fMGC9eQJUvH2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J/ddG8lXA7w=;4/5Efb5RG4IZl9z8aOEYiZ9Swkh
 4WPelJmCZmqi9M/b3O8v7I4aF7bGPhLOGIolQWVp0yX8jDOrpI0T0lxnHh/dkI61WxUNsj6Mu
 0sqxbrch/rx8aQQs0o1qYzNsDSH0GrTV/vK9+V8j2tG2CAP4kADtnbNcHv0/7fS/s7bSk54ol
 5c/JpBwiABax2VVmhTBn2g83vjMVRYXUyfGeZkq+JUVatJs7tJBjH4VbMJyMyzU7/P3BV4Slg
 z9hqY1a0/Kwr1Sr6QNYZSnZLCvGpAtPDRgX4Yjx7PguTts0Fqq2iz4NPUUymlD8XpvKgC/ABs
 rCQa+3y/g7KnljGBqc4sFtG6gVphAefqxyfhQFx0qZAF6inAW74YRJNsp4nCn4TiyRma9KE37
 Hd/Fo1oJzLC1Wl4d5oKHWs6rv+3BclfO/zd4ZO1detcrqksP+IniqobqTCKPCzMDVVfVjNQgK
 69hHdvNDIxoQqAdt6Y8/Uc/mIEdRo4oTDgLJEZf2vl3MbVnWtnsYMLyShQomslMAhP0N9vY04
 JXleIXGliU2eO1RPHY/0j3lS2J73p61pfmAbm2B1kgaGyMIf5AX8AP5FCK4vgSGG7aSjyGtD3
 K2wf3d/DZex0GrsLIWAmIKpAh+qiBN9fkVD4l/WhNIwYT6yFB28P/lBjkSFAGupuyaP8ZyM1l
 aqXFiPc9RBYgsh3Mqi0UlI2VayUYDpJYH7shq0zS4dr2NnXLuplXRfuFkGaBj3SIWTSEtXRrG
 9t+PXE/DV1+Mg6gfgSKmumV5WcrHE84QJ/TmKxGJVoMK7MPpVABVLORWC7FsOgUvqAdGcIn+p
 tLcOt9fwevipql0Ep1NebdhQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

