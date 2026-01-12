Return-Path: <stable+bounces-208204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E58D15C3E
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 00:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF55F303807D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF4274B23;
	Mon, 12 Jan 2026 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abyI8AKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E414A60F
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259864; cv=none; b=rdRCi8x2lARHYS/nqy/bBuW/I5drbaxUKS1y5Z7DlcvJNuRe+1hlnFl0HVEBpI0DOJTQmMZG6hfGtWvxHPHkpJ+gpUJasp4vuQ3X3pul0UNlPbvaeVsPvGB3G3hNV1FRISOveT+1jlL0kV4yTe0N6Gv/Wsi5TC6jb2lry4DSRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259864; c=relaxed/simple;
	bh=zV4tWXOHJj/d5B490kgolE4CIyu1A6j0FWHxZFnv8+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhPJZ6+Kau4BKsFtVCHmrCvqSpyhwcnUBJdTRHZCXx42NmrQnpJXbQ04Lqu1CLTSTheZsQ4qyzvcOb/KbXWs+ZnFkA+4AEX5r7gHBmjgVRKHqrowoJdUQjqaNbEB6mXA/AJWIJAd62FG3VGIyQkD5sBnWtoCsCAuw082rdcu084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abyI8AKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A5FC19423
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768259864;
	bh=zV4tWXOHJj/d5B490kgolE4CIyu1A6j0FWHxZFnv8+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=abyI8AKps1YGUzkOlwo9OI0RGZT8AqtdpLpEsE8oCIYomB3NNsIg4BHNnmbWtoCDR
	 IWwirrZZU7EJ+563RAcq6A1VsieGPNY86gBG43tZbzp+q7Phd5tuAr0W8FVWu/17tT
	 vjTmmrPwJEidHaSsCt9Bg+kUC8x9w78jzYAAnzDxOtMYSterhaMa+Sq+BCmeMP+IT4
	 7pQv02Had9qnzRqWZAEZjyHtLME+q2QjrNvY+TwGlfEmpPMBtezPsMvZtb8Sb6YjrY
	 LMXcX202DBSy0VDxxkdcHZsI+FCb+gEH8j6cnBox3X9npwSMZVwu9zoKqZJOHhjPgI
	 kGnm/0T9m2g3A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso14563695a12.1
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 15:17:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPSfiVMUoK+0gOwtcHyUsCe/1DHZKnTPPWWFrJEk1OAgASd9oSmaN50EbNt0u7WpGX29PpsUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOed2sjglHQHYcNMXBH+gJqKMFbzjFAOEVOC4FRhu7KmI6XJJh
	eG9HTBfYmD9I0LEZw49MQyFe26xDPHD87/JyptWLatsy0+lmwhD7cA9tGw/OArW2QsSqu6O/m0O
	186ow2Cly7ZQQQ5BPR6cukP1u3gPgVg==
X-Google-Smtp-Source: AGHT+IEA3jzWHifhDnoilgPbQzGfG1w2b+BI85hIy+58FrBfRouezhzyvtzUBOrOUTG8TMt5dRspD6+1w89DNi0tn6I=
X-Received: by 2002:a17:907:c06:b0:b87:2410:594b with SMTP id
 a640c23a62f3a-b8724105afdmr342416666b.34.1768259862729; Mon, 12 Jan 2026
 15:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112090149.69100-3-krzysztof.kozlowski@oss.qualcomm.com> <20260112202040.GA943734-robh@kernel.org>
In-Reply-To: <20260112202040.GA943734-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Jan 2026 17:17:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ31NN7vNxPxRFm6DfVtE=GvrPwPEOcVY4_TZJRG70R6g@mail.gmail.com>
X-Gm-Features: AZwV_QiC216nPgSHrfhxOc0o_1GO2-8h3UIYG0rNXAU4LNdinaYvd0y4YbGhSb0
Message-ID: <CAL_JsqJ31NN7vNxPxRFm6DfVtE=GvrPwPEOcVY4_TZJRG70R6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: parade,ps5511: Disallow unevaluated properties
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pin-yen Lin <treapking@chromium.org>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 2:20=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jan 12, 2026 at 10:01:50AM +0100, Krzysztof Kozlowski wrote:
> > Review given to v2 [1] of commit fc259b024cb3 ("dt-bindings: usb: Add
> > binding for PS5511 hub controller") asked to use unevaluatedProperties,
> > but this was ignored by the author probably because current dtschema
> > does not allow to use both additionalProperties and
> > unevaluatedProperties.  As an effect, this binding does not end with
> > unevaluatedProperties and allows any properties to be added.
> >
> > Fix this by reverting the approach suggested at v2 review and using
> > simpler definition of "reg" constraints.
> >
> > Link: https://lore.kernel.org/r/20250416180023.GB3327258-robh@kernel.or=
g/ [1]
> > Fixes: fc259b024cb3 ("dt-bindings: usb: Add binding for PS5511 hub cont=
roller")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.co=
m>
> > ---
> >  .../devicetree/bindings/usb/parade,ps5511.yaml       | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml b=
/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
> > index 10d002f09db8..154d779e507a 100644
> > --- a/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
> > +++ b/Documentation/devicetree/bindings/usb/parade,ps5511.yaml
> > @@ -15,6 +15,10 @@ properties:
> >        - usb1da0,5511
> >        - usb1da0,55a1
> >
> > +  reg:
> > +    minimum: 1
> > +    maximum: 5
> > +
>
> This 'reg' would be the upstream USB port. We have no idea what its
> constraints are for the value.
>
> >    reset-gpios:
> >      items:
> >        - description: GPIO specifier for RESETB pin.
> > @@ -41,12 +45,6 @@ properties:
> >              minimum: 1
> >              maximum: 5
> >
> > -additionalProperties:
> > -  properties:
> > -    reg:
> > -      minimum: 1
> > -      maximum: 5
>
> Removing this is wrong. This is defining the number of downstream USB
> ports for this hub.
>
> What's wrong here is 'type: object' is missing, so any property that's
> not a object passes (no, 'properties' doesn't imply it's an object).
>
> We should fix dtschema to allow additionalProperties when not a
> boolean property to coexist with unevaluatedProperties. I'll look into
> it.

Actually, allowing both wouldn't make sense here.

If you rely on usb-hub.yaml (via usb-device.yaml) to define 'reg', the
additionalProperties schema is still going to be applied to 'reg' as
unevaluatedProperties has no impact on it. That would happen to work
since there's no 'type: object'.

I think the additionalProperties should be a patternProperties instead
because we need to define the unit-address format:

patternProperties:
  '@[1-5$':
    type: object
    ...

Rob

