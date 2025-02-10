Return-Path: <stable+bounces-114704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9F7A2F6BB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5525166033
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7B257455;
	Mon, 10 Feb 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JYGLSQQ8"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB82566EB
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211488; cv=none; b=Gsu+dr3BbBcdSz9W6qJJDaLY2FZHLbCuRh6QUwqTdeJMLutcHHnHV+AFgqgOfUjYlSLMXrNiFb+paossjdBA4fCD1Zt+uc/3UOOZc4q2dHV9UKlA0G/wWpOrgLnC3gmD4wgGC7RGyx0E5SGSigAEFCRKnbZTKZHZNynMSC4/+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211488; c=relaxed/simple;
	bh=WP2GX0lRf7cnQXbdHt+BeLm2SEKYPAt8D177Sm1NedM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RkvxaKWmrK6ko4KFlEFfkwgqJRAZYq0PLZww6+x8f0Nm1tC0yiIGqoUuurVLzvJ89Azwgk33+5+w2yYlywl87QsMKlD4Qn/emdGk3LzykEWV3IGnmKSSd2iwhZQ0vGHve6laWHsBPEMOXR3f/MEdUaV/F2DHOcdnl9nUb3wq6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JYGLSQQ8; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 95044A0012;
	Mon, 10 Feb 2025 19:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=jNMZP/MEND6A1/9DI2zt
	mU4pMdVhigV8aegZXs12/mo=; b=JYGLSQQ8vrJOwdevMv8GC/dB64erBCiN6dd0
	0YSxo0gDICTUZz++V0+UUf9DW1YayMQ4uoiJUE4c2xSwYCILIdhcXhVGTqrq1/RZ
	lIBPahv+MHShElT9EEwuhz04YcJyqnNOn81hWD/FTaMaqkOUwcF5FyjFX/yMr01q
	kj7bKm8Uqxk2K7ZU4Mo3sBr9g5TTzAKecMrHcKx92PTqdcdvOkUV4alUTYjg85Mr
	/ROtSW5ONPgQmSAH48RwRqiUpkMXkA+7VzxAnDdCDFT2ZBKtTi4WyEk157Ba0QgS
	KXqg4Zv3iKyozyyj5HVN4Q60r8tn6ILKATEwTv1AnxZtLkZclelIf2F/uMj3X1Dd
	FcCrLpZK4ctJBJwvfCCJfoh134PUgWNVmDtzmqe4rQXBaBAB7c4TZczMklXkqTxj
	q6tx+C4I4BzxNIc4ZecOPiv1yp9vwB1Pv9mdH8dCUI6nPzsWIJOxjFw+x1gmNzbf
	X38PakjAAZMH29Yg/ubAZNWmGYaSi4WMC1R5wCKXq6OBHPK4suXIvBx2ZFrbNm4f
	ZFHALjW0Yk2hc1sIOTbtzPbdkOyPIwpoeI3NZ1FL0XqTnU626WmXhsntCdFCFmh6
	sKHBLXVt3262jxtpR8pjiHy0GeSpLCuwsQRBinYtYRjLFApCDY5SHJJ5r7xtdUur
	IcEGvRc=
Message-ID: <fde3442f-3ea5-4742-af70-9d243678e303@prolan.hu>
Date: Mon, 10 Feb 2025 19:17:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] spi: atmel-qspi: Memory barriers after
 memory-mapped I/O" failed to apply to 6.13-stable tree
To: <gregkh@linuxfoundation.org>, <broonie@kernel.org>
CC: <stable@vger.kernel.org>
References: <2025021058-ruse-paradox-92e6@gregkh>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2025021058-ruse-paradox-92e6@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852617666

Hi,

On 2025. 02. 10. 13:52, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.13-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

There is a dependency, that I specified in the commit in accordance with 
[1]:

> Cc: stable@vger.kernel.org # c0a0203cf579: ("spi: atmel-quadspi: Create `atmel_qspi_ops`"...)
> Cc: stable@vger.kernel.org # 6.x.y
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> Link: https://patch.msgid.link/20241219091258.395187-1-csokas.bence@prolan.hu
> Signed-off-by: Mark Brown <broonie@kernel.org>

[1] https://docs.kernel.org/process/stable-kernel-rules.html#option-1

Please re-pick with c0a0203cf579. As a side note, I also specified 6.x.y 
because - in my experience - anything earlier will not cleanly apply 
anyways. So you can safely drop these from the 5.x.y queues.

Bence


