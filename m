Return-Path: <stable+bounces-114193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32797A2B7DD
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 02:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9B63A7961
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC313D638;
	Fri,  7 Feb 2025 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxaxPLIX"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58712417EF;
	Fri,  7 Feb 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891741; cv=none; b=QipYZxxEj7j9rAg7gcBUYTojVl2YfWSmUQfFCQyX2c4xGCGWrnW1HAxG/4FQbGChquQ29CHVzD5XH3ZtUeMbCm2a/kWQVXG0OvDurgU7lruvaQ/vQQWDW060ateq7f6/M5HXjYaujP0SB3RJyIopUyRttCOIhrHz3AMsHmrr4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891741; c=relaxed/simple;
	bh=BzUxZTtxwumnukkI09CukCJOLgaE/TFFCrXxLItChB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuenX945DR+WUMU1CyVPUy06VWfyrBZwfearh7FmBB62b0whmpFg30fK8PO9D7Ka30QEqCMEpgHDPESxWjCptBsFu8ssYWNhFQpaN9p2XlCE3gVOyHhK6Ws8/gCHgR4SBDcqfV+4sbEhaGEm8UK5cU/EqQmTPozpTmiwwAYwAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxaxPLIX; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f2efbc31deso866494eaf.3;
        Thu, 06 Feb 2025 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738891738; x=1739496538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzUxZTtxwumnukkI09CukCJOLgaE/TFFCrXxLItChB4=;
        b=JxaxPLIXRyzEzaB4L5M6u1okSL9SEGgubhVA7QexHHnphXOMaJhNqYDx7MkOMA28Wy
         pv16R4oYa2AhhNsj6mXL4bF1h4I3ZJc6xHcDhR7vehlz+hbzpgeI2DtLDMXKyH8uvkGm
         bjssL0A/Q5VT2p83G0wChiOrU30tRIAocxAN7YwBv7sF24aLe+uU5dlVtx95zc8H1wn1
         Kq/Yse/FsUO3zPYLJWX0jFNsOnjzlYZmZAz1KWpmngafGnRy4oVhR7KMbosPH7wQaRHe
         VbAKQtQ3aH9Gq2CAGlTIXU+fuY6Bo/ERgy4u0jocDkCczit6p5tk+5gKDAZ9UZMx6RSz
         hNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738891738; x=1739496538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzUxZTtxwumnukkI09CukCJOLgaE/TFFCrXxLItChB4=;
        b=buqKZrP5gMmHPu8ehcVd5avM5sIaojnQjEYIN0pF7t1X7aMm0aJnHIl7jgkkXpM8uO
         gdlX6mQ8bq73CMszDz1MWPZzswBHoDrk7xQE5OgGygsg0BWxk1HL/62/Sk33SRAJS79Z
         Xv6SCAV4rRCgTO2zlRgxEyml1sb79c5VepJdaDzalZRe3FNpvQaJcurvJ3BlZFM+2aNq
         L2Xh+/YaqdtrYRyh+nrz85Okk5s4j7H5un0z6pCvHHHlDUOLHNgYIiVtkIFeezldq1CV
         3/LDYuqNqAw/zvECXQCTApTqycTF/kOsqZJMjuGper4Y2uwhuZeIustx/RI8yK8NtLqG
         hw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1K8o31TXR4Vhuw6pO7z45Gh2RksCU0icJ2pS3oi/WRyysHVakJPu71t2HypWBYM96+52FlXzZIJ3p6xM=@vger.kernel.org, AJvYcCVPJ0A1jAXpq+MnZBl9l4z7gp+ZBDEBh9MECIRuboSGrckKZHvt0EG41je8mxlDd4EqKgrX7V6L/zAQ@vger.kernel.org, AJvYcCW2Vcwp1hxoXhc/h6h7nfJVtdh6/dtGFvzL46re7M8SDZgJe3CTuVKFVHVhqhSTFm2CQyHxBe5I@vger.kernel.org
X-Gm-Message-State: AOJu0Yymor1LP7PzLbd97vjSl/RO+eRMXp59P+O9B9Udp4sa1DfSwhWl
	3dFIkU9KU5fdbWCj9RTNwNIcSbLDteqklA5uqK1Y/tS9i+tak0ZYKCgCtNG54VE5l/8swOGz9JH
	tsxJ0/g2pjLC2v94fxsf2BXigU4mZMRdT
X-Gm-Gg: ASbGncsqTWAKK9ioIx5Qa/6hIoTkz8qc7P5DzKzScF8pUHt3ts0Gk1+atz07p02fF8B
	qKA5z+1m9hpFI8WFdLkZBvuyYDqxC+G7oyOpD3e+W71tRS3u4rMe4xj5VbXQeSsKNEq3p89Sq9F
	E=
X-Google-Smtp-Source: AGHT+IG75clZlllzy9XQTaP2FPNL3vTeI7H1p97304WfhcgG3hrPOEbxwJ9lS3cI9+5mGNmx9T8ZltQBWkifa8h/zZg=
X-Received: by 2002:a05:6820:221d:b0:5fa:7e37:e42e with SMTP id
 006d021491bc7-5fc5e6fa396mr1210285eaf.3.1738891738547; Thu, 06 Feb 2025
 17:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205053750.28251-1-ki.chiang65@gmail.com> <20250205053750.28251-2-ki.chiang65@gmail.com>
 <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com>
In-Reply-To: <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Fri, 7 Feb 2025 09:28:47 +0800
X-Gm-Features: AWEUYZnJN_Wvl0daxZMU6pB3EC8o0lb2Btv437Eb_kWrAPCwh8givgTgB9zPZTs
Message-ID: <CAHN5xi2Mfob2t9S6Tni=JAuXvnP7oYbyUNkONa8+oFuV9c=E-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2025=E5=B9=B42=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:16=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 5.2.2025 7.37, Kuangyi Chiang wrote:
> > Unplugging a USB3.0 webcam while streaming results in errors like this:
> >
> > [ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr n=
ot part of current TD ep_index 18 comp_code 13
> > [ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf=
8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 00000000=
2fdf8000 seg-end 000000002fdf8ff0
> > [ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr n=
ot part of current TD ep_index 18 comp_code 13
> > [ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf=
8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 00000000=
2fdf8000 seg-end 000000002fdf8ff0
> >
> > If an error is detected while processing the last TRB of an isoc TD,
> > the Etron xHC generates two transfer events for the TRB where the
> > error was detected. The first event can be any sort of error (like
> > USB Transaction or Babble Detected, etc), and the final event is
> > Success.
> >
> > The xHCI driver will handle the TD after the first event and remove it
> > from its internal list, and then print an "Transfer event TRB DMA ptr
> > not part of current TD" error message after the final event.
> >
> > Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
> > transaction error mid TD.") is designed to address isoc transaction
> > errors, but unfortunately it doesn't account for this scenario.
> >
> > To work around this by reusing the logic that handles isoc transaction
> > errors, but continuing to wait for the final event when this condition
> > occurs. Sometimes we see the Stopped event after an error mid TD, this
> > is a normal event for a pending TD and we can think of it as the final
> > event we are waiting for.
>
> Not giving back the TD when we get an event for the last TRB in the
> TD sounds risky. With this change we assume all old and future ETRON host=
s
> will trigger this additional spurious success event.
>
> I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case see=
n
> with short transfers, and just silence the error message.

Yes, this was my initial solution as well. See my patch v2 [1].

[1] https://lore.kernel.org/all/20241028025337.6372-6-ki.chiang65@gmail.com

>
> Are there any other issues besides the error message seen?

There are no other issues.

>
> Thanks
> Mathias
>

Thanks,
Kuangyi Chiang

