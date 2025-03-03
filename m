Return-Path: <stable+bounces-120177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D9FA4CACC
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 19:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBED3A6916
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D6229B07;
	Mon,  3 Mar 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="PVwnOS3E"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF15214A8A;
	Mon,  3 Mar 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025065; cv=none; b=WmMSjGFmMvEMJmdxTuTRhgMecCHBKibH2DDExauNHIexAjv95haNbYJdDZ5jY/0554g3KbR4YU2TlLT7lc+YHWl02VbMKPdNAN6XbcigZrmurJBEJsjMwNXcpd9OkViRfotXvCvhMN6EZRVq1mbQSiKQ+xBQoHYMCkVhnCP4XOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025065; c=relaxed/simple;
	bh=zoa9d1W2hAHMj2Xu5aH+Voz4qYbR0KEfYZx6lQa6UrU=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=ueyWY5qtnZLfnLF6OdprHcvQ+hzd1rYNBVftSHbQ//C1Ei0BPxy1hlvVd4cx2p7Pi20wyIGGnCo/s5M7G2P9mjUMbFQ6FArd5tKN1QCT/qfPj9xk81OZsmLWzB2p6orJcYPZIzYdiprC8qOyhTk1JxBudKHXTTszha7+gatDAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=PVwnOS3E; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A48D4425F;
	Mon,  3 Mar 2025 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1741025061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h29U88rKE0F9ZULoLkFLslgs12yl8Pik059fbjfoXBI=;
	b=PVwnOS3E/h/TsZWB6T6zmH/EOBZ4fW6bNWQf57rTUuMGrNIRAt12dKlgI5CRyIudHj4Y1c
	FEQg1pIxnPZiSyQUND2hgTKAw5uFGpFKDTabEYXLyAGFnqRPGGyT3/zeH9jCqy6M2xIZV2
	lVAn9s1eqP4XfW3hUowx8Tv2JHqv2cHf+BUmc3S+unohm/0qC0+uO4szrFUTabUGFwABtu
	/efHftawX7fP4iv/NQYK7mgUtnVTwHYURajwkNw8q5AXxt+Rz333bU33h2U7CHMYgI1XAV
	GVj2sJ/JWC9MqU2mgfu4dj8Zjlz0bsLm/SauqffL2VItrQ37CAQVSdKgnTp/jA==
Message-ID: <88b4e029-1513-41f7-be39-4f31d360be8a@grabatoulnz.fr>
Date: Mon, 3 Mar 2025 19:04:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Content-Language: en-US
References: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
To: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org
From: Eric <eric.4.debian@grabatoulnz.fr>
In-Reply-To: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
X-Forwarded-Message-Id: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfufhfvhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefgrhhitgcuoegvrhhitgdrgedruggvsghirghnsehgrhgrsggrthhouhhlnhiirdhfrheqnecuggftrfgrthhtvghrnhepleefudeltdffhefghedvueelieduueduteejgedvgeekieelkeevledtheejfedvnecuffhomhgrihhnpeguvggsihgrnhdrohhrghenucfkphepvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdupdhhvghloheplgfkrfggieemvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdungdpmhgrihhlfhhrohhmpegvrhhitgdrgedruggvsghirghnsehgrhgrsggrthhouhhlnhiirdhfrhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhor
 hhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihguvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

re-sent to lists because my client mistaklenly sent as HTML (now fixed, 
AFAIK). Sorry for the inconvenience.


Hi Niklas

Le 03/03/2025 à 07:25, Niklas Cassel a écrit :
> So far, this just sounds like a bug where UEFI cannot detect your SSD.
Bit it is detected during cold boot, though.
> UEFI problems should be reported to your BIOS vendor.
I'll try to see what can be done, however I am not sure how responsive 
they will be for this board...
> It would be interesting to see if _Linux_ can detect your SSD, after a
> reboot, without UEFI involvement.
>
> If you kexec into the same kernel as you are currently running:
> https://manpages.debian.org/testing/kexec-tools/kexec.8.en.html
>
> Do you see your SSD in the kexec'd kernel?

Sorry, I've tried that using several methods (systemctl kexec / kexec 
--load + kexec -e / kexec --load + shutdown --reboot now) and it failed 
each time. I *don't* think it is related to this bug, however, because 
each time the process got stuck just after displaying "kexec_core: 
Starting new kernel".

No further output, the machine is completely unreponsive, even to the 
power button (I had to force power down by pressing the button until the 
system switches off).

> Kind regards,
> Niklas

kind regards,

Eric


