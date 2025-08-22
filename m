Return-Path: <stable+bounces-172329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82CB311CA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D505E218D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A12EBB89;
	Fri, 22 Aug 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JFVxF0Eb"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2ED1E5705;
	Fri, 22 Aug 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851331; cv=none; b=V2UGRG1slCqq0nyjvcgo0nSqE1z5FvjpOIzn+OrW808Oh3nb+dKPsNCFycKhPMZKb+/NYNwKy6AWejLt336PCkBgpRBF3pG3vLZu0xEDjlFvjlJ85JndakIvoY4z4dTnk1qkjMjgWQd426pD3ZKM5xujDvuvGp05+0/APpARyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851331; c=relaxed/simple;
	bh=HtCqrpkvP1bYtOkdVWB6M9lAvEMzJbL55TwSdi6Ww+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg0Q6vTVSgGoU9pnP+pGI/M60h6Mv7ALNv/f/AcBijJ+utBl347v9DgBRJApC4InZ9h1pjzameZVIdYDba1Ss0qISSLBX2r0TrABX2Qf4RT8fiMed6feoHqWeaLXliWmbI7bqQkK5onaetV+9xikp9Pz9W6Saq7k05j98YvIJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JFVxF0Eb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BDEB825D78;
	Fri, 22 Aug 2025 10:28:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id meLimCg_NvAA; Fri, 22 Aug 2025 10:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755851325; bh=HtCqrpkvP1bYtOkdVWB6M9lAvEMzJbL55TwSdi6Ww+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JFVxF0Eb+86f11LQnDaqhXg40EgLPCop+LSrtry4aFC0MscuLU6mpErrPqlssRm+q
	 MiIRoC0R2U5ef2bI7pKDB6jnqPBGdnuO+xwBoLO4DmJS721+FdPlxKq0/AaUJ9spd+
	 bO2s76sWcVz3sf9EhQA+oYfFxM9+4RAlfn7GW5phLvE7+o1SVC1AbXp68wEanJczFa
	 FLvFMrkMZf/FQRREBKNYkTNXevPaZNV/KbbgGBfYC6XbCPcLbX0UOkjGEyQjpvKKhG
	 wWb3Nw7vnLCq6D6b0F3nacsFWLCdJF0jc4CHsTuvLARsU87RVLzbvxZ3JLSB+5n0vV
	 SWhuK0JvjakTQ==
Date: Fri, 22 Aug 2025 08:28:21 +0000
From: Yao Zi <ziyao@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: Scope the compatible to VO
 subsystem explicitly
Message-ID: <aKgqJWKOssEfgNRO@pie>
References: <20250820074245.16613-1-ziyao@disroot.org>
 <20250820074245.16613-2-ziyao@disroot.org>
 <20250821-bizarre-pigeon-of-unity-5a2d5d@kuoka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-bizarre-pigeon-of-unity-5a2d5d@kuoka>

On Thu, Aug 21, 2025 at 09:54:08AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 20, 2025 at 07:42:43AM +0000, Yao Zi wrote:
> > The reset controller driver for the TH1520 was using the generic
> > compatible string "thead,th1520-reset". However, the controller
> > described by this compatible only manages the resets for the Video
> > Output (VO) subsystem.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Thanks for your review, I appreciate it and will stick to
thead,th1520-reset for the VO reset controller.

But I'm not very clear about the subject prefix: I already have a
"dt-bindings: reset: " prefix, should I also make the subject more
precise, including the exact file changed when changing a binding file?

I've seen commits either with or without the precise name of the changed
binding in subjects. For example,

a341bcfbfa7 dt-bindings: reset: add compatible for bcm63xx ephy control

doesn't scope the prefix to brcm,bcm6345-reset.yaml, while

4e55fb7d60e1 dt-bindings: reset: atmel,at91sam9260-reset: add microchip,sama7d65-rstc

does.

Or do I miss other parts in the subject prefix? Thanks for your
explanation.

Best regards,
Yao Zi

> > 
> > Using a generic compatible is confusing as it implies control over all
> > reset units on the SoC. This could lead to conflicts if support for
> 
> No, it won't lead to conflicts. Stop making up reasons.
> 
> > other reset controllers on the TH1520 is added in the future like AP.
> > 
> > Let's introduce a new compatible string, "thead,th1520-reset-vo", to
> > explicitly scope the controller to VO-subsystem. The old one is marked
> > as deprecated.
> > 
> > Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
> > Cc: stable@vger.kernel.org
> 
> Especially for backporting... Describe the actual bug being fixed here.
> 
> > Reported-by: Icenowy Zheng <uwu@icenowy.me>
> > Co-developed-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../bindings/reset/thead,th1520-reset.yaml      | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> > index f2e91d0add7a..3930475dcc04 100644
> > --- a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> > @@ -15,8 +15,11 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - thead,th1520-reset
> > +    oneOf:
> > +      - enum:
> > +          - thead,th1520-reset-vo
> > +      - const: thead,th1520-reset
> > +        deprecated: true
> 
> This you can do, but none of this is getting to backports and your DTS
> is a NAK. This basically means that this is kind of pointless.
> 
> Compatibles do not have particular meanings, so entire explanation that
> it implies something is not true. We have been here, this was discussed
> for other SoCs and you were told in v1 - don't do that.
> 
> You are stuck with the old compatible. Is here an issue to fix? No.
> 
> Best regards,
> Krzysztof
> 

