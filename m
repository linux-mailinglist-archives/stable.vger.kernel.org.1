Return-Path: <stable+bounces-86895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A810F9A4BCF
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 09:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D0285230
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA011DC19E;
	Sat, 19 Oct 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr2sYeJr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8F1D54D3;
	Sat, 19 Oct 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322433; cv=none; b=YRNB2bap5iKmi6kC9hlpRAHmjoWI7krGd0yvl9dOgRoFv1qtBsAsGLZqw9iBuvGtjumg9sqPvkGKzkvHwE/xPBB5J+D+VIdaf1idG/L3Ymr1zH1r0rN2wqYC2MdjygUrBBmIHw4sY0FrgfdoAzww/AhC/91w6EdxwSUEbR5nsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322433; c=relaxed/simple;
	bh=NrAzHRiXxKtj6O5GYtWbKzt+uZBxQwqk1QpwVk2wTbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=rnrr1HhArJy4xwVCKhVGiSXOARlV289noBn1kTrxJKqIQthEH+mfLnOFvl83kH2th91kWsgdIxN3EAWz1YT26WuNWRAfBRRO9IR8HzbXdkLxPPogr0CW1C5IBMR1iDd6XB1iDSF9jtFoER8crIjeJsl2QQE2h+MD02ubvmH3NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr2sYeJr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53a007743e7so3554250e87.1;
        Sat, 19 Oct 2024 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729322429; x=1729927229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOSgqBuptd5/+pKaXDmre/ntgdJaEZmL2tgWZn9tjU0=;
        b=Gr2sYeJrrNLbITb2ay1TvlyPHibj4G1KWY91X7CMM5R4a1JUAwIQ2cwLQTGVevahmf
         rjXDifhqC01UEaaZWK4oPXRZq0EwaDR5QJ+tCnkDDGgBmYx0slk764KEa0rLaCojnMa7
         c8ppE9RaBkpyyqp2puDDW+Tn2Ec6FYDxWiFkLlT/W8b60qpbdz3nAiO0IDNMpm6Qvu5i
         O0wFn8YFdoCwdGJmtl8Pt2r/va9e2Y+g99npygoDAGaZAfmP8fwQEi+Rs9EG9ZpEs2Ml
         EQXAGDcYX2PFyN/owIfi+lbkZf6/1Fz4fnrv+tXmidJoWlD5vY3oHRjuJyK0gJO4auHP
         fiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729322429; x=1729927229;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOSgqBuptd5/+pKaXDmre/ntgdJaEZmL2tgWZn9tjU0=;
        b=boTOB8I8qrPLUpmz8PrneIR/v5WSOMEa+pP0A40aoPGh/LtLCIrz+CyYvw3cmPrron
         DRP7ZEsl8jiwmOB0htVl7J7ZOg3z+gky7T1KzY63CNUZwd4gCQ6/f6GU/Ssvza8RCFPn
         HCfMQr//AP+t3UnjWbF0I6J2+FEkh266P+RuWKwH4WRwmpF3cjrb9P5mVSF5YQrrpv8K
         q3LJaRJ0PDDpLdziGv0H8Iv/TdWwg381nOPGKWGR/AqXKQAFghoW4qwxsrMbv3wsHjiY
         UDRrHntXyUGGe3mOWrKUsSjAwyYrwQEqMJ0e7RkS0UJUtyNwEoaUhm6fLGDeovW1MjTy
         RJlw==
X-Forwarded-Encrypted: i=1; AJvYcCUonmIKZ64tS9WpBMqwpV85qxGOVYXOvyoVWZ8unn7FGp7mG10Ce381E22BkAiwYZQxsiMVp7Bst9UR@vger.kernel.org, AJvYcCUss1RpNFrejjZEJwYsFZj6gmheqmpDKS4nO0NYRG8dEnyGKi5NQgDzwjmDFmmCvbg7ftQ2CbNsrGeNZ80=@vger.kernel.org, AJvYcCWBFd0DoIhNxPK1ydR1oJllLTl2SO0BChZh2qGx2mur4tywqQ/srEWdCwFmin/rMuwf2Vm1Fvm3@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/pMnqRG0uj4nH+INqgc4u71/3xTygordDSKJHEtzEPPzyxfn
	2sYp5W3J7DwHBZJ6JOxSGKNit19eg2PKJpPRaShiIee++02lAIcXn7EzhQ==
X-Google-Smtp-Source: AGHT+IHUzG5ypUus5uLhkbQT4EyrzUgEy8gdbwiHOwwVV1bpsUKbdfCLljMWbxL0x9RFKubWPR5KXg==
X-Received: by 2002:a05:6512:3985:b0:539:f23b:59c3 with SMTP id 2adb3069b0e04-53a154b3094mr2557177e87.34.1729322428554;
        Sat, 19 Oct 2024 00:20:28 -0700 (PDT)
Received: from foxbook (bgw235.neoplus.adsl.tpnet.pl. [83.28.86.235])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b9d40sm438219e87.117.2024.10.19.00.20.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 19 Oct 2024 00:20:27 -0700 (PDT)
Date: Sat, 19 Oct 2024 09:20:23 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: quic_faisalh@quicinc.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] xhci: Fix Link TRB DMA in command ring stopped
 completion event
Message-ID: <20241019092023.5d987d7e@foxbook>
In-Reply-To: <20241018195953.12315-1-quic_faisalh@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> During the aborting of a command, the software receives a command
> completion event for the command ring stopped, with the TRB pointing
> to the next TRB after the aborted command.
>
> If the command we abort is located just before the Link TRB in the
> command ring, then during the 'command ring stopped' completion event,
> the xHC gives the Link TRB in the event's cmd DMA, which causes a
> mismatch in handling command completion event.
>
> To handle this situation, an additional check has been added to ignore
> the mismatch error and continue the operation.

Thanks, I remember having some issues with command aborts, but I blamed
them on my own bugs, although I never found what the problem was. I may
take a look at it later, but I'm currently busy with other things.

No comment about validity of this patch for now, but a few remarks:

>+static bool is_dma_link_trb(struct xhci_ring *ring, dma_addr_t dma)
>+{
>+	struct xhci_segment *seg;
>+	union xhci_trb *trb;
>+	dma_addr_t trb_dma;
>+	int i;
>+
>+	seg = ring->first_seg;
>+	do {
>+		for (i = 0; i < TRBS_PER_SEGMENT; i++) {
>+			trb = &seg->trbs[i];
>+			trb_dma = seg->dma + (i * sizeof(union xhci_trb));
>+
>+			if (trb_is_link(trb) && trb_dma == dma)
>+				return true;
>+		}

You don't need to iterate the array. Something like this should work:
do {
	if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE)) {
		/* found the TRB, check if it's link */
		trb = &seg->trbs[(dma - seg->dma) / sizeof(*trb)];
		return trb_is_link(trb);
	}
	// try next seg, while (blah blah), return false

We should probably have a helper for (ring, dma)->trb lookups, but
for stable it may be sensible to do it without excess complication.

>+	if ((!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) &&
>+	    !(cmd_comp_code == COMP_COMMAND_RING_STOPPED &&
>+	      is_dma_link_trb(xhci->cmd_ring, cmd_dma))) {

This if statement is quite complex now. I would be tempted to write
it this way instead:

/* original comment */
if (cmd_dma != dequeue_dma) {
	/* your new comment */
	if (! (RING_STOPPED && is_link)) {
		warn();
		return;
	}
}

Regards,
Michal

