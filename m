Return-Path: <stable+bounces-124797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77AA6743E
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 13:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DC63B4831
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB391FCF47;
	Tue, 18 Mar 2025 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="exCqs7/1"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA562F37;
	Tue, 18 Mar 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302077; cv=none; b=rlOOuUD0q9uD5aRlr2+TUDC67ibMZyPRncNiWrCaEy6DCcpU3lPfGwH3CjR4RtOi2ythvFMPevFmBGkGwx5Nd8KCDJeFPqY/dsuepwquFlDIu6XIrSGoyS6yEn16KGEzpBbFPYYfN95FP7AKmqcE/wXAiLjgyh0iZwBDr7bOwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302077; c=relaxed/simple;
	bh=JrkJq1TR8evIvgTVOlocAONxVSPvWVBh4GMsMB07KBE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Dt1LjgHjwIGzSxRjTcnWl3h/K0OMr2R+LP/boHw6v5a3qO4fUnthmu7rXlgZtUjCXCZ59HTXpsG4j2zfTMQWBN8yMOSss//0SUytGxUQqLdh1/KbgyBVs8ObD4cuPOdkHHAMQfOq5dPZrS9o6ZvkCgqO+4IVaeX44y6/7t3LHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=exCqs7/1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742302065; x=1742906865; i=frank.scheiner@web.de;
	bh=HAU6yVHHQsef2etIltM4g3rVJPQx5Yh6FgBlpUZOkik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=exCqs7/1SH7xPm8oWoqOGdXPaoEj5ZLiFfr6pWeUWqMUJ7pdmGqarlpMPcGLeqrC
	 W9J6zXMdWtxx5BTERP/mLfxcSMps4ud0GIr0i6Mv1sVBhZG4PHetbQw/OayYpke4a
	 Qkarru8JS5sPltYvalV3luDWz1ESPC50bm8YGsHMJ3PFKMOQLfwMDcTtBsQ0dSAVy
	 o5dRxiCbv2R5jnI4IdMog8mGC5tXt8aj1cbPFe39HGODyGdL48P8iVclUzHqeN4Gx
	 Hr79Omc3z0gS8f3QC+GAvlR+AwtpgVr/xNcJoqh2FswNbZW9JxBAbASCXbhtXBl0o
	 BBNOHpnVoeQUh9vM2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.22] ([87.155.230.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWoU-1tae1g3ndg-00WRST; Tue, 18
 Mar 2025 13:47:45 +0100
Message-ID: <68e093fb-556d-4267-9430-ff9fddc1c3d1@web.de>
Date: Tue, 18 Mar 2025 13:47:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tzimmermann@suse.de, linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Frank Scheiner <frank.scheiner@web.de>
Subject: 6.6.84-rc1 build regression on ia64 (and possibly other
 architectures)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FJKlLDfHrxAUPzWqy55OJn8T76v026V4SPQJ9/b/50dbEhxKQ3q
 jxWB8qSN1yDFgPli7l3+CC8NrN3upwbvKla3CTahVKF1KleKId18LVVAsx+W3dYE1MHhq65
 8eOd3ly6qdNtpg0QHTU8c1MDEXPyTM0u7yo5kC2XlINHpnNiHy3whGZTEg8S5vryPa93ch5
 HnPcchz2yqG1vbTFW13eQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wHMfjhyP/3k=;pwvUvKq/MneL/iqHylNaKAFXV2v
 UrJGfO8lm1MkNAXUZd2bvmXpjKSMb7ZDVgEEUFQ3/JkgmyPkwPMNw4kIpjU5WhcrQxfs4xC0R
 cAkoapyY+xDtK4RHgKQBu+N0C216DK94cpzUnC7cEdv0x+bcQrwuwU7r811Zl8/z/zMx9a93Z
 wQ2Qhuk8Vu0qbSOvhig7QrdoQ4WgDoyvgdyTStJqSCCJ0C7VEuj3u08vr8+KhqTQ73b5IBjgZ
 9oUMQrGveY5G29+KgXcxb+v3oyE+stQnms00DgQvNxSIMeX5VXxFYdgzQ62/mzkevS1W1h71f
 CeqtrBIO39YCdMrkH8P8Md7J0mZLc3PVQ2pPITClYc7LSHPmGP8YoLWak3EVGhmDp3Kig6msO
 PcpR61j21y/BR1Q2YzzpcWIRtOyiZj3n8v6fR1bMBZyQ9WGP0irrR7vgGBFmObPn2MMhfxyfl
 hBvn+qbBRinQ+8VJnXCWAFkn9dXzEv8MdLVZUWE/HsDS5BUP/OaWs3rjCxjlzp9q4DyR3VxGB
 F/vCEb2g29YfJMcF79EMVsMcxkTxrl52w1Osju5ZdYT3fVJ/QqDc91Lhfk09hwCbJeiXco+0y
 NVZ5/BZ30B2CtSHSCkn7Z+R4vtMGQ4k6i5GwofiwweDQFPvAKNOPqDhRf/cV/CMQyPEdnFf86
 WUvUyhlNwuFrTe6M9Rfd1u7ITxL4ce9PP4O/DyHggJi8FVBvPHx9pncFVmT5iB8y1kVlV6Ss2
 yBT5hkoTXLtwQ5M97qMmgj4OndUZUtD78r8gZsugKdjLDf37mlc4rhjx1en0J+RRjgkW05iST
 rkR8ZYe7/hAlg9gM7BBwlpa72VUxaO+4Q0mNw3im07XI0ZcrMNTJmyu2bB9qnB7/7ROdoU87m
 Xiko1luBq+Hn3npmFdE7xc5QXm7u00FeM1iwUyovgwcYSltld4JrPZWnRd/ytNAb9ktw+4veU
 zz4UlTdlaDaOFkgQf1St9OV3gmhKV7sO5aIIBowKGpZzcFYt8PkdyJ5xRsknQYa3+q/3I8a06
 rOQfnOA0I0I+VPDOvdGVErDmqVf+EsHL5BH9CtMq+HAlkwXsaglEbWGXS6uxloXX3eQWl5+6Q
 tumVbjrlKREXzttkzKHqCK2OTkK8cgcmvkXm+QoXCUGdPLxR0o06oyc6f96ja2My/o1Do5TLK
 W/rbF8kv9+/96f5aTnkzUmx8Qhl6IHpygmz9/SXzgZvBmoq8too6giVsPxIiXE+U0dBAYdyZe
 Mm7NMzFrCcEOPRd3SeYM1VE/689i65MpB9lrcfmeMMhewnpcDaDDHy37PW5JD4TMg3UBQ85bG
 N1A4uJ5ketUC217W2F32aQzC4/LWHRNgYjqCGJxmmKSoio1Pgs3DF4mBpanibwVJw8QFTVuch
 /sU2hfZq4B8VPvBOHlaetZWBL9Cl03nY4aZBqZ7+sOwdIOu66p7lMb5IEM2pWq8dp1K/nKYa+
 HYPZTZhxtvzzFtm6Q7h4UJJUKOl2Qh+S3s6V3xwiIXmQIqU3eE0T5SS5rpz9BwAVJfSohnA==

Dear Greg,

I see that the review for 6.6.84-rc1 hasn't started yet, but as it was
already available on [1], our CI has already tried to built it for ia64
in the morning. Unfortunately that failed - I assume due to the
following **missing** upstream commit:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8887086ef2e0047ec321103a15e7d766be3a3874

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.6.y

Build failure (see [2]):

```
[...]
  CC      drivers/video/fbdev/core/fbcon.o
drivers/video/fbdev/core/fbcon.c: In function 'fb_console_setup':
drivers/video/fbdev/core/fbcon.c:478:33: error: 'fb_center_logo' undeclared (first use in this function); did you mean 'fb_prepare_logo'?
  478 |                                 fb_center_logo = true;
      |                                 ^~~~~~~~~~~~~~
      |                                 fb_prepare_logo
drivers/video/fbdev/core/fbcon.c:478:33: note: each undeclared identifier is reported only once for each function it appears in
drivers/video/fbdev/core/fbcon.c:485:33: error: 'fb_logo_count' undeclared (first use in this function); did you mean 'file_count'?
  485 |                                 fb_logo_count = simple_strtol(options, &options, 0);
      |                                 ^~~~~~~~~~~~~
      |                                 file_count
make[8]: *** [scripts/Makefile.build:243: drivers/video/fbdev/core/fbcon.o] Error 1
[...]
```

[2]: https://github.com/linux-ia64/linux-stable-rc/actions/runs/13914712427/job/38935973485#step:8:1458

[3] (fa671e4f1556e2c18e5443f777a75ae041290068 upstream) includes
definitions for these variables, but they are guarded by CONFIG_LOGO.
But in `drivers/video/fbdev/core/fbcon.c` those variables are used
unguarded with 6.6.84-rc1. The above upstream commit (8887086) fixes
that IIUC. Not build-tested yet, though.

[3]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.6.y&id=6562a182d204492b7c1ccdf857b05b46a9d917a0

Cheers,
Frank

