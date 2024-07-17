Return-Path: <stable+bounces-60424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92F933B75
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86981F2312F
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9117E905;
	Wed, 17 Jul 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="baBtptbc"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F811878;
	Wed, 17 Jul 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213455; cv=none; b=udgnReOjTOwDY0rZyZtnXLEp+tHtneh4BsVkJ9V6otBbJaATgOXbLvnuykWdBlLCGrrGWY2yPhMAAHIohpnjm/0iFoTaiWJv51vDp9lF5FaZIEhHhCnDlFYMBOuwnHB3eABU5iVpU380R6RLF2bPLQX2x/CRXHVmUZKt/YKw0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213455; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=a5FsuiD+2mIv8AvTUUcwaav/vi62dVYVj4IjWiBWQLqw8V19wxHwbL/HRi7sF5WhPOeHSK7lLL/yU26IcOljCns+tHNiEna69zHRCbhCrYz+bGwFjAbpz0LJCaua43lEj9hIIqNxKvgiCxnSyWzqbBx3D2Kvuc8agxMNKzxL6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=baBtptbc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721213450; x=1721818250; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=baBtptbccu2gz/BAzLtDu5AmeXpHq+Ag1PcfQDcCeBuHRCxnBCSeq9C/mOLxRl8T
	 HfCcp3r5GlHRzS1EDMU9iJHxMkW82uXfDzKGJeaPJI7v9V+u4B31BwnheZexaXSpZ
	 HGRIrPGKVGvv03UiLjDIzfLRhCbRja5XW1WlKFjxjngXp2fmJBdpJpyU7KKXvwvdh
	 pUHIO9J6D33ruoz9RojNcHOIXH9m7wGdphXU1QEhkkgxRCEVqQrVs0/DDbUMygyjX
	 U7baInkZgSR7Hihjnf6314+JAVvy/24ryTGi3sycBDIfQjY6OOtQmFCGfk9wIJ45x
	 3oPB+pV6Vh6ATTD4DA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.96]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1sAzzb1trR-00y6Gi; Wed, 17
 Jul 2024 12:50:50 +0200
Message-ID: <94b96235-4572-4cbc-8ac2-891c1dcfe3d4@gmx.de>
Date: Wed, 17 Jul 2024 12:50:50 +0200
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
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DFCMSvfhYijB74j3gFyTUJ/Czlldfk0+b+11xIC0rhuB50xC8qh
 zIYw0KN4Y+Pt3rPcwxgj2l0bg9HAlrCkhLZEkXR3n4Pnhc7IauWqQZc+xD+v39crGz83BGi
 a8wyKOwHgzmQQnoRgUiaJ5VWmnaf7HgkwqevHzG97nAMzzhzD8qsngeO/m2b6Hj81hHPRZ8
 158Iwx/kSOmuEF1L/Os1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8dHNIc+lvQE=;uw13cgEBcD0j+SxoVlrpT1Rjn4u
 hyXJI3XcVtKCId+41FEGhV3AZo30WKEymbkjNMf0e+bLFxjIWulCY08xYmdcrs+2Y+F1VKqDM
 dgYyn+htHHvJ5uFLL0StDRfcgUxCRbFmngSfK25R594It7hAVorn89k6X+sJK7jK9fFMCO0Za
 uMZmFu2uy4uMIfTwo+DGacTKYhyMfySg61AJFrEuyLe6vDwRTWqoV7Byvu03tyCRqAUdkk4iK
 k60f7Z6FaGwMHRpJYsGz8MaHVepuHZn1uWTep6NKaLf16Wg9SJFy/1jgKPf0H/sKa4On7jy6e
 fZi6sM/bu6zLLbz/XCBqqfhfdznGaC9heRmV+PhCrck/v9aDAcFqExGV/0OAh/t2iSdnkx/aX
 x6CHaFf1XKAsSgr6U/aZitNMtbNOuF9CpIp2XbWHgy8uxEHbg4rXTW907SVsNiJ8U1DvvxBxf
 elEPeIhBbjimymzAauChT7IR9UPXHmZ0aKLqObZoLPiVneKGkH7+UxdNE9oJ0xZSc24Xfa/k0
 lQjoqQqF9i0Mo+eVQnpoVoYUEZlIDJASZKljrAk1nv6wRHoZk1WeqYPwj586chzDnYVbAMltv
 VMLVmtMG/zHazaej3pWW1945VoM/Rxd7bG2hMPEnh5Er45pZin5vYEBoTXgxrIx4QDqhXmh2u
 UdMKpv85dFt/edwmlHAJPK7bC2RVP75lfxpWP/uur6S/uW59D5WH/IVtZf65NsEWoqTxKkO8M
 ZZCjUYm745tZt8qHBSwbEi7r8uY5XIXAZzK03gkMPqstcR11Yy0eVdUVckCarHBolqvf/Puza
 KP9IjRc7ZGGHq+fRksB96CeA==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


