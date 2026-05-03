Return-Path: <stable+bounces-242636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCBmIfHC9mlsYQIAu9opvQ
	(envelope-from <stable+bounces-242636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 05:37:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A14B449C
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 05:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF977300B05B
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 03:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1D2D839C;
	Sun,  3 May 2026 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBkG/S+d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNrz04ET"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF024E4A8
	for <stable@vger.kernel.org>; Sun,  3 May 2026 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779404; cv=pass; b=LHlSbMrLs+v4MBnvkQ8Hi8N82FoVmoJeHt2T2FqC7igNU3FCRk7iyACZfuozmU0u/gNmqXtrAF2XI33P7rg8VLe3ssPZ8MPnxGhI/oDwpFvXHBHxOpgqSuMESMh7WfJGXD77zTd41AC/1o1Wq4BLd2ufDUY9/ln8WVVCZntfkhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779404; c=relaxed/simple;
	bh=tUydmwkNKViZy7RWTMXdSuRd5OkjMnnrGh50lyioA8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THQ08cRCkxLH60Clrt4wgQKHrSec19LBWm47hycr1ZnFeUAu3EXdesRwvxKZ1CeCnizloutcr/arMGJ6M8mpvVfLRHNI3RIUvpmlWe8pcz3/YEo0g/OHvkDImj1OKbpfbkNqe8s9wfotLHc4DmsNhxSAyw0RZ8asvCy4w+GXe00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBkG/S+d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNrz04ET; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777779401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0OWAJn8muYcHbaFRLc3IDvQHdIxLvENWnakgrL5hdI=;
	b=bBkG/S+dx6B64hak395LKasQNKEV+YxL4ZM7oJYFRK6Rbefd/8LS2BbqkJhv86Cktj5Lam
	JP8PjatvSQPaoCFAHPssIbuAVtN1GQHpdNW3bxCsNz4yF0Obc871Svl53Ij14E5NYv49Nh
	VLUU4swoU1f+WUagIDmi0wZL2d7iSxM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-O-FM3qSeNKuO_ImSK5WdIA-1; Sat, 02 May 2026 23:36:40 -0400
X-MC-Unique: O-FM3qSeNKuO_ImSK5WdIA-1
X-Mimecast-MFC-AGG-ID: O-FM3qSeNKuO_ImSK5WdIA_1777779399
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-696266291d6so4074338eaf.1
        for <stable@vger.kernel.org>; Sat, 02 May 2026 20:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777779399; cv=none;
        d=google.com; s=arc-20240605;
        b=WkS+qasYRW2qOOTmrC5X7XIcD2q8iEYR43dx1E+p7srhcb0pum1bLJfpiEXjBjB2Yu
         uqqsCHodJXf/4Bsowsv4OT6sRBYFvGSL9AsXULyvhQLD2R7lZrP65Q3Yk1drIElnJagB
         ilXYOG7gvm9ko1tF6RiwnhwsUxVph7zqtLzJ534BPTrwqtoP3VdPy4iIJwWcvNiqLtsD
         lGfp6RsYq3hr2GR/Kdu/nIMGudcvmOb0D5qwxQgeNtClqqH6hQTLFCfYtq0OwvUc2101
         zXeZDOGGZslAT4k3YVaY0ccoHNF36NkcojBYd08GQcWrl4yd37fg2ofq0Te7hoy2o6EC
         2EVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0OWAJn8muYcHbaFRLc3IDvQHdIxLvENWnakgrL5hdI=;
        fh=sUpdCm+bmSPxNgYJ+ltvA7JgCkJOnf9dAgJl3bdZmkY=;
        b=eZhLDhGooy1vSWfLNbClXxj8LqZPnuZN+BI58+vpRNmzzmb9/jcH3mrUzf7WGzOJ5K
         l2vjv3ozIjQN72BvhzSFuf6M+YKYikNtqvynWnje0eLbZgQQXNGNyTgBBIqkIzSlWgTw
         le0Z0wBkMV9msYUgoI1vB0PObi4wT+uWwL41f/0h9/ChPThpIrMFjIMCYf2sDN4Ldou2
         7NJGpf+L5+ZUQWI3ziv6t8hdB3MgcijeY6HBZlukiLJjURXL+EgjWXDA85YWhpS6Ji7r
         W7JdQGj5DOd5LpvWcJwIZ6TrQMHwyVIA05K6P7quZBJjCEiBjBSQsVFiUcMoiMEdcbUt
         xojg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777779399; x=1778384199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0OWAJn8muYcHbaFRLc3IDvQHdIxLvENWnakgrL5hdI=;
        b=FNrz04ETKSwVn2sLOSVxA+61+lBmKpipMuY9N2TAz1MhJNCuCzR8RBXce33PQKAyeK
         B96ZCh/nVLJYpZ9ytFt/nwaePduTEIkS4DFZxMi5XKiPUKqw5EUHsgYoiVeeslqDv0yQ
         idnk3NQ6Ev6/mi9iE5d4/GlLEfwGbH6xnSLEcKF9c6xcLifTnRlPpw9XhiGxjvgZ/i3z
         ZygPdv0sDC9rNnkyCWcIqN0vSmCtwZK3jgRbiluosp+SeKZZv9dFzHNnb1guxSUBjjXa
         88fOQSsL83ACD8sKo1kr8f6XfYh8uEy65OtGH/uG6G31DTSgU/vmkQvWRfhH6a37NRLJ
         ed6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777779399; x=1778384199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0OWAJn8muYcHbaFRLc3IDvQHdIxLvENWnakgrL5hdI=;
        b=XCnlEJYa9eQNNRAIbiqHRuJVbCdwyI3BudEnzdDQNqyTNK3m3urcRfVLKd55FnWp2Y
         mhXV+JWfthlPgYT1ku49By7r/CiXVyL5JvpUwog4MbUKeL+Fu2cVukdoKRQEkHKE0nzz
         bhjW6uMH8BqJG0RrkKtYhBZnIi38jTWDGs8xi6fqc9AdtniNMp+YOmZJMr3dmlSDsz4i
         cORvDzovawgav3CZVnOuiI6BCOkCNh+MrZT3UjiMvr65NTaHJk+I9fi1Ir8GYoEeVKlR
         KA+/NAMunn4OwwqsdPl1DVlWN4Wr2rQCtOol5OuAKCIAcvX/TYJsqn51n/3ArbbDVw2c
         vHOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1a5ZgGdgd/DhnfzOkHEmT3gNncF+itqaWlV06sOAmq05FQ2VpJEtMCjb0cj+RjQVCva6MRgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPv8pRvdRJOXEBxDNJaoNIRWnJwYUk4FnN5afLgb/SEUpo2ZlV
	L34ogzVnnSwstPGHJi4uGo/sqpB8S3LmpqBFgWdoYkhpFhum78vHK0w91My4oD83RpEGKz61WHW
	F/9yIwOqH7o1j/QOi9PZvxdU74euVhCSTZd89mWhzBhxPkzFP9g51RGp0TIFPOG+IBLfk5OCql5
	3U4p9kicIzPqFr3BXD3saXWnYsWvJnDXEg
X-Gm-Gg: AeBDiest4exhOv62HqqEovNwDza3W5WlLb2NelY1VtDEuiuDFtU3y61WF7gQCJWEJxn
	F6YlFNac+9awZByKlsYHm4l5cwd8x4hNbN2nsOdgPpDGlTF0STktSMNTOrBocuhsb/KLhgMFANN
	8gOzaM/c6goryRwHe325ytCCME5MUXgyiuH+rxAJ2RTXY+IVtcWoc3vVqE9o0mrhr159Kc6eNUy
	jb7+wTziqZYKWphfWI/aIgxb2fhMhOVuRfGv6eZ04MV2XSm
X-Received: by 2002:a05:6820:81c9:b0:696:637e:4820 with SMTP id 006d021491bc7-696979f55d3mr2541000eaf.27.1777779398938;
        Sat, 02 May 2026 20:36:38 -0700 (PDT)
X-Received: by 2002:a05:6820:81c9:b0:696:637e:4820 with SMTP id
 006d021491bc7-696979f55d3mr2540994eaf.27.1777779398545; Sat, 02 May 2026
 20:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <20260430104850.352bd946.michal.pecio@gmail.com>
 <CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
 <20260430235453.2288c973.michal.pecio@gmail.com> <CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
 <20260502114644.76e6b5a3.michal.pecio@gmail.com> <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
 <20260502235517.089ba5bf.michal.pecio@gmail.com>
In-Reply-To: <20260502235517.089ba5bf.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Sun, 3 May 2026 00:36:27 -0300
X-Gm-Features: AVHnY4JrHk59WE05_dg9TKwGgt1QjyIQVcj0PtqyhuDEWMRv0JtTFXsQeGGmvRs
Message-ID: <CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0E4A14B449C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242636-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[desnesn@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hello Michal,

On Sat, May 2, 2026 at 6:55=E2=80=AFPM Michal Pecio <michal.pecio@gmail.com=
> wrote:
>
> On Sat, 2 May 2026 08:38:34 -0300, Desnes Nunes wrote:
> > > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-rin=
g.c
> > > index e5823650850a..3041deb67b57 100644
> > > --- a/drivers/usb/host/xhci-ring.c
> > > +++ b/drivers/usb/host/xhci-ring.c
> > > @@ -1761,13 +1761,15 @@ void xhci_handle_command_timeout(struct work_=
struct *work)
> > >         /* mark this command to be cancelled */
> > >         xhci->current_cmd->status =3D COMP_COMMAND_ABORTED;
> > >
> > > -       /* Make sure command ring is running before aborting it */
> > > +       /* check for crashed or disconnected chip */
> > >         hw_ring_state =3D xhci_read_64(xhci, &xhci->op_regs->cmd_ring=
);
> > > -       if (hw_ring_state =3D=3D ~(u64)0) {
> > > +       if (hw_ring_state =3D=3D ~(u64)0 || usbsts & (STS_FATAL | STS=
_HCE)) {
> > > +               xhci_info(xhci, "kill the damn thing\n");
> > >                 xhci_hc_died(xhci);
> > >                 goto time_out_completed;
> > >         }
> > >
> > > +       /* Make sure command ring is running before aborting it */
> > >         if ((xhci->cmd_ring_state & CMD_RING_STATE_RUNNING) &&
> > >             (hw_ring_state & CMD_RING_RUNNING))  {
> > >                 /* Prevent new doorbell, and start command abort */
> >
> > FYI, sorry to be the bearer of bad news, but this also panics the
> > system as soon as I run `echo c > /proc/sysrq-trigger`.
>
> Is this not what's supposed to happen?
>
> Sorry, that complaint is so odd that I thought I'm seeing another case
> of debugging being outsourced to an AI chatbot, which forgot that panic
> is triggered intentionally here. Now I'm just confused.

No, guess you actually saw a case of poor explanation on my end -
apologies for not explaining the outcome properly.

What I tried poorly to explain was that the system simply hanged after
I intentionally triggered the panic with a sysrq - both times.
Nothing happens after the sysrq panic stack trace.

> > Kdump doesn't run and no vmcore is produced:
> Is the kdump kernel not launched, or does it crash during boot?
> The latter would make sense if there is some problem with the code.

Kdump kernel didn't launch at all, thus no vmcore was produced.

> But I don't understand how patching xhci-hcd could possibly have
> any effect on the former. Does this new code execute at all? Does
> "kill the damn thing" ever appear in dmesg?

Both kernels booted normally: the first one checking HSE after USBSTS
was logged on xhci_handle_command_timeout(), as well as this new code
checking for ring state or the HSE and HCE bits.
Since kdump didn't start, the message "kill the damn thing" never got
a chance to appear on crashkernel's dmesg.

Best Regards,

Desnes


