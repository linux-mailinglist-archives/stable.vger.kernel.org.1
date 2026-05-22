Return-Path: <stable+bounces-253815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDLeKs2CEGoHYgYAu9opvQ
	(envelope-from <stable+bounces-253815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:22:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F75B7875
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1C57300A313
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EA35CB89;
	Fri, 22 May 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcRC9yO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593D356765
	for <stable@vger.kernel.org>; Fri, 22 May 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466955; cv=pass; b=Wt5+kQ5NDaJdCPELOlwX3kdO3k2IhE4O7bG8GDSCPeEGyJCV1Hic8jh6+a56BPHb3d29AtY9rm9CyxkE1MgGytVkutdu2w8yDdu4HwjOEbiIFZOixsXPeZY9D6Si7Nn8IygBMUkXUyRH29BAuchUhoYmA5bq76SYUwFO2e2EV2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466955; c=relaxed/simple;
	bh=nxDL5wbIW5pkhBBgQjLoIFOrjNVlK9PS1v0vc3/+klM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trfcQUytTIAyxav0jOaRj+rDxKugtWSDDyH34uqTg8kV9H3P15XXA9qhU3eP4OiORFicqu2/0e7cBMCRNEXEptftkSpfO7XBz7B50D+NcUOxN5bbD2Tt4r+1cdLYFcY2FC7YynLT/Rkx0iS/vcemPZecmJnCVRPjg6T8VghPoIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcRC9yO8; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so8030848d50.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 09:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779466952; cv=none;
        d=google.com; s=arc-20240605;
        b=WA+ubZosCZA3qN7I6o6LDn7DJqv0KDUgKun1zcg3+7PxIDu1ZhOS8ki6NGslS8OqsL
         +dP7NDQ6/2vjg1xLvQko8nMVAewvnynACZF7bZdj30/FE7XkIVHV0EGwqIPqhFNF3mS5
         LG5b+8ExcT6iX0u5UVFoyHv5CO6aplc5YEr2LvMvhFFyDFXa/JCeap83b5xjTMZS6f6H
         6e94aGdUsBfmcllV8cCUyEkzTy8JaTAMeSCIU0LvOQvpYEMvS0HSiv8OreqgOThcAo3B
         33Bbg5EhQ98IyERra5+si9JzSSsY+S1P2DvQC10naXqOwwrN3hXX3TRsCOzt75DmPuiv
         wIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vimbPXonM0vzfVvoUxK3iQItdTAAHoqaETC2qpf4r48=;
        fh=q3e3jVgTJU/JBSj3yl58az5z8ykpWPPdI+ho8OHvjhA=;
        b=Dcz/jV5CgTRPfVeXmyzyrjXvFHN7cN1bQ20suW7TOM2NnrPLJDE/Tp2OfND9Y1QIa8
         fA/oiYYRsntGQtW+lbD0Cu8NaksylBt3MY2lFMWgtYslS4JmbX/eKy+YdyFiLoZnHJf+
         U7rqdThwijBQzUkwk88s0pDkQQdg5A2+h0lpIIw0vw4hEoUdTsPUSin2xa9Ukv8U6eLy
         +t8UgvTd/rPfwWtUcg+FtLPOss3ANRI0d3N78rsiPlhDXuiKN7FXgzP1BpafyUSCPQl2
         BV+hbis0jLkqoRJghslnpjNCQb7abBUY6AoZ44FzcI8J1SZFGWIyA2K9l/W0zMxPEtnh
         eUEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779466952; x=1780071752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vimbPXonM0vzfVvoUxK3iQItdTAAHoqaETC2qpf4r48=;
        b=WcRC9yO8MfwgMcr8gL/GJ662vWIJtrsLWM9Az6xWycu4oLhECy2p88ldJqlRgVQP9r
         zbLg+Xuq7rhwXutbL2ve2uM/QY3nLCoZ+Wf/sZ97TInnf+1SdpKvPETww5tl5AXlQB1i
         OjwS8iWuvOFj1eqEqdE5sbeCvL+rZjWPyzytNpXKqu1aBnxXW0Y2w4E0RvDYpxnWjAgl
         NiFAgR7dg1anAu+Jk6/X389XP2vTop+SFnbhMGCpYesc4Bo7anMBxIXRItLOytg/FQ8K
         4bZJh/fb6Hx7VbVpFGpbiDe2CwKlKU2pKa6Tx0XXj0EeYXpxVy2un1mucme7XZzpNEr8
         G8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466952; x=1780071752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vimbPXonM0vzfVvoUxK3iQItdTAAHoqaETC2qpf4r48=;
        b=JkVoyuXQffq4cv5ECCvAWDSaR2/aubCWoQgZ03BcSRvAVdrQY9FlVwzZzoujnXXnDz
         U6Y7tP9isT95Vi1dbroz7LGOtZOvP5+lDaXvIpmAvxFHMogIQ3dJZXBSykAj3PfMO9w1
         y5NDOZEf180dWAjrNIhGmHNWpiwDigZ5ZxezoRjS1OHx94p5xJzZ3OFRo5+FoXtKBo6O
         W9scG7NGBeklEYMxE+A+mehu5Cmp1eXhzJ27R/z3jo1JCVXdD0x9pCdvxjmhlM4VVF3X
         ZsVVz8InKESZDnpVTDYkIgPJEPNthz2rGV468n+AYC63yMG9uSM8dZPliG1SFPz5mrX6
         xvrw==
X-Forwarded-Encrypted: i=1; AFNElJ/8ZTBeyPIh9sbJlwkA3g8hXnv5U7igVoSnicYHrn09kHG86cHFItgzjEA53kRzy0fL8wT0GS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNANu1TE0/Lfce7p57H6dEyYCvWlTBgT2PfJo81I7n+EH2jSsJ
	VcBXj97qdueVhfSKdKMPu9uDFT3crh3McigTI3BJFBdU26yH1OmXrKZsbGs1OigqJR5gtiduSjk
	iWOcmv5xKvA6us4GOeles6VXmrpca1hw=
X-Gm-Gg: Acq92OF92OBpoBOw/dwp1rMXAh+QrpZ56RXgHSac/EmcJQc0/MVlcgdc6V+KCGvnOMQ
	tVk00gxAvk+KLkuVRZK3Vnge/clEKapu0sqyPiDMUvvuO1EJgeY0r7f/16XwyPUgvzVXqieoTpa
	N9cpERtu/jJQKSz01bNHeIHN+UDDYYz+fGGIJS8xRWzKWunW8q5W84MZjXZjnQ38eyEkjx258LR
	v6tEPcSWIxyjGcnqil5ck5gPniIQ8+QBg5CmxDPBj1xhhQIcTK8JxRPasOcm+g8fiOs3gYGx/4W
	QYmP+cTOoRHesbuanrp86jzCVpoF3PKM/B/1BwOm20KqEJtr+IT/BeYYRk5r/1Svh8U=
X-Received: by 2002:a05:690e:2505:10b0:65c:2360:dfc8 with SMTP id
 956f58d0204a3-65ec97cb46emr3504100d50.19.1779466952292; Fri, 22 May 2026
 09:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com> <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
In-Reply-To: <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 22 May 2026 12:22:21 -0400
X-Gm-Features: AVHnY4Inv2WF9EZ8468g95mfpM_6fOpWwRbf-9-010PGY44gyz3kDqoT-LBJp3U
Message-ID: <CABBYNZLQ5m-24twTZaHXzi6QHqgGdvuDt1aaYwbEi0Vt=R2Dfw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253815-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mpg.de:email,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 561F75B7875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul,

On Fri, May 22, 2026 at 10:50=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Shuai,
>
>
> Thank you for your patch. Please mention the delay in the summary/title.
> Maybe:
>
> Use 100 ms SSR delay for rampatch and NVM loading
>
> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
> > When bt_en is pulled high by hardware, the host does not re-download
> > the firmware after SSR. The controller loads the rampatch and NVM
> > internally.
> >
> > On HMT chip, due to the large firmware file size, the
>
> Please document the size (> X MB)
>
> > loading process takes approximately 70ms. The previous 50ms delay is
> > too short, causing the controller to not respond to the reset command
> > sent by the host, which leads to BT initialization failure.
>
> Maybe paste the log?
>
> > Increase the delay to 100ms to ensure the controller has finished
> > loading the firmware before the host sends commands.
>
> Why can=E2=80=99t it be increased to 1 s?

Why would increasing it to 1s be a good idea? Actually a _proper_
driver should be able to detect when loading has finished, not just
use an arbitrary timer and hope that works and the controller is
responsive afterward.

> > Steps to reproduce:
> > 1. Trigger SSR and wait for SSR to complete:
> >     hcitool cmd 0x3f 0c 26
> > 2. Run "bluetoothctl power on" and observe that BT fails to start.
> >
> > Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) f=
ail when BT_EN is pulled up by hw")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> > ---
> >   drivers/bluetooth/hci_qca.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index ed280399b..184f52f9c 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8=
 code)
> >               mod_timer(&qca->tx_idle_timer, jiffies +
> >                                 msecs_to_jiffies(qca->tx_idle_delay));
> >
> > -             /* Controller reset completion time is 50ms */
> > -             msleep(50);
> > +             /* Wait for the controller to load the rampatch and NVM.*=
/
>
> Missing space at the end.
>
> > +             msleep(100);
> >
> >               clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> >               clear_bit(QCA_IBS_DISABLED, &qca->flags);
>
> Is the time it took to load the rampatch and NVM visible in the logs?
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz

