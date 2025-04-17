Return-Path: <stable+bounces-134422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E86A92AD6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9796E7B23C7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC22571A0;
	Thu, 17 Apr 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="b7d5S4Mf"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D21D5CCD;
	Thu, 17 Apr 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916078; cv=none; b=Bu1GigM1QqNwhsCWtZoRqLbnJjdMvGgeSbDA2CVQCkN2glnFm9R0xJwzzSoqO4eZt0LICyYkhTU8azy8gS8KHw2UHS0QiSR1qTT62/izT9s9/33ZVSszT/nIOIEZsNEQqpYZcnzz+a8grItMgGiNLtqkl3lQ904ekhtUzWHANHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916078; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/u0095bo04vfgm4fiLgbA9AOjZzvpB3uxUHV21PByBKo0zxNCKM/Z2jsIm7n5yia9nnPFuMye4xoAomTqF8PFYsy9LHXGUG8pDGieU/NJ43L5KHoUYfK3qCzsdY38Usr/HCzUjuT+qgn8P6MI5gvVyPYKRILqVRrZBJ49HoDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=b7d5S4Mf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744916039; x=1745520839; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b7d5S4Mflgv1rTEuxygYly2z8bV8WFlH9NTloWscIxMZ4kvizbdxwUQmr6tcSJGN
	 qmqQCGoT6kxRZPWGzVC1g3PAsN+tFNbP/NrDtX7YyVfgwfhphbL8vO3S68SZ1Cp+7
	 9Sw4dyuGy4pVh5P27YC4NsNFEGzkgVy7faKTzjaOCeJtDL3GQzgiAdWLOLZr4/Z5U
	 AodU459KMRBmZIufA/8RAmxVyu16pcidw8+bPxnOzqCnEKxV/n0YztGHFPLI94nt9
	 eSnnfnJm38z5o3Mw+m2xL/81JVjFgE2D0oAGTqXfZe9IqJPjCwNSdqKkO0tWlUBNs
	 2wOeFCySS9oJC+JiAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.101]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1utidd2Y9G-00obIB; Thu, 17
 Apr 2025 20:53:59 +0200
Message-ID: <81faa8d1-7d9a-4768-b89f-113bb4672218@gmx.de>
Date: Thu, 17 Apr 2025 20:53:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/449] 6.14.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250417175117.964400335@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K2bz+hU+yYyhtfq0Xs6zbG3IAfa5jcz0szI3T8pte1fJMPcMrSK
 uKqd513uAfNmfZDoHp7kkZmCwi9tMCxbcT+l80ZSQjIZE/IljpHcY4RjyBXXUNxc7iYm4Sh
 27BVG0t3ugTPeodhlCQ91kxrTt9OHjCznfBdgBu1LLtbDt2XOYsNW57trfEp2+b876gJF/G
 EeLwVskc88jS8JdQGQAtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j+gokKn2/9E=;hTWiISN0CNnoZp9vz2+NNlLH/oZ
 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

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


