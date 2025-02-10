Return-Path: <stable+bounces-114475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C5A2E403
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 07:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D40161DE3
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46A19259F;
	Mon, 10 Feb 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk+1JKqg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834762F2E;
	Mon, 10 Feb 2025 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167785; cv=none; b=bgFYzJ3Jhy/r5KaCdminM8w1P5v/SmAxcvmemeBs1nwyNy/2LJRU98YGJvU4u7Yy8ZE/sBpUeOenF+c6or0g0/47tFeq4vRRiYyhNt+2BzcVjW6mpGGKqIL0RhxTf2K9i+SPAGwt9kNtKR9WkO174WzH5MipIOD2v3ucVpNsYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167785; c=relaxed/simple;
	bh=NghQxZhDl6fAy9b3XrYIeSdc4CYNEqlE1YkpEJbIU2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWuBUpIdJNO5j3EIfyzhMpzkXQDgF0C9bbuAuqjjm8TZCsgKfU2fYiZNX9tRDm/PUhxv5LcU3nmLXYm0CmlT2x401I/uYX3WRanhQhTwIu+G2gi19WyA9e9oD4zoHLKfg45XRcTI6xLMGvnZZUkhFAeCIvywDJ6+iUVaDvX0b2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk+1JKqg; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b86794e3acso747904fac.3;
        Sun, 09 Feb 2025 22:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167782; x=1739772582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXNMYHImz9NwOzihEuvq1AVlKtNri+stmoZJr+hxXo8=;
        b=Gk+1JKqgAXZHPfF4J39bOv9ozNee+ns4jPgq9GYLbowVnT8YlKSMmXUeExqHEyfQcr
         /pjo5txdFjVR5r+b5Rlf6Qad4N63fdlWUoWfWWDJDyRmBMS4mMHK90UsSitIN2QJwUVw
         e2gabyMCR9eOKNZ6OxXbiyhqNsI7ZFgaXLyjTR1LlMoJl2cX1ZXT4Ucjt95GPtU1mypY
         er2x3F0a/m4R7ysZX4KG1nh2IDqUC6iUqlE3ARFZDAaI4VgHak6XUo8y097j/MrQa8aa
         lYtLBSwg2u02Gyc/DY4s4SFm0KHea0TGNPzSD4NJuMd0g8x+1ZXsQa43ACQZCkKmAIr6
         Hr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167782; x=1739772582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXNMYHImz9NwOzihEuvq1AVlKtNri+stmoZJr+hxXo8=;
        b=CD0QVtbpBDHHR8vEbXSgB7ayF98qWkx/Ru7XVbTQs92QzmQQwFf5UGfS73xGxBdzs/
         0kSbELMPDSwc94GCNdQOd467XwPX4zLqrfwZxpHBzLdVqh64/E062whegglClrkHYjKB
         3rM4kTkBBxIFHuZWotILkn44qyWqPxz6e9BFexOd8Tfd86YCkj2PlQoYSPFjbY+u+v8z
         myfFfyv/prO8ITlpJq9Hm7Up5QN8cn4MRzldVATQf1tobEkFBkabY92EMVx9KwrM+Pjx
         dLZNd84jdzZB6HLP8fJioc5R4h9es5KMf1KkMhLlfWAdB/epXCx8yH/hiBKAIRYw3oyM
         EXOA==
X-Forwarded-Encrypted: i=1; AJvYcCUECnaWnSi8EXi366g46C0DoXU3Pp4wf6Mku3zRSByHlfPXFOMCw4xOd7XhHyvuKiysN950LrkL@vger.kernel.org, AJvYcCV20euhevvnwEjcJc6KwmnLtclIMfi+mgtCQqjF6wspid4nIzP7dceFVQEQw6h82phjsXEX668rGipt@vger.kernel.org, AJvYcCXzi5YPit7j/KvsWh+llhgzXMlKvk9DlHplsoFGnCV6DcJXeT5SCfdWI0bFfI8mDMo5es3qpqBmJ/XwQ9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1Ou6dtqDCZ1K1H/asmSjvrPthfV/kUbboDtiHbSBGPgjzjzd
	sso7PncrQFZnPSDJz+/XDk8jbaLVTGEiEsoF+FBaK8DOsJ9ULlnFdJS+7JBrgOOEWHBFEsQ/0M4
	IGHR0CKHR1F22SzyHZr/LCNbHhaI=
X-Gm-Gg: ASbGncvLOxh4P9fYAtcdXJypvupAaci4nt3sWDBbPs52U1pcxWEDF277Sg8Clif/jWa
	bUsWiVJlm79ojjbgEq4xVhEp661VUq4MdvvTtKhf3HnwkS3NM4Wu6eAIZPamy+pY29HH6QxQ4it
	M=
X-Google-Smtp-Source: AGHT+IFZ2RGrd/aWuU7GOztYPY3xrdBYt/J+Vq/euS8um2o4geoH7mOKvAbv556JN/tJZwHwDoq0rgTa2zu+4r4mQrU=
X-Received: by 2002:a05:6870:82a9:b0:29e:8485:197b with SMTP id
 586e51a60fabf-2b83eb99801mr8046172fac.2.1739167782366; Sun, 09 Feb 2025
 22:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205053750.28251-1-ki.chiang65@gmail.com> <20250205053750.28251-2-ki.chiang65@gmail.com>
 <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com> <69eccfa6-5ca0-44d7-b6a8-2152260106e2@linux.intel.com>
 <CAHN5xi29XwtnJx18-8md-CBRNaedq6yHGN7UkccmtpaHpjJLsw@mail.gmail.com>
In-Reply-To: <CAHN5xi29XwtnJx18-8md-CBRNaedq6yHGN7UkccmtpaHpjJLsw@mail.gmail.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Mon, 10 Feb 2025 14:09:32 +0800
X-Gm-Features: AWEUYZmjgrdMilYV-_zU4GgRPO9IK-10N9xfiWkbfeImh5TkOwwKBdiRIPyUAhk
Message-ID: <CAHN5xi3W7oLwUWoCmzQXs+e5LTXYe3q4Qo+3v1ZcoLj_rAPp2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kuangyi Chiang <ki.chiang65@gmail.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi,
>
> Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2025=E5=B9=B42=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:16=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > On 5.2.2025 16.17, Mathias Nyman wrote:
> > > On 5.2.2025 7.37, Kuangyi Chiang wrote:
> > >> Unplugging a USB3.0 webcam while streaming results in errors like th=
is:
> > >>
> > >> [ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA pt=
r not part of current TD ep_index 18 comp_code 13
> > >> [ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002=
fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 00000=
0002fdf8000 seg-end 000000002fdf8ff0
> > >> [ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA pt=
r not part of current TD ep_index 18 comp_code 13
> > >> [ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002=
fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 00000=
0002fdf8000 seg-end 000000002fdf8ff0
> > >>
> > >> If an error is detected while processing the last TRB of an isoc TD,
> > >> the Etron xHC generates two transfer events for the TRB where the
> > >> error was detected. The first event can be any sort of error (like
> > >> USB Transaction or Babble Detected, etc), and the final event is
> > >> Success.
> > >>
> > >> The xHCI driver will handle the TD after the first event and remove =
it
> > >> from its internal list, and then print an "Transfer event TRB DMA pt=
r
> > >> not part of current TD" error message after the final event.
> > >>
> > >> Commit 5372c65e1311 ("xhci: process isoc TD properly when there was =
a
> > >> transaction error mid TD.") is designed to address isoc transaction
> > >> errors, but unfortunately it doesn't account for this scenario.
> > >>
> > >> To work around this by reusing the logic that handles isoc transacti=
on
> > >> errors, but continuing to wait for the final event when this conditi=
on
> > >> occurs. Sometimes we see the Stopped event after an error mid TD, th=
is
> > >> is a normal event for a pending TD and we can think of it as the fin=
al
> > >> event we are waiting for.
> > >
> > > Not giving back the TD when we get an event for the last TRB in the
> > > TD sounds risky. With this change we assume all old and future ETRON =
hosts
> > > will trigger this additional spurious success event.
> > >
> > > I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case=
 seen
> > > with short transfers, and just silence the error message.
> > >
> > > Are there any other issues besides the error message seen?
> > >
> >
> > Would something like this work: (untested, compiles)
> >
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.=
c
> > index 965bffce301e..81d45ddebace 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct x=
hci_hcd *xhci, struct xhci_virt_
> >          return 0;
> >   }
> >
> > +static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
> > +                                          struct xhci_ring *ring)
> > +{
> > +       switch(ring->last_td_comp_code) {
> > +       case COMP_SHORT_PACKET:
> > +               return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
> > +       case COMP_USB_TRANSACTION_ERROR:
> > +       case COMP_BABBLE_DETECTED_ERROR:
> > +       case COMP_ISOCH_BUFFER_OVERRUN:
> > +               return xhci->quirks & XHCI_ETRON_HOST &&
> > +                       ring->type =3D=3D TYPE_ISOC;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >   /*
> >    * If this function returns an error condition, it means it got a Tra=
nsfer
> >    * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
> > @@ -2697,8 +2713,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
> >          case COMP_SUCCESS:
> >                  if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) !=
=3D 0) {
> >                          trb_comp_code =3D COMP_SHORT_PACKET;
> > -                       xhci_dbg(xhci, "Successful completion on short =
TX for slot %u ep %u with last td short %d\n",
> > -                                slot_id, ep_index, ep_ring->last_td_wa=
s_short);
> > +                       xhci_dbg(xhci, "Successful completion on short =
TX for slot %u ep %u with last td comp code %d\n",
> > +                                slot_id, ep_index, ep_ring->last_td_co=
mp_code);
> >                  }
> >                  break;
> >          case COMP_SHORT_PACKET:
> > @@ -2846,7 +2862,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
> >                   */
> >                  if (trb_comp_code !=3D COMP_STOPPED &&
> >                      trb_comp_code !=3D COMP_STOPPED_LENGTH_INVALID &&
> > -                   !ep_ring->last_td_was_short) {
> > +                   !xhci_spurious_success_tx_event(xhci, ep_ring)) {
> >                          xhci_warn(xhci, "Event TRB for slot %u ep %u w=
ith no TDs queued\n",
> >                                    slot_id, ep_index);
> >                  }
> > @@ -2890,11 +2906,10 @@ static int handle_tx_event(struct xhci_hcd *xhc=
i,
> >
> >                          /*
> >                           * Some hosts give a spurious success event af=
ter a short
> > -                        * transfer. Ignore it.
> > +                        * transfer or error on last TRB. Ignore it.
> >                           */
> > -                       if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
> > -                           ep_ring->last_td_was_short) {
> > -                               ep_ring->last_td_was_short =3D false;
> > +                       if (xhci_spurious_success_tx_event(xhci, ep_rin=
g)) {
> > +                               ep_ring->last_td_comp_code =3D trb_comp=
_code;
> >                                  return 0;
> >                          }
> >
> > @@ -2922,10 +2937,7 @@ static int handle_tx_event(struct xhci_hcd *xhci=
,
> >           */
> >          } while (ep->skip);
> >
> > -       if (trb_comp_code =3D=3D COMP_SHORT_PACKET)
> > -               ep_ring->last_td_was_short =3D true;
> > -       else
> > -               ep_ring->last_td_was_short =3D false;
> > +       ep_ring->last_td_comp_code =3D trb_comp_code;
> >
> >          ep_trb =3D &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*=
ep_trb)];
> >          trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *=
) ep_trb, ep_trb_dma);
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 779b01dee068..acc8d3c7a199 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1371,7 +1371,7 @@ struct xhci_ring {
> >          unsigned int            num_trbs_free; /* used only by xhci Db=
C */
> >          unsigned int            bounce_buf_len;
> >          enum xhci_ring_type     type;
> > -       bool                    last_td_was_short;
> > +       u32                     last_td_comp_code;
> >          struct radix_tree_root  *trb_address_map;
> >   };
> >
>
> It looks better than my patch v2, I will test it later.

Yes, it works. I applied and tested it under Linux-6.13.1. This issue
has been resolved.
I have tested Etron EJ168 and EJ188, both have the same problem.

What should I do next?

>
> Thanks,
> Kuangyi Chiang

Thanks,
Kuangyi Chiang

