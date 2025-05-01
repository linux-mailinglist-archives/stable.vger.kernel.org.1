Return-Path: <stable+bounces-139277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781EAA5B23
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 08:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349A61B67D74
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48982609F5;
	Thu,  1 May 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yJmhkE5i"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B1230BF2
	for <stable@vger.kernel.org>; Thu,  1 May 2025 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746081712; cv=none; b=VdKdVWh2bj2EZB3WI83LfzlvrZP4/8DtYuFV5Z1lMXMHTaivWQo+ZJn9wWowNUQsDRFN/iOc0KKw1lcLqvGVkmXbq5tfWh6+ZPsbkjSZ34dUYyl80003b7cHRak0thkiafRKjZmn6EFUpkWt6T37uLFuyrDDmKYnth6BN3wsihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746081712; c=relaxed/simple;
	bh=jM9w79wmEUC0Argfg1gJ+a2Xx9biaUe4re6MAwjlxRg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q77bLZ+ybktIJgLSlNcJODfT4+xcSG5Xvb3pY1iVh+IxSnQ9887EJxU2e/RgExDtZJSiE6rQH8sMiaDE9lrEG4Mxs233Msfu6jA+dFaf9YoIzTx8rd2L+D3+0/I133i4zdnFaMsLpfanTo9UKGKppguwyDaHjb5P/DCk1Y60vFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yJmhkE5i; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <e7198e45-f7bf-4864-aed7-dd4ecfd13112@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1746081278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZCT7tD7JysOnOZaZVBSIq9G80THqPNPqPd8FLWlNTik=;
	b=yJmhkE5iiS+Z0CFRk93dlb/k1Uyp+UnWyoT42abtfT2uz5xvpIv8yenZug7Ge0IWn9Ttua
	G8x6fEoNcVixDd7n869C7EDcLhJ3t7RnDDtSkR+onFo7YiCx64BZQAOA6zQ27/5X9ZJRUt
	IIHYC3egCdqjfzO4/NPtY5HSTCsLlhqr10r8ddUin9V+rGVgF1cfSnCv7GGkCkriBHKJI3
	rasOsN8LICmuvBHi6Lh/SBub5syhG2gIzoCQtRvLvwkqgkqiifmgJp92pA/+YUXzdbml80
	PrKm/152cE8k6LISzs9Y7jUPVArg2DU3WGmN2pZ4+0o33f3uSRUo5zz1aGyWpA==
Date: Thu, 1 May 2025 08:34:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Subject: Older kernels like 6.6 and lower may not compile with GCC15 due to
 -std=gnu23
Organization: Manjaro Community
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Hi all,

GCC 15 changed the default C standard dialect from gnu17 to gnu23,
which should not have impacted the kernel because it explicitly requests
the gnu11 standard in the main Makefile. However I see these errors in 
older kernels series and some realtime kernels:

5.4, 5.10, 5.15, 6.1, 6.1-rt, 6.6, 6.13-rt

2025-04-30T19:26:10.5226566Z                  from 
arch/x86/realmode/rm/wakemain.c:2:
2025-04-30T19:26:10.5228293Z ./include/linux/stddef.h:11:9: error: 
cannot use keyword ‘false’ as enumeration constant
2025-04-30T19:26:10.5229525Z    11 |         false   = 0,
2025-04-30T19:26:10.5230691Z       |         ^~~~~
2025-04-30T19:26:10.5232337Z ./include/linux/stddef.h:11:9: note: 
‘false’ is a keyword with ‘-std=c23’ onwards
2025-04-30T19:26:10.5234141Z ./include/linux/types.h:30:33: error: 
‘bool’ cannot be defined via ‘typedef’
2025-04-30T19:26:10.5235478Z    30 | typedef _Bool                   bool;
2025-04-30T19:26:10.5236557Z       |                                 ^~~~
2025-04-30T19:26:10.5238016Z ./include/linux/types.h:30:33: note: ‘bool’ 
is a keyword with ‘-std=c23’ onwards
2025-04-30T19:26:10.5239544Z ./include/linux/types.h:30:1: warning: 
useless type name in empty declaration
2025-04-30T19:26:10.5241119Z    30 | typedef _Bool                   bool;
2025-04-30T19:26:10.5242189Z       | ^~~~~~~
2025-04-30T19:26:10.5351835Z make[4]: *** [scripts/Makefile.build:250: 
arch/x86/realmode/rm/wakemain.o] Error 1
2025-04-30T19:26:10.5362380Z make[3]: *** 
[arch/x86/realmode/Makefile:22: arch/x86/realmode/rm/realmode.bin] Error 2

I found this with mips: 
https://lkml.iu.edu/hypermail/linux/kernel/2503.2/09285.html

Do we miss some patch not backported?

-- 
Best, Philip


