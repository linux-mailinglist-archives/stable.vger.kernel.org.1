Return-Path: <stable+bounces-243857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIG1N027+Gnh0AIAu9opvQ
	(envelope-from <stable+bounces-243857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:29:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800A34C0AED
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E859B3008240
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC83E0251;
	Mon,  4 May 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="BaY0DpzD"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C83DF015;
	Mon,  4 May 2026 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908553; cv=none; b=t4Uin7Ajedsl1bXDShsDtvchH4aaTo+2cHy6okwPn34muY8td+xhicFHDcw9DRZ+N1/V9oiMGoKm67Ly0s0KcaGYz/ExWOQL6c17XC8ik3Z5jBQh+BH2giAWflR4bCiugvbVW77tejo7nTrTV13LNMpKvCY8laVhKrkQXHCjORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908553; c=relaxed/simple;
	bh=1R+q0brxT5FCSRMOO/LqKS2K1GLvRDjYnI692aiflvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/1BKyVBBQAQeKiACJvAJNnLQt5DR3MjlDiBK/mSfBKWP+FITFKdC3AZc1L2hhKiPCsL7mxq/qlw93HDYZ5kY7c77TUmOsq9BCVaCdgwTvyplg5lhnC5Ojiu1TfkiXU1Nk+W1aYH6NolrPO6y6Ih412WID5SmhYRmaX9aosxDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=BaY0DpzD; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777908540; x=1778513340; i=rwarsow@gmx.de;
	bh=1R+q0brxT5FCSRMOO/LqKS2K1GLvRDjYnI692aiflvw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BaY0DpzD7zPtbACvEDEpTyKU03lTIRIJIExTzREftykJnVXjxjqVNYCmTqvheVzJ
	 K0ecFBkNYkpEpRCNSsKD9Gv27A1VrTcP413qO0GlMD3XC10J+mWpQOSLEkEz+1Zr3
	 EPDMOdWv9B6+F299/4CwVrL470D30cZcs0P1DBsr/w7bH6YMCJ87TNcuhucXpoGY7
	 EXVCI2UnzAXJ7uogZ6y2pivab/y0gzy4Do9AVy2FS7o0dTXXgCet2wFU8YrVzhuHi
	 mGHE7r/aVtur0nCQ9DpmI0jk6ExlAuoUtFJ/r9MMontiQJe997p1OO8yN4pBnIESZ
	 i1hT3BP7kYdnVQEyNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79u8-1vEhbU1J76-00v92x; Mon, 04
 May 2026 17:29:00 +0200
Message-ID: <31a8c07c-7d62-4ca1-a757-003d110b6519@gmx.de>
Date: Mon, 4 May 2026 17:28:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260504135142.814938198@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DQPrQ6EGijbRBaVerPuYq8cJP1jDHO1IbZ6+0m8DihAGU3sptYJ
 J3OJr5p7uW5sOOJgveD1pr8eoTsuigqaw69M8VqMRd3UNf1FjNVjOtXer6fnhVwHrAt4u5z
 kyoskK/kqqbkNgNyoe75REQO4G+K7uu/4odbqxr2ZM5XHY1v3jsxYIJ4DqEXUaW0WJpZA7l
 Q9wshLBXCXmjI3YHV+94A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rDPCb8V7XlM=;3GXYB3nvinSJ/diYQTj6Uze8cu2
 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
 gG
X-Rspamd-Queue-Id: 800A34C0AED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243857-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rwarsow@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:dkim,gmx.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi

no regressions here on x86_64 (Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

