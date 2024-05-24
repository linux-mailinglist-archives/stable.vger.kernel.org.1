Return-Path: <stable+bounces-46065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1638CE66B
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 15:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEBC1C21378
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233E12C461;
	Fri, 24 May 2024 13:54:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6739FF4;
	Fri, 24 May 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558876; cv=none; b=BqsDr6sDyohNweWv0snzVgpDHtq2wts5x+dxojnkRyDjAd6GNxE3mBExDtxPm0HXJtfwUxOCDHNUDRDRQhn9rNVk2nob3aF79TuJjniQNJhkxuF6YyVFmllAYGj6DlF9Whzn7HMizA3aX+N8yf+Al/8hjflLiAW7k4jwFcvRVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558876; c=relaxed/simple;
	bh=eAOPnFbyPbt4b7dZDxAMimYBECW1SJUYOjLmWeeLflc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0K1HfGGEN2fkgEDaUswUclMAO2LutmcgqvP+CWFzUa8fz8kcUoPBRkPa7XJZBpAxVTvl+E64qunlKAc6czxpcuPQk9TaBUkrilDWZKPu2QivTqMBNKnehPbC+n+wV5+s0s+eUsB6xJXJyyEx5u+Ne9ZK6MNlvrLAcuMbd5WKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so818124366b.2;
        Fri, 24 May 2024 06:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558873; x=1717163673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtIiG4+dY4ijuoTv6o6TaHGyoLw5cDgUvbJqBk9VGYo=;
        b=nkho6x+co/BwYDkCbY9KREKSBfol4XzRUniAM+6NFlZW26wsUUxQtCPy6vwdO5YOhc
         +ab3kW6nDmmFndLQw8QxzgGZ2VlwThlcHwysL00NpU4a5U7QoxekSwnRf1LkVQm7YMyk
         WEPNvLrOVlPmoFvKVDPEd/eBBB3s8r4HD8U7nFt7J+M4nhJMLigiFPBVRiirTUyqYSNL
         sAL23fi4FOlN3icaH79DynSgJA2Yrxdw+nol3O+9KmSMHeu1lnYrvJAC1VkE9xfnrCS8
         XDlHScAgosg9V73AcVYavRfeOyk8LDzF2pCIUd+4ekE20K4a/EU+6vN5S8fx6W6Si+g0
         8aoA==
X-Forwarded-Encrypted: i=1; AJvYcCXTnTpoEcI/HhTQmJ/sFEhcgr71Fzf0bn29C6mN4IHJOZVTqeDDnQBPe4t7ZtvGwRPYfhO+ZiLrRlDbm5rFANKkFDZT7w9CEKo0hTK30sEvuagVGgUQY3HwE5CFTS/u52nP4S8w9LDZt0bIgGsXyFZgq6hxhEBnFCv/Ffpdzs/e
X-Gm-Message-State: AOJu0YwPnWpfq/EXtpQ0YN49BubUj9FNbnjJzL28GvpFuZ7bfTyJIilL
	FtapmtX6b5SLk7p+Ey+cdGiZmZ+CiPj0TAkvK9rY8j34Q1BvtI06ZU4LWuNX
X-Google-Smtp-Source: AGHT+IGRu9Vh+Y889fwFeYdjoJhpHCTs6pmBAcVwnozz/2DXDsbes93GufuAD/lIwvsmPxrL40r2LQ==
X-Received: by 2002:a17:906:c002:b0:a59:cbb5:e09f with SMTP id a640c23a62f3a-a6264f10776mr153578866b.53.1716558872503;
        Fri, 24 May 2024 06:54:32 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c287sm134358966b.162.2024.05.24.06.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 06:54:32 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5785c1e7448so693028a12.2;
        Fri, 24 May 2024 06:54:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDDQwOgt0V2T2gD0btkBt3hsWIo2XpH0G1wUB7CFAiBI1r/xWp6Tgo1sSXJXXMqQSF/iSPye5tZyDqFDMbsreWxcZv2LoCLQHeX56C0PEAOwooUguBY2nvI6PZGgkyUCNjHxUCEglHEH9gEJdrAeX+GAN2OMLO8HfGoR51urWQ
X-Received: by 2002:a17:906:27cc:b0:a5a:3579:b908 with SMTP id
 a640c23a62f3a-a62643eb6abmr151973466b.38.1716558871847; Fri, 24 May 2024
 06:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-xhci-streams-v1-1-6b1f13819bea@marcan.st>
In-Reply-To: <20240524-xhci-streams-v1-1-6b1f13819bea@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 24 May 2024 09:53:54 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-O=MU2DHobGcRy_5YvWkvA0f7JJbZ4PuZd4oC_ofrE4Q@mail.gmail.com>
Message-ID: <CAEg-Je-O=MU2DHobGcRy_5YvWkvA0f7JJbZ4PuZd4oC_ofrE4Q@mail.gmail.com>
Subject: Re: [PATCH] xhci: Handle TD clearing for multiple streams case
To: Hector Martin <marcan@marcan.st>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:28=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> When multiple streams are in use, multiple TDs might be in flight when
> an endpoint is stopped. We need to issue a Set TR Dequeue Pointer for
> each, to ensure everything is reset properly and the caches cleared.
> Change the logic so that any N>1 TDs found active for different streams
> are deferred until after the first one is processed, calling
> xhci_invalidate_cancelled_tds() again from xhci_handle_cmd_set_deq() to
> queue another command until we are done with all of them. Also change
> the error/"should never happen" paths to ensure we at least clear any
> affected TDs, even if we can't issue a command to clear the hardware
> cache, and complain loudly with an xhci_warn() if this ever happens.
>
> This problem case dates back to commit e9df17eb1408 ("USB: xhci: Correct
> assumptions about number of rings per endpoint.") early on in the XHCI
> driver's life, when stream support was first added. At that point, this
> condition would cause TDs to not be given back at all, causing hanging
> transfers - but no security bug. It was then identified but not fixed
> nor made into a warning in commit 674f8438c121 ("xhci: split handling
> halted endpoints into two steps"), which added a FIXME comment for the
> problem case (without materially changing the behavior as far as I can
> tell, though the new logic made the problem more obvious).
>
> Then later, in commit 94f339147fc3 ("xhci: Fix failure to give back some
> cached cancelled URBs."), it was acknowledged again. This commit was
> unfortunately not reviewed at all, as it was authored by the maintainer
> directly. Had it been, perhaps a second set of eyes would've noticed
> that it does not fix the bug, but rather just makes it (much) worse.
> It turns the "transfers hang" bug into a "random memory corruption" bug,
> by blindly marking TDs as complete without actually clearing them at all
> nor moving the dequeue pointer past them, which means they aren't actuall=
y
> complete, and the xHC will try to transfer data to/from them when the
> endpoint resumes, now to freed memory buffers.
>
> This could have been a legitimate oversight, but apparently the commit
> author was aware of the problem (yet still chose to submit it): It was
> still mentioned as a FIXME, an xhci_dbg() was added to log the problem
> condition, and the remaining issue was mentioned in the commit
> description. The choice of making the log type xhci_dbg() for what is,
> at this point, a completely unhandled and known broken condition is
> puzzling and unfortunate, as it guarantees that no actual users would
> see the log in production, thereby making it nigh undebuggable (indeed,
> even if you turn on DEBUG, the message doesn't really hint at there
> being a problem at all).
>
> It took me *months* of random xHC crashes to finally find a reliable
> repro and be able to do a deep dive debug session, which could all have
> been avoided had this unhandled, broken condition been actually reported
> with a warning, as it should have been as a bug intentionally left in
> unfixed (never mind that it shouldn't have been left in at all).
>
> > Another fix to solve clearing the caches of all stream rings with
> > cancelled TDs is needed, but not as urgent.
>
> 3 years after that statement and 14 years after the original bug was
> introduced, I think it's finally time to fix it. And maybe next time
> let's not leave bugs unfixed (that are actually worse than the original
> bug), and let's actually get people to review kernel commits please.
>
> Fixes xHC crashes and IOMMU faults with UAS devices when handling
> errors/faults. Easiest repro is to use `hdparm` to mark an early sector
> (e.g. 1024) on a disk as bad, then `cat /dev/sdX > /dev/null` in a loop.
> At least in the case of JMicron controllers, the read errors end up
> having to cancel two TDs (for two queued requests to different streams)
> and the one that didn't get cleared properly ends up faulting the xHC
> entirely when it tries to access DMA pages that have since been unmapped,
> referred to by the stale TDs. This normally happens quickly (after two
> or three loops). After this fix, I left the `cat` in a loop running
> overnight and experienced no xHC failures, with all read errors
> recovered properly. Repro'd and tested on an Apple M1 Mac Mini
> (dwc3 host).
>
> On systems without an IOMMU, this bug would instead silently corrupt
> freed memory, making this a security bug (even on systems with IOMMUs
> this could silently corrupt memory belonging to other USB devices on the
> same controller, so it's still a security bug). Given that the kernel
> autoprobes partition tables, I'm pretty sure a malicious USB device
> pretending to be a UAS device and reporting an error with the right
> timing could deliberately trigger a UAF and write to freed memory, with
> no user action.
>
> Fixes: e9df17eb1408 ("USB: xhci: Correct assumptions about number of ring=
s per endpoint.")
> Fixes: 94f339147fc3 ("xhci: Fix failure to give back some cached cancelle=
d URBs.")
> Fixes: 674f8438c121 ("xhci: split handling halted endpoints into two step=
s")
> Cc: stable@vger.kernel.org
> Cc: security@kernel.org
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/usb/host/xhci-ring.c | 54 +++++++++++++++++++++++++++++++++++---=
------
>  drivers/usb/host/xhci.h      |  1 +
>  2 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 575f0fd9c9f1..9c06502be098 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1034,13 +1034,27 @@ static int xhci_invalidate_cancelled_tds(struct x=
hci_virt_ep *ep)
>                                 break;
>                         case TD_DIRTY: /* TD is cached, clear it */
>                         case TD_HALTED:
> +                       case TD_CLEARING_CACHE_DEFERRED:
> +                               if (cached_td) {
> +                                       if (cached_td->urb->stream_id !=
=3D td->urb->stream_id) {
> +                                               /* Multiple streams case,=
 defer move dq */
> +                                               xhci_dbg(xhci,
> +                                                        "Move dq deferre=
d: stream %u URB %p\n",
> +                                                        td->urb->stream_=
id, td->urb);
> +                                               td->cancel_status =3D TD_=
CLEARING_CACHE_DEFERRED;
> +                                               break;
> +                                       }
> +
> +                                       /* Should never happen, at least =
try to clear the TD if it does */
> +                                       xhci_warn(xhci,
> +                                                 "Found multiple active =
URBs %p and %p in stream %u?\n",
> +                                                 td->urb, cached_td->urb=
,
> +                                                 td->urb->stream_id);
> +                                       td_to_noop(xhci, ring, cached_td,=
 false);
> +                                       cached_td->cancel_status =3D TD_C=
LEARED;
> +                               }
> +
>                                 td->cancel_status =3D TD_CLEARING_CACHE;
> -                               if (cached_td)
> -                                       /* FIXME  stream case, several st=
opped rings */
> -                                       xhci_dbg(xhci,
> -                                                "Move dq past stream %u =
URB %p instead of stream %u URB %p\n",
> -                                                td->urb->stream_id, td->=
urb,
> -                                                cached_td->urb->stream_i=
d, cached_td->urb);
>                                 cached_td =3D td;
>                                 break;
>                         }
> @@ -1060,10 +1074,16 @@ static int xhci_invalidate_cancelled_tds(struct x=
hci_virt_ep *ep)
>         if (err) {
>                 /* Failed to move past cached td, just set cached TDs to =
no-op */
>                 list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_li=
st, cancelled_td_list) {
> -                       if (td->cancel_status !=3D TD_CLEARING_CACHE)
> +                       /*
> +                        * Deferred TDs need to have the deq pointer set =
after the above command
> +                        * completes, so if that failed we just give up o=
n all of them (and
> +                        * complain loudly since this could cause issues =
due to caching).
> +                        */
> +                       if (td->cancel_status !=3D TD_CLEARING_CACHE &&
> +                           td->cancel_status !=3D TD_CLEARING_CACHE_DEFE=
RRED)
>                                 continue;
> -                       xhci_dbg(xhci, "Failed to clear cancelled cached =
URB %p, mark clear anyway\n",
> -                                td->urb);
> +                       xhci_warn(xhci, "Failed to clear cancelled cached=
 URB %p, mark clear anyway\n",
> +                                 td->urb);
>                         td_to_noop(xhci, ring, td, false);
>                         td->cancel_status =3D TD_CLEARED;
>                 }
> @@ -1350,6 +1370,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd=
 *xhci, int slot_id,
>         struct xhci_ep_ctx *ep_ctx;
>         struct xhci_slot_ctx *slot_ctx;
>         struct xhci_td *td, *tmp_td;
> +       bool deferred =3D false;
>
>         ep_index =3D TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
>         stream_id =3D TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2])=
);
> @@ -1436,6 +1457,8 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd=
 *xhci, int slot_id,
>                         xhci_dbg(ep->xhci, "%s: Giveback cancelled URB %p=
 TD\n",
>                                  __func__, td->urb);
>                         xhci_td_cleanup(ep->xhci, td, ep_ring, td->status=
);
> +               } else if (td->cancel_status =3D=3D TD_CLEARING_CACHE_DEF=
ERRED) {
> +                       deferred =3D true;
>                 } else {
>                         xhci_dbg(ep->xhci, "%s: Keep cancelled URB %p TD =
as cancel_status is %d\n",
>                                  __func__, td->urb, td->cancel_status);
> @@ -1445,8 +1468,17 @@ static void xhci_handle_cmd_set_deq(struct xhci_hc=
d *xhci, int slot_id,
>         ep->ep_state &=3D ~SET_DEQ_PENDING;
>         ep->queued_deq_seg =3D NULL;
>         ep->queued_deq_ptr =3D NULL;
> -       /* Restart any rings with pending URBs */
> -       ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
> +
> +       if (deferred) {
> +               /* We have more streams to clear */
> +               xhci_dbg(ep->xhci, "%s: Pending TDs to clear, continuing =
with invalidation\n",
> +                        __func__);
> +               xhci_invalidate_cancelled_tds(ep);
> +       } else {
> +               /* Restart any rings with pending URBs */
> +               xhci_dbg(ep->xhci, "%s: All TDs cleared, ring doorbell\n"=
, __func__);
> +               ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
> +       }
>  }
>
>  static void xhci_handle_cmd_reset_ep(struct xhci_hcd *xhci, int slot_id,
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 6f4bf98a6282..aa4379bdb90c 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1276,6 +1276,7 @@ enum xhci_cancelled_td_status {
>         TD_DIRTY =3D 0,
>         TD_HALTED,
>         TD_CLEARING_CACHE,
> +       TD_CLEARING_CACHE_DEFERRED,
>         TD_CLEARED,
>  };
>
>
> ---
> base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> change-id: 20240524-xhci-streams-124e88db52e6
>

Intense story, relatively simple fix. :)

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

