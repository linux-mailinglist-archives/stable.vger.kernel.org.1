Return-Path: <stable+bounces-171955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648CFB2F028
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2577AAEEA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832AA283FCB;
	Thu, 21 Aug 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW1yJ47z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474B27CB0A;
	Thu, 21 Aug 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762851; cv=none; b=akfdY2EbnyIVp9X+Sll/5LyEUZYgztOvIvUi5wtZCfQnkKdiS1V+qOvouung8stOEgN/RCmiz5N/Jn5/6twPJEfslT8SRoa8rkHoCMrDSgYN9njyjtJLBWvJVnDarLeVGnwJvywAu85zjgzBB3/lAj8Q4KzS4F0kHJfU60b0Vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762851; c=relaxed/simple;
	bh=IPUilLuvpTBBH6sPGlI6idGeP+t2/3AiJ5bzLQuzi4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pywbDtF1C5nptXj5LoRx7y6bUniGvlHsiIRBOA3R29okwSVmG61/14hR97GCXi6cyFgft/xIJi6dPCpFD9hqeZaUv98bbGQpmHxewEVm4LYjgyMT0o0D85qov/WEu2qXxZjPWNJLZCAWDPKXMFo8zho5qnaJObZX1b+d+eKYnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW1yJ47z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D8C4CEED;
	Thu, 21 Aug 2025 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762850;
	bh=IPUilLuvpTBBH6sPGlI6idGeP+t2/3AiJ5bzLQuzi4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aW1yJ47zmSPUHgdPC4EYbN1/1lCNd7kl9uuDMieVhuOo43n8Y8ivXbxNTbx+f4x8p
	 DXu4NBjGWGCZLDxpjoSBAaQmx5Rkop/kE6zIpIkvhBdKSNloW4mZGc3ISRCBdzUX/U
	 tQJATBa3WsYkw6cpQhAyzByLzczEWiY1VuepkbS/TTL16HsKKEwntMdRpCzAcfolpC
	 TwuXXqqbVKX0Io2Aq7NULsbcJs73hT+s5G/AbRFPS/JvVpEHJrUnH6Rfyz98nCWhi1
	 Y6k0Kf88lVBi249eXJVqcO+1Qr0N/SMZ9pDd2iiEbbqzOeR6hyJK6vuY6P8mefHbSS
	 5yX5bpfUxoekQ==
Date: Thu, 21 Aug 2025 09:54:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: Scope the compatible to VO
 subsystem explicitly
Message-ID: <20250821-bizarre-pigeon-of-unity-5a2d5d@kuoka>
References: <20250820074245.16613-1-ziyao@disroot.org>
 <20250820074245.16613-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820074245.16613-2-ziyao@disroot.org>

On Wed, Aug 20, 2025 at 07:42:43AM +0000, Yao Zi wrote:
> The reset controller driver for the TH1520 was using the generic
> compatible string "thead,th1520-reset". However, the controller
> described by this compatible only manages the resets for the Video
> Output (VO) subsystem.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> 
> Using a generic compatible is confusing as it implies control over all
> reset units on the SoC. This could lead to conflicts if support for

No, it won't lead to conflicts. Stop making up reasons.

> other reset controllers on the TH1520 is added in the future like AP.
> 
> Let's introduce a new compatible string, "thead,th1520-reset-vo", to
> explicitly scope the controller to VO-subsystem. The old one is marked
> as deprecated.
> 
> Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
> Cc: stable@vger.kernel.org

Especially for backporting... Describe the actual bug being fixed here.

> Reported-by: Icenowy Zheng <uwu@icenowy.me>
> Co-developed-by: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml      | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> index f2e91d0add7a..3930475dcc04 100644
> --- a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> @@ -15,8 +15,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - thead,th1520-reset
> +    oneOf:
> +      - enum:
> +          - thead,th1520-reset-vo
> +      - const: thead,th1520-reset
> +        deprecated: true

This you can do, but none of this is getting to backports and your DTS
is a NAK. This basically means that this is kind of pointless.

Compatibles do not have particular meanings, so entire explanation that
it implies something is not true. We have been here, this was discussed
for other SoCs and you were told in v1 - don't do that.

You are stuck with the old compatible. Is here an issue to fix? No.

Best regards,
Krzysztof


