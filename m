Return-Path: <stable+bounces-114196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9ADA2B7FD
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 02:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE7B3A7D43
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA655887;
	Fri,  7 Feb 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4XUPICL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153214F9FF;
	Fri,  7 Feb 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892342; cv=none; b=CXRqzydUvH8uieZrXm46KR+I2bfo1Zx0BAM70oNY8MWpyNzeAYZInGENPCv5hgzX2xVNaOzd78kzIW02TiAxXtj1chPulWlcjB8k0NbWkM30+3F+/ILSM+ozkWBfWkG8suq3p0/6CYlvpeLPbO0TK8P7nROSOKWTDvyyhGlbFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892342; c=relaxed/simple;
	bh=68BPILoUuezaQod5BOUNVEsEx7dJI6ICbrXeSODVu5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9c/mb3RJQYn0NRHfQnC7uVcpUZtsThRv3aIsDbQ4bNza6Z2XfSau9irlKE1X8kvqKVIF2iSkSn7NeTvAEL29YuTMTmVxPFNxSyd9d2aelZ8Rh4QhGn/RbtWwf8GvauAmJmY68XisFkVFWxFpR2tbVBZ70w9AdEZwGz/uX+63P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4XUPICL; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e17ab806bso948824a34.2;
        Thu, 06 Feb 2025 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738892340; x=1739497140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p3DsipidrAfiqFstFAXSWEOEmCQ8zXeBOu44QQBPG8=;
        b=M4XUPICL/I+dqhiig5573RJBTluoyxo/VlXpq/pNPhqjoTR4+ROmG5qecAfMJCZ1cU
         NqYOD3hMpz4nIw/836osIkz88szBLdXZQVPqiunB8JHTbD8z/O/AGmv/bhzlHbWd/Piw
         R4QF0YkUQXy0eztvqa8ewyl9C6o7dA/b8r3+Xx2jSx3RIAYnP3ALcO/UN8uH1cqtB3XT
         4FOfwbQorPN2swwUPNX+hy+T77xbns6nVg4hHSVEZhYczUyTUTk3hnpKQXTCmbjEPtpZ
         CygPKK705DsSnHobLjLtKCXXUfBlZPvClcwGeIC4GwL5mOd8pbMKJ8drpVUlReEJkveB
         PoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738892340; x=1739497140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p3DsipidrAfiqFstFAXSWEOEmCQ8zXeBOu44QQBPG8=;
        b=MITk6rK8zlcekJC35w3Ql4yEs8SNdggUDircku+glNkLFNdKD0NfxVueG1LExAgDl0
         XDRhFk14GnBBFrlgUsJ55Sfw3BJBQuVurJ7Mig+x7v9CSGV/0hmxKpxRQ7t6xsENoTPK
         Ju4cGcaREwoc2EF5izOIwXOwhXSvoThOr+7jrIMhisPTj4kxoMH35/h6pSFQLBEbfPmj
         JH4duMtywmWzSeeB3JZ1IKhBn0sx0P/GwgznjCPwvflX0v+rVtzX0QmJ/jk5MvCvCZ/C
         dYrQExpnHH4rg/KX9tcNfu62+ItLYVS899lP9AkGxgQdWztxnbivTcgAwOxwXTwF6qmJ
         FFzA==
X-Forwarded-Encrypted: i=1; AJvYcCUHeAc1w4EO+Q+sAQmNHGE0qsQ3T+TjbRdKj2zKKb6yg01+r6mFcJI1H8zo8Nbf7vcNgcGIjf7528Gq@vger.kernel.org, AJvYcCWkr6EjV+C8dvDHImy0N8kQ+aS6nBYMwbu3kDdJ5LcwuYSy4cR1PpuDMid8pebrekBskFGaMcsZ@vger.kernel.org, AJvYcCX/536FdTMzIy8CMVSNHlOu+13lC/9CXDYkrWE78aeAnfYB/tAzd1pv2HkJz+kafpsidXVyv0SpqZ27ih4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gn8wSiQVJXtjtyzno+4aS0UQ7e+IeP/pRxcA4JFUs4e4WUP9
	6APbaLaZ//m+iGZVfsi5+2+KoGXG0Ehhq2njZCeZrpW7W4gRag3FuYcQwm3ReQLb/CPM9ZxTU5l
	bXeL0TlM7hCUrhaDIrgKJVJTWSdk=
X-Gm-Gg: ASbGncur59ecdbz0r56QjzvLoCNg7N2Lc9ShI+USBWtEbClxzLCpdEkNtmuXEXtBMdR
	NpLEogsEt9wHhchzB/mMkrjIb8gI5uT8Kl28CLL5L47INc73UdIvn+fjK7rgSfn1fNs1uCHJD/3
	Y=
X-Google-Smtp-Source: AGHT+IEnOG8urI29uJrz8qhePp1oO1r4nTX/cLq4emr4pd/W10Cp5kXwDrAp2Ui0Tzlc1wNK/p5LJu6YaFuLw/U++iw=
X-Received: by 2002:a05:6830:650b:b0:71d:4ec6:8600 with SMTP id
 46e09a7af769-726b87f8949mr1206069a34.13.1738892339689; Thu, 06 Feb 2025
 17:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205053750.28251-1-ki.chiang65@gmail.com> <20250205053750.28251-2-ki.chiang65@gmail.com>
 <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com> <69eccfa6-5ca0-44d7-b6a8-2152260106e2@linux.intel.com>
In-Reply-To: <69eccfa6-5ca0-44d7-b6a8-2152260106e2@linux.intel.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Fri, 7 Feb 2025 09:38:48 +0800
X-Gm-Features: AWEUYZm-aGttocuG5-WfQRmkfk2cDHIFk1x4Ig3z2NcwOAx7pOYrHq8m_l7jRRI
Message-ID: <CAHN5xi29XwtnJx18-8md-CBRNaedq6yHGN7UkccmtpaHpjJLsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2025=E5=B9=B42=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:16=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 5.2.2025 16.17, Mathias Nyman wrote:
> > On 5.2.2025 7.37, Kuangyi Chiang wrote:
> >> Unplugging a USB3.0 webcam while streaming results in errors like this=
:
> >>
> >> [ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 18 comp_code 13
> >> [ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fd=
f8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 0000000=
02fdf8000 seg-end 000000002fdf8ff0
> >> [ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr =
not part of current TD ep_index 18 comp_code 13
> >> [ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fd=
f8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 0000000=
02fdf8000 seg-end 000000002fdf8ff0
> >>
> >> If an error is detected while processing the last TRB of an isoc TD,
> >> the Etron xHC generates two transfer events for the TRB where the
> >> error was detected. The first event can be any sort of error (like
> >> USB Transaction or Babble Detected, etc), and the final event is
> >> Success.
> >>
> >> The xHCI driver will handle the TD after the first event and remove it
> >> from its internal list, and then print an "Transfer event TRB DMA ptr
> >> not part of current TD" error message after the final event.
> >>
> >> Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
> >> transaction error mid TD.") is designed to address isoc transaction
> >> errors, but unfortunately it doesn't account for this scenario.
> >>
> >> To work around this by reusing the logic that handles isoc transaction
> >> errors, but continuing to wait for the final event when this condition
> >> occurs. Sometimes we see the Stopped event after an error mid TD, this
> >> is a normal event for a pending TD and we can think of it as the final
> >> event we are waiting for.
> >
> > Not giving back the TD when we get an event for the last TRB in the
> > TD sounds risky. With this change we assume all old and future ETRON ho=
sts
> > will trigger this additional spurious success event.
> >
> > I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case s=
een
> > with short transfers, and just silence the error message.
> >
> > Are there any other issues besides the error message seen?
> >
>
> Would something like this work: (untested, compiles)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 965bffce301e..81d45ddebace 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct xhc=
i_hcd *xhci, struct xhci_virt_
>          return 0;
>   }
>
> +static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
> +                                          struct xhci_ring *ring)
> +{
> +       switch(ring->last_td_comp_code) {
> +       case COMP_SHORT_PACKET:
> +               return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
> +       case COMP_USB_TRANSACTION_ERROR:
> +       case COMP_BABBLE_DETECTED_ERROR:
> +       case COMP_ISOCH_BUFFER_OVERRUN:
> +               return xhci->quirks & XHCI_ETRON_HOST &&
> +                       ring->type =3D=3D TYPE_ISOC;
> +       default:
> +               return false;
> +       }
> +}
> +
>   /*
>    * If this function returns an error condition, it means it got a Trans=
fer
>    * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
> @@ -2697,8 +2713,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>          case COMP_SUCCESS:
>                  if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) !=3D=
 0) {
>                          trb_comp_code =3D COMP_SHORT_PACKET;
> -                       xhci_dbg(xhci, "Successful completion on short TX=
 for slot %u ep %u with last td short %d\n",
> -                                slot_id, ep_index, ep_ring->last_td_was_=
short);
> +                       xhci_dbg(xhci, "Successful completion on short TX=
 for slot %u ep %u with last td comp code %d\n",
> +                                slot_id, ep_index, ep_ring->last_td_comp=
_code);
>                  }
>                  break;
>          case COMP_SHORT_PACKET:
> @@ -2846,7 +2862,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>                   */
>                  if (trb_comp_code !=3D COMP_STOPPED &&
>                      trb_comp_code !=3D COMP_STOPPED_LENGTH_INVALID &&
> -                   !ep_ring->last_td_was_short) {
> +                   !xhci_spurious_success_tx_event(xhci, ep_ring)) {
>                          xhci_warn(xhci, "Event TRB for slot %u ep %u wit=
h no TDs queued\n",
>                                    slot_id, ep_index);
>                  }
> @@ -2890,11 +2906,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>
>                          /*
>                           * Some hosts give a spurious success event afte=
r a short
> -                        * transfer. Ignore it.
> +                        * transfer or error on last TRB. Ignore it.
>                           */
> -                       if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
> -                           ep_ring->last_td_was_short) {
> -                               ep_ring->last_td_was_short =3D false;
> +                       if (xhci_spurious_success_tx_event(xhci, ep_ring)=
) {
> +                               ep_ring->last_td_comp_code =3D trb_comp_c=
ode;
>                                  return 0;
>                          }
>
> @@ -2922,10 +2937,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>           */
>          } while (ep->skip);
>
> -       if (trb_comp_code =3D=3D COMP_SHORT_PACKET)
> -               ep_ring->last_td_was_short =3D true;
> -       else
> -               ep_ring->last_td_was_short =3D false;
> +       ep_ring->last_td_comp_code =3D trb_comp_code;
>
>          ep_trb =3D &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep=
_trb)];
>          trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) =
ep_trb, ep_trb_dma);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 779b01dee068..acc8d3c7a199 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1371,7 +1371,7 @@ struct xhci_ring {
>          unsigned int            num_trbs_free; /* used only by xhci DbC =
*/
>          unsigned int            bounce_buf_len;
>          enum xhci_ring_type     type;
> -       bool                    last_td_was_short;
> +       u32                     last_td_comp_code;
>          struct radix_tree_root  *trb_address_map;
>   };
>

It looks better than my patch v2, I will test it later.

Thanks,
Kuangyi Chiang

