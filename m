Return-Path: <stable+bounces-227037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCktGNyRumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:51:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D52BB1AD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D790300F143
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C03D1CAA;
	Wed, 18 Mar 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ui/d7mXp"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FB3D1CA8;
	Wed, 18 Mar 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834712; cv=none; b=dAqJdTBJStVaUjvnIBPtjKDhuBEtzDEXfaBoSvjvK0HW+QJgZ83D3RdtHfAgEZta2IM8QlpIbm1b3DWHxkXuPC9IOkmTnYy3hIFq3QaF8NhlgzC2U/Uq9riEj38qFAnjvR3P9bg1WDHyrdhFntS34koDp4pZLv+YpJdGwy1/1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834712; c=relaxed/simple;
	bh=VYZPJUCH/zis0PLPrlJxolNvmJLT32eq2uGppj1UhDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOpoQgtgQhCgA5vppOD/3AO/U2G/wll3KF1a0gNE7x/g7tf/qy63DZWEPVoDlr7MA9FmAtpNAShzYBkGnxVlTy/VXxwxXH3VT+3zOBc0lA5iG3uujXE0EevH9ngtEIdTrlKfD7OP0gCx9X+IG/eAYqMp7/0eAcmahY2F/JOJ7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ui/d7mXp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773834708; x=1774439508; i=wahrenst@gmx.net;
	bh=CD2rW0fbR1FZot/wCeeUujf5tCNH1tjPqxsMiig6w6s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ui/d7mXptAVSn3cNjs+Nq1M5rJn3faHw8TwND9e+MHuFFVYe/aDb/1VCulx077Wz
	 N0sbA90jSi2oggaK6ximkvVUE1ryfi1GVwIKjiJHVC0pzukha1nQbtfLW2Cu8EOhb
	 aUbctYDu17eXaUNavdhc55I8jKyxZ5vZOkOs6P4txuh1/ic66/uttTE8u/DUWJ3Of
	 FQjJ7Gz7m7+Ab7S8JArldU3zyk640LSMYKUPwHr4w2fcdnkaREkU9ocqtuvoVX3vh
	 Ho63FNlTjhaDA/axfN51smufyD8GqgSydZl3d1l6/nLJhP1MiKfMBwdKrQt9pXgCh
	 IubWt4XxsaplL7SkWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1vEOT447BJ-00blLm; Wed, 18
 Mar 2026 12:51:48 +0100
Message-ID: <c803299f-709b-4b57-b7fc-46ef3bb4c9ee@gmx.net>
Date: Wed, 18 Mar 2026 12:51:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>
Cc: kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
 <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bdg9yIGrgv6ApXCjjiX7YBhI31U5NLG0/2e/YfEx2TAnqhq9UcY
 ALKLdrKqI1a5FmKrPCzYIJc/u1DDgWR7HlWAlyZoaKVoYM9uFAUHEhSlIbnbQL2SgSdHsrZ
 KZCHvhBVhD+iABtBJgScVr+vcqTxB1v5/A1Rwd1jlx5VswfdvSoDTZmC2rKsKu5/LU25jia
 /ev576ZmQ8xdcC1NCPIEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d8dJF9uEF/Y=;4CA73TtH6tkKe5pWivOSgx6sviq
 ltBpLRJzewWot/5NMBkoUifoJ8tLjy2piEE0e5veIHbkwByI13ESzyRcrx4gHbeBG05NlM0FQ
 KuMTQWcoHELmxm+ToZHgUej+ERgnr0TA6vgb4udvdR5UHyxwKJObqggCaVpfyGYDy1AZClvQS
 hhEbVCAN2Jj6FDYIAcsGiuw0csOlvqPd5Ttf1fzeisrtftV3DSg2XihsUefdlCfkB3VGcvPbJ
 rpZp+ByncYi/pXbE5iaRsoMFxDRPkYBri5jKPa5fg06s/noQqw+bMJZ/zNp+f2Dd52JtD5j/l
 75LB4kOGZRylZTXA1Jk04UlITGSDUK/F56sqcEV1w27J7MTax7u8fN4yPNlClNHD/F2ojlRF7
 L6Ez56FPUbtNCU8nT4ofQPLJfVy3kolA8+/hyvTfjyOb7a3Rodv/PE8Gko0D+8tZJzOPlfBLu
 0UiJtBzu1QMZZZFFt9U/QVZ/0yMTBQMoe2jom/sNw0f4WoIzm8yYPHUJa3zV2UdsI9c7VVsex
 r3/9r9sB5T2VVg/xUyI84vrPLPHG96SXE6HQRp2nZu2MEjHBWzaIkH3uAJK6q9NBjg5tFjJ9E
 0Pv3cV/D2GPFyK879shMiMxejcsZMABz9j3iQLCZdS6CymVo5oFNuP4xj34aqMworFJOHo//q
 hnWdzpfhvWfdTK13C7nbU5v+y9wqhm+IzUCclG2iuroTuWyJx6dQjK/ACnjLAdo/2CyjS27nz
 cZgiMRaVc5RBuPw/k5sreMepxFqK2s34kYYJZDmrXT4ZET1jNsTgpkaoPs4uUV6Tg1irHafQf
 XbJ7bsVfOjHIacyNgAooKz8e82BKsgsgacw8r6MNzHbztlxwz6Rb07A4BJqDJuqdQkFt7eNtJ
 PxE56nZ2q6EPSmyoPF7HA+mxHnbpuPPTN0aglLruinUF4OfOeRjLF6ZazLSDAVYE1/l+xiN53
 cLjRplik7TJhjsZxPKtQ/c3w293yEcYTwqvUsTrmWrEo9MAUMbck+ZNXM3jNY1J5r1+GVUgeM
 B1yeESpeCpX3w43DKlkjx9prZHjAOjTEDzYc/695v8s1nGHMneib37ZCXDx8ZhlFS2fVOn7os
 HJEauxwWqsGX9MvBYLGayXmZPsafN7OjetTgx/Yllfz1D3ZtfbRhbvzK8KR51LW+MVjxNoP2b
 H8kmB4tnCSSav2E13mHlozOTxTJRzZMVn540FoAiH26bLG156gTKVGZv/nSjlbKTiQFYTDZLz
 zNyvhPHHs+kEeEJ9gh9pF4OCvr9brnm07l15g9qRFacz/TZdAH7AeEy1fIXTvgj7l+WkzKYFi
 Yb7DfcVKzvx05ZgLfQlSwG/j4ieZxv3Yu8Jk1cMNhuJ+SakVwfT7hoq/1xDt7SDZNR9qJZFpu
 EmKX0FJV59BKwiSrbcDCYdx3TeOANU6FJxsFnbesGDRo3KH6oX02hoCsY9NbZuMttJlPfO2rI
 VNtwWexwWCF4yUfb/twpUw9aRT4iiLQPuzQiazZQkmuPIMQN7jBfAeTWM1p5FZZbwwnEjUb0u
 C7tdAtcSm8WkBkHoxRXCC9zSMV1yJJGtaoaesrjumJvudDUIyWiHyXtugY6ntupXkfWIlaK3O
 4IKsQp4J6abqMgGhq6oN1KpbjsDQHnJR/l2t0/AVdb32QlgDqGZstizxYa3DEkjTrNbLiBHIP
 9XZ3ew0CzQ2bQab4fwN+6qnVKfPIMhIfoimDBDqBcX9+3LwbVzZTRjEvyHTLE8JbcflH/k8q9
 8foOt6m0S1sQhttBsz9H3crvn4ehKrn9EStudnB/waZBbJD9/N0QaTbKQeSG8Luz4cL8N2Idk
 Zqt87srMF/QrqzXYLQV+yTc5Cp8idjZ9M2cNsNHlLJ8FDzC0r8byMMN7LW+34wb9AFGuoD3Qe
 XOX07lLH1srv+0bS0JTDx78RJ7QM33z0GCcsVQfuFBLP/BsnCrLX4Donfi0HFMmllsrDBIrCb
 PUOUNH1pMMVGats4VUNbr1/F3hUjafTZKe+loCO1RwqfPwZ97ed1DZVvCXIhZm+jzH/8tjVN5
 AMnZbTbUg6OGjgllJV+29CjqxFpAIfttm7LoDq35XJTUUJevreMzT5JOMBKDVp4zsO26Tsekh
 ZJ1cC2rBGE+70WYbQ/y2WtixfxgUIYXNRAKjSGW8TdDDyAPFjRmtcppU4TCRW5AmV+3lTzFsC
 qtRD6bRDMP4HffFxQHHQVGaZHV6MFqlfVAkWjv6qOsU2EPlPzB4pD0qs85nnFUtIWJdAGZi93
 2kJJoBcRV8XMTF+TMxRGz7k9efKoNo/BTFw6QwKnClHlyK0/CIErDLQreQVAJoSVb4ofJROhj
 imrtZPK/IrSWfPu0ZFqugg1hvgPDtKzgrXHCZYg+jQmSChIRWcjei0/4XMsoLEApMbhU0ootq
 YFaQKOqRL2q8i8qT8Q7R6o4BdGUpPH4BP2AY4+q8r/iOzd24y/3C5nlTGcuBSc++2csfj960j
 lsOLp8WRZiFXvWlaA+o2UmNMzoIDhgjfHFyl2kW+w7/meLcCkpjSTF4gkcySfLl/q7d7/JcYg
 KhXN5ZLCb9gwrq9VRBIjg+3i2UdAkZZasiWqLrDpkjNs4M4R+s0VBuelypo0anxh1cpMQ+S8X
 PtHyhv0SNotnrI85Jrb4aLFECYkuiWbADCos47cGdE2ObIRkg33hug2ggBYen4RUzJo+AUw7O
 fyBCK2qVJJnKHG8PdlI9eqWeWN1wfxArDW9GxPPtVGn3h8Lz7TYny0y3Sn9HlLlK2AnNgmoee
 3SXYr9MrxoH7iD0DIR3bJyvstjudJu8KJjA47VhUTVtdJwPE48KJfJ4Jke1tgmXKRma51uUCI
 dHWGpCnYyOsYiTTU85mrnEQaMLmH8wqPsQ0jRQHpn021Kb8pKm9kuh9drQALStOXUyNY/1MpQ
 dKx4lSGEihie+HqnS4Z2nhUqoK8wrAaEzu4/Jq3OOQ4cieRKC+AQUCzvY65WANKRZOi8uPMgR
 q3Q69Da4KHcBw1lzBMK7SJ5k6x9FCVbpQX7Lt2EDDdmehMCM5LxX98gn8obNnLl07n2Kcdo3D
 tv6cxhDMzzpa+V9do2dYy2Tw6yF+raT9YZyPSrn6R31SLXtnOM+Q4A+sqnQjSP7FX2lyaV8ws
 qeAHIap1ips53nGvqzKVtL8f1zA/1QHuDiYaQRA+pjkEizZSTHi/U7cRb9wiIaAgwafIEf50w
 RfypGLE1xPt8jlVg8WR/IJ6pHgM/G581zdh64hf2dHoz2QH4r+8WlEl8ZuK54us2HzdZQDZ5Y
 K9biPFTVKk3qtVuGC68WYVkanNuFv8GZw3WEA7PE/AexuFYTGpj2xVNnyqK9bSCjkcufciqUt
 MISLCc4dqoqv4j7x/7WrXHipchEeC4Pt+iNhaBwZ/St70AY65r+u5P+6feuSPSa8SYBLURbvW
 Q7/YLQrJVaMX6U0gD0JxQBJt8Ap3rB9MtLj7LXYGDZQOVZMjTgk0u7kKaMY4JUqZeY+oX7Oji
 aODzm+loQcvgKFJyo/nzJYJaW1i0/u5KqwY1aCtEtrfUmiOpNBeh/cQXpr+UNuS1nv9o6pwLx
 30A8haIX3Q6/bQ7WICt+GR7XnqzcIu6uLdRJcNifjWwXd7MzncaAOjbRb+3zy88sHUySD+ouY
 D6opjp2Obm3Cic1C+5Wg2qrwIfQ8jwoqICo/zXPrHDwolNgbNfkU9vKQzP9KuRhWNa+YOpCoc
 03JuOwRIdm5MrT2rvOEVMhquQbnIi4h1pk33Fp/C/yb7Jfc4V1Vw7LDqNrcZuqo5kncI2gSgT
 nbAIgR7efSGZhRumvVHSDehQkWBzRG9xmMdhbxgKkcTGyHdrDtlJCQ8jvZ7UkCmcFMdQmxDUz
 CLy1nwtN9TVHSCgXDu+2vC8nVpsIQOFNs9J8+6NHzKc/7dnvxiUcHJKhqInWrnA+hswvWDMzI
 a/z5D1KIgaXf9K8RoI/6e8CNtMQIY9D0eMZ+PTIBY8lJYpsqAiFvJ7Mb6psX1OptlOmUuKOsq
 +fncDK3O8Prz4G6JjMWRt5VpiYRyD633TYDUjneK3o0V5riRnrHY4ahLQsFZQWY73AyXoJO5q
 ubrrFBfWz0YIx7yKvp6VFAT6FeXEmMcju3TSVnzitstu7D6BaNi2d0QAfHxapf//dg3lLCsJE
 MAGlA24/FIw7aJh4weN3/UGPKTEXFujTHRpcX7XDMVtyCBAH68PQ+wKKbpi1UJrMmVeSSij94
 cECu3I/va0dg8a4qunXZJfiHpS7BRjQB7wwfJGr6+cQp5b55QM2bArJ1mJblaylWww9AT4IKB
 N2bBKdLvp6HaHRMq4/Ds2wUqelAN4p5ZOrnNMoutFoxLrc237cB7kVmQtOy6nHm4c7FhYyGIy
 TyqpEsSGrnyFFNQfhR3+t/Kohrk6s7k7tYYRqbbiz5y2gff7EDWfQHNirXfGj80M60jjqrAsO
 bG95mVycJk11M3khWNH7d+GBXa+cMwJy4DkU9oiQTqbE08cxJDMrLsH0wuGKeqJgyhGAs2IHE
 jUZfM8tPzNfC+h2ClhRsdbDjb+XzNBokBBaj4iFnS8nkD8gKWLZw9FBid97857TIspgIVOCaJ
 EBHUccqhM7ah8BJLyL6BLUmXg3UP+NvBYYrTU3YxMa+33bFoZStj4NoXdsN0yjSKkdR6HPPb0
 cBYpJaQeKQHHt6TMWAgMdd9JeYpneZTFZY2fAWX96fo1KRTZCepLP4bNJDI2ChQ1i1TIBwqFm
 gzpDJv+SqFGAi1J9rKmScleojYjQ1pC2WFEqmeKEGCv6LUa0whaIpCEnGIsjoiC1ziX+VHziC
 MHM4HSvxeqp1xMsq5iHKe+mJmZs9myT3diMJPFQHaRtDXhm47zhGFgtLSvkFO4D+8gSaUtcI7
 qiLpp8+W0xbrJn0+zUuTB0GAUYcXy/hNr61RLyUgWZSc57Mg0osYm5nwjLFwEbn5CWndjbTDs
 IjFaANEt64p2muM/Yp4Lp5hsqvGJ5yrtBmvLm6kkQAQ91w2Yo0uCJEBIv0RV8fsmHTMhuYCOM
 owzaL4q/CGsLWN23YYMB2up6Op1tcdMImG6LmU2oDzu+a8b0ylKYHPKChG7ykHQ1zNrfaBdso
 jgnIGV6HfLjnTwJMqTynbUURcJu2B7aG4K+CK0oDiepGhN6LIP2hfcNzy0A5MC4dezcIYm2AS
 zhp6WNCdxHlDL2T/4LjzqoJkd1mow2tfo2SkSYZhqdm4rrPXSZwtBIPglhoZ+UtZoLEFvlH2W
 XnFoYil2rKLysV84SsOQ6ZjpfNHQc26hwKshp/7wBZQ24thM/pmdE3W7OB5KPUYWfGeWpVPCo
 J054RmlZG9ekMMKFZ3Y/5BuDdGf7gc1KkcBO5GmyacFkbkF2DQxz+zxgmt+tLFhNkJXpkcXW5
 WN23IGqAmGVLW4BLxH7VGft998gnkSs3K4AsHv4GS36/+uYmn0siN8=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227037-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: CC8D52BB1AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ma=C3=ADra,

Am 17.03.26 um 23:41 schrieb Ma=C3=ADra Canal:
> The bcm2835_asb_control() function uses a tight polling loop to wait
> for the ASB bridge to acknowledge a request. During intensive workloads,
> this handshake intermittently fails for V3D's master ASB on BCM2711,
> resulting in "Failed to disable ASB master for v3d" errors during
> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
> a broken state, leading to bus faults or system hangs on later accesses.
>
> As the timeout is insufficient in some scenarios, increase the polling
> timeout from 1us to 5us, which is still negligible in the context of a
> power domain transition. Also, replace the open-coded ktime_get_ns()/
> cpu_relax() polling loop with readl_poll_timeout_atomic().
personally I would have moved all readl_poll_timeout_atomic changes in=20
the second patch, to avoid possible conflicts in stable. But no strong=20
opinion about this.

Best regards
>
> Cc: stable@vger.kernel.org
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domain=
s under a new binding.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>   drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm=
/bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5=
fd729b168a641460 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -9,6 +9,7 @@
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/mfd/bcm2835-pm.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> @@ -153,7 +154,6 @@ struct bcm2835_power {
>   static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, b=
ool enable)
>   {
>   	void __iomem *base =3D power->asb;
> -	u64 start;
>   	u32 val;
>  =20
>   	switch (reg) {
> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>   		break;
>   	}
>  =20
> -	start =3D ktime_get_ns();
> -
>   	/* Enable the module's async AXI bridges. */
>   	if (enable) {
>   		val =3D readl(base + reg) & ~ASB_REQ_STOP;
> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct bcm2835_power=
 *power, u32 reg, bool enable
>   	}
>   	writel(PM_PASSWORD | val, base + reg);
>  =20
> -	while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
> -		cpu_relax();
> -		if (ktime_get_ns() - start >=3D 1000)
> -			return -ETIMEDOUT;
> -	}
> +	if (readl_poll_timeout_atomic(base + reg, val,
> +				      !!(val & ASB_ACK) !=3D enable, 0, 5))
> +		return -ETIMEDOUT;
>  =20
>   	return 0;
>   }
>


