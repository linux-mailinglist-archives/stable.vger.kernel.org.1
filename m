Return-Path: <stable+bounces-92193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE29C4D54
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 04:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355C4B22463
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 03:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CF207A0E;
	Tue, 12 Nov 2024 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="q7WiT80Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3F205AD6
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381499; cv=none; b=g3Vngu2CRTpiebZrb8j7fLYVKEsihWhC+qsGVWE4XuNAEy+mb4YB7/waEMXrzLXGjGjyFtMy+tfwUvdJkYtREzAIf+FRCVdM99TqsEAXXciS/+q91zrqYvggc1l5fEq8m4yqeuwgdBNgYGZWzmlDGqufj3KstEKDvwcViEMFdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381499; c=relaxed/simple;
	bh=Kz+DjEdznXySwhabk/fkyNPadUJtfFyhxjLJqtBFTMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N07QY+4G8/Hx2FL2dH0gbP0RmoTNQFugVLacpY8Pav00DzMCjCHtrM8MIpwuRZaVjyuqjWwiW+9edIVByTaLfFzdg3QAkLBe5gRBlmIImBldzj8wSI+GHmftvS5XGJiv/xwqhnGVXHFgBWl0C8hPmqMH1UGH/bhRRcbQG//C5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=q7WiT80Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21145812538so47465855ad.0
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 19:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1731381497; x=1731986297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz+DjEdznXySwhabk/fkyNPadUJtfFyhxjLJqtBFTMA=;
        b=q7WiT80YdZ/hwzK4cgDs6QQS7XbTc45NOiYx4pjo73zrs8a1t+okFVEDuNyFdfXliI
         sXW6lTGjRaK+4JBbGAFCerzGvZVxrFkgbMMGMZjJMYeVe7QnyQuVbU+0q7rjTV8C3vxS
         TBy2QrAIR1NIUpgMWv89qzZj7n1HG45W8PRqi7BRMNjyuwSfUBvzv39bnn//uUc+1lw2
         ztVvO62IFCn2hMOkeTsw0AjVMnN5xdpouXRZc8KjjHVjRgApurUt3q5z2i6/lIi8MVci
         2q0c8UWl7hJlnSCkf1OjQVRY9qKOm6l60vL3R4Sg+G+UqgTBCGP/hHvC1z3Ssd5oivl5
         6TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731381497; x=1731986297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kz+DjEdznXySwhabk/fkyNPadUJtfFyhxjLJqtBFTMA=;
        b=GHJhp/WDZzhbn9WJt+VLxq8XJCBuSgLFlT+jfh9IlYKCWMBNtJD3kZ29vwZCXlRlPn
         hM6EdmF/Tb2SJA3Lg9rUuVxXbFD7DLazUoJ2/k9yj6lHv/M6nm6qdWlaUyhHofiYPI0L
         vc3LhNJU+RcpoLr+k85A5I0yN7sxdpid4/b39qsP7WkCpM8B76O9u6Vn/ug+HEu13ddP
         FZDUKH+S3swj3VyP8HhvZ1nJmYKbzOx5Frc0PBjM1fUhXe6JMj4TD+MsLK4I/XpQm/FV
         XpC5PZTJ1xxZz+KZEvr/Txr7ciJ4SAwqMNRp7hdL4wZnxYvF+f74t86BRqWGJSrbXGLN
         s70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxxaixeqsXbqmPkvI+c968io+eG+5RDcVC2eV4cY2wCDKoIopx7+xZqnRV6B0bJ8x3Ubgdk48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wtArOkmBEERVbDvxFmNXOotoQq1bB7krDFQwOxGogR5onv5J
	xWwQ2LSzEWcWr1O+ihCAPK9xFAD1datdOdo2P+MkviVNIP/jJgDCGIBXLevGk/9hZjlm4kNYuT0
	/Cdk/DATOzjyGFVU7vtztJWfbJCBBxY8uy5WS4w==
X-Google-Smtp-Source: AGHT+IGv6tGl/DenUr3w5nLyZlQNxRJrfEo7yfHQCrtrVXjF9Q2uKgWZqYtaSe51UMLmlsaAf8S1EKJ15II6j95pLAA=
X-Received: by 2002:a17:902:cf0a:b0:20c:dbff:b9e5 with SMTP id
 d9443c01a7336-21183d16b33mr213007715ad.33.1731381497040; Mon, 11 Nov 2024
 19:18:17 -0800 (PST)
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
 <CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
 <87ldyctzwt.wl-tiwai@suse.de> <CAEkK70RAek2Y-syVt3S+3Q-kiriO24e8qQGDTrqC-Xt4kHzbCA@mail.gmail.com>
 <b97c52ec20594eecb074d333095a4560@realtek.com>
In-Reply-To: <b97c52ec20594eecb074d333095a4560@realtek.com>
From: Dean Matthew Menezes <dean.menezes@utexas.edu>
Date: Mon, 11 Nov 2024 21:17:39 -0600
Message-ID: <CAEkK70QottpLxq-prAEPe8TtPR=QBdQWuUrjf6ZT6PipcfS9xw@mail.gmail.com>
Subject: Re: No sound on speakers X1 Carbon Gen 12
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Linux Sound System <linux-sound@vger.kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Yes, it works!

