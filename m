Return-Path: <stable+bounces-208449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD632D257F4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65867301174C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0943A1D15;
	Thu, 15 Jan 2026 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c03i5Sow"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C83A4AD4;
	Thu, 15 Jan 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492253; cv=none; b=c0iWvhhuhpPb2bRpDGNjLDqzqIWCBz+o8f6nqQAA/VmKOvOItzH39K0YS/oWufm4/YFNWsmxyeL60MBLV7FvSSb+FcS07zj6pbNX1H+9r+qemiu1atVSaNS2X3YE7ayrFo5RCI0t5zT6MWMpsL4AHKWjOpcbFgTZZ/FYCcubzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492253; c=relaxed/simple;
	bh=M1Qd5Bjo3Q12K7w1VxP1UIZaOW+2fCL6lGhXPbvfqjc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=krdofBJAntlpPc4kbSrbnUJ3RoZjvUzdA7a/IZaOoe2nNnHB62FEtI1PWvyX832CCRwbm6yKDMuzIj4jHowZvyi224ZSDu/PtbW+wioNaHSCQAoRqOQDIRwJqzmNvQDup1hNHpJK44AJ7anvgGpx5UEjbMiEDwaI19yxNgIELK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c03i5Sow; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768492228; x=1769097028; i=markus.elfring@web.de;
	bh=4wFQR7YokgW9S7poN7HtD+Dw54Q+qa2eUhWTatUmVqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c03i5SowVXHWtuCB4kTBNmfwFOJyDJDlRZ7Xh1oFPnyEx+UWEnhIF0t1QpeHGSKc
	 aW9JnwWnfPauPqfVrgrMv2qNoK9OjPDKair2cJXau2G1BkNPNqK5qowRN/cVWoWNE
	 Rk8Vl5xl8bO5FifLfHJh3sQPfo+jPqEjr33yZ8kScnx3S2gxHw4Pus6R87mGWtiw+
	 knSKLVmjaJUHDp2X7RXaquHPWhARSjOawBlwNtdofibJyPu0PfWZPK/BWIt6hhBDO
	 EhNuy4RUmHjIyr2h4RPa1pImsqQHzyEhO3MvA+7CuD8/4N9E7fFCvkEbtBwDUMsP9
	 FnknBKZYt4tg5Meahw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.191]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1wIEXv0TTX-00glqy; Thu, 15
 Jan 2026 16:50:28 +0100
Message-ID: <c7f3b0e9-9635-4108-8225-ce1fdb2115d2@web.de>
Date: Thu, 15 Jan 2026 16:50:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-clk@vger.kernel.org,
 linux-tegra@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260115050542.647890-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] clk: tegra: tegra124-emc: Fix potential memory leak in
 tegra124_clk_register_emc()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260115050542.647890-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kH8TD1Lnul2dFF80X63pAjgzDWI1FwRrBfBtveeNEQNu45EVqgq
 U8jx3bPticzYC69fuMJDf30P0jYYnxRKhDPVEyWjEdVvJlljJP3IKpDHWpE3kFQA4dpPhHI
 C5VKs8c6XfZ3Q7NY/Qd291n53cxqIAGLusPnTA4PIGLgS3lLEfwMudUah0s17PB2u0DB0VX
 st3M5ylfxz1kCaq0PyGKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HN1lsR4la5o=;pP05Zv6d9/NVEAVmvaS/YzG4SVp
 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
 T2vDVLLexwUokUKHYnXNL+3OToeWx

> If clk_register() fails, call kfree to release "tegra".
                                     ()?

How do you think about to avoid a bit of duplicate source code here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc5#n526

Regards,
Markus

