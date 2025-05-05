Return-Path: <stable+bounces-139691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE20AA94B6
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C894E3A95E4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DA1F9F70;
	Mon,  5 May 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Xx/UhOfD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED521FF7D7
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452494; cv=none; b=FibCFdiHKZB/lHtgS29gvz8jOA1tWzh65C1F23y4M6bMOBAN4DvdSt4ziS5S+4hDdSxmSZRyAHnDwSjrmaiu3Xt+y7bYvWZbI1475DvukPJH1UGRslLJEvopOtFtZLkcN/gk0Haoz9uMoFfQbfitcsjvuc8cw+eGLsdvacD6N5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452494; c=relaxed/simple;
	bh=v/dJj341xsNQeCqC1Siht7Ws3sENNj7ybHPuPW7JAIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB9vbtuYMIlmsJpqW5ssbn/oGNFgR/BHk1cyJuHKxR1q7YETk4uA0nwkFAw3XmUdL4ice4Iqm5CKksoOfV9uHbR0jYbTWCG7Wi5jV3FkNC1x8rU1WTtLMcMzBiTxKEIr9u+rIN7+w8Oq90RdwHjmnD8OCkWHEAB6K5yEaOOj9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Xx/UhOfD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f76a47549cso725189a12.0
        for <stable@vger.kernel.org>; Mon, 05 May 2025 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746452491; x=1747057291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgOQcCW/5EumNCwVGw+nICO19/zCvETl3yaaQWKBefg=;
        b=Xx/UhOfD/qky5tF1ejmyxvuFXvL7dECMnXPp8Q/DzOCtl1peXih6rOnW4sCMQukfwP
         h3Uk7h8KXGMiBxJcRU4lPvyxRmql1XFyuKb5sbf1fH0PakVhPmwSN0qS64rJ2roXgycV
         WE3lzjNz1jTiGDQZDmTmRo+QUt0aUI02/AwIRXKOmJocihQhnm9xuBxt2HhCXolULC5t
         c0q0tscySzcKpiMqc9168z8FJ3QHf2nhip6/1RPsFW9tKEIc/iIZygUxGlplOd0Wnu3v
         TLI72kIrHyBBndoJYz16FI5IKpWcArFArfTdxeS01D709BA7yxlXGLDEPXQSyugwNJUE
         bM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746452491; x=1747057291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgOQcCW/5EumNCwVGw+nICO19/zCvETl3yaaQWKBefg=;
        b=jk2iXJvw2fBKEDpYJIXzjt4MzE+opdo9s0QQ9AfgRk+AerPdSMaVthMeJDhLBREkEB
         CfmwlqxlGsOBCthm0fco69OmBkHdrGUB2lltFPutD/yh5dKYNhmdBpR2L9FG+FlOF91P
         7Uo8FRUegXITdNmLmNL0hKK78EuYdNYT0BRenG03/6IEGLMWR3Jt8xJCRSt3tEfcgbfI
         UWPonFGxMoRAyMl8esCrHJ8qpLuN7Q1CKyxJbdPQXChI4OY6vD3aW1cnc9TXVpFiYDwi
         dMXI1MmhciwZhHnoCS4/1s/ROECCm4+fOokrBY0LRU/WdLkAwQz2C6OWT9WPXVAIzOLS
         rkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWerQGVfysX/LCIU7/WN3sNk4HWH/us7qEIMwf5ZOV0r52D4LCnWTvIJRmJAUAloqOG+lNPqbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3BtkzTTaATQKM2HUN1rteOgxfggpk4Sp3DvU+HF01opsWadF
	nc+Bo+OXa9o9lJcrwyxOWd2VlDPD+il+XxR46aB0LHtqRNRhSWoW3FKM1jKH3woGMMLXXLwLw/P
	xQPZUfs17efU39nICyY7wDTEomLIVYf8+ECxiHYDIxlXFUHPGv8jyJw==
X-Gm-Gg: ASbGnculKnTn8dAPVvehimD7TAf7icZ0R7OL39PZrnsixUX3BoAfX4dR4EYDFjKZta+
	JpBkOLTWbKhQcuu+8b2XNTgh6Vxzb5URc/KZsDcTeN1Wh8XMvF8bi8jio6Q9mrqmYG7M9ggDSNK
	d8lpX+I2JT5lwCzrIBYlzVsA==
X-Google-Smtp-Source: AGHT+IH2hOCS5Z69bOQ625GKeNTnF9RcN5dGnBmAkGihHjKuHZ95cnwty0CJl543wI4Egr86ZrHZg/5KpIM+x6HxCIM=
X-Received: by 2002:a05:6402:430b:b0:5f7:ebfd:58c0 with SMTP id
 4fb4d7f45d1cf-5fa7890ebbdmr3588715a12.8.1746452490817; Mon, 05 May 2025
 06:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025050500-unchain-tricking-a90e@gregkh> <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
 <2025050554-reply-surging-929d@gregkh>
In-Reply-To: <2025050554-reply-surging-929d@gregkh>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 5 May 2025 15:41:18 +0200
X-Gm-Features: ATxdqUG8ype2G5NCyCQYXzUTM3xsY7dHi1Xmk8vckI_hdindlupK2NwHK0ygNoU
Message-ID: <CAMGffEkSLbtJL9=nL-Tt4Eo1smKg0GCpoAutA7SeeCjsA2XbGw@mail.gmail.com>
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_mq_map_hw_queues+0xcf/0xe0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>, stable@vger.kernel.org, wagi@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 3:28=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, May 05, 2025 at 01:36:52PM +0200, Jack Wang wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > In linux-6.12.y, commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_que=
ues with blk_mq_map_hw_queues")
> > was pulled in as depandency, the fix a9ae6fe1c319 ("blk-mq: create corr=
ect map for fallback case")
> > should have just used 1452e9b470c9 ("blk-mq: introduce blk_mq_map_hw_qu=
eues")
> > as Fixes, not the other conversion IMO.
>
> What "other conversion"?
Sorry, I meant  in the mentioned Fixes in commit a9ae6fe1c319
("blk-mq: create correct map for fallback case")
"    Fixes: a5665c3d150c ("virtio: blk/scsi: replace
blk_mq_virtio_map_queues with blk_mq_map_hw_queues")
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
" which use virtio: blk/scsi: replace blk_mq_virtio_map_queues with
blk_mq_map_hw_queues, should have
> Sorry, I do not understand, did we take a
> patch we shouldn't have, or did we miss a patch we should have applied?
We missed the fix a9ae6fe1c319 ("blk-mq: create correct map for
fallback case")for stable linux 6.12.y, which should be applied.
>
> confused,
>
> greg k-h
Sorry for the confusion.

