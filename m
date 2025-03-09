Return-Path: <stable+bounces-121636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9EA58913
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 00:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB333AC2C9
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8EA22171F;
	Sun,  9 Mar 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giXcKCOK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974761AA1FE
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561506; cv=none; b=SCTtGwzS2IEccIfXBGHocvI5XQxdr3PsQ79GkT+86K8ZAPx9D4x5tUiWWUUCivRG9mwEEYWFuTZ8Rzval1F2wp4ImH/kkxvo64bikl9C7NOeVS0KEXSJj4Ae8YGGrwmqxShEtN1xIVnHAySwCuhW+216ibd0JFe4pfRGD7z9dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561506; c=relaxed/simple;
	bh=GyTQkuqeTxhma+gD2YDcbFJwT+7AuRcIG0+3H2omrQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTV28ah59xR/+iPgmhLZtufrumzP6kimUYNANFIyTgRLCNnfBADhhai/kttI963pN7Gf6ymM5gR9mn7Yo9bxq6raid7+CCPxgu9UYaQxlAVVoL/f4q+Xq9HVTqMc5XcksvrfGpuR+Q5EZF9jsFLjfT+0kX9XRTHnSnQUTDuiwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giXcKCOK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso2650998a12.2
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741561503; x=1742166303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5hpZitqBMQVlF7J08zn9wRX2rf7bvs1kUek1crATEg=;
        b=giXcKCOKRi7loLOOkZ6MTWtrpB10v/2XG8ipP3P4u14GtI6zHstDRPUfZ3ypC+lHWA
         0IFr+Qh6qt15Z6K2lrUFfTsCdXw0nZxxnvvdmnfXE2Hd8rErok4rJqIzixDjkrn4IwkN
         5MjBgeTePbH0UCCvAAtyW9hwTeSCo2YTVFKxoy+tznYczJiKMUFAozkfqGKESpdAvZEP
         qPjSZGbMN2yNFgrGbifRZ1I/UJBKPPKmmQhentdD9z5ADFj/mn3x60f61NR7Eoc5YTvk
         83N5RXhXACCGDASxXVtBcLVp+Aq381MsrINRu1HpLzKyR6FkQeQOJMp3f9wPs4QGmIbc
         dhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561503; x=1742166303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5hpZitqBMQVlF7J08zn9wRX2rf7bvs1kUek1crATEg=;
        b=qX0DPK1kq1gFYE7MBPuD6FY+b9HVs2cVhHi9Wsdss5fzFqn0HuSM+AoO0ArgLT3qYx
         FzBpJ+ARmmM3HV3htIhac6X+v8QeoQjQZ0tA43zQAJKAwsIVMvsFvxcA0qllRJUEjHJ5
         0oI8qMa+HG14vllDvNCAaT5ps/oR0lbA196QsuKrSngAWDgtWL4nXWf7ehRp8rfKcFqk
         RYBV4yDKn154pyBdQiXhcggrRMjbhnVWT3CMhripSftRdUvyer3ORLCAhIMYriF4GZJY
         +2RU0VtkHGD/VXEEsiqrH9MTK+Hs7YuoZlqcT5nhSCUJ2ddkgrrXyYcZAGmjkTudwCZT
         nF2g==
X-Forwarded-Encrypted: i=1; AJvYcCXwcWUfnyLwR7kwjL2XdYgtekK+TGBb89xjhq6864YGduDFph+Rh8KqHvf2+pgmgC7muxblOPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9stW7IOHJSqnXX+l8A5xNxkGkIh4nZoDiwx5ZHWKU7sWqKZuv
	sv+3tV0pOSGOdmqLMF5/XiZwhvRFB7NBJQAm5vZBaUnXFN+4h2Gk
X-Gm-Gg: ASbGncv77CJ6xza5j7261K6D9WbI0hhU9+bV0AxFcRbjvxM27ZHZ1nxOUuIQ4vHUynm
	ZK+scozcVClGI+WPWK430yS4xIBBLIsjT7FBkbWrMTaS9BjfaTYzUtVRZmSYdERUdk6hA7Xak/A
	qH6Xnv5jfxo4ix3zw3vlINhkARJtMEKFD7e3773EmH/fXqoZ9RZPcCnLz6L4iPzmU7lFqkfV1OP
	la6GuUIM0/URvlijYhBPmyb6Xwn9EGZUKSYM/ips/6bEc4RzSZHdrUO2u3nThe/txCOp2/PnptC
	aZtF2O4zeg+UFyq1EoBNodEnCtZ6IDgnmS4gXs+8EgvEvxw3jyY2PTdgmEPEcg==
X-Google-Smtp-Source: AGHT+IEmuqEYfqUikNXZX5I3soDsPKPk/u9g8nMVIcnLkpo8dwmE0n2iNDDg12hxwpAAmDC+1pcXtw==
X-Received: by 2002:a17:907:3e82:b0:abf:6f44:bffa with SMTP id a640c23a62f3a-ac252e9e7c4mr1487323166b.36.1741561502541;
        Sun, 09 Mar 2025 16:05:02 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac283e4d50csm249886766b.175.2025.03.09.16.05.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Mar 2025 16:05:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 00:04:58 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: xhci: Enable the TRB overfetch
 quirk on VIA VL805" failed to apply to 5.15-stable tree
Message-ID: <20250310000458.1cbe89f7@foxbook>
In-Reply-To: <2025030921-blank-obscurity-1a26@gregkh>
References: <2025030900-slaw-onstage-6b47@gregkh>
	<20250309220918.26951f03@foxbook>
	<2025030921-blank-obscurity-1a26@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Mar 2025 22:21:51 +0100, Greg KH wrote:
> On Sun, Mar 09, 2025 at 10:09:18PM +0100, Micha=C5=82 Pecio wrote:
> > On Sun, 09 Mar 2025 21:22:00 +0100, gregkh@linuxfoundation.org
> > wrote: =20
> > > The patch below does not apply to the 5.15-stable tree.
> > > If someone wants it applied there, or to any other stable or
> > > longterm tree, then please email the backport, including the
> > > original git commit id to <stable@vger.kernel.org>. =20
> >=20
> > Hi Greg,
> >=20
> > For 5.15 and later, the sole conflict appears to be
> >=20
> > 0309ed83791c xhci: pci: Fix indentation in the PCI device ID
> > definitions
> >=20
> >=20
> > Would you still like a backport, or pull this small whitespace
> > cleanup to keep PCI IDs in sync with mainline? =20
>=20
> I took the dependent patch now, but 5.10.y and 5.4.y still do not
> apply cleanly.  Ify ou need/want this there, can you provide a working
> backport?

5.10 done.

5.4 has a few piecese missing, not sure why. I won't bother fixing it
for a branch which is dead by the end of this year.

Thanks,
Michal

