Return-Path: <stable+bounces-52943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093090CF61
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E491F22CCD
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4F15E5B7;
	Tue, 18 Jun 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmKVcg85"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B3145B37;
	Tue, 18 Jun 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714868; cv=none; b=KdjW7gIecAsetVsXpnfq3WzRTMzM1Kcwf0f8v1GHBuemuNoae2iALh65NrXdEfiKt1wrz6rvePZ0I5YqKrOveWWA0a8Gd+3BmfBKvz+wQfEgSyitjBalOGfdUrHRXiNzN0uo/UybabAtMegYOcSH3VFXQY/AvP/O7gc5ufwxCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714868; c=relaxed/simple;
	bh=llKsSokbWVreY2pYxSxMXJ4DmkKrX3OzdhY8owx9+Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWUia1ztKil+4Jl1bfG+UdIKBiuBATJtnOOt9vAFpN03ZQq49OFJK2cVGLFolwPlb8xP6ZOlz/cHw64At4euL5KK0lbbjowpc9BAfZjesJ5MaO0Xu8CTNFzTRsG9SyTqaupFIF9oQEDJ2vBxTvr9hobcAVUzVLHLu58/rRlDj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmKVcg85; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6efacd25ecso332281166b.1;
        Tue, 18 Jun 2024 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718714865; x=1719319665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3VpHd0JHmZD4WjBkUsTzzEDz6Rx27ZsVrJclfCl2X8=;
        b=SmKVcg85SO5esFP0WCiyk8IhDWHk375GvrGPbtqK5QP6qk3XB8a0n7OwPdD1PwAS5F
         joTOtbMD9H/mhj0cRks62+MMGuCjal+sgZIUv5kR75DcGh0L7+HwXus0e3DO/UHNEou6
         3beW0BJmk6AjlU4kngzW0Dcvca1CsA4PkV9RkSsfvtpF+Yji4IOx4V84zc7cZtZTZR9X
         A8USdhES4fQctAn7EVKB3qwh4m7JTuOdn1hwZ84/hWG+47srwxqrPxqnxqR7rcQwmaZC
         Y7avAMqZjuO1liN+Y9Z2fWcfN5CI8zOkaLguxe00UtBdwThObeyu2Opvk/+cmElXfPrO
         M3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714865; x=1719319665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3VpHd0JHmZD4WjBkUsTzzEDz6Rx27ZsVrJclfCl2X8=;
        b=rhxoslDaXq6qOXzafaV0FwobNyQHHE3lmQD5pPD2tC7RtisoXh3aK/vRDblN8NkOQD
         6yDpmKfDM2nQyycFWitXlse9g5AdSfy2rVpuoOP430j5oKYgPwA6qVSDT4XOxa8n/GjN
         ARuG9uOtrlwJvPjtKuXw5WcYcZmNM3lOryu9WPWSAJ6VYrGlPZiW2lxfHlW/sI2D5uNu
         AqLmuRF4yoLMJn2VF+a5gF5OM3qvmzI+CL8Lte3Svdj4RSJZQnhyH9/jSs00LZ4DToYp
         aCaBdPAamK9RFNrzB18J9UPGSSxvwA3eGYjcCWLcHZgHvBOz5gZMpuInxe0D1nvVKnWA
         IKvg==
X-Forwarded-Encrypted: i=1; AJvYcCVMqRTz8wzoHFKhYb3fM0LYD5Hm+BJTjIWfxK6e83+UsLn70mfLxpPhcH37uhJNqqeot3hLXymn5P80Au+0JuHUpTNmJLGTYYPi1RKPudw4xij1CY7HWPO3DpE+qnDPIXvotzJy9EBE0zdUitM+5AsYpYyILUElrg1t7Wk1Ei9K
X-Gm-Message-State: AOJu0YwFuj2x0AmsPdTgtDnqxc2c1w0Yns1uM+Gu5w2YXrfkRZVmgbCp
	97hnb210nfO+NM/hTNYKEtPo/ChdImG0mK9/vEyOstFRPYXnHFB30zgSELQErptk6iPTcf71gz6
	muuRX7QDdD6tGNNJuTelo/QEe3eI=
X-Google-Smtp-Source: AGHT+IHIr5iz35UBLYc9HYQ/hr9/2KdLV2xXGggyddelPLlm2c+GVYrDo85rEXR385uQ6YppFvU0egjvulIHsqGkR2s=
X-Received: by 2002:a50:ab4d:0:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-57cbd6778eamr9821853a12.2.1718714864647; Tue, 18 Jun 2024
 05:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240612153922.2531-1-joswang1221@gmail.com>
 <2024061203-good-sneeze-f118@gregkh> <CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
 <20240618000502.n3elxua2is3u7bq2@synopsys.com>
In-Reply-To: <20240618000502.n3elxua2is3u7bq2@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Tue, 18 Jun 2024 20:47:38 +0800
Message-ID: <CAMtoTm1ZkT6NoBj9N-wKkzxASQ2AboYNdd-L7DHUEt8m8hootg@mail.gmail.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:05=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Thu, Jun 13, 2024, joswang wrote:
> > On Thu, Jun 13, 2024 at 1:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 11:39:22PM +0800, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > > >
> > > > This is a workaround for STAR 4846132, which only affects
> > > > DWC_usb31 version2.00a operating in host mode.
> > > >
> > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > in host mode that would cause a CSR read timeout When CSR
> > > > read coincides with RAM Clock Gating Entry. By disable
> > > > Clock Gating, sacrificing power consumption for normal
> > > > operation.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > ---
> > > > v1 -> v2:
> > > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
> > > >   this patch does not make any changes
> > > > v2 -> v3:
> > > > - code refactor
> > > > - modify comment, add STAR number, workaround applied in host mode
> > > > - modify commit message, add STAR number, workaround applied in hos=
t mode
> > > > - modify Author Jos Wang
> > > > v3 -> v4:
> > > > - modify commit message, add Cc: stable@vger.kernel.org
> > >
> > > This thread is crazy, look at:
> > >         https://urldefense.com/v3/__https://lore.kernel.org/all/20240=
612153922.2531-1-joswang1221@gmail.com/__;!!A4F2R9G_pg!a29V9NsG_rMKPnub-JtI=
e5I_lAoJmzK8dgo3UK-qD_xpT_TOgyPb6LkEMkIsijsDKIgdxB_QVLW_MwtdQLnyvOujOA$
> > > for how it looks.  How do I pick out the proper patches to review/app=
ly
> > > there at all?  What would you do if you were in my position except ju=
st
> > > delete the whole thing?
> > >
> > > Just properly submit new versions of patches (hint, without the ','),=
 as
> > > the documentation file says to, as new threads each time, with all
> > > commits, and all should be fine.
> > >
> > > We even have tools that can do this for you semi-automatically, why n=
ot
> > > use them?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > We apologize for any inconvenience this may cause.
> > The following incorrect operation caused the problem you mentioned:
> > git send-email --in-reply-to command sends the new version patch
> > git format-patch --subject-prefix=3D'PATCH v3
> >
> > Should I resend the v5 patch now?
>
> Please send this as a stand-alone patch outside of the series as v5. (ie.
> remove the "3/3"). I still need to review the other issue of the series.
>
> Thanks,
> Thinh

This patch has been sent separately, please help review it.

Thanks
Jos Wang

