Return-Path: <stable+bounces-59252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B6930BA5
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 22:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007FB1C214DF
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590913DDB5;
	Sun, 14 Jul 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N45LsQ0l"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EC13D89B;
	Sun, 14 Jul 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720989707; cv=none; b=IDIdgI5be+dNkNCsWLl22S+hEQMctnfZaTHXooAQwP4kJt4LTV6JxtK0uf38vxN8Gkc7eim+rmRPDDbUmlea/Kaqbq0oezf6G0SFnHkv5VdwnYiEjRwEe02BrYk6BPTkn9Bp8uEgmF4EVkF3/lyCpYbXZW8gMd8lqB10ZtPCJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720989707; c=relaxed/simple;
	bh=Rbhi9raS35yjLs44ICMqmzwlTLdlFu8DJr1zq7AF6AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJGmSSNnxhy2gp42LA3ULlZTNSVsdtQIifx+2CTvy9vkWNTcKgE09guGSA4ovzKZIGHeZVbirZHKJrPNEVMwZ6AXu/ViOF/LFlxrTuTIS1q1ubwbri8B5I+VNhf7vLdSyqhbcOyC5cRZK2nvTbFurLd4LAQVOCUQudJddKosXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N45LsQ0l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so4460488a12.1;
        Sun, 14 Jul 2024 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720989704; x=1721594504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/cK++aNJsVXbuZ4CO83IGAtI8ojo7ZZbJZliVitl0M=;
        b=N45LsQ0l2Bvria4dNQMr2t+IdhoiOH2w2MeNq7VDJVGDRIb4RIyrWL3HXdcnVhQtBI
         DIGTkw34p8Olf+QaOFppnfbzDurVZCmGBH8cd23rryD26bCT0SgXrzv8jF0q7nC/OmEm
         eFiArPh85U93J0dAcYe3AdABTwsHPOEeCQa/eq7su6bmPdolxraDyMeun4gkMn4MdXML
         +dJc+VWbpTESj1nRZFdmvzpWA4GaNoUQ1OoF93nEzjmL1yAKg7DMplp5yuLlMClcD/lZ
         oPLJzJb07fzjRKnulLQ1Cpzh+fosStEDrXg9u3Um4ZeBnnxLE9TpWNRDxZ7E02OciMBV
         w4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720989704; x=1721594504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/cK++aNJsVXbuZ4CO83IGAtI8ojo7ZZbJZliVitl0M=;
        b=O8hpcd4DWIeXlGBMCjAkTQCOnXwMOCOy5/cWQqdcGhDY1P4CU07Np63/22TfmRBudd
         xkCvnSU/q3aFhyp39+Uud9EPKInTd2S39EgMjiPXGZlTyUxEh8Am2qv10tpWwdMZkLHg
         /LlpZldBAaEKf0wxyTsQu+f58LvjG4VbASE2VFhaDxVhHM7XnlHoU0R23B512lbY818x
         YAdp93vvUtk+33oHbOGBotyeru5eYYbVuz/23N0N8V6MY/DZwB7ELg7gKupPta2+rURa
         nmIAjqViSAzXEEAfGQqYf1P6TXvhWg0OeBrpQVDZs4Ro0owg2vrJmPJeout2xb/NyT6R
         Z24A==
X-Forwarded-Encrypted: i=1; AJvYcCUSoOWdX52FijYPIfDui55txZ4cAJHHeT3bygoBWk9ICmx0DONhmeVa2QLJ+gNfNTo0wJGo2myTQy/ODX2Coh60MbRyCGKcTfO7eMeyZ5Bxca9fwMDsKkthAnFqFAxAqHKISYlLcThaPikumbEHdtPSq4HPc5z2ZNJzzds3Me3g
X-Gm-Message-State: AOJu0YxQb1yqwz4lawEe9IlPdMWWgnbHTbVB8oJPFGanNZq3YOLJ8A/M
	db7ck//g8+QBIb/QogFmEPOsMK/aG2puAotdj6ooB50WorpQU0D1ePCEbOQa9eDkIWEbXNXuGqB
	hnWmC3Fr2Mo98RKCfLQe8C5jkbnU=
X-Google-Smtp-Source: AGHT+IFFU4LKVj2rB7Y2ql4XbS+Q0ZtDsClPyxLPu1EwMtucLEgaSQSDlc3rjRfkgzPGNZviraCFeIooj9FdKqL4z9M=
X-Received: by 2002:a50:ee0b:0:b0:58d:836e:5d83 with SMTP id
 4fb4d7f45d1cf-594ba59f8eamr10226955a12.22.1720989703622; Sun, 14 Jul 2024
 13:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
 <20240714173043.668756e4@foxbook> <ZpP3RU-MKb4pMmZH@eldamar.lan>
In-Reply-To: <ZpP3RU-MKb4pMmZH@eldamar.lan>
From: Tim Lewis <elatllat@gmail.com>
Date: Sun, 14 Jul 2024 16:41:31 -0400
Message-ID: <CA+3zgmtwunPaLbKygi0y+XY7XUd2cBGVP8So8MXxK_1pOX3miQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: gregkh@linuxfoundation.org
Cc: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mathias.nyman@linux.intel.com, niklas.neronin@linux.intel.com, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 11:32=E2=80=AFAM Micha=C5=82 Pecio <michal.pecio@gm=
ail.com> wrote:
>  see if my suggested solution works.

On Sun, Jul 14, 2024 at 12:05=E2=80=AFPM Salvatore Bonaccorso <carnil@debia=
n.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219039

Not on 6.1.y:
    drivers/usb/host/xhci-ring.c:2644:31: error: ~@~Xir~@~Y undeclared
(first use in this fuunction); did you mean ~@~Xidr~@~Y?
    2644 |                 inc_deq(xhci, ir->event_ring);

On Sun, Jul 14, 2024 at 2:30=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> Ick

We now have 3 USB HDD Vendors that are reported to crash the kernel
because of this patch.  I think it best we take time to sort out the
long standing minor issue this patch is for, after we quickly revert
the major issues it is causing. Can we get it removed from 6.6.y and
older branches for the hopefully soon next release?

