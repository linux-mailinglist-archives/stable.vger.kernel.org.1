Return-Path: <stable+bounces-78654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C720298D376
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8F128322B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807661D0411;
	Wed,  2 Oct 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="kYsQiO02"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05D1D0141
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872893; cv=none; b=dfBB8ceGc8h31TwDMVAGiIv5N6MhZZHCt9QoX2sG89BnFgQzUonP5m0wtlhcjjXYuXmcPKezxOB52wpMtHmTpgLY5VVxs9hs9INry6vhVqWO1bHLiBfJTT4dAmdPAFJllBgVjFm5gUvTFC8/g0YNlqLTajjVK57GbxIcrz/UP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872893; c=relaxed/simple;
	bh=C4utB14r9gCxQ+O/HXcvQyObNXDOaCxafEgXaEYT+QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dObXvYch9eP47vdA1yBPvdo3wsisethc+NndrvDJ9IHlifkPOwxIuZ1qSRZYfaub89exfjed0xh4F3Ud6gQmG3V/Z2SpUTE9NKOr2w0KENvClla+1VbktwHRbgzfPnXgWI7F2VVGkXEMHkvF07gMRQpxnO8aWaenD0XufsUDdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=kYsQiO02; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727872882; x=1728477682; i=georgmueller@gmx.net;
	bh=C4utB14r9gCxQ+O/HXcvQyObNXDOaCxafEgXaEYT+QA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kYsQiO02cj8HwuZSvK4cRGx51rawLP6KvaDfiw9bP0VYMu+d5baw5GlrdVj8Iahg
	 tn6tXjvBWRK5lqzKbPdiPeS12e3p0JQzcVHPkqvXuU+L6MTm5/onDoGDuiav08R+W
	 YAe98F8AH96KvuFvbdYl81VeqlC45B3QNAJfnyUwCwmY8P8NRJPkPnveNwWjxhMdk
	 p39cZ+Wr5DU9YyvgohM0EgECJOWIyj6ve56K/ZkZZM2wdtKr7Raya7X+9vmmYq5HW
	 Z0gZ8YmpLoQ+6LnG2kPuPwAbzrCg7EH/5gHUIUZ3y2SlF57mqeGmDb1GSm3X7v+YI
	 7ipE88pd5JruB+ZZpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.41.16.31] ([80.153.205.84]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1skNXo12Xm-00Gurd; Wed, 02
 Oct 2024 14:41:22 +0200
Message-ID: <d039eb47-d41e-48d3-a51f-1a0cb6c0ebb9@gmx.net>
Date: Wed, 2 Oct 2024 14:41:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: do not run mt76_unregister_device() on
 unregistered hw
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
 Helmut Grohne <helmut@freexian.com>, Kalle Valo <kvalo@kernel.org>
References: <2024100221-flight-whenever-eedb@gregkh>
 <20241002120721.1324759-1-georgmueller@gmx.net>
 <2024100217-sighing-rehab-b6fd@gregkh>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <2024100217-sighing-rehab-b6fd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8zfxFTpKPU4nlE1tdBpuVctZC0fWSA5GJ5kaEYVYpNRBmjvqvx4
 IarRDQggF/9a22XHrJmNWEq5DYqT0TOuDpvksd3UCFQE9GOWbwVWmVraSmXTRCnJ4ON1FyD
 g57XbX1azS6KLxAZtM+uGAoa5gd7XeCVUj6bkgRUopwlQc9Brf6ACi1GXYLZ3iqEZQhvfAf
 dNWLylF1tzXB7XbLiQTEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MGa+idyptW0=;+y2KWGu+wxIISBAthknH1c5ZHAP
 Lf1dIIuK1UOFnGH/+m5dG5DL6l80UWCfIUdYgUutY8LpFHZbktjpk81Kr88O4YVkS51u6BnvQ
 JBrblDXl+CpfoB3QOSty4ZZG9g0LIm0dC+BKBsATl3qsRDDPWbGjvbFGrk8sx7MxhkSH7dwTj
 ub4eqSyphoXdEkAncmQuz0eW5YaHIw+M0474cPfcgeOcRnD5wo5xcYhXP9YJkbWyzuusVFCoT
 pISeLN2axB1FhvJcl2rOE6bx6yb5o6diuiFfZ0bjg4LEDRW5cfOsq6REYlfugy5NXXx8zqkIF
 js6qOffpxQfmM4ciensPYwxryg6ZxN4V/g6hN7lFgxFQVS7OHJx16LCVG1/QNLJqA2fHypmLJ
 okImdV0w90AprlROP+0IoyjiycRoY9hZnNykBCJKspdk0SO43q1ZR4zs/mn/xQpNrtpfxc8v5
 GQlziaXL2jHOaU9/y3mcckQRuS/VMPanEXWaxfYfKEn2nWrj+6f2m4FV3mWGPX3q2ioHT0cxL
 DxSbLKjP44EQquwIfV9Y31GO7Xl0y5trntbi9u+RyxGpn0pBuBkyENuhdrwla9OnvA7b5KFTq
 rH1RAodjm4KuXfeTqsLdBfSbTfkO+MReV6SLF3x8cRszLQhH61B+HAIr6GY+JGektPsIieppL
 FXH9THTjFEngxm3+kklYPsTSwEyGb3cCPdIHcnmT4ZuaLY2lNI/xgprLtZhUPVVhCcCO0g0GJ
 H2NTN9kHV1ps1hsV6XEA/xy98roq+leDPeWCjcJEO5sin4IQ1XPFnaKEXP/4nwh5/47kNld3A
 8Shd7dxZVmGH6c/2VozuEPsg==

> What kernel tree(s) do you want this applied to?

linux-6.1.y, please.

Thank you,
Best regards,
Georg


