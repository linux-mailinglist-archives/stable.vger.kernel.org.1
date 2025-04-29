Return-Path: <stable+bounces-137846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8548AA1581
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07573986BEF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0932459EA;
	Tue, 29 Apr 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="FpeMG7gL"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7225484A;
	Tue, 29 Apr 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947305; cv=none; b=QJ8uIizs6LyQoqpIOcwjFLdGXOfPZRLZ8pslST6SFxIXM4Clm/KN7BDVHvHz48E98obR4Oxw6tSNq2Do4TOJR1hrU1M/gPYpH9tvrVc8Ig3DNkv4Z3vG2BUjaU19dPmu12C/mNZQXg5wx07FHTU9I9bCutcqsQWV8X2MBPUQ3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947305; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UePrlHN+R7jDRXZK/yLSXvaAhKgio+fA4AW7nvmk3lBO3FkU++zuRFDnNLtpfNkV7Qc7bN0y+I1c6eWfjoClCYl1Jrj2AUu5vN/lCAIihdzfUqDRJtjMovGniQvdyAo+K0LegJQjNXGwHvRvRQA7uCTk/P1g4U8RRlBhWTMF/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=FpeMG7gL; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745947270; x=1746552070; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FpeMG7gL8bQcwbzGPSPEHrCekH5szayaNULqmusJiwx9NxW3oLppX/w9gZmwEI/E
	 PAK4rlVveDMFuIRLzeHUOE9GGSXEACybl3fa2ljMoYeqWtoSOLancCrXQ4SM6ifdj
	 lkdmqKR4JxmZIy+V2QVbNfzeqowPpbfQWISP/9kS+OeaRZrMQ2oNPmJX+UbfG/ceI
	 /2mS+TULOSehtMKuT1FpzZA2w+r6V0jaf1yu9VHWhXzGOOQGsrVPPFbbCSGH3fN/J
	 ZOVimmDz8yAEXAr1GP46q4k0hfWkR99+doRcQyQdH8o99tZOqkj/LqjtNzHVXcerC
	 7qYw6Vd33JNldhp6TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.35.117]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1v00OP2QZD-00wOEo; Tue, 29
 Apr 2025 19:21:10 +0200
Message-ID: <79f5c0c6-1c7e-4831-bd81-2b466e73d860@gmx.de>
Date: Tue, 29 Apr 2025 19:21:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161121.011111832@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S/Tmqmk8K4T3moxT2efv1fQ/D3NqiiDg3lKrT57XhcZHkvLzRfm
 +Ci+79znFMsajcWWcODOvnuqK/j2H5lylGiI+HYXEblythjq31KDMEdg78V04wA5ge7BoJm
 UElf0Itcoitep2TyP70SjLe2nyAo/FKG/4sVXJmt0QfQt74e/V5Vt4qTlpReEV1pWYiixRv
 1RSbdbqKLY+bKhnwAe/zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tsiHcWhUleg=;W7ZRkMH00Sxrcl56CoiQCkKwt3F
 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
 lUR3lJNeac+Gl526ByEtuLl/s/m9yGs=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


