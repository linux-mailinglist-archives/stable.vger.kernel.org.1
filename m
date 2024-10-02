Return-Path: <stable+bounces-80447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADD98DD77
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298B41F239D7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E691D0B97;
	Wed,  2 Oct 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="R8H29Bgj"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1A1D0B8C;
	Wed,  2 Oct 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880400; cv=none; b=KXqu76ygW16LCYrBqYUZC80IqRWzNc+VLVpmxxvu3zz4Xs1uMdL36fsx0ydOW4LWOWRDzVaJVNnVCsGqg0NccPzvRZdvO3m1qZnNBJnOsh8pgFBusaONi4ZLECr994L8nF7b2RKzAYPF/zqXEM0y4QkFcoT9TwmRb2lFwY+uujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880400; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=AgzgAQbfl8OzEVmgENXhendkLVlqsLbBdVVGkzG/dP0AxKZnI2z0FEyHR0zINvxguKUntZg3OY/ewyKaCie0yIf3hR18mVtNfbx3GYd0PeKAsrdRt1MALghVTCFEKKaMXHrTO8SCXlXOM77k5BUJjzWAyoY7f8FoZ6/sAzJi2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=R8H29Bgj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727880393; x=1728485193; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R8H29BgjIYHC5HSrs5ExoC79VXfbxb5HIpFPE6itf4REqL4YqQQqBLGmgNZlWfGr
	 lNTvlfD7TBpInhf8FB1lLsltiGL+KGFKmDiNOUdNfMmIfrzf6XTHHysM78ZgHyITT
	 r4yJP56uJ3K7wPjAIQM4X9g3EVGiXBWYQN3DDYPRPtCxivMrW/3JbKrhNzpOdEhir
	 59zf/w3TL7eMSmW8cY/D3UIqH7xuZpKe4zS+V5P3kBW8RSTpmDZETLwmnjzEKE8Og
	 nybEnLinHBBoT5M+WHJ8KrcRcbeBIpR47sC8NKBS9rbGKfjZlH/D22VnQWltI1gWR
	 WO9ED3mUGCZiMeP7Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.42]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1sKSwa0Tfd-00gfte; Wed, 02
 Oct 2024 16:46:33 +0200
Message-ID: <0c1a5657-086d-4155-94c3-74b05d640c35@gmx.de>
Date: Wed, 2 Oct 2024 16:46:32 +0200
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
Subject: Re: [PATCH 6.11 000/695] 6.11.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dhPz6HDS0AuLM7HAc53ac+B4Ef395QlklitoUiMS7hzXnuLP6Mw
 Y9C5Ik1DhFdxWF0RKkWI7U0e7lWkn04XKG736nJKsNlbSETxfZjsnlC72jABCPUxCSAithb
 N9tna1IoC27b3rJQQd46jtGx+M7JXjfDgMoli7oMry8eCbAPz9hMT/CXbe5ktGUlda8rPjM
 qX3CSOuEqJonOKUJv6gcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HFVvOebfRf8=;wH2cjSWC2Y58oP6u8N+3NmK/B/k
 OgPJ6435sESR3AHvsN5iUUIXRcUpDvlTvy148PDbUP62iURlN3XTWJI+3TjZVN1g9zUaWGu7X
 E1h7ERb8OmJPFp+dEfaZtladwKHworEy3ciZp1r8ZeJmj4yBcKgo63nU4CX85DzurE8XJn/rQ
 I/WVr+SU6yTB3aq5lMt3RJkohcBCqCj6Id4sQxALgUa5gAF4ZXXspWQltZXKvCaO4ryvZLy9D
 5qkoft6BZx6gcXr8eTzxvjwPbOAPs5Bmeqq2deAqAKwERozkZoDQPrU5oZ/Cued+7FwL1Mt94
 XbSlEjnnezBfYBbCFFfP5lNDjlORhJqJyxr9Dm8MbWyXBT/9ujZETW55TEPlvDu88Ih0UbN43
 H/Ij+tLJqqEpOSzLk+0zUucxa4P46pZoBpPyGFl+61LjFAfyZyFOuI8wlOaD/+Qpmx75R1Tae
 +wB6PBTmMDoScr7qwjL0nSeTsa3XD7UbB+eCFw8ANjnu+AGc+y8cDfJ1u1IhvgcY0xejAUyBA
 +fw/OVtYS2V6IXnzFt2qD6hius5duQdphEnQssLgH/wib6keQzNewK3+uonHV9dm3xXVICbGS
 y3QHc4V24hHQhjQgrN7OIzXtObEUvZn1vibS2E+5vg52TTo5QsIsjAs5q6FcIbrRj5ckhem5+
 5EYb4Qntb/Fs5/L9uYV3xYwJeP1SB9bBCs8HXiGr7idvoqdCeffw98PfVrcckxGNBIyNy+WSy
 JIOPNi22hokp4+PGVEXRnv4jLK+31mrsDunE93NI9Qsh1a5P9+cGhE0C3ud0JTcSv1/PywQfY
 GYbhikqnpMoBJ57gJsHwZZ2g==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

