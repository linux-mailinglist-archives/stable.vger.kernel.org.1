Return-Path: <stable+bounces-32201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4384388AA51
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 17:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7468D299DB6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDD137C2A;
	Mon, 25 Mar 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWvm9OrQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B1136E3A
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379897; cv=none; b=SOVriBYzk1GLdlJ5KvI4viD8zVbtQG1qhz6YAWyda59hmGPMcoFzEFOGmB+4ZC9z6RC4Aeq4LKJfquSlo1+poxxs9EuNGkPfgMYArhUafKoZ+s38fYbdA2h/NMvCkausVlwyrG7lEVy++EYFYkgcP8kdmoeQitZWf0UbBnXU+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379897; c=relaxed/simple;
	bh=TkIg/lvjEPz5lcPcLRg/J/Sr6mWV/AKKVZgeMpHf6WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZjtoXSqf/yiJ/9YAqSKoUabOG/3Wwq0CQSxytJeDU49v+CtnXJ+4j9bdB4EWMsPIjcpm4c08a+gdSIN+Eu7GSfT75VRlBtS5N6RmfeD59AweljbrLLBOIn2nyp2jhh/4Dk5u/6lXujthPGVMl+7K6Zjo0hplpGmdezhwiWEdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWvm9OrQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2450866a12.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711379895; x=1711984695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpBAbzji3EZqSEp3CbHVVIz9w0o8Ay39z1NWcQVt35M=;
        b=pWvm9OrQCBv3sBn4xWH0vIGXjZLUhBk98tx9Pd+od+zIxS8lYSSdnGGQkQtsdYceNV
         w+hPXK2iUh77vgVaeYJWDYS/rswnwixjlh7eecQd+bSYwKOBlj6B1449P+Wrztz0/rSC
         0f7pFeaPZ8SmrS84VB3Ui+lF5icqeFSK79wILWTQCD2+hthUWRSUGotq6+rgYi9YYz/v
         uskov0NBgb0UgZ+4rMFndM+lDJKKCKRsMeo3zBCHyswOXUPzmkn7H1b9LC4ynjsWo09S
         hgIsrzeAQN5Nrigoz4ppMf+xCul0CkCRq3QwlSoI/ysqPT2FaRhmeyLdaMrU7e3t+ymd
         m6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379895; x=1711984695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpBAbzji3EZqSEp3CbHVVIz9w0o8Ay39z1NWcQVt35M=;
        b=NWQ03/l5Hzucg3XmkoMKunLYdlu4birrdvXW6qEGiw5yJ8/QcqHviLxZ3vqLz96UTb
         Jj+1loCocCVX/55YOmplDdiCfs1nS+Dcxph8PLLkwpkY/0KjGAM+5b4PQmBEBeaXS0QR
         tLTQxbt0/CE+kslNzufz/AeePOYtpdSTAejqLl/aIoMyFIxWcwxBQpeUdKR4BMqDXlSr
         i5jTkq3F7Mh7F7coo/aKFK6PfxD2HOnNgBmiHs0AMUhrX8YZ1E33IdtYgMfVH9etZ1S0
         9VEXGL9VOopeSDfLk7xvvW8ieF3T47MeqQQ6BMmhjkhSn1KZR0FJUJicDuo5fv2zYKER
         MXmw==
X-Forwarded-Encrypted: i=1; AJvYcCW6JIgRtdPrsWEbxhupeMQhox1PqsMBZP0/Iyi7emMHDL/327pkCpaIQfVG09CNPyRBab4Ca0Si3Bep54a2n41XZv78bdBX
X-Gm-Message-State: AOJu0Yyg8hiseixW0wxfatjT3IbNQGYlwZqaPPgSY/SyFcOpjf1shzyB
	44roszcGRpdnq0MAmMT6wFWWkLRzBgWQhj4iFzVUuK8SXxX8qqwG4oq8N+iOfKI+5wTHh73GYk8
	kM9+yPpuerm5S/m8vxDVMwjeZi2pmmw3TaZbPFg==
X-Google-Smtp-Source: AGHT+IGWAxEkzcutnF2I8XHXBCPmjLrlOrn1iC4dX+mBPPeimz4g2ntb2COkxyTtkZYbEYLiFCeB/h6rAYC15aBHuOc=
X-Received: by 2002:a17:90a:f3cb:b0:29a:8c78:9a7 with SMTP id
 ha11-20020a17090af3cb00b0029a8c7809a7mr23661pjb.40.1711379894874; Mon, 25 Mar
 2024 08:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120018.1768449-1-sashal@kernel.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 25 Mar 2024 09:18:03 -0600
Message-ID: <CAEUSe79J7w3=oRAkTks80HLR9CbbkzGXTnubOuzmBYpZBnnttQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, 25 Mar 2024 at 06:00, Sasha Levin <sashal@kernel.org> wrote:
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

A newer revision was pushed on to the linux-6.8.y branch a couple of
hours later (f44e3394ca9c) with 707 patches. Is that on its way to
become RC3 or is that Git SHA superseding the previous revision
(eed20d88c6a6)?

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

