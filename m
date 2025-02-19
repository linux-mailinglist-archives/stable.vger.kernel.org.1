Return-Path: <stable+bounces-118245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3664AA3BC5B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1459A3B8A85
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46FE1DED66;
	Wed, 19 Feb 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="smUnhMaJ"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519651DED45;
	Wed, 19 Feb 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962985; cv=none; b=CIIw6QN5rbOI7oQjGECHWwmwJKHKFr+EEJVoZ2G7ykvB03v9qh6D7xi37hKOQGMXskW3FoL7VugDUpXG2oddPfIGc7X3d/U0CRdVBJ9v5O4e4YMCKRJYS0y5EqQCvsz3Tzcvyljbegwt9nqY7C4s9vd+FAxB99i6gCh6Gu8oYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962985; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=H0EkPyfhhAU+MzG2WGd/A7ivGqjjleDrMqwsaJyApcGHWUkJaWvRp9iBT8QL+uKe/CzpUi11B8y4zoGwGD65RpDGfJ5oZOvhP4hL+0VfONYWN9LZ38Bseq+lbn9yXfpNM5yqHpW1kTqhDWas046ylEOirlOw5sPBvD5+sYCfXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=smUnhMaJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739962981; x=1740567781; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=smUnhMaJ1acAIIKE/MSsCVzRFnhjdles4wt65GP46MW9wEGo28XCsTd2fB/Rjb3Q
	 ga/s8cFSGMRldCBV0rcD1kQfjKWoGpjlI9sSqFNlzLDYoXTwTQX8tuGk5CyzA1JNL
	 rlg6/5I0/munJjnsm02NRgnsqqo7ZlzbNL3Vgu5+mL+BUcZd/HqwhZSbS9Wvz5uLZ
	 jKMhHG6Q+HjnhoDwMTb+lg5pI/gvyRnn29Kp+V4nmUVmAevSL3jP60j8wC9zZuHv4
	 1lpsc7+MXmHmTSMfkUxxjY9kRkdZ3mnWXelQYlHeHO2cFArtVgdYTG9AiJjF4CySy
	 AzTBbdIAXsutzGjlPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.199]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1sy7YS2XPk-00fQlA; Wed, 19
 Feb 2025 12:03:00 +0100
Message-ID: <0988583c-3bc5-4ec3-b841-088ae3485740@gmx.de>
Date: Wed, 19 Feb 2025 12:03:00 +0100
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
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+lKkkfgD4EIZ31jwTV75L2Y3Ts/mYLXsonnx07++b2CbYhmyL4o
 ixGBY8dEHR4A6Wipc3EV6vIHtPbh0Dvn+LYBKW4REdxEpaps3Idy3TwJUa24DDhXMrilu5M
 sn6+xepkzI3cMe3ZTgdRSmzV2C+ExI4/cvXms682HPAsnsMBhoraErCNohP0e7SRXmW4FY+
 dr1B9Hk4LSWB3HGKCjQrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qo2KksZ7X5A=;53ZLjIJZL8M56cLeJ1pUbFCe/Ei
 4W6/bV/RY63HutiKSKBxjostjt2rREj80XQ0zuSOVDSXyRVuYbtYY9ZTweNZYllDq0GZI90im
 0D8lHV80iKR+L4Py/ygtTXWGIL6OcxwXp6UdWPn92ptSneAFvOXQ/BSrBw419N7GxkolqPJG4
 2EgaSnKOBSfNt/hG0/mF/WV/GfUeefuXrt7Y/VLZwWoCTBTYrXLpSy2dVBfH4+PtwabCk/1XV
 0MZL9sm4pQWkVLRrSIGXO/a+hI3iO47+LTfeuzeuqUV5UXxQR5B5qnmJSJ6qY/Sp7r6ePh9On
 S+nPw2rgICqk+0mjLQcy+2shCzCf7qIDpjVxF/VBxOVKSFlCZGwSD1Uyb9VWhSbVwK74e+slo
 UZ3377fRHUfeCJwgJFVoLihcCRrwx+uAmdd5rPGrqtoTcw5lRgvnXdvNRecVyFLkTMAUdCZSd
 IFx67Dz9oYTTed91BWhg1RgC2hwjE3PuNb1EchaNzonfV4lC+4RP4ZRB8kMSyxuERVu7JpFiT
 ZC2r4BELUTaBbg/uLKHc7udjU/FKqe2Cjrgt/QEoVaC8/jqSurY5bVYvBMsHtfJXVPu5uRIm6
 0kPDEAknpobwcCXjrS2nEKVKtECQ+xa28Vhum5gcoHTadQ16wGZ+G4La8YLqHE2OCKBtY181Y
 NRuenr0fkIbb1gV6QA+MyQiV0/WTtlCo0aLwQX1iUl4hwXR+RiDuuI8EKCuKv9vUXvYPamstd
 CoGGNpYdzfP/ekXGDC4PLqorCC//R4ixhFZ+9vWi4ns2QfNoOHzKKlm7fWJ10qkdlNQX+zL7e
 algxcRQjbgveDQLffLbI35Bq9ONp4Sj87/vaUIQqfkYuTOjlyKRvSkI2oaIqB1hogeOqn9NcQ
 56DhE7BZmTvaBRoCGO2ZO13S8axgVQ1Q4I5Wmq99ZK9M+v05Rdpt1L4zN1y4+xNMwKjt/3C7v
 Bt2nF3yslP8sbb7P/hI+UcwFo4rtNG+T63IdYLZf3GJV4r874puP88ow8EyVuRa4pp7GWjMlL
 sh3scXc6Xlg/3Oz+6XjVu4uzXt6zvY0ynEcRIL2aqO/lRYVaP6bELQ33boVhXKmsZHF/x2Ha8
 6hu4iz0Khc4gzVDG79T4Ik6jqIfz2sHdbXf3yi+fYwn34tPU0ORMU/EaDT8w+qXXAckCIgGkg
 VTXltuCGl9ziRd4GdfOldyTl/nEWH4z9IsHtA2SxPEtjPpeQoBlTdbUxEHRALT5rDpAdBJNCy
 f2w+EsTVqlilG83DYcVhYu+G5NuHeKT9TSlF1kvuo4bLk6fYiJR8qNhMEFeMJW52wo46w0+5y
 Cs2UzBAMYsLdnZuddKs5/sJbUFbyQr2yXSubidbM+MEA3q7E2sW8EtG1oFGgoPKEx8lircCk6
 J85DVAkVu/u2DBweXQvbFoq1bneDExNBC/FH6uoWgF1jOGPggJCt+EPx9C

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

