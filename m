Return-Path: <stable+bounces-88118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A029AF6AB
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33871C2128D
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B031173F;
	Fri, 25 Oct 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="sOvFbXkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB741A8F
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819397; cv=none; b=liSN7FmNUDU05Kr2PABtxthEFVlG5PJOA/+27ebSz2GuhbnqFlpa78BhOuz1r7I/IcrSLc+nbIw3PRtTEW0XNqK/4Irc8d8zi81Eqgtc4dum5PqmvdFTfdA6AtJ7S8KbowqyZfZG/B04KqOtZd5SutgIy7CAi2+tk8IJMB2Ta2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819397; c=relaxed/simple;
	bh=pIz4D5iSfqKhs9u4Ccrwg9Su/Utf2wLMgSechXdBxec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erqHLRpa32mrnusliwQ2c1z5G0P58IU1RXf8u4k0boinpgRzlbkyk3ywebxO+lz9UfYhJK5vy/qTdMhIv3N2Q+NvmZuQ3XI5cmK4XNjVwzr9eK/xPcCwNSqZFUy2cr83xBGQNdHrSBqmmAvND9ecRgjCII2+ubuIknGMs6iOMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=sOvFbXkp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1180591b3a.2
        for <stable@vger.kernel.org>; Thu, 24 Oct 2024 18:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1729819394; x=1730424194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pIz4D5iSfqKhs9u4Ccrwg9Su/Utf2wLMgSechXdBxec=;
        b=sOvFbXkpHQ/17upeJKYgTKjYLnXyiKqSJp/UqyrhFi5MMDogTB1677ECmJCw4mcC/x
         KMBLCuQKZGayu1BlGJvSkAEtBRdTYTAjpiIBLb3vu53sCo81e1BF+cMzeWEisNBvC6Jl
         54fdnk3B5cFcpVK2XaQMXF+rx+s4+7/ZYoIIoJXu2cpzSN340q93UzZQvmmyU8MnqNJ3
         jeNOesXs6aADa83q9XCbXSdvKV3UZIV+WNAzvl0rUedWu9Blv1t9nVnFgKgZXUD9CLjL
         ICmTU4TLrljrnf/MZws+8+XgmpBCet45tjoJpgammlCOlVy/Y4HInAGjqkhxJhLovTNi
         +W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729819394; x=1730424194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIz4D5iSfqKhs9u4Ccrwg9Su/Utf2wLMgSechXdBxec=;
        b=FQSrbmjgbIAXbMh1xhmQLJfgi1RggZhCZ321cNAfWkcREv+t8pq5MbxELQWA6j+kUa
         jL2lWC+RMe2vhe5FgveDPxXfRwZSlgAiM+MtijUj1zKz4qVduH0IBvJEZ5VsUdXAqCf/
         QkQdrlJyplsXGj4uvQEByZ2zKBPVRvgnsfdMNGWjRulwFppCrJ/PD0i1jJH4hBfV5fin
         D+qkrN3o5hw+AWe/0XYyYPHbyIHH0AOz0vFiA5T2O+J0UfNW0jB1PrhvB0C9zAjUelZc
         GuHkBXyCBE0IcCEJzcmLyUyq6sWqp/db/AtvBvpzCp7oq/BPx7fMw7SIoLfYv2xJ2MyE
         gP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKgmuLHbU5b9BtvuJV8UD6Gw2LOk+qaks/ec3vIrOgve+oQ2y7vg0s8pNxEwkstXMpYD+oImM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8k5cWkD+DZZu6VLd47mGySv+i0zllbYbP4m2BaRJ5nGpJDBK7
	CSeggaFlB/99+n0y12qlz7cCx5y33WPmG1xLM9TxrNT2JaI/GMapwqBKJi9TT63JC0Xhu5q3MJo
	r7zdpS3i2Pb2SDXweP4vHnMS5bXDgbX0HwM3k+A==
X-Google-Smtp-Source: AGHT+IHfXyziaUAl/+tK39Ykk3K6biro+i36WzXpNeEaPUEW0LrmKuZryiGvNWdoR4dgyxHgV0gJYhyFSUG2HhmvTZI=
X-Received: by 2002:a05:6a21:70c8:b0:1d3:2923:e37 with SMTP id
 adf61e73a8af0-1d989b4ee3amr4495019637.30.1729819394136; Thu, 24 Oct 2024
 18:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
 <2024101613-giggling-ceremony-aae7@gregkh> <433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
 <87bjzktncb.wl-tiwai@suse.de> <CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
 <87cyjzrutw.wl-tiwai@suse.de> <CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
 <87ttd8jyu3.wl-tiwai@suse.de> <CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
 <87h697jl6c.wl-tiwai@suse.de> <CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
 <87ed4akd2a.wl-tiwai@suse.de> <87bjzekcva.wl-tiwai@suse.de>
 <CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
 <877ca2j60l.wl-tiwai@suse.de> <43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
 <87ldyh6eyu.wl-tiwai@suse.de> <18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
 <87h6956dgu.wl-tiwai@suse.de> <c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
In-Reply-To: <c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
From: Dean Matthew Menezes <dean.menezes@utexas.edu>
Date: Thu, 24 Oct 2024 20:22:38 -0500
Message-ID: <CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
Subject: Re: No sound on speakers X1 Carbon Gen 12
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Linux Sound System <linux-sound@vger.kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

I get the same values for both

axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
0x5a SET_COEF_INDEX 0x00
nid = 0x5a, verb = 0x500, param = 0x0
value = 0x0
axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
0x5a SET_PROC_COEF 0x00
nid = 0x5a, verb = 0x400, param = 0x0
value = 0x0

axiom /home/dean # hda-verb /dev/snd/hwC0D0 0x5a SET_COEF_INDEX 0x00
nid = 0x5a, verb = 0x500, param = 0x0
value = 0x0
axiom /home/dean # hda-verb /dev/snd/hwC0D0 0x5a SET_PROC_COEF 0x00
nid = 0x5a, verb = 0x400, param = 0x0
value = 0x0

