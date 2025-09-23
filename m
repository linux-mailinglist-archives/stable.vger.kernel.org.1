Return-Path: <stable+bounces-181538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C208B97234
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B30E19C7344
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1D2D063A;
	Tue, 23 Sep 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/KHlXO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E022DF12B
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650199; cv=none; b=FLDmoK/4MN9h8ErISG383uJJzXG9KzcZHOlH8rVx139DIhN2HqF5MSKnS3bWjnQZpkiFWu4Pm6d0y7Rjhn8NDBcPclZoCHiVzfWulgDaPhA5WvS1tGxxVY4rCcwTaaS1qgUSySZh9l9vqRpk8wF4CEMSGq78t9zMIRdN4pgdS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650199; c=relaxed/simple;
	bh=+2VyYQWo3bsBibTZIVLx3nWadN0J/BZKQdGjMX/uX1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFAW5YfsT47YSXgQoajvDwn4etSjzWr6JO53qCfYM7y3Dm2INdBZ8ZiF7pZfPcfHbsGRbAHOq6VC93Iq7ucAxxvCdQd7rntyPUMIifhRNBBOBfhg2kH/W0+LN4ULBYX0SpxtjYF0LmTL567CIOOljPILaOjsitYyI2k7wwYtQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf/KHlXO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-750a40d6583so3038087b3.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650197; x=1759254997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RBKxzZ6kU4c7lQtSNThN83j+ugKQYRphi2BaKEQ6gc=;
        b=Bf/KHlXOgjHZvLypdVJ6KMhZjIsdWPT1SZTuztKu1b9MKovaRA45FM+cE+YgKik3dW
         pGv3jcxcdsP+BTxn2pdGcCJAkAF7kP94iBGwtO5DVjpdoskAM4XXZyfhR6u3mFHESvet
         KmcgP70wG9G5atqoxuTdzqaFO4GGtzMQlR2r2idBRDpP5q1V0k8fjrDPTOlrclbTAm3g
         REjrHMurtmFUh83Vq+namEtqwudN/wBipDBNc1+clSSwqMnXDKpSI8YKkU2UqlDaLO5t
         /NIEGbVzlFmEXHvLlNi4pHP/mHspqS9tMR10pP+H/I1lXgfwyDjhcwG1PEZmGGzJ9yh4
         sUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650197; x=1759254997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RBKxzZ6kU4c7lQtSNThN83j+ugKQYRphi2BaKEQ6gc=;
        b=hZQe78w1nwWBWjoiBgPt/e07Tz2jCPRAaONUbMcKtM0Hg3riFqV/xM7cLUR8TRso2u
         SeBQnlry9a04p+VtPUqjCqVZzDiTfZSHPyJoKzDSMotiFYr7NAAHa18fBok0ZBCRL2Z0
         tuzfjOj2tFsrKmem0u4ug9Zw6IqNCYGSZ4IFzwdA1ZlbGFU7SJnEQ7FUvIJxds1FGzCE
         YDVRT4ee7ReShjLEq/DEi3B6aArgTigIm96wTqWDMenYok6wBqkq44Z238NPQi8jveVG
         QnWpWtBg0y9NcLflidZV7ghBnrcndhn6MXS+bcqTD+iUcXirqmYybQlhYf7H/qzNfkyZ
         R0/A==
X-Forwarded-Encrypted: i=1; AJvYcCXixMJLHOQl8/3ww+j8MNHnVAJuTJhT8aGvrPwJw2Dusvm6umObc1zDFtNPWiDskQEF3AFSkko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvU1Fl0qn7qaobZ0b/XXAhIPDAkJGPI1C3Wcp/2MBDE7jPb6d+
	gJtVp6RNC1eiDdG37nAiN0D1teRwiHtSe0u/6tD+A/BfZNN5Y18R8QZ81JE/UQ34HOUi00Z9XvE
	vqwc6BfZs0t5kqU/zJe6aV7flN0ChrEs=
X-Gm-Gg: ASbGncs/M8mCw+QNg4YTMpNu2OdvWJXLJ5yhxEDVN7OT+HxtegRvY0JVCU9+4KbMnvP
	FNIcsTHyDg5wWMdu9cTf96NUaPHadLXw+UnbUSeRmt2sqLFqtikHkt7Ekj4TkntJY+HMpYi/GBE
	9hyV7m4J7gcAYGjh51y0PYkKjNL2dwUii6yYYB/dlbKQqJI+Kd3TmAs5BDiGllUfiRJ+53MyY5m
	7qLf6te0U1uyvTO1pEBqzlUglrxQ3qe3PXPgSNHwyOJlNEhxmA=
X-Google-Smtp-Source: AGHT+IHFYFnbDFoI8nXPm/DbKE6WwSpo1v/Alo1pPkP09kUWL9d8Oowjt7g3OspcbiGB8leMO3y3rMrtwX3aXsOxGiM=
X-Received: by 2002:a53:e035:0:b0:628:3892:b666 with SMTP id
 956f58d0204a3-636047726bbmr1466398d50.5.1758650196488; Tue, 23 Sep 2025
 10:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
In-Reply-To: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Tue, 23 Sep 2025 19:56:12 +0200
X-Gm-Features: AS18NWARQQsHpK2MdVqC8zgUyvOCYrPAmI9se1FvWZJ1HDiZT1pR2BaT5dqzbC8
Message-ID: <CAPAsAGx6C4PdODuTVxc2un=wpDC1azcO5GUa5cH7KwC=bHF-7w@mail.gmail.com>
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Brian Norris <briannorris@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:10=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> From: Brian Norris <briannorris@google.com>
>
> max_link_speed, max_link_width, current_link_speed, current_link_width,
> secondary_bus_number, and subordinate_bus_number all access config
> registers, but they don't check the runtime PM state. If the device is
> in D3cold, we may see -EINVAL or even bogus values.

I've hit this bug as well, except in my case the device was behind a
suspended PCI
bridge, which seems to block config space accesses.

>
> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
                       accesses

> rest of the similar sysfs attributes.
>
> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_s=
peed/width, etc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..160df897dc5e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *de=
v,
>                                    struct device_attribute *attr, char *b=
uf)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
> +       ssize_t ret;
> +
> +       pci_config_pm_runtime_get(pdev);
>
> -       return sysfs_emit(buf, "%s\n",
> -                         pci_speed_string(pcie_get_speed_cap(pdev)));
> +       ret =3D sysfs_emit(buf, "%s\n",
> +                        pci_speed_string(pcie_get_speed_cap(pdev)));

pci_speed_string() & pcie_get_speed_cap() don't access config space,
so no need to change this one.

> +
> +       pci_config_pm_runtime_put(pdev);
> +
> +       return ret;

