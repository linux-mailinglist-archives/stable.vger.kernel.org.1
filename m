Return-Path: <stable+bounces-6612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17438118B1
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706FF1F2110A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9431758;
	Wed, 13 Dec 2023 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwTlcLbF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D1B9
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702483607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q106s0gS4HpONPoouMQtCupD8VBOdms/F16NVa2ymO4=;
	b=GwTlcLbFDRGZLVbkMxCovNqnFjxqqUmcqzmnU0N7L1V6gCBpDW+X/8ofXN/YkjUaFgwojn
	0wbM2SIp+Qk3nkE24aR2a7q4QlZQ7uXOflLn6Tk4pGpi0Q8B2mUK/w4YoKErnxgNL3Sr1+
	dO7gLNclXqsjCgNaYrXxpdNoJk0Xh+M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-B7PxR-KePhq5yaelC0v83g-1; Wed, 13 Dec 2023 11:06:44 -0500
X-MC-Unique: B7PxR-KePhq5yaelC0v83g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50becd7229aso6011689e87.3
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 08:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483603; x=1703088403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q106s0gS4HpONPoouMQtCupD8VBOdms/F16NVa2ymO4=;
        b=o41ItkFECOz4X0CzJi06JA+KaQdSSpQwO7xyhquyy757EXkq1ZUKGCYIRFqqni9Ur4
         R6w/uuojKFyzEhIgM2SNEvfxAY8HFlkblOhNVBGjbHtrNOo9JU+65qzHAu+F7rgBeSBh
         bZ9TmlYq3Ru1oi2EdCf3aaBi2g4h+OURs4YO9/sNkwy74cn0hvcfscNTkBt1p1wB+lhA
         UwgrSap/75fPo5EUQKmA8VoPPLlquvOmQ6PzGeGat6eu8lp3VHiXuhOuGG5DiY6uMHTg
         8UYNGjtBtM2Kqgew2RqAMf37yzvnXBthm1VxEuYSIQpf1oK/Uv1wpMFrBVxuFbEgVhB7
         ZTgA==
X-Gm-Message-State: AOJu0YyCIdYjiEYGDxL1QdBBEyZ4Gs6OThfNkwS7kkeKIga01OV7+7CQ
	/O3YlFQJAn7Htw7fFLTtgwfNiG7JwnvsISw6qbcbh+oDli1Z0saVoSork/ou6vqQOIWPjPHH7WH
	unoXFYc7albT+EPX9Ja83JKWPB3Pjsauj
X-Received: by 2002:a05:6512:110d:b0:50b:f858:f138 with SMTP id l13-20020a056512110d00b0050bf858f138mr4609483lfg.89.1702483603154;
        Wed, 13 Dec 2023 08:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw3Ljc3eklHpFpuSFf+Z9BjZ7uARG614C+AsLZ+jCD1co83tLSpAVEHTYy81SLTprROZdRDO3ZqT6G3CREyFU=
X-Received: by 2002:a05:6512:110d:b0:50b:f858:f138 with SMTP id
 l13-20020a056512110d00b0050bf858f138mr4609474lfg.89.1702483602853; Wed, 13
 Dec 2023 08:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213003614.1648343-2-imammedo@redhat.com>
 <CAJZ5v0jQTiLqbBQ+xMord2apaQcdXNWumZPbHqu0GOxJ3apPFQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jQTiLqbBQ+xMord2apaQcdXNWumZPbHqu0GOxJ3apPFQ@mail.gmail.com>
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Dec 2023 17:06:30 +0100
Message-ID: <CAMLWh55+GkpBOqihsM8Nry310GQh1f5mT=3_2yxCnfiWbFg2JA@mail.gmail.com>
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com, 
	lenb@kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, 
	boris.ostrovsky@oracle.com, joe.jin@oracle.com, stable@vger.kernel.org, 
	Fiona Ebner <f.ebner@proxmox.com>, Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 1:36=E2=80=AFAM Igor Mammedov <imammedo@redhat.co=
m> wrote:
> >
> > When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
> > adding device to bus and enabling it will kick in async host scan
> >
> >  scsi_scan_host+0x21/0x1f0
> >  virtscsi_probe+0x2dd/0x350
> >  ..
> >  driver_probe_device+0x19/0x80
> >  ...
> >  driver_probe_device+0x19/0x80
> >  pci_bus_add_device+0x53/0x80
> >  pci_bus_add_devices+0x2b/0x70
> >  ...
> >
> > which will schedule a job for async scan. That however breaks
> > if there are more than one SCSI host behind bridge, since
> > acpiphp_check_bridge() will walk over all slots and try to
> > enable each of them regardless of whether they were already
> > enabled.
> > As result the bridge might be reconfigured several times
> > and trigger following sequence:
> >
> >   [cpu 0] acpiphp_check_bridge()
> >   [cpu 0]   enable_slot(a)
> >   [cpu 0]     configure bridge
> >   [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
> >   [cpu 0]   enable_slot(b)
> >   ...
> >   [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
> >   ...
> >   [cpu 0]     configure bridge <- temporaly disables bridge
> >
> > and cause do_scsi_scan_host() failure.
> > The same race affects SHPC (but it manages to avoid hitting the race du=
e to
> > 1sec delay when enabling slot).
> > To cover case of single device hotplug (at a time) do not attempt to
> > enable slot that have already been enabled.
> >
> > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if nec=
essary")
> > Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> > Reported-by: iona Ebner <f.ebner@proxmox.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/a=
cpiphp_glue.c
> > index 601129772b2d..6b11609927d6 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -722,7 +722,9 @@ static void acpiphp_check_bridge(struct acpiphp_bri=
dge *bridge)
> >                                         trim_stale_devices(dev);
> >
> >                         /* configure all functions */
> > -                       enable_slot(slot, true);
> > +                       if (slot->flags !=3D SLOT_ENABLED) {
> > +                               enable_slot(slot, true);
> > +                       }
>
> Shouldn't this be following the acpiphp_enable_slot() pattern, that is
>
> if (!(slot->flags & SLOT_ENABLED))
>          enable_slot(slot, true);
>
> Also the braces are redundant.

I'll fix up on respin if Bjorn is fine with the approach in general.

Patches need respin anyways to fix botched up white spacing.

>
> >                 } else {
> >                         disable_slot(slot);
> >                 }
> > --
>


