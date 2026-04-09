Return-Path: <stable+bounces-235349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI2kIExh12keNQgAu9opvQ
	(envelope-from <stable+bounces-235349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:20:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A2D3C7AD1
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F103051BCB
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB73A2546;
	Thu,  9 Apr 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="hK8QAq97"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994F3890E1
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722547; cv=pass; b=uFwuGHtNSfUBqRxPAwgY422hg07DoW8RUfW92R6nANyRTCp8PlaNJ3MDhQxBNCt09XewgQVzk7Peq4rtVWvLxiLjmQWByw6jxAMd+slDcyt4gvtrHeWYKW92jJQnl3HQtMyOJchos8J+EMYkXP8ly6SifQ5uVnnCYLiVIujsoRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722547; c=relaxed/simple;
	bh=Dngotpoiby0FdEKfKRicFCk8dHaAyFjbpWnfFURByR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUI0iGn3NCI8tbyg+vRqxf98yHLLae0SO+JFS4v8aj9miNx50OJUwk8LQG8CGXU6TtJ3Z3ajAB7VGqDryn0x94nr9ydenaTo9xA8rdEFx9U9buwidKCL5PkP0mDxuOv2/HR5WHPyXg8/JNIfjxZ9AhhY3bxk+Xc1KZzUwYfAphU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=hK8QAq97; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65075c2ba66so668808d50.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 01:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775722546; cv=none;
        d=google.com; s=arc-20240605;
        b=XcrqmJXHWyzDP+MotW/kt4WGmr/KMYpmEklMNYNK/rMAvB6Y8gb1kIfVXOYogmeeqi
         2ii702fW1LAsATgkN1dcRY6Av0pgBs+zJffW1lxzs0BGxk8dhAPk2c5mmor1T+5awHt5
         wYCeWUTYMAquS3YcgVJP6PO/ywoo0B3d91juSJj0/WAqVa1fG8GQg5c13P93Jhp18Lkv
         jsjx0ehd6n/WTWOywaCLojRbO/GGlqrYajr+PJqmrXnlZC0LyPDs+Gvd64Nm1jbHB8Db
         U0JzpEzGAeTi2wJnqNDH4Sp6XpBb9j2NtPIil5qojVXQ/ckCm6pVOXrR14DIpBnOCfQw
         EGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dngotpoiby0FdEKfKRicFCk8dHaAyFjbpWnfFURByR0=;
        fh=vyxkEHW7Y5137XlDl0xzgBLUc/TrjifkHyPaGLofrCg=;
        b=iAiqfGmVXTLmWk49Fj3pGBS3T4Sg906buH6KeHfzYL517p/12hXMetUPN6asAzD7+t
         2uD241CXgOc69ALKNtNnOlCPlXCTiTsW3YS1KJ1rFQXOMR9Iyiy+KdG7NgWCnVEGv6cv
         ER1CHr/9noOsk5urn4rTn25ozQHS9xs1jcSbR7aWEgZccGsuYtHqHlLtN1WJnsK01pnD
         RRLERLFFuuk3KzbQh+G9pZG1NZYhURjWjNHS8P9YGrhquvEPT0CeBkAGpXc4zeyL0iXl
         JRkyNoOBYSNjR/6Xgto3+9r3Q+yQ8g62BUEEV/jCXoXPeAydat6SJ/qnlJ+rDslpk5mB
         +gAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1775722546; x=1776327346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dngotpoiby0FdEKfKRicFCk8dHaAyFjbpWnfFURByR0=;
        b=hK8QAq97TlIOoUC3QXTQogSkiZ5m0vdteO2CqmRT8OD8bwfmVSQVKwb2AfKSWKd8x1
         5omp5PoAQxvuew0sos0lP+Bez4zcRbLI51aH7r5EDDVs1bshFInZoziHjOVJ6KUw+njk
         itjwSNNtufrhKpAf2sQRopPferDvPivo+4Z6S//3cTbO3dtR+rRR1Fuh/WJQf4ahxd3/
         jROhSNHiPy+QkNUa3D5k8HY55knVpJw4J+Mq6tFHixiDOmujL+tS2A9beuKTntQsVTPH
         MXNXACM+Ofx6imiR6LU+p3yqgRiC4yeAobPgxBOWan4C3sbU79Y4Ugj59GT0EWJq0IK8
         Xe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722546; x=1776327346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dngotpoiby0FdEKfKRicFCk8dHaAyFjbpWnfFURByR0=;
        b=LM3fclgOMIHB/EJKLNXAVcP5JcT/lkxKl9l5sZL8ePumx05624EAGnFfWfQZvWI+6F
         xSwlgR05soVNjbEYyJ6PHiCJBPF7iy3Wqr2dCkzF5OJD2BgR8D8WJoZGCIZqkq8y5SqR
         KBiWnlQ6tDTZvHVbQYx8K0MjwL9/E82XJc7bHdjG+JY94LnNx4bBQ11xYyjEB8/j8AjV
         Afy1I9vPEvMGKha0PqzWxjjr8634MzL9WZvbTMRLRYj+9Xa0/hN+JsSED1bQOZ8hXnNo
         RhwVkbdPj8027zrcjjj52NmTYX4GJJFh9WOLTHFM59hyEK7wsN+sgs/cALCJs/p7u9DM
         HUvg==
X-Forwarded-Encrypted: i=1; AJvYcCXQUVKy7kljkv2RLR/x81DPzCirtI+PPhb92S13pYlS/Kwn0MoJQLPDi/OMrK7al2Fe38ci//U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqmv960adI1vRg54iYXNfXsETAVjDknmvRKG3Uy1Mn/kM6+mBB
	k9ow0h0rvVAurGkWHCjQyVBkuNY9nE7vfkuk3hY/RCMHuEmyKJcPuYeC+H5852baCzEEidnQIFR
	bpue6jZqKw6Mkdi2lVCDV0PC0OPDiylVzXTCmQdMO
X-Gm-Gg: AeBDietO43OriGK2YHhcBJlw5gUlFSnw3Xr0JCqoq6EvdjYgbsiFNZZ1/6hdhJsVTXn
	JAya69bD68XeLgCIBE86fxKBSAaiTTlKmvomBVZKAkRnWsL1UD05zcHu6bYK29mofiGsm4Qfm1D
	jUDioreS7+lAXAc7ROoxBb1M5tT7lYf8rh/Ld9gDXjJQywZBYh1vEWARGlpsamMXuDcRBJ+eSnj
	Mx3TWpCh1HG23smHJa8lPyCTHxn3yh+eHA02BhwcMooqz5EUzcrSzz4VwNBwXyXj9ZghCPrtoSg
	qhhR
X-Received: by 2002:a53:ea4c:0:b0:650:3039:6c7d with SMTP id
 956f58d0204a3-65187573bf5mr1888711d50.12.1775722545547; Thu, 09 Apr 2026
 01:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331003806.212565-1-jp@jphein.com> <20260331003806.212565-3-jp@jphein.com>
 <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com> <20260409100247.7cfb62d1.michal.pecio@gmail.com>
In-Reply-To: <20260409100247.7cfb62d1.michal.pecio@gmail.com>
From: Jeffrey Hein <jp@jphein.com>
Date: Thu, 9 Apr 2026 01:15:34 -0700
X-Gm-Features: AQROBzBsC-Nkq1RmMLeEIh8sjrySSruolHrCkdk9eliqPcQqpZeF-BuE1MuBPPs
Message-ID: <CAD5VvzCr7gOxB2J5A6Bpma5+4OTn0zFDmpyzb3N016-BS4a87A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235349-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[jphein.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,jphein.com:dkim,jphein.com:email]
X-Rspamd-Queue-Id: E9A2D3C7AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michal,

Thanks for taking another look.

I will reproduce the hc_died() crash with dynamic debug enabled
(xhci_hcd +p, usbcore +p) and with all unrelated USB devices
disconnected so the logs are clean. The slot 17 stalls in the
previous logs may have been from another device on the bus --
I will make sure only the Kiyo is connected for the next capture.

The crash that kills the controller happens when starting a video
stream (LPM disable failure path). I can SSH in to grab dmesg
live during the crash since the controller death only takes out
USB, not the network.

Will follow up with the traces.

Thanks,
JP


On Thu, Apr 9, 2026 at 1:02=E2=80=AFAM Michal Pecio <michal.pecio@gmail.com=
> wrote:
>
> On Thu, 9 Apr 2026 08:45:17 +0200, Ricardo Ribalda wrote:
> > Hi JP
> >
> > On Tue, 31 Mar 2026 at 02:38, JP Hein <jp@jphein.com> wrote:
> > >
> > > Some USB webcams have firmware that crashes when it receives rapid
> > > consecutive UVC control transfers (SET_CUR). The Razer Kiyo Pro
> > > (1532:0e05) is one such device -- after several hundred rapid
> > > control changes over a few seconds, the device stops responding
> > > entirely, triggering an xHCI stop-endpoint command timeout that
> > > causes the host controller to be declared dead, disconnecting every
> > > USB device on the bus.
> >
> > A usb device shall not be able crash the whole USB host. I believe
> > that you already captured some logs and the USB guys are looking into
> > it. I'd really like to hear what they have to say after reviewing
> > them.
>
> Sorry, I forgot about this bug. I will take a closer look at logs
> later today.
>
> I see that there is a case which crashes the host controller, but
> without dynamic debug. It would be helpful if this can be reproduced
> with debug enabled.
>
> In the future, please also make sure that there are no unrelated
> devices spamming dmesg, like "slot 17 ep 2" in those "stall" logs.
> Please find this device and disconnect it or unbind its driver.
>
> The initial cause of all that may really be the device getting
> locked up for no good reason, but not 100% sure yet.
>
> Regards,
> Michal

