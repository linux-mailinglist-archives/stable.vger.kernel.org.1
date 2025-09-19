Return-Path: <stable+bounces-180610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F1B885AB
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C71BC59EC
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3D3054F6;
	Fri, 19 Sep 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="YJBB1iDZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8C2FDC50
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269544; cv=none; b=Du8k8BxC1WjUFlbzd37w9RbRn6PI+kuLP20c+HE7ZYx0pGVehjB3qSbj/bNw3Fra5TyyrNPFQtAoKIfVBJG4f7jP6gEeKaqc1AUwA9ynaBnXgrTw6qc+sHuNpZeobxW0O1vlH0cdU+l6HVnUt2shq0FcY/eH+8mqXEOS/EClrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269544; c=relaxed/simple;
	bh=NpaY/s4HIMDt0+2Bxnt8uJctQlICgEp1j3rKlIvDyLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sYMuMcFJsphaUnHsXCfnNaB7QZgTIDR/65d5SGzINW7BfzlR0/TncYAGV6pBDOMnbMQSCsgxx7h5wMEJT6OmMz9PflkfExVrJmaEI+bRZNHagnMHdBShlyn5vj5S+8n+qGTNuAH3tgAUrOUAXYAP60t+ttcJLbYa7lJr7Tu+Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=YJBB1iDZ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso334093866b.1
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758269539; x=1758874339; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpaY/s4HIMDt0+2Bxnt8uJctQlICgEp1j3rKlIvDyLQ=;
        b=YJBB1iDZ2SM/3fNTx+cKBUR2i3rVdSHcZQhcVOc1zml7yyFnwsG0wVbwtYUdJwiyR8
         meRFgoRJiFhqJn5lbG1V8ayujsMpvqErsq29EiWUXCFSqAJ9TRqEZ/cHTtL/Uq1IsET9
         pFB89G2kRXutIzdLi35DWtXcnZGuBSO4P4fC3sHteLK7ubTeFS339Yu40ZY89Nckj7KG
         lrkqBiSxw6EyFPcU9IrRPyaClQLfPTi710tAxkBySmh2HWH7C14f/YREbthmwZZVUJT5
         3jSBcypiUAXvqeXaISKYpAjFrTUFLXauCYnCp4IQ2oZn6RAT1ctCuJ2cPXoC9IuJKBJk
         MucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269539; x=1758874339;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NpaY/s4HIMDt0+2Bxnt8uJctQlICgEp1j3rKlIvDyLQ=;
        b=Eo1LrUeabaiW4tKpgFe7eHo6MLaoZD83aBckgXqvQupTx9B4kj4iBvwTsH3NJ+9v+u
         ciT3FpzaEjBJEQUt8eVV+zVBtHFb2+yIrObhc9blUK6UhR1n+npE3NYp5zW/YdODFNJZ
         AEsKlPgASeV3Io0FaUtK4hxC7rBqWPRetp/7O8fI8YxHp3XUlqxtY6Wskfs4kzviYb7R
         Km1Cgo72QplCqBbgu3tgmge3at/xV00oyWGDnwVAEbKk1P/wCv8t/BG/clka3ujeQlVO
         Q4bq7BUoBlaLMthnPCFtejzV7AspDE9IlzgJPLeBIjZM45UsvupQNVv/LH0fPwVeY2dL
         F5aw==
X-Forwarded-Encrypted: i=1; AJvYcCXD54erWwto/lV3hg9Jahf13yqgbzykkRz56vOdewLtV/s0VvN0pE1kGWe4VV4f6c44nkbKChg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9Ua058OosXlK6Sk8OMHl6lOrnWi4+X322aJa1LNHA4gAM9Gp
	h+FONLnzJ/X8AUc9yIfjRWgcXJ9hOHey28LyVFe0ALkir9LH407ACcuFsWplZ1dHZy0=
X-Gm-Gg: ASbGnctExF1RWqQ4/ujfQYiCcnV5xYytfOEnKgKdXKh9ToWr4KUcDKRTSaeWxzo8nQy
	8Fgg8xllLDwp30Hd+H+xxpyf4AcYcn8Sup+TqeqXaGKoKJdYPZzD9SXkziSX/IuvZ0o1ni1yBem
	+dI0eidBmkHIXZucQ1q7fx8q0FqFVcL65JVFQWC89d1CbOFo7XdDVUJIugXtLvATtoIuWkFkm0E
	10m0WtLbB62LYp/y9EqqjiJqg+sUkn9+KU5AQ5DhX/xI078rV3eV5FxXHGT78F2Yr5BblgNbS6J
	aXm22gx0Z584Q+Y0nhWxz+oOlFGYE/21v5KUWWn5R3yADscWqSiizJXjYDPG10fr73cU7uDKVos
	avs6C7//oJdRFjrI/GAkcKOg3ymlELCoZRnCPlw7sgdgCttPFtBtKG6jyhPvF+s299blY
X-Google-Smtp-Source: AGHT+IGH2L5Cs1Yr4IicnBQLWLPnN2LIXEqc14EimrkOsvHCK05Z8Mf+Sxf46z58s1gpwiushS71dw==
X-Received: by 2002:a17:907:849:b0:b0e:8cd4:e2e8 with SMTP id a640c23a62f3a-b24eedc3122mr252009466b.17.1758269539368;
        Fri, 19 Sep 2025 01:12:19 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88d79sm378700866b.65.2025.09.19.01.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 01:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Sep 2025 10:12:18 +0200
Message-Id: <DCWMJ6YDI2GA.EKTOE6UN9HNQ@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of
 compatible
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Joel Selvaraj" <foss@joelselvaraj.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Tamura Dai" <kirinode0@gmail.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Joel Selvaraj" <joelselvaraj.oss@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <4ae418ec-5b84-40b5-b47f-ee2e988d7e99@joelselvaraj.com>
In-Reply-To: <4ae418ec-5b84-40b5-b47f-ee2e988d7e99@joelselvaraj.com>

On Fri Sep 19, 2025 at 8:23 AM CEST, Joel Selvaraj wrote:
> Hi Luca Weiss and Tamura Dai,
>
> On 9/12/25 02:24, Luca Weiss wrote:
>> Hi Tamura,
>>=20
>> On Fri Sep 12, 2025 at 9:01 AM CEST, Tamura Dai wrote:
>>> The bug is a typo in the compatible string for the touchscreen node.
>>> According to Documentation/devicetree/bindings/input/touchscreen/edt-ft=
5x06.yaml,
>>> the correct compatible is "focaltech,ft8719", but the device tree used
>>> "focaltech,fts8719".
>>=20
>> +Joel
>>=20
>> I don't think this patch is really correct, in the sdm845-mainline fork
>> there's a different commit which has some more changes to make the
>> touchscreen work:
>>=20
>> https://gitlab.com/sdm845-mainline/linux/-/commit/2ca76ac2e046158814b043=
fd4e37949014930d70
>
> Yes, this patch is not correct. My commit from the gitlab repo is the=20
> correct one. But I personally don't have the shiftmq6 device to smoke=20
> test before sending the patch. That's why I was hesitant to send it=20
> upstream. I have now requested someone to confirm if the touchscreen=20
> works with my gitlab commit. If if its all good, I will send the correct=
=20
> patch later.

Hi,

As written on Matrix I've confirmed the patch you linked works on v6.16.

Regards
Luca

>
> Regards,
> Joel


