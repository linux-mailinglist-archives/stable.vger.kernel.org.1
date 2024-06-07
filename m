Return-Path: <stable+bounces-49944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F073B8FFA49
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 05:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428BA2868E3
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 03:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65817BA3;
	Fri,  7 Jun 2024 03:56:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F23FC1D;
	Fri,  7 Jun 2024 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717732563; cv=none; b=Gs/8+RZexSImKVdmDq2ZDw3mp1rhE32jzzoAzpNRx8nOkmgNrjx7MedlRA9dbxvHs7QOCGSguWvZ3ptoQk77/MM+8CP/k6B79Bb1/G4Y8GbjCPa8nwYE/zK6XPEJI95NkPNmcqRr0nc4J+Fpas9yF2hclXPmuP7xD2j0vHJlk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717732563; c=relaxed/simple;
	bh=/vSZv0xz0fYaeyMGOavT8gPXtL9VXswBqH5VNvM0oaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxSsiJ6Zs5ELAxXbXvi1GYGAfh3NDfK+SKHmpBBcK67Nnx5QeZI79qrbHQd0LbJzmzcMVV6A3Q6cC3mrGLwIkgj8NEGrfbAH3F/oSQMELEZiuvrw6ugZTroWc0g3PXffraHPuUekGeuKevU4GsnM+//yXkBmA/EhA5inOcMmGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aee92.dynamic.kabel-deutschland.de [95.90.238.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B015B61E646E4;
	Fri,  7 Jun 2024 05:55:28 +0200 (CEST)
Message-ID: <250a5988-271a-4a64-8fee-5aa48592c6ef@molgen.mpg.de>
Date: Fri, 7 Jun 2024 05:55:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth Kernel Bug: After connecting either HFP/HSP or A2DP is
 not available (Regression in 6.9.3, 6.8.12)
To: =?UTF-8?Q?Timo_Schr=C3=B6der?= <der.timosch@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot ^introduced: af1d425b6dc6


Dear Timo,


Am 06.06.24 um 22:46 schrieb Timo Schröder:

> on my two notebooks, one with Ubuntu (Mainline Kernel 6.9.3, bluez
> 5.7.2) and the other one with Manjaro (6.9.3, bluez 5.7.6) I'm having
> problems with my Sony WH-1000XM3 and Shure BT1. Either A2DP or HFP/HSP
> is not available after the connection has been established after a
> reboot or a reconnection. It's reproducible that with the WH-1000XM3
> the A2DP profiles are missing and with the Shure BT1 HFP/HSP profiles
> are missing. It also takes longer than usual to connect and I have a
> log message in the journal:
> 
> Jun 06 16:28:10 liebig bluetoothd[854]: profiles/audio/avdtp.c:cancel_request() Discover: Connection timed out (110)
> 
> When I disable and re-enable bluetooth (while the Headsets are still
> on) and trigger a reconnect from the notebooks, A2DP and HFP/HSP
> Profiles are available again.
> 
> I also tested it with 6.8.12 and it's the same problem. 6.8.11 and
> 6.9.2 don't have the problem.
> So I did a bisection. After reverting commit
> af1d425b6dc67cd67809f835dd7afb6be4d43e03 "Bluetooth: HCI: Remove
> HCI_AMP support" for 6.9.3 it's working again without problems.

Thank you for bisecting the issue.

> Let me know if you need anything from me.

If you could test the master branch or bluetooth-next, and, if 
reproducible, also with the upstream commit 
84a4bb6548a29326564f0e659fb8064503ecc1c7 reverted, that’d be great.


Kind regards,

Paul

