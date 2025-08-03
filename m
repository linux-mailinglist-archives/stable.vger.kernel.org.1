Return-Path: <stable+bounces-165818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2CB1937C
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4D93B6C70
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C31FDE39;
	Sun,  3 Aug 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Dq9+9t4I"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC754774;
	Sun,  3 Aug 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754217766; cv=none; b=seI56zzW0AADKt/eL037uVbVQ8ldxngeGk/6OltO5DXgWtp7SVVQecApbpIB/xEpAUnTBrob2C4myp+mPBACaQkhpkQESJ9DJOyqx9JdY70RNPT6mCjYPMOcH5QSs9XBAwMvKkLIsRqqfC65XTZsAYpHRZKhvx6IL1YixuxWGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754217766; c=relaxed/simple;
	bh=3FRRPkFlnB1kL69t3mAMsVsert5m14RQCUkcsgC+nPU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=b4cjX9J3IkeyQ22lfLyHBqqCXHZJ+Djdt15DL3T5FahqZZ0Fl6fmP/2nekEYqtUSVnYhPGvbr2irROmW3w41Gt1qucsyiI/QKj30CL9WuqFRsu6WTJHc8OjhUIRFqnkFaQlYtT/1hIiSAMwx61eCHSa3XxKgJ6UheyTgtyRKGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Dq9+9t4I; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754217756; x=1754822556; i=markus.elfring@web.de;
	bh=3FRRPkFlnB1kL69t3mAMsVsert5m14RQCUkcsgC+nPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dq9+9t4IAWH8NwqCurmWLXLhDrf96/0dHCAMobWjZuNfjYbRiubf0pD2TCveQbtt
	 i9m8RAUsjNfLWFdsB+5wilc+JTSVunOnm2ssGik9ihRDECIat4BzhtWx3Co2m6uNa
	 A8N/yLLEsGZrqixu90mTvIN5CURegiX3avWnwIdxcWmAiOHhJWMve8xSQXRK9RYHZ
	 Y2jn3++BH6/b8rSEs5iZgr3juEMe8HElAoCBy7gON2EF8w5ztyxbE3ApUzOG3k+ld
	 LcRFvn0/Aalz9UkcXY4VkKaxFabqg+mVk5UmPx29zvrJt9ww6EjKySJ9IQ2KJUZCx
	 NyLNsmSqHCa1mhkc/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1uUP8B3ANo-011kyh; Sun, 03
 Aug 2025 12:42:35 +0200
Message-ID: <8b23c9f1-900c-476c-81eb-80aeb2a691dd@web.de>
Date: Sun, 3 Aug 2025 12:42:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, linux-amlogic@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20250725074019.8765-1-johan@kernel.org>
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250725074019.8765-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aNb4W/nWdenW+ZKO5jo4FMRXp6+U/eLczt5bDV6V7x1u5EN2Mkp
 HHn5L86hY7tdEc8JhERG4Vxg7lqK/mTf78C1E/S7cnUs2Ped+kKFmQwJOFzKbbyOD8JM0xt
 bnA8fUxDfMcuLh57LOXJd94lxhe36a+L/I/LSmxqQMwi3xkhxak+EMJiB9ksEn1Xd0gKQmA
 kMwdXJ8P5SuzWYsM4A9QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mUn3ZxUDFJc=;FquyFyVDmHvO6r7qoYmiVJfMr07
 o61rMoJybApU/e7VADry3lhqpnHlg9ybJWDcV8F5aWNDXEVodXpCiSy9x6JBmbWiPh637lBKI
 qm5k76yxAYqmYBeMlc37YEawX7xqhhxJAa+s40PWR64RqzBYexHkiPX5q5IefcoAE73fXKO7q
 78QqM/HsQNnK8Nq1VKxfIRPa1w6ySzbyF0kzw1k3WfYvRwnDcMVRibbL4sDRMRf3KJ1ourb4s
 RMhreW4Bi+BHRU1rwE5rPGec84coIc/1l57hcSw7t1ZW/LADSDDAcer6+8YdYsyrTeDmGEjiT
 8EIdFWY27eBxA2Dx/zS0K69u88f1JIADh0/WYDPw2PZMitrf6ZIQwmw2+RF9HHNdmIZfauLck
 QWxP2avzgqJi4m4/RHPUgxaNY8Sb2n0ddq4zt2pbr8FT4D5C7KF3BgImcjSYGo95g7yQL2VHn
 GEZMKwZRGCUu5TWJFXL1UHYe/dtSRAHRAkP4Baj1/FTqA1rZZsYVCPn0NVnx/Z9Mc8ePWBfDO
 zvCSaeFZgARwV5Fq/idA+apjNn/KF55iFgCYHkXbo3WvqK9IOM4N9XbaZbd1JFKN/OENE8uKi
 grdkH1W28EfoCMMeeUOQTPtEybamCpE2xWowQOpGVQF4QZ2jTLMQC5aEYPaY56rwHil1AsBs6
 sphUwLI3e3CogGgRJyu437mK4M+nLqR+ply8iKkENGSYgCwPnTvm84XwgGmg2nfh4a9dbgV/T
 nfZIUNj3dIyo6AAhUFBC3+CxtOgepmPKrFY9tJp17gpPvGW++7s/CkFICIwAwe1P/VBDVq9hG
 hyjozp37b02EeprmB9hAGnDa2OtDWBnbOIzH07JXjIvZMrS5v0hfcSthVhGx5h0J91D4LWTX8
 usznngdICsdBDmcGsibKPgeSM91izjiYSDufXOH6624HhBlKgzNr8Xv/h42FR/143UKt0la6u
 UaLoQjLtG582h22yJodUlc0hxWUEC+W4G+vW9qgYV0/6OqKIQyIENT+7KFW4To4N/yr8t14Qi
 JaXilTB3v0qGHzxXQEOKywr/4StMCrvDV4yGPJ9mItJwRaP3S5coK+1ETUXNPER3WjYjDKC0u
 ZH5sd4rThqMV+bZd/40J2nD9rU0HugvstUiwhEE6lH8yY+HQY42mJy1ciAJcC3U2j+L1neHKX
 QtsF8F2CcBbDejdIlv7pFyZ6IBzkM8a+loPxJGHuWT5zjtFkZybQT7gFDPvwb5lj7nn028l+2
 PrTCD8aN7JGFgBVEW/3PgXtwn6TsAZgIPcpVx88ZkackF0yI5efNimuzjFTVhukvov8rSJ4rd
 otrtEr60XMkKAVEFsYqcCDPfCRXXQBpMurjZchxpip5maBIIq2guIH0HkPcYN42Xqi/9pFKdo
 TPGnGpOBU2saNXGhEHgG/lEb7/P5N9HFnq0KokU9Is9v0rkPBKNlgQJVUt7ZGJTXjcEtafZIB
 57AnmaNu0r3qOEOzaZXnq5W112GPsnA83ZpYiBwZcvRwgn7/jHFGlgyRSURAqFKYpEdr3k6oc
 uN5M1JLkSBf3T5ISTcAax8K42tWyFXHz/qgk1iE0czcegIvQEDbcyojXh30HeFHqMfMre+8qe
 Pff69li95igjAYdo+/ucashRfDoNy9BVRw7sCwlJ/JDFkKPxSVbt3f2xl12YDLqvn1DJnSUF3
 0pWS82nskBRs61/HAdsf1M4XC62tjn0NnUSJhuKThj8xsyKn3Bi5YWB724mXkEZW9TtSmjw0a
 wWqvaovycucCL8832D2V3m6DZd/8Hi1Ecnzu5QqT8s3TNtp2Sm2pPJ9ttUPRFDo7S/a9XBTbM
 zw2GtybRuNBdXtk6H2uwvRJslvKoL7cA0hgijd+mCvGxWeVAXkelxr3bvD+tYqlBzt2lcieFP
 t7ygYaug9Y7KLTk8GRfowRjye/Zu6e+CBZQQpBSVaYPR0lQ/WRi0xSTqXKb4Q5JyDJY0ub7jP
 zYHGm54/4KcdN/9y1CTsVUQz7aPqVBFYn/oi1TcqLxRNCR33PY4wO2OZU24MOe/G910n70pJA
 wz5cJjXLgA0uro6IYF19afghWb4jkN30Xqn2WWvRXqejXEiyC7sSUmT7mObPqUld2AWRDNns+
 n+DHxGQNADhzVFQCv25RWWRdI3E1tDj8/3v28lNc/Giz7idir8gbas6Anq6moXRxQeHT2ZGlT
 yffku1yhGULpb1sgZluO5mjUV7ITAsMfBEfFhdrloqtfBA6EP8U6/IrWjNy5hxyV7VUfL5fv0
 Ol1+9M1kXELx8pdv1uj2ouYZcezolauJvsNBr34ySOZ9PoGGtHszYd4HsDhcxyNfqG8NIXfK7
 oEVHVkml3ZNEthK7spTPADvg0ca6vnCLXnMqdzRXDt+HjiZwzFbBFdU5nYaIaQubl7OQDfAH5
 5VC5K2DP926OmPxEczvj7o4yjI00AugRyjVM+tchFhztByyUfRzvNp0J1rCQ74yQUn77yt3UO
 aSH2KTRhGKjaBjcEoJpCeUZkIKGSoBuNmK5NUSS/jf+vwY0uWyHNoH9x6ogVNV0T9LeGGCxq4
 ngGyj4YONYjm+APn7XOOJwzq2BRx1uj60ufHfmACeKttYIaeFo5OGtdHcjTmxS9RhgA3kJjV/
 tRRa7BE23EW5W1st42MB984V3KUfuvP1Q+Eu7ZsSZselCVeRqoZe7zSNSxVju7OxlAhRjRzFj
 4Tit1uwZMo/G/Vsa2BYP21Xec2bFOsZd4rVB5BOEE8X7wClWsW0cgs/hc0cFPuG2yzfSm7DaE
 eDcqRpS3OygyKUXMCsvFyu69XWJ85XAnSjTgXSmJ5i/XSLi8LgHNhgYXB0K/OoR33j5ODAAaV
 J/lC8AFWmSEPi16gCxCW7nEysztuWGHZ6dPEz5TvpBqYxmHNW9+VkUMTw95JtuWqGD6QFBIiK
 G8bXjZDjEaaB54RnirlRmXzz2XBh1uEQ818OaYEdt7AJzmiVNzH7x2ZWFiEDJIeEpO+iuZvS7
 EUb4vFCAsEK0DB8jgUCaYQWKm4sKWcmcaDOsEKeS877k46UmSP7p8wymsLMkEXZyCeJESDSKY
 2y/mMnnlzQCK/M+LqgC4iNXqwFd5I4niSA4cetYgHqROfYjyW9x/tYP6HGO5d1iwmn3baj8FU
 GjlGdnWjo7ikZi7yr4X+ear7gmlaDpKcNCJoIr+Ix8V895YEVwTAN/ZgDpSmp6nILk1XpRwQX
 dIu9IinneHNKseLLs3oUfIaDqOvS4NG/Rwdw5ND6sfKDQMYYk/yrJeEQzC3uabelONXQz8WgA
 cSM1eTLZPThRm3Bc3ZLOTHlVvLwFW8hLvoJG9Q/fQOlhLTMZu+BQXB3YYgDPNsLyNp10cpkAj
 UI+pk0TnXdMvDn88sGpg6rp7nJz+B1R9dqXR8WEwUR1QVtxaQn6IKD3gHb2L9ZOEgw0DNgyMA
 iQIwy7uMKN4KQz8voYSw+dzSS2zTX1QEJGobJISQibqWQUu5FdNz906qUDsO5UBUWIoDIhlNQ
 6/QUl+dVefGjxxFJ5hMqnwisaU4r0lVlHt7KwyLxVKd60bMX8ovP7/tjV/iYjBk1XPuz+tvi1
 1g==

> Make sure to drop the reference to the secure monitor device taken by
> of_find_device_by_node() when looking up its driver data on behalf of
> other drivers (e.g. during probe).
=E2=80=A6

How do you think about to use the attribute =E2=80=9Cput_device=E2=80=9D f=
or this purpose?
https://elixir.bootlin.com/linux/v6.16/source/include/linux/device.h#L1140

Regards,
Markus

