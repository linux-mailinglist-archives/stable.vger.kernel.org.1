Return-Path: <stable+bounces-58762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61892BE23
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9754B26B02
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4E19D88E;
	Tue,  9 Jul 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="Y2RGSdut"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632919CCFE;
	Tue,  9 Jul 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538344; cv=none; b=DWyPl6162Ytkj98PdJJ4vPGPrjncH6V3zNZz1vMYarL3lLEJh9amYRmosw58ECbzD/oz4U9xDQhehWTiMjSj6sUMAUEpfogeR2oDjCNlK93M6Sjw4J00t+RR6sqOUiZxo8Jnu/bILcNaIq3/pYGcJcag0UUjR4ctIzAsHXfKIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538344; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=iPxpWS1Jj4wSZSWEl7tJFTsGjCE+kUY1M37DpiYLMnNrEY5iVfzUH8j5JVD5qf6hjxaDS7OppSIijfvMtTYEZc/afDAS3CdC/2FsNjvXM/TQaKMUqygRs8Wvzs6ndxWunGEdMfiiy3EFj3f8BsgZsMiPulIsH1fBvXl7vBFEGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=Y2RGSdut; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720538339; x=1721143139; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y2RGSdutiUPcHwWt+lTq9NdFFAUX3PjVTRZefHmwnpucOK+uCPhOg/YShrv7YesK
	 AdXnjU2sWRZcoFwfk/UHXALaiheMCZJmfnJnwhCCmQQixK4P1uPMP3/oV+X+YUY7h
	 KevQ6rEZN2N1Aawws30AglFlnlZSVw+ssaRmOOvp23XEGu2QfyVln43BMTxv+U82h
	 dE11AYawb/49su9/RQxAzNRN8odQCtxvar5QWlng+Dq+UuJUN9M+a7u0+RMkwnwHO
	 QkLtLG1c9/an1a0vHSl7jrysmEYwCdyWITA7qQzBYFz1zQtdRfxuvgZ5DSLtvnmdq
	 8NrFuU7L+SLf3gkLBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.144]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1sADvl1MYs-017Nqb; Tue, 09
 Jul 2024 17:18:59 +0200
Message-ID: <268b039f-b810-496a-8c9f-a9db1f833e74@gmx.de>
Date: Tue, 9 Jul 2024 17:18:58 +0200
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
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZsCCciyRw7X8jqtGN97V3oAJdeXwjjym+NpSKqqoBDgrzpinzAR
 SlysNkVEX0ZZrdtQJ5cVdTQC+UMXuXfDQOcFzAHdgPeRDyWfDa7yMg5t7lU8MDeNCfGJwCB
 WSC0xTgo1McPAoUyT08J2uYpBIjZLEany6BroLo34ob2aCc1iJFQqNUP83ZAVlAk8AtO7bI
 ZwrmhsWDIMS9X/yJxA4wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/9AxidmAcGw=;QG2AUrJjt83Oq9cYeVHBCT5zW8q
 ZHsDkDp0XEuVG04LfueEvu+ufKRlGYXhoQzfDL19bWgg4jc6VuBFKih0G9jThiTUM3sI+X/7E
 gAOkB2cAQPIaH7kazfC3K83n/dwqZO68nHHJiL6z91OOXqR2u22NPfUOdnvONrZSkrXim21f8
 Zem/ngO2sG3dprW6KXAwaXwLp8QuIhOP1jDvKOOy/qBvN4eQGzA/5hopYz8KUAZlFomNuquHb
 EDYAh4FADRJ8hhJnbUEUUsx6uJf4D9R+7CElKQCrBytoA4zPhgGGyqASe01BcBpmxclsG0zEE
 HxDUqIVz2mwonZ9jAHicEGj8nOiIo/UdEI4BdNyZpeJeIkQENnw2cCpq+6rv40VejSHtWLZf3
 01M3e2oOFfHTVwhm1wN/LCy29bfqLPuKt+q0xB+HpfMClkYCpIhqxArAHab0Z9I9PqXFZDgXF
 /N410iur8L9Hz4bVRHRqFBahQWl0LXjSlyxb3is67/bTyoaoDHKKQB87zedHb34Qr+5YHwQNI
 5Iuz7xZCNkMHmoQfbZTd8du9pVYsSATNOZabz6axOvBnUk/ErFp5l9N1T9fR4Qiv7D7c1KB16
 /iTU7ehqTdd8iCbIM9gqAYD4gnzL2crDlqOwFB/LKmfs2rbhdmYFQQ9eW1afDP3OVkbdn1/Gb
 N5N7a/0HuAfMmnnhF6H2UGUU1Rjnb4dmrW6wB6o21uN976Xw+dFoYjHi71k0zs5Zw0EcxiBhi
 8SqeaCIr3Byi1kZ6WXvWZnABSMN8txPCxE6n/UUJo+FkfSixwLZOZBgZIPlud9IJzob3qNEyQ
 Fz3kNw+aZUzcS9f1Th6R2Pmg==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


