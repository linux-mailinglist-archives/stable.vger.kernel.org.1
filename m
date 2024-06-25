Return-Path: <stable+bounces-55759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02F9167AC
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4DEB239AF
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02307155320;
	Tue, 25 Jun 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7vGgrow"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB561494A0;
	Tue, 25 Jun 2024 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318201; cv=none; b=LBAXhgCqPnDHUJHPImBR+d80ROANNQVwDXAvWm7jgdkIrRCmzEqSqIC0Hjb9ivHLiWOwBkRRNdznXriAqVGva3sFMnzm+RcgAgkrLsF8SZrxThRL2KOukKjOAcIsDFidkg1XyuNcQA5SWCe5chU7R79s0QrdOX20v/S3HWpWTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318201; c=relaxed/simple;
	bh=XNipA7WM4LlHtrfo1peU5XTzzP16pFJt8SAtSql/dd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuItYHvjNToIu/Uy3NDkTM79KNGT7IUr7nvvHoaSOvD6t8Y9ID6MI9ZY0v+Vex7uOUGQpJYj3VJ5D7P+M0B6GJqMbJAtGRje/HjX90BnSlueuhYsDX2l985wvrtH+ddj4gnnWIhrp2NFKvk6Ct83qUVQ6A8HYQHP8M9YCHOdr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7vGgrow; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so6763838a12.1;
        Tue, 25 Jun 2024 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318198; x=1719922998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPdVzEGKSLX2+NwkSqu7FU59prs3gqdqHeBd/jKqpqs=;
        b=g7vGgrowyoLeORIRVk/1fFQiUiViknSmDbixooZ79wF2UtP2f0B8TpEjaZI5gCmMCE
         gbUFLez2f9BIMUWnQAWMRSWWfGnTQm+TZc9ItbMQHWOyXKHXRhjPhKehWd6UcSE/o2wL
         t4OwwX4n+aRaiuQ0rMgmTYGV7Kqi8HOlpuAitOVrn1I0nF/iCSlo//IWAcO5xWl/J1PX
         tY52WzdC1OCfa35Dg0/+Zw9WbtwsAIlTqkm2OkSGS4Cuyfmm36G1I4whTfxu6tl2Yfbt
         SnA1uMPkr33c3JRyzRNROEjyOgnN3S8clJNOYq5JC/zFpAwvpqo6gQAsFlSXhCSfMDRV
         Svgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318198; x=1719922998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPdVzEGKSLX2+NwkSqu7FU59prs3gqdqHeBd/jKqpqs=;
        b=ehTYBgcLEMiS8vELWL8Zr+8XNegnTld7I4urOkblrgrS1iU+v3eESKI8G9msCijg1l
         1Kqv1M2rc49DqxjyfsDWtzEyXa06cpH4lGEDTn7gSbN4ZO4JK9G14AlQuwh2LYiCydy3
         1niaWWph9bj80EmRGG8Q1HeXWLsdoqrzY9xEL5Jh6jlBr6au+cVugxBFf6pqKafBfBhY
         QV1vU0VPRYGc0zWhBDo/h8C456utsv4sJQ/0JWxfGCSpGmm4bUpbAodKARwVtUuGBcSz
         vYdV4kmDU4bxILFCjkDaYv8HPExcko+dh6kR3PxeENL5fmIv+lhoev02NlR/IoPfd5Kk
         DIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAYKCrHHCnzOKSlh3XSs4Xw5CpSoeLAs7mEBPNMYIxeigw7cNDzOqIZMLhNK66PWjPWD5w8lDMnrSlTbRqi+pLwj0uAG6kQIfeMtLu+siW876wSOm9S/0tf4Fp/EGXswOL3jep
X-Gm-Message-State: AOJu0YysZrU3QN4zoMtVfmcpiuCisQoM5ZqBcN7BP6Wg+krz6Z+uQRJe
	DJWivH23eEStxZ6nbwG8cBoU1lvVgXrLciOtoDFmwe6lZgqHYoxjXn1Ohst/p82CBmQlPAW0lta
	+aZMe5JlJMu0eCF2vCz6AdcbqlAbv6TzxGvY=
X-Google-Smtp-Source: AGHT+IFVIZyc/+AyCQqQC5uBq8MF6nLmt4ueuogjzBWCBowhY/W4tpo5sHEfp6moVR+WNbxQt4ecn4DSI8mXnFlkh2s=
X-Received: by 2002:a50:d4d5:0:b0:57d:2650:5f62 with SMTP id
 4fb4d7f45d1cf-57d4bd606damr4809931a12.14.1719318198082; Tue, 25 Jun 2024
 05:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619114529.3441-1-joswang1221@gmail.com> <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh> <20240621054239.mskjqbuhovydvmu4@synopsys.com>
 <2024062150-justify-skillet-e80e@gregkh> <20240621062036.2rhksldny7dzijv2@synopsys.com>
 <2024062126-whacky-employee-74a4@gregkh> <20240621230846.izl447eymxqxi5p2@synopsys.com>
In-Reply-To: <20240621230846.izl447eymxqxi5p2@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Tue, 25 Jun 2024 20:23:06 +0800
Message-ID: <CAMtoTm2UE31gcM7dGxvz_CbFoKotOJ1p7PeQwgBuTDE9nq7CJw@mail.gmail.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 7:09=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Fri, Jun 21, 2024, Greg KH wrote:
> > On Fri, Jun 21, 2024 at 06:20:38AM +0000, Thinh Nguyen wrote:
> > > On Fri, Jun 21, 2024, Greg KH wrote:
> > > > On Fri, Jun 21, 2024 at 05:42:42AM +0000, Thinh Nguyen wrote:
> > > > > On Fri, Jun 21, 2024, Greg KH wrote:
> > > > > > On Fri, Jun 21, 2024 at 09:40:10AM +0800, joswang wrote:
> > > > > > > On Fri, Jun 21, 2024 at 1:16=E2=80=AFAM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 19, 2024 at 07:45:29PM +0800, joswang wrote:
> > > > > > > > > From: Jos Wang <joswang@lenovo.com>
> > > > > > > > >
> > > > > > > > > This is a workaround for STAR 4846132, which only affects
> > > > > > > > > DWC_usb31 version2.00a operating in host mode.
> > > > > > > > >
> > > > > > > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > > > > > > in host mode that would cause a CSR read timeout When CSR
> > > > > > > > > read coincides with RAM Clock Gating Entry. By disable
> > > > > > > > > Clock Gating, sacrificing power consumption for normal
> > > > > > > > > operation.
> > > > > > > > >
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > > > > >
> > > > > > > > What commit id does this fix?  How far back should it be ba=
ckported in
> > > > > > > > the stable releases?
> > > > > > > >
> > > > > > > > thanks,
> > > > > > > >
> > > > > > > > greg k-h
> > > > > > >
> > > > > > > Hello Greg Thinh
> > > > > > >
> > > > > > > It seems first begin from the commit 1e43c86d84fb ("usb: dwc3=
: core:
> > > > > > > Add DWC31 version 2.00a controller")
> > > > > > > in 6.8.0-rc6 branch ?
> > > > > >
> > > > > > That commit showed up in 6.9, not 6.8.  And if so, please resen=
d with a
> > > > > > proper "Fixes:" tag.
> > > > > >
> > > > >
> > > > > This patch workarounds the controller's issue.
> > > >
> > > > So it fixes a bug?  Or does not fix a bug?  I'm confused.
> > >
> > > The bug is not a driver's bug. The fix applies to a hardware bug and =
not
> > > any particular commit that can be referenced with a "Fixes" tag.
> >
> > So it's a bug that the kernel needs to work around, that's fine.  But
> > that implies it should go to "all" stable kernels that it can, right?
>
> Yes. That's right.
>
> >
> > > > > It doesn't resolve any
> > > > > particular commit that requires a "Fixes" tag. So, this should go=
 on
> > > > > "next". It can be backported as needed.
> > > >
> > > > Who would do the backporting and when?
> > >
> > > For anyone who doesn't use mainline kernel that needs this patch
> > > backported to their kernel version.
> >
> > I can not poarse this, sorry.  We can't do anything about people who
> > don't use our kernel trees, so what does this mean?
>
> Sorry, I wasn't being clear. What I meant is that it needs some work to
> backport to stable version prior to v6.9. Anyone who needs to backport
> this prior to this will need to resolve these dependencies.
>
> >
> > > > > If it's to be backported, it can
> > > > > probably go back to as far as v4.3, to commit 690fb3718a70 ("usb:=
 dwc3:
> > > > > Support Synopsys USB 3.1 IP"). But you'd need to collect all the
> > > > > dependencies including the commit mention above.
> > > >
> > > > I don't understand, sorry.  Is this just a normal "evolve the drive=
r to
> > > > work better" change, or is it a "fix broken code" change, or is it
> > > > something else?
> > > >
> > > > In other words, what do you want to see happen to this?  What tree(=
s)
> > > > would you want it applied to?
> > > >
> > >
> > > It's up to you, but it seems to fit "usb-testing" branch more since i=
t
> > > doesn't have a "Fixes" tag. The severity of this fix is debatable sin=
ce
> > > it doesn't apply to every DWC_usb31 configuration or every scenario.
> >
> > As it is "cc: stable" that implies that it should get to Linus for
> > 6.10-final, not wait for 6.11-rc1 as the 6.11 release is months away,
> > and anyone who has this issue would want it fixed sooner.
> >
> > still confused,
> >
>
> Ok. I may have misunderstood what can go into rc2 and beyond then. If we
> don't have to wait for the next rc1 for it to be picked up for stable,
> then can we add it to "usb-linus" branch?
>
> There won't be a Fixes tag, but we can backport it up to 5.10.x:
>
> Cc: <stable@vger.kernel.org> # 5.10.x: 1e43c86d: usb: dwc3: core: Add DWC=
31 version 2.00a controller
> Cc: <stable@vger.kernel.org> # 5.10.x
>
> This can go after the versioning scheme in dwc3 in the 5.10.x lts. I did
> not check what other dependencies are needed in addition to the change
> above.
>
> Thanks,
> Thinh

Is there anything else I need to modify for this patch?

Thanks,
Jos Wang

