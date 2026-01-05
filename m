Return-Path: <stable+bounces-204860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F318FCF4E75
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21993124965
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E133ADB7;
	Mon,  5 Jan 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DVq+T/ao"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C336337B8B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631757; cv=none; b=dHSLYroWVBKIoIlB8oCXoICqYRqFj/T7v5/y4m2udou+tH+6rblq5MAeR4n/amrLSg3VDasSRgGgzRzLFiLrqQzlDYO1ydheLScRHLLdL1gpCfUXZXyfnajdebMP5rE+2o+ZVYorQXOpoCPSm+njs4CPsVABlrOtE8PBFumCK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631757; c=relaxed/simple;
	bh=OpE212T/F9BXcXkqoV8tRgvykPW9UH3BnbLCVGJJS38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQY4wLVilkhf/viNd40OP4C3lEa1lXjZGqTSI+/6nnqNQby4XIx0kBCR9z3a2KecSHF3uJg9tCuMp/ZsDjJsC8spl0HLX65y64lStQKSRW5hG1yd6+nbnh4sE/gpafSdHlRR+lGros4myTo7DJnBgrbFicO1LtORqdOdcn4tGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DVq+T/ao; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a110548cdeso1176565ad.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767631752; x=1768236552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p5G3xJb8go3voJ/ska7MmknNqjaKO20ee89C7s96SI=;
        b=DVq+T/aogTwlSdL7kfYlA8KAh+bRlYW8BnFj2yi2KWBTyHSrh2gXj0EcxueVFa+rwo
         9P2Q4I7ZNaRZKtEOOVr6WJzlEOPF75gQD+0HOvvVbTrqeLKXd8HmWZJBcYoeHDy4/mcD
         ReS+RmaYBBUZHd43YtUUP1qiuXB0ec5ZfRpw8C1MgK6blFNhbiPRQx1ZPdiXzZXS8pXR
         /UELTIhBEGjUxdejk5XmJ8nkd1zFE61+KXIXtUBlAt28r2KcERhzO82T4FdYoo0BObJg
         SZw/bMia81j15V0nCOGTLYOyLd5TR1SIrtWnDBcj9lz2h+noNmrr+V2SsR6F99gr6PbY
         sGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631752; x=1768236552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1p5G3xJb8go3voJ/ska7MmknNqjaKO20ee89C7s96SI=;
        b=LYo6t/ZF+srUXAqc1wGSjcAh6GsJaccDv2OHVIevA729Cke5/tIMX/zNnizov9iY7Y
         cUSxWsn8I6g8STcJC7E55ouLJAoIVGv6S2/vd9RkZpahZPIJ9iD9Yti4y5rNCGlYuo4b
         gteFUI1WCUxMQTQywMCHe8NE/ZRq/tZJ2NzSZ1nTMJdigQsclRgLLxHlG08kbGZ8XI2/
         ExWxJ+sLh1q5mkScKhFVJs/QRfCvYEKKiDUpc85rDu7Gxbe1++HselKdr7yvR0xZO3TC
         2mk2d6VllNj/iS6blA2EAo4wT4/UcdacSCiHQjq79e5ipfbyOEAjY7SGzXDkWOF93WQ3
         Qijw==
X-Forwarded-Encrypted: i=1; AJvYcCUm+Vb6UaL8VqIUVA0IAWyRAs89zYOStg55eOOLUqk3Xmbl3FyIiECJzDsM0o+o8utJpcETP10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6+qo5+sGM0U3owQHdfanziHapUyGpdT8EIOiMcTBzofnNS1U
	iNYbjtLAvFQmvX/YquIGbzHkZZwwYZwpoXKn26Wpv6owd+P9+1d6z2oEdSv9jV5qywbpQjZqpbG
	EUb2KrPF+R4GCNbudK/OzWOm/QAgzBMg=
X-Gm-Gg: AY/fxX6A8j2z0znU36l5nXH5mGkvatO0Ab84ub0csZbPFbqO1DaXeOdMBnqLy3jCZ3X
	PHxPpldsTal7hRpClzvESUIRQZ89gXMvMpQENqHCpdoieH7xaWmbtR7Y7SvvkvByLVJ457X0now
	9nkF3ytlPvvN7FzQK9rEvbqV+BLMWQu24hrBLk6j/1h6bd+Y78h/k6aJ5SEAtBCtR8nm/wev6Wg
	iumXHRNcshOZ5n7HbHoL7iTw0wVm/b/ko6ZcVwz54tMbMDMXOsQtzyG63EDi1ZwtdLl71H8NBFS
	Y8Rlb8aiVaeW7iQBWjwWHhtPd0ZX
X-Google-Smtp-Source: AGHT+IGDtOegmT/WubwoP9uhYGjEyI36HrbbD+HDLKKzlp50hnIAwbFpuvZJAMWfwWQ5Fu7mo4QOpgsR9wCZJW3kUe4=
X-Received: by 2002:a17:903:28f:b0:29f:5f5:fa91 with SMTP id
 d9443c01a7336-2a3e2cb39ffmr2973425ad.27.1767631752099; Mon, 05 Jan 2026
 08:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103221930.1831376-1-helgaas@kernel.org> <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
In-Reply-To: <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 5 Jan 2026 17:49:00 +0100
X-Gm-Features: AQt7F2rVWmf5Npt8HCJJTiZdHZlTavXt7hjPiasOfQo5l2lbIUvVpU46LHb_LE8
Message-ID: <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout, message,
 speed check
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Yue Wang <yue.wang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Linnaea Lavia <linnaea-von-lavia@live.com>, 
	FUKAUMI Naoki <naoki@radxa.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org, 
	Ricardo Pardini <ricardo@pardini.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Thu, Dec 18, 2025 at 7:06=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
>
> On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> > Previously meson_pcie_link_up() only returned true if the link was in t=
he
> > L0 state.  This was incorrect because hardware autonomously manages
> > transitions between L0, L0s, and L1 while both components on the link s=
tay
> > in D0.  Those states should all be treated as "link is active".
> >
> > Returning false when the device was in L0s or L1 broke config accesses
> > because dw_pcie_other_conf_map_bus() fails if the link is down, which
> > caused errors like this:
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed che=
ck
>       commit: 11647fc772e977c981259a63c4a2b7e2c312ea22
My understanding is that this is queued for -next.
Ricardo (Cc'ed) reported that this patch fixes PCI link up on his Odroid-HC=
4.
Is there a chance to get this patch into -fixes, so it can be pulled
by Linus for one of the next -rc?


Best regards,
Martin

