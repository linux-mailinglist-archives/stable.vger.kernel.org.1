Return-Path: <stable+bounces-91854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064139C0BE5
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B183A1F2338B
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078F215F7B;
	Thu,  7 Nov 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="MtFYysou"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055A215037;
	Thu,  7 Nov 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997862; cv=none; b=Z0SY4dDwjYRaRCzflr/zv8wW8zuxrLxPNlACOA9/0t9sbVt1nXDeNShoMSXcFS31lvcqc48gdxwHDUgYf143y80mq7iawe4tEEPX2mKuIgJXQiEwP7gl6FZWniXZ9i1UOXZK8S8vL9GTHRs1aBcPROCk3gHrvLck2nbgDA5Pw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997862; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=XwmDswNgfu6hCURw1eh7EFMQuiZwYmvjs/jG1RbgjY9BADMEPvLOLXBI00t/ucba4rTY46MhrGkxK2VXWHObLK7osc+vthI60ztGaxKyS9NPiA2lv4wtNsC0ht6YJeOgZUNhJR2bbcal4i1u1supZC6IQbpZcETtpqBxP8HylCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=MtFYysou; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730997857; x=1731602657; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MtFYysou3CHMXezDJSruCi+KdEvsil+gcURiS3Rb9QNQMXqEJ0nqSL+A+Y9+KL4H
	 XDpDN7Td4ZhIFLybO/vh1chTFJHsTma1+NCVQOfw0sIzeN6AKxnSt2rO3lgyFjiZU
	 F7KQe0+J7mowtiovFbZknaDrQedFQBiASJe/asfFqznx+PkqvDIWxLYRM2sSdkVsR
	 XM+o1wRY5WmPMJ/UqzK1KCdcyru3Lb4IN9HKKltGFl9YCt8raJuIrYAQfcs+iMcMV
	 FxlhqwdPNZZnY0nhYU3j8SnQwOT1Oknqk7/1Gir/zdMi/Qs6AaMWn+YqaNSJn3gZV
	 ceilw50bQamry9PMkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.34.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1tBZf62pcf-001dg2; Thu, 07
 Nov 2024 17:44:17 +0100
Message-ID: <177ed6af-1b3f-47e1-a061-909df724622d@gmx.de>
Date: Thu, 7 Nov 2024 17:44:17 +0100
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
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iZhjYk1Mlkj/RK68UtE09D6HNmPHeBa6qMbblH5TdW2m5cIHNrU
 FWIoJ2a5st3zaNXAySiyK44vG66xCHJixfOEkHt7VwQJPbRLTNwwr2tWUPWShktu9ekMt9j
 M680sgRLA7aaFxkPFAIQyeRNFhcFBvM4CI6kQ0CXi0IJyD5ABLpNCQdhoUR6JFz3Exyi8XT
 5MmddOaWD14oHdiwZPJKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j4zPOd+VDe8=;I0XJWyCN8f90SUzg59ZfYuGqSo/
 d4gT+uit0gxDjKpuC0p/glH97RH+z1E6OzfsbNHDR7RC2GYtQj8ygTws8QTn7S6u8ayOFlAkv
 FOqPRscey3IzGsaFQCmQBv6xdOivruha1EfcPYnzrVWBNSR1k+bS88YO0YXQaUAzB0MO8AvHF
 23RY01jk15DGeYgtqxGRN19JgRYQt6MaTfYSkomJMcrdRtvfjiLVfPbaAaDsDFN01LZqt3+gz
 xq8I8zwvU1oQ75XWVNF0c2NbVodvJBfsJaPNtdjtjobNhtpGzbO9s4FEPgxwThPV4RACEFXLF
 23VLtb81vWV5UJpp66grgeYwXMxxWmeHWVUx4B3WnmCXtCEnt+vA2wRaK3xeS2ZOP1449qgrp
 ySC+FTdEvJN26rtwoqvd5OWbwWBEBAXamKQNzOkyXgVefCoZ9423y/v6sWG321/o+Stzv1ZWZ
 CH2XYgQaEyRuz9AWthsos9TQEszfh0K2FVVSEFJXga/y10OGI6MnPUp8/qIT5i1g0kM5h1H3C
 CtJv1IKJsHSFMQ7hJ2XGtZ8AIdqj5xszgxBXmPgAqcjKGKftoEhOJAyyBRJHMkbCiJEolwD/o
 ehkZaDWxQXCniYedG6Dj7GTNANCpVQRg2yJDeZlL73GFQNQIKEh9O7WevUCpz7zZ5PDW5uf7A
 g/2xv+GTiKIhIvrdkIYRyS8h6BfZdqyPELgwy4lj7z/qse1IfQMzaMxB7TZ5gf5MqHWSHLtK+
 JfVmhU0FI73xWXbbCLqhEJ9wZZKCENvrE9JNDhQ40LM/7PlJpHu1jogQGsSO0LXL5SIHIMoK3
 EfYdH+Hgh7YZm7T0fI5LxAzw==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

