Return-Path: <stable+bounces-242623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEZ+J+Vy9mloVAIAu9opvQ
	(envelope-from <stable+bounces-242623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 23:55:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA94B38F5
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 23:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69DBF300AC0A
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 21:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10B37C0FA;
	Sat,  2 May 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOVGlMyC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DB33D6CA
	for <stable@vger.kernel.org>; Sat,  2 May 2026 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758925; cv=none; b=BrLI58tX1YzJHypskEeiReJyrEbT196c1bPmDJwkVij+LMoRu57zlK1QBf5TeM8/OX0w71farrOqndObxTfSl7XQOI1HTsh5uXhCOMVKYDEeRDyNCaTIPnGDOxCgx45LP11iMmDDPTbZ1h/4qP7cOkw2ozmC5OZu7s64Xki7xQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758925; c=relaxed/simple;
	bh=yrsqX7PWvFqc7WXIAaXKeO3CvketME8kxLMBs4Qgdsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjHd2KPuDpDNKGi41366wl3McBr3Btzj4PWQy7jBM3vflaPyBREomwqKmlXWPVsPShEGmBl16WulPp0ln6Ug8GLZ8Pbx6MKjPbWqEOUA7LrDAcoVJW3ZpO7AWZpy7aHD5jfJXvY8jEHsSnnWKb5nnHOEX+JGSUt54t4DSXAnb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOVGlMyC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so46933705e9.2
        for <stable@vger.kernel.org>; Sat, 02 May 2026 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777758922; x=1778363722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw2jZRLYzOlZ7sxfl/+h5eD7AhFBQmZQktoNUjcMaC8=;
        b=NOVGlMyCFyx+Ljn45IbOkjBYJjJHbJJjIma58szJsFWHJ6IEQc8YSHre5SirTWj7R6
         lviv9/zj4p3MwtGoMbCFyTHnnmAnLpetaF+zx/r5dOVMLv9V4Ofco9pZrR+wZUid0G0C
         e1LqHPJcDOQJDE85cjkfrI0ek596WRhRHu+Ms6RphqwvcrQaNhQSCjGu3g4hN/d/nsFw
         9sGs5XUEJON1HZp21+NMMxz/cSaxNmMGshmzQ6znrXiHCKXg36ewI/OZO3EDRDJoaAJB
         GwiqL0XjZ0iGIx+tg4ycOBGU2ud/0v7nT3XDf3tNVpvFWct/Y7CcPlG3Je8jwX93CfOO
         idhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777758922; x=1778363722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pw2jZRLYzOlZ7sxfl/+h5eD7AhFBQmZQktoNUjcMaC8=;
        b=RtGJMbu808cNpPX48bp/B8GRwCHzu/hjeWX/8BKgo+J57kisO3vfQPyzmaB8077VWY
         5mk6NqgVQldxXVsPjFVVDN3hwsYX1VhiyFf4V0YWUtE0qM82FjXOapiW+ZdMDb60OC1v
         +MHcns6V3LHiQStWUcELd0gBuw0QYB/HbGQb35hV8rPAlZCsLimHzvjaJSKP5c93d7aV
         wJcwWYynTD08GykZPJut5L8RQDtpHYsZsv/DkFlDo3357/IvNwaDRJgTyswkc85yM42F
         y/nn2w5kcplAkGmYlYti3HtxFdyQ7pVhbg3z2IB0ORdYcu9Be7fDSr+qmsZbp/QcCmgP
         DCSA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ih/dNByQlGxWSgRWVPF8dOS2TSUKfZfg78OgaOLXYZcAm1GvXMGVLGcFcQq7fHGPApi2e8lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4BAqfqBtfrUmcR4FISQmcvDC+iD0zADj5ZDBhfaNoEwGCbc3
	xBloGpLv7pV6BUTjifi3/13l1a4dEI0tNFdonffhmH1zN/aEcEZdXAKW
X-Gm-Gg: AeBDievNVUBS8TTKuuoig4rGwkh44CJ5xK3FNHKGQ/OywJ6T5PiLEAyDi5FfRJFARDF
	kcgUIRV1hKbmOhi5g2UCw6qSpaJJAohUfwIEGV2BI/h2vywZJNEy5h6bS9NSHlXZaXhxxzRmVAt
	acdFzJAqpC0FTtOQd3U81Bb8y5FSc4GPWQR+yF+zbGMytzApxprPk3p7CYnY5SEhmE+6ZEXxrqN
	jN82Rp2eo30eV6lJcvYJyK/qMzdrzUstNFCeKIW0xv3U3eaRL7Is55ilVHiNewHzGQtPDZ94qnG
	b7bfGe+4pI/DAZ+tAn0D6ePqD9xmLCj8woE1lbIEhpygCcsughp44afJBlsVY6PGqdjmHcwuJ1t
	5Afdqe81F3ciz5O46dEBetOR7yYLwl8VRMPxWVHaQXG2RoDduEupxZPaC+0vccY2I3LkpvF/d+S
	HncUECwZXaLVwNvjat3xjQiyTJAXaJ99OBH4+/I9VwRAEhFw==
X-Received: by 2002:a05:600c:c101:b0:488:8c89:cfaa with SMTP id 5b1f17b1804b1-48a9852f492mr46167455e9.3.1777758922338;
        Sat, 02 May 2026 14:55:22 -0700 (PDT)
Received: from foxbook (bgt227.neoplus.adsl.tpnet.pl. [83.28.83.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm344248525e9.9.2026.05.02.14.55.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 May 2026 14:55:22 -0700 (PDT)
Date: Sat, 2 May 2026 23:55:17 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260502235517.089ba5bf.michal.pecio@gmail.com>
In-Reply-To: <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
	<20260430235453.2288c973.michal.pecio@gmail.com>
	<CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
	<20260502114644.76e6b5a3.michal.pecio@gmail.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 62DA94B38F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sat, 2 May 2026 08:38:34 -0300, Desnes Nunes wrote:
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index e5823650850a..3041deb67b57 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -1761,13 +1761,15 @@ void xhci_handle_command_timeout(struct work_struct *work)
> >         /* mark this command to be cancelled */
> >         xhci->current_cmd->status = COMP_COMMAND_ABORTED;
> >
> > -       /* Make sure command ring is running before aborting it */
> > +       /* check for crashed or disconnected chip */
> >         hw_ring_state = xhci_read_64(xhci, &xhci->op_regs->cmd_ring);
> > -       if (hw_ring_state == ~(u64)0) {
> > +       if (hw_ring_state == ~(u64)0 || usbsts & (STS_FATAL | STS_HCE)) {
> > +               xhci_info(xhci, "kill the damn thing\n");
> >                 xhci_hc_died(xhci);
> >                 goto time_out_completed;
> >         }
> >
> > +       /* Make sure command ring is running before aborting it */
> >         if ((xhci->cmd_ring_state & CMD_RING_STATE_RUNNING) &&
> >             (hw_ring_state & CMD_RING_RUNNING))  {
> >                 /* Prevent new doorbell, and start command abort */  
> 
> FYI, sorry to be the bearer of bad news, but this also panics the
> system as soon as I run `echo c > /proc/sysrq-trigger`.

Is this not what's supposed to happen?

Sorry, that complaint is so odd that I thought I'm seeing another case
of debugging being outsourced to an AI chatbot, which forgot that panic
is triggered intentionally here. Now I'm just confused.

> Kdump doesn't run and no vmcore is produced:

Is the kdump kernel not launched, or does it crash during boot?
The latter would make sense if there is some problem with the code.

But I don't understand how patching xhci-hcd could possibly have
any effect on the former. Does this new code execute at all? Does
"kill the damn thing" ever appear in dmesg?

Regards,
Michal

