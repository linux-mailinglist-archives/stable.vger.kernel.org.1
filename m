Return-Path: <stable+bounces-206373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 178AFD04258
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2096130286CA
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250526E175;
	Thu,  8 Jan 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4fNL9M1"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349A3033F6
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886573; cv=none; b=oHWJT+KA9YNfUQslBvObcDD5/Is0CT1zkOlVOrMLJWLJ0x57mjiAoN52sPKRPsh2hpVbC7iefgfS52dcI4rhdrBM/A6aUqRs9mii8HfZractW8lRZAwLY9vQVm2dk6yGcooU2RkarOK3CJ2JIF6bzYYSBbtDmx6ILs5UMbPfxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886573; c=relaxed/simple;
	bh=ucRGlmDd3/r8nfrOQe5jirZFyZr6Y1yZ1K5F6n5ysSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1J2zCO3c5jRkAcWMdQXTjz7JETpZi0HrybVcbYf2SiuEBVrx4nbXTDpfE2bwkQ8MwZ+fzQE+LN8YCUAzf/gGNtD3FG7+rGh6GfHLM2KCvfGn7h0SPGwmLH3XJ2PXArQBhRIk3Ee2rOgNJs6Kcw8AWcJOhBkPpttaGNgH5Bo0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4fNL9M1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79028cb7f92so32745407b3.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767886571; x=1768491371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnFJkRhaV66zgMXaJc/JY4M/OQDHlfL0DxhciZSYrK0=;
        b=D4fNL9M1ZvUpk4B/6viWYNf0lLXJYQ+WYrDvruCxddqE0WVLrDmOnDSNenP9dOlGAe
         LvmUxZspuwx//V7Aa1PorMkuW5tYajtwAzxzBCons7VBkz7x4qX6/li1MiTWLW7o7M4q
         7XNaoK75rwXAhJfJb+UwPPpF/E/L15XMPOE5qUmnN6YVzQIhgF3eGiBwsfvRwmE6pU3m
         M/7ytqugYrhAtpNaQk0FFqdxvA/YVvzGqYt0mJgDOI8O3IyIzcVkFJrmAOxeUWMh9Bj6
         zOcbtMcHHxmpnv2lSdpXFBLAUM9UxCr/ArGZeIpDLINbft0Y5HiRGfG/j6j6fCdTghp7
         j+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886571; x=1768491371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gnFJkRhaV66zgMXaJc/JY4M/OQDHlfL0DxhciZSYrK0=;
        b=nLbGBSTCMET/hcovFy+xwz+SGBeki+NxURYLm3IZNtw7UR+tCdWPeWCz3PB2/wcJuk
         2WBuN6fcOmxxZGbyCM0X1zaiGDmXQmAzEJcAi+ki9kzvxeWbe45eJyqJcAukmK4Gvct5
         rN+ZkKcqjXeTNc29Fux5hmcwcxR80khgfPgxRJ3se+8tQl0fo1ByfdGFfwyDHlvo9/h+
         h4Ktup0C5i0EWYtDBpfAyhfu/JCRSxBMh4LL9LLtOmJobGUvalZF77NlZWDvOyl8geAC
         y4wb05Ln7P/tjmnkG60H/WJ5ENio22pMYD+yqe8Nc+g1YeOhNQO1PsYk+YEBLzB8tRde
         WLRw==
X-Forwarded-Encrypted: i=1; AJvYcCVfTMb6rTqk5QpvthRcWL39ayL7sRAJtN4zOIKQoRyRFxjcVEugU2qJmXmLExpgdF/gs4Akpt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dWWlZ1DDaWKDxRkEJSg2xKgpEen6jSQ0uFbtxD3ApU1cZ1hg
	caZN7ODkg+s5sjW+b4yVFz+w0lS8pkM+3IaDjFw6dKL+YdtC/lPCmfQIxBJA7OkJI/W+6Mm6ykv
	Hu3weJzVUnORhuJN6wJxJ+vfqJlwfuVrA1mYTTu5B
X-Gm-Gg: AY/fxX4YH/jNRlr2PFebTYz2lBSnZWm8J2M5XEhiSzaNsBP798F/Pem87QDTzX1ktcM
	3CXQLeXWt+fSJPE6A7kQ9wbVTm1kbeCZxjYBKAYcvcHZFHrtHkvkKgB5VlO46QztP0X4I1F+gOq
	bFpmgIYRTQi4a95z0Oivk/vIJeZCkktR5Vc1ZuAT3798knX4V8Dvn9N8kE8SuGpeeJb3p457Unm
	AdpgL/mgx1Fp1+oQsfWibUqs1Ol0hift+2rZY9MCmoyFwCw3RzBqN+VCfsYWutPnRpBU3Y8l6GE
	zCL1kiNfDLLzE+LW
X-Google-Smtp-Source: AGHT+IEhutCa+d1fecklGrAulTr6368iVhdJVg2l+MKe+nQdWtxJwrbTRLVCZBCBVbsC0Ui7pART8ZAUov35MeYOE/U=
X-Received: by 2002:a05:690e:c49:b0:645:5b1f:4cbf with SMTP id
 956f58d0204a3-64716c97e5dmr5547871d50.82.1767886570937; Thu, 08 Jan 2026
 07:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com> <20260106182244.7188a8f6@kernel.org>
In-Reply-To: <20260106182244.7188a8f6@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Thu, 8 Jan 2026 07:35:59 -0800
X-Gm-Features: AQt7F2qghmcnZCTDqBJHYPPZ0nhfFsgTlE5hVuZJf6OdRubD9agLAdLg-fjfDGs
Message-ID: <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Catherine Sullivan <csully@google.com>, 
	Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, Sagi Shahar <sagis@google.com>, 
	Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> > This series fixes a kernel panic in the GVE driver caused by
> > out-of-bounds array access when the network stack provides an invalid
> > TX queue index.
>
> Do you know how? I seem to recall we had such issues due to bugs
> in the qdisc layer, most of which were fixed.
>
> Fixing this at the source, if possible, would be far preferable
> to sprinkling this condition to all the drivers.
That matches our observation=E2=80=94we have encountered this panic on olde=
r
kernels (specifically Rocky Linux 8) but have not been able to
reproduce it on recent upstream kernels.

Could you point us to the specific qdisc fixes you recall? We'd like
to verify if the issue we are seeing on the older kernel is indeed one
of those known/fixed bugs.

If it turns out this is fully resolved in the core network stack
upstream, we can drop this patch for the mainline driver. However, if
there is ambiguity, do you think there is value in keeping this check
to prevent the driver from crashing on invalid input?

Thanks,
Ankit Garg

