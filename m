Return-Path: <stable+bounces-106228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3019FD98F
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B3B188378A
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0A78F5F;
	Sat, 28 Dec 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="obKx9kho"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2278F32;
	Sat, 28 Dec 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735375477; cv=none; b=iL0pViIIxtqIb0AOTUYfuMi007qPtQU1yjqXywxuIC93lQNESHVU50QlZibeCXJ6P6+J8X+30+6QX3nmBHXLxctWqEAtbeEGFoJQIRcUor/7XxRoOV3TrAz+EraQKTBh8X2moAVpbOFDYdOAWGyClI0SshsGo4Y29wtjWE75zSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735375477; c=relaxed/simple;
	bh=glbmLKBY3lJbM52rKDC7xHyJWnNPoMEgG68wQDlKM9g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k6YzAuwxZ+V9jish6/ne0tK3Crsb5tiR6uJEE5cffJGpMo+FVb57u0nHfvEI+9Rjb7mgmYAltdNV2qz5BMUl9n5+LgPAx37ejPYgX0AGmlQvOefdExqEW7NsudWn3WJ1zdVMiG9VO/g4H5n+jwSWp1M744O/2q+cpp4cmwc1rw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=obKx9kho; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1735375464;
	bh=rbXjhb3ElquvVzxrnrGVl/HiyjIXZ9o8rUk84Yp8eM4=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=obKx9kho/996whfx109RHJUev7o56pPlLUGJX7lo3ReniaJnAJPAQulYzanbP9B1C
	 lyg6gn9AJfn5hNc5WSb+K5K+kvPHs4p3GcftDw1xWpQK2qWyST+D93MKFbGt8KIz7k
	 RdkejZgcxli1uBTY1Hino6J/gCOzmVM0P9oxHpNk=
X-QQ-mid: bizesmtpsz6t1735375458tmnm7bj
X-QQ-Originating-IP: bgy0wEaggHv5brjaUcRjn0q6btV35QwEPuujt0TQzhE=
Received: from smtpclient.apple ( [223.160.206.216])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Dec 2024 16:44:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2162146024762976083
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds in snd_seq_oss_synth_sysex
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <87frm8nr20.wl-tiwai@suse.de>
Date: Sat, 28 Dec 2024 16:44:04 +0800
Cc: perex@perex.cz,
 tiwai@suse.com,
 vkoul@kernel.org,
 lars@metafoo.de,
 broonie@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 masahiroy@kernel.org,
 andriy.shevchenko@linux.intel.com,
 arnd@arndb.de,
 yuehaibing@huawei.com,
 viro@zeniv.linux.org.uk,
 dmantipov@yandex.ru,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C3453F66-8E22-4AFD-922A-ECF9639C4097@m.fudan.edu.cn>
References: <2B7E93E4-B13A-4AE4-8E87-306A8EE9BBB7@m.fudan.edu.cn>
 <B1CA9370-9EFE-4854-B8F7-435E0B9276C6@m.fudan.edu.cn>
 <A2D50A73-EF90-486F-9F5C-FFC4F0906A01@m.fudan.edu.cn>
 <13599E88-AAF1-4621-94BE-C621677D9298@m.fudan.edu.cn>
 <87frm8nr20.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OK89Mwdk7SD5cyzJNEsR2lBYdgiJ/blWzno/a1bbHHy7h33YeYQCaUfl
	YPZoZsR1ppvLBDGm2oPS6FElebeJh1m+K+pBERCvZaZjvwiBPv0ij9NUvsVXdRwbKAZdJZh
	HaFl7Ny7oNeXgPXTXk+hnfInyb40KdcJeboUhUmP4xLrA61VyHFXLsXr07F/qf5NPlFZ+Wy
	sfn9BhBnOi+11hpj3xpNCO86D9v6/Sr64cSiHoRVGSDx7M1jZPX3bSd5QfOtDgrf9v2ADPM
	4NViKmxXW64HepaGWWi6fOF2s9SwraXqXlBV8WrsaKFUTRt1oXKFAjUYa4NmTJefjJDy4mr
	l2vXuv1Kd0qIUM/PR0IQzY04cAD/vlxdlhJ+dzXiARdb6G0VMswi1oKIEi/hZ9moxcswmoC
	/QYZRNY1jO1KL+WrnQQd+yGTlz+N8eq/wd/Foi91Y85ViOrqMA3lw61zdyz88xYeNRVdpRm
	OckX/uubNq0ljPAIMEEBUMSQgNxdfzoYuJlqr437/hDbub4JEaIht+JcAC+igqq0Sae5A+I
	Zs+JVGVmvWz91cSN8EjGOTcSQd0cdfwwCTYf487woN+I1xViZ53hUPQyU3EQZHLuIlcc7pc
	KXTOEsk/mmpOs4t5v8lO09Hxv8doRKgUTXPKUXWiiMtMKPEJwaWCX3bsc+uJD8h23V4jmL2
	0nxoK232oEt4iE8aJEbomY/7vZOpc41IoHMPAozKH3QfJ5M9GHg3FEb4SDMua58Pxv0ZnrS
	ydDy8NsXoj/bWGkUwcTm38h8m6hf2QHq91RnUlsB7kuPV63rqUBufZgEPz8SdE1HAOhh9pr
	j/Y37oXClo0uXc1Ktr35HNeT2w5F1+5JvKZmgBrC94nssLwmMVx31i36hCXJ4/OafVRqFf2
	WOxhHLIQSLpieVfi2wCnP0aRzVaWQxdMvCW2gPAzXmJNOKFbMFShGx1Lj0ik6pFJsX3R5RR
	0Dyzvc/93MxCL8q2oUOSldc4uvN8Mo8hP22KkHKf33PLZEyWQ2k8lGuigu1eOHh4x0bAWfp
	u9Vuk5WQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

> Sorry for the late reaction, as I've been (still) off since the last
> week.  Will check in details later.
> 
> But, through a quick glance, it's likely the racy access, and your
> suggested fix won't suffice, I'm afraid.


So sorry to have disturbed your rest. Let me know if you need any more info.

Best Regards,

Kun Hu


