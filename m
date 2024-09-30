Return-Path: <stable+bounces-78293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B098AAB2
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14101C22728
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5D194C8D;
	Mon, 30 Sep 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bVLwvLJ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384F19047D
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716241; cv=none; b=nj9YlY6d4naON+bPcUICjYvTFnOMA1Red3+gFaZPG1PhfleBeF1kOqI4Wlx4pCaRxsCqjZ+AML3x1sEDpU7gG/vDIFOIFwst4/Z2W/tQU1wZvfW84HhkGavumb5PjOgW4okEYtfAc3gJ59VIhDEthC9BkeyGBLEOPbMzT6mvwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716241; c=relaxed/simple;
	bh=s7FNAQFbBAthLoApr+2jTtWNsoIAuGqUKUhpyn374dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8lBWxKgvzN3MK3W1xH77HV7rBx/rkpkOkcDhyP4nQ0M+R7G9VCHcfLafK7I+pUUS+gMCpUXeLi9apAusNrAz80ffXug51MdMJO33waX22uQApXY+ndbdCHzjxhSTHCv8D/Jd/c5sHzNhs9ARtvOlmGcUzlOoJNUY+ThSmkGCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bVLwvLJ9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539983beb19so1134174e87.3
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727716238; x=1728321038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HUGg1CTEChxy2W6Uha9F8JUl/6sw3gvRQr0bLe2rA0=;
        b=bVLwvLJ9lJ1rAGNV+FBq4Gncu56WtKTLoLURr+7bjobY4aNaQi0r1UadOkmWwUjvVY
         nrIr41G2NU6ibl0T9nm5wKG3OXJWe+j3Vlmo8kWPGmdqtrhHA4kzy9w+3+Ht5JyLushv
         2KW1XXToM/OZPmAU9TDSStiPFHijg/ys5t6gfjAw2WNqsFZ3SM1uHcNrv5sVD4HkufAD
         ivejRA9f9fZva01KAlRPD3qt4RS5id187SqdhWSH60du4pKRRwzu3pA580LLOMlq12yp
         UFZhzsGEAwiKDEPilC3ex11Im18vXM62pINJPFiIfVoVvGLXxU98cfGZYHkKbIQLKwXK
         +IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716238; x=1728321038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HUGg1CTEChxy2W6Uha9F8JUl/6sw3gvRQr0bLe2rA0=;
        b=Wx4SH76HXdHrGMtEVzFcrYJzHS8L+2X1Cvo4187fNKllDLIluDVWsnlk1VoIEAcVCZ
         pxuEIakYDWjv7UCoUc8rxs/LSmkEsthdTPoOUpHN3mi0gMibkq+ym3sDuHAi38FHx8Pj
         WttNy8l22UjtMUri2ckikYlo+r762s2onWZq3MnH2TH2uDM6sSHk9EMlgi3Z81ANoGug
         IfSny4KTgX5tB5MeEqt46Y2+22ZI3+uJt4i2tus1Fl7Wpo+fjExUmNtSewSYg/QJZ952
         /PBuL8hHhGURM89XeX0gZCsXsZ8wIa6Nzw8fa5478y+LiNPLOU36A5tNwXHxXD55n6vK
         Lajg==
X-Forwarded-Encrypted: i=1; AJvYcCWIttSFcnTFmp2//FSR7yqDJeLxDI01rcU0kt+Hp1jA4Yrw+9sQMSHToQmsNEmlrqyhxlTeJTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67Aay6taV98LbCK+4Gff1tUePuKmxveS1GffwatDWfyDHmmgo
	S6DHKrLaDMo+ezQ4ZaMC41remFIywNHqzxN31bSlPhyJx0Z/tZ1yezDREBCMnVqR55WxzIsErhr
	zKzraFp8tPneuwM2SxBlWHaqFcmzvWRNSK+ZcRA==
X-Google-Smtp-Source: AGHT+IHOSuOAJH6wyb2l648qZhJgADHag9eUy/aU/ZZoi4ZM1MmnH1uTOVdKqzges4Kca6V/NstLLZC85VGvpIaT4Jc=
X-Received: by 2002:a05:6512:1254:b0:539:93b2:1373 with SMTP id
 2adb3069b0e04-53993b215a8mr2363588e87.20.1727716237610; Mon, 30 Sep 2024
 10:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930132517.70837-1-mwilck@suse.com>
In-Reply-To: <20240930132517.70837-1-mwilck@suse.com>
From: Lee Duncan <lduncan@suse.com>
Date: Mon, 30 Sep 2024 10:10:26 -0700
Message-ID: <CAPj3X_WmGTAm4=K6tYR6CTyn+GJiaFOXcKw68YdOff77Rnzz4g@mail.gmail.com>
Subject: Re: [PATCH] scsi: fnic: move flush_work initialization out of if block
To: Martin Wilck <martin.wilck@suse.com>
Cc: Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>, 
	Karan Tilak Kumar <kartilak@cisco.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	James Bottomley <jejb@linux.vnet.ibm.com>, Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.de>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:25=E2=80=AFAM Martin Wilck <martin.wilck@suse.com=
> wrote:
>
> After commit 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a wo=
rk
> queue"), it can happen that a work item is sent to an uninitialized work
> queue.  This may has the effect that the item being queued is never
> actually queued, and any further actions depending on it will not proceed=
.
>
> The following warning is observed while the fnic driver is loaded:
>
> kernel: WARNING: CPU: 11 PID: 0 at ../kernel/workqueue.c:1524 __queue_wor=
k+0x373/0x410
> kernel:  <IRQ>
> kernel:  queue_work_on+0x3a/0x50
> kernel:  fnic_wq_copy_cmpl_handler+0x54a/0x730 [fnic 62fbff0c42e7fb825c60=
a55cde2fb91facb2ed24]
> kernel:  fnic_isr_msix_wq_copy+0x2d/0x60 [fnic 62fbff0c42e7fb825c60a55cde=
2fb91facb2ed24]
> kernel:  __handle_irq_event_percpu+0x36/0x1a0
> kernel:  handle_irq_event_percpu+0x30/0x70
> kernel:  handle_irq_event+0x34/0x60
> kernel:  handle_edge_irq+0x7e/0x1a0
> kernel:  __common_interrupt+0x3b/0xb0
> kernel:  common_interrupt+0x58/0xa0
> kernel:  </IRQ>
>
> It has been observed that this may break the rediscovery of fibre channel
> devices after a temporary fabric failure.
>
> This patch fixes it by moving the work queue initialization out of
> an if block in fnic_probe().
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
>
> Fixes: 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a work que=
ue")
> Cc: stable@vger.kernel.org
> ---
>  drivers/scsi/fnic/fnic_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.=
c
> index 0044717d4486..adec0df24bc4 100644
> --- a/drivers/scsi/fnic/fnic_main.c
> +++ b/drivers/scsi/fnic/fnic_main.c
> @@ -830,7 +830,6 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>                 spin_lock_init(&fnic->vlans_lock);
>                 INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
>                 INIT_WORK(&fnic->event_work, fnic_handle_event);
> -               INIT_WORK(&fnic->flush_work, fnic_flush_tx);
>                 skb_queue_head_init(&fnic->fip_frame_queue);
>                 INIT_LIST_HEAD(&fnic->evlist);
>                 INIT_LIST_HEAD(&fnic->vlans);
> @@ -948,6 +947,7 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>
>         INIT_WORK(&fnic->link_work, fnic_handle_link);
>         INIT_WORK(&fnic->frame_work, fnic_handle_frame);
> +       INIT_WORK(&fnic->flush_work, fnic_flush_tx);
>         skb_queue_head_init(&fnic->frame_queue);
>         skb_queue_head_init(&fnic->tx_queue);
>
> --
> 2.46.1
>

Reviewed-by: Lee Duncan <lduncan@suse.com>

