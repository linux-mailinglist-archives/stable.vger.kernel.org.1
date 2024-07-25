Return-Path: <stable+bounces-61788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56693C892
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D2B222BD
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1D25569;
	Thu, 25 Jul 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ka/P4w4K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7F2E40D
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721934031; cv=none; b=dVXNFcQz+BznuMwrkweIAV/Z67SP4DnYR2Dcd0mPgLN+q01Z5+G4ll8Hhb25qYm39YHfPrYeKsDCvn8G3HNsdexS4OdlEf6i66vQ1uSNs6tlK7BkLYJzRMv39bpynE1EjzKyl5rldFtupY/s44JuZnK8YnwSr942TosdA7Gsux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721934031; c=relaxed/simple;
	bh=AjVlzTF2LGrnSzM8/4XkZMhAnv6fs+uvqifqYuqWfq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yro8dFWd9VVWzA+JYZr1gP/DZZFvCINYkw5KBiahE/jW9da3+1HIwqmiQ5n6QkLeW2AXF7MR7y3rbcUZ/aKrzgNp4KtqR2HjgfiqAqU7gu6l2movP927OQJJe8nNGvCltD0qj8TOegHdEd3d74CqW5xp59dgF+YB2c8mfIj3pSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ka/P4w4K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so110762566b.1
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721934028; x=1722538828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjVlzTF2LGrnSzM8/4XkZMhAnv6fs+uvqifqYuqWfq4=;
        b=Ka/P4w4K/wB4nIi1Nv3SFTKisBqS+Ltg5pHVVx/IvGkX6Y/duVkZzSTC+FJW3ATV+8
         x8HOI0KgbAKKtOTNl7DBs2JPsEfjWPgDpBC3l8tisDffWq5YSf5hVpFiubZMNPQiD/90
         AjwmLFZNcgXHizO4JIOMYYhgMiIKxO5U7DwY4Kbu06Bo2ipVxSPmZxlumGaJLA7k6iP6
         Cs07LBXZLEsWA96dIEYW1gfI5dzUBF7tw8D9szZFbdouZrJ3bTilC+16ojOMFEolsrV2
         i16Ss+KrNanDKUAqBUocivqYw7X0T9tMWvoST9peiKUNpJ5Yn0m72VF5jC93gQqPyTBW
         zcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721934028; x=1722538828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjVlzTF2LGrnSzM8/4XkZMhAnv6fs+uvqifqYuqWfq4=;
        b=MDhGvNkdSxtv1ldiREK7gaLTi2+W1Or9rQ8BX46oslbpDHvdMebAVYQvYv+Dkb17Jx
         +90FHsuIs0qlImckL5x4siX458HHI4Oe6mnFnn7QQfsoi6lmsaq6JyJrxLm5ze1xjTcp
         HCW205RPALfm4YS87ytSa5TexOHbdqS0kz16KqAncwT6NxinJJPlDTz1N+mGPnYFrrm3
         BBMU/Gwro7PbcBWO3ivHgk5TrC3E3oqEE54nvwK+zCkxrBw87oR7tFD28skvF4lrkpVW
         M7CyrnW8/NTCCA4XHZM8OP2JsLvwPu/Zwdpcbl2l6uvN9ZOqCrmJkERtBJo1UlMHH2Ee
         5Kag==
X-Forwarded-Encrypted: i=1; AJvYcCUxF2Mwi3M6FezXI4L7IPpB1rW4PL9otdqCAnAT7T5QT4fokU10Yno7ePUeaOwxe0RIxccUPSmK3CJlzjr3aBko8O5KBd+M
X-Gm-Message-State: AOJu0Yz13+Z3N125OSIH0PBWcFN2hGV8+UKpP35aqunbujWBcewcZHJm
	EfMNb7O8cmz9ky97MEriWFjrblNHExVRouppvHpg3RCmG91LGIYwtE4qSBYpY/OwDblgWwUXTXf
	7Xl4T2K+5UMGk4X5XuWos0epxf/ExHCk8xp8Nrw==
X-Google-Smtp-Source: AGHT+IGWrT6AGOjft7fPxfyGvYvCXJfttPv/nEZHz0d3KcIR2jl3mOL7uB8g8yrYQBh2WMamTXYhqpV0NrzQOqbsGCE=
X-Received: by 2002:a17:907:9483:b0:a7a:af5d:f30b with SMTP id
 a640c23a62f3a-a7ac508ab79mr312568066b.66.1721934028544; Thu, 25 Jul 2024
 12:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724183605.4038597-1-jesse@rivosinc.com> <20240724183605.4038597-5-jesse@rivosinc.com>
In-Reply-To: <20240724183605.4038597-5-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 25 Jul 2024 11:59:52 -0700
Message-ID: <CALs-Hss0UpyR-NriR1egtBchssqRnhER=ND+4H1TbOk0PerS+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] RISC-V: Scalar unaligned access emulated on
 hotplug CPUs
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:36=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> The check_unaligned_access_emulated() function should have been called
> during CPU hotplug to ensure that if all CPUs had emulated unaligned
> accesses, the new CPU also does.
>
> This patch adds the call to check_unaligned_access_emulated() in
> the hotplug path.
>
> Fixes: 55e0bf49a0d0 ("RISC-V: Probe misaligned access speed in parallel")
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

